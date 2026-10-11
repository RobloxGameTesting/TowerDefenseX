local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local GameSoundHandler = require(ReplicatedStorage.TDX_Shared.Components.GameSoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Crates = require(ReplicatedStorage.TDX_Shared.Modules.Crates)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Util = require(ReplicatedStorage.TDX_Shared.Modules.Util)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local UIHelper = require(game.ReplicatedFirst.Util.UIHelper)
require(script.Parent.PopupWindows)
local PurchaseHelper = require(game.ReplicatedFirst.Util.PurchaseHelper)
local SplitBuyButton = require(script.Parent.SplitBuyButton)
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)
local flag = false
local LocalPlayer = game.Players.LocalPlayer
local CratePreview = { ClassName = script.Name, ClassModule = script }
CratePreview.__index = CratePreview
local v = { Legendary = 1, Epic = 2, Uncommon = 3, Common = 4 }

local function GetPerItemOddsByRarity(crateData)
	local v2 = {}

	for _, skin in crateData.Skins do
		v2[skin.Rarity] = (v2[skin.Rarity] or 0) + 1
	end

	local total = 0

	for k in v2 do
		total += crateData.Odds[k] or 0
	end

	local result = {}

	if total <= 0 then
		return result
	end

	for k, v3 in v2 do
		result[k] = 100 * (crateData.Odds[k] or 0) / total / v3
	end

	return result
end

local function FormatOdds(p: number?) -- 1 equivalent call inferred from this helper
	if p == nil then
		return ""
	end

	if p > 0 and p < 0.00005 then
		return "<0.0001% odds*"
	end

	return `{string.format("%.4f", p):gsub("%.?0+$", "")}% odds*`
end

local function GetViewport(p: string, p2: string, p3, udim3: UDim2?)
	local viewport = TowerUtilities.GetViewport(p3, p, p2)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local v2 = {
	Util.Create("Sound", {
		Name = "Purchase1",
		SoundId = "rbxassetid://15098084380",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	}),
	Util.Create("Sound", {
		Name = "Purchase2",
		SoundId = "rbxassetid://15098084298",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	}),
	Util.Create("Sound", {
		Name = "Purchase3",
		SoundId = "rbxassetid://15098084032",
		Volume = 0.5,
		Parent = workspace,
		SoundGroup = GameSoundHandler.GetSoundGroup("UI")
	})
}

function CratePreview.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrCrate = nil,
		WindowHandlerGroupName = UIHelper.FindWindowHandlerGroup(root) or "V2"
	}, CratePreview))
end

function CratePreview:Init()
	self.Cleaner:Add(self.Root.gift.MouseButton1Click:Connect(function()
		local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
		firstItem:SetTargetPlayerId(nil, nil)
		firstItem:SetTargetGift("Crate", self.CurrCrate, Lang.Get(Lang.Strings.AssetInfo.Crates[self.CurrCrate].Name))
		Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
	end))
	local v3 = false
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p ~= "Inventory" or v3 then
			return
		end

		v3 = true
		task.defer(function()
			v3 = false

			if not (self.Root.Visible and self.CurrCrate) then
				return
			end

			self:SetupButtons(self.CurrCrate)

			for _, frame in self.Root.SkinHolder.ScrollingFrame:GetChildren() do
				if not (frame:IsA("Frame") and frame.Name ~= "template") then
					continue
				end

				local v4, v5 = unpack(string.split(frame.Name, "_"))
				frame.Frame.owned.Visible = ClientUtil.OwnsSkin(v4, v5)
			end
		end)
	end))
end

function CratePreview:SetupButtons(p: string)
	local newbuttons = self.Root:FindFirstChild("newbuttons")

	if newbuttons then
		newbuttons:Destroy()
	end

	local clone = self.Root.buttons:Clone()
	clone.Name = "newbuttons"
	clone.Visible = true
	clone.Parent = self.Root
	local _, _ = pcall(Lang.Get, Lang.Strings.AssetInfo.Crates[p].Name)
	local v3

	if PurchaseHelper.ArePaidRandomItemsRestricted() then
		v3 = PurchaseHelper.GetBuyAllCrateSkinsInfo(p) or nil
	else
		v3 = nil
	end

	local function buy()
		if v3 then
			PurchaseHelper.PromptBuyAllCrateSkins(p, v3.Price == nil)
			return
		end

		if PurchaseHelper.IsCratePurchaseRestricted(true, p, ShopDataV2.Items.Crates[p].IsRobuxOnly == true) then
			return
		end

		local crate = ShopDataV2.Items.Crates[p]

		if ClientUtil.OwnsAllCrateSkins(p) or flag then
			return
		end

		flag = true

		if (Data.Get("FreeCrates")[p] or 0) > 0 then
			if Network.Invoke("ClientOpenFreeCrateRequest", p) then
				v2[math.random(1, #v2)]:Play()
				self:HideMainWindow()
			end
		elseif crate.IsRobuxOnly then
			MarketplaceService:PromptProductPurchase(LocalPlayer, crate.ProductId)
		else
			PurchaseHelper.PromptPurchaseCrate(p)
		end

		flag = false
	end

	clone.buy.button.MouseButton1Click:Connect(buy)

	for _, v4 in { "buy" } do
		local v5 = clone[v4]
		v5.button.MouseEnter:Connect(function()
			v5.button.hover.ImageTransparency = 0
			v5.button.press.ImageTransparency = 1
		end)
		v5.button.MouseLeave:Connect(function()
			v5.button.hover.ImageTransparency = 1
			v5.button.press.ImageTransparency = 1
		end)
		v5.button.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
			v5.button.press.ImageTransparency = 0
		end)
		v5.button.MouseButton1Up:Connect(function()
			v5.button.press.ImageTransparency = 1
		end)
		v5.button.Activated:Connect(function()
			SoundHandler.Play("ClickUp")
		end)
	end

	local classObjectYields = Director.GetClassObjectYields(clone.buysplit, SplitBuyButton)
	classObjectYields:SetRobuxStyle("Primary")
	classObjectYields.CurrencyButton.Activated:Connect(buy)
	classObjectYields.RobuxButton.Activated:Connect(function()
		if v3 then
			PurchaseHelper.PromptBuyAllCrateSkins(p, true)
			return
		end

		if PurchaseHelper.IsCratePurchaseRestricted(true, p, true) then
			return
		end

		local crate = ShopDataV2.Items.Crates[p]

		if crate.ProductId then
			MarketplaceService:PromptProductPurchase(LocalPlayer, crate.ProductId)
		end
	end)
	local crate = ShopDataV2.Items.Crates[p]
	local text = "???"
	local image = nil
	local v4

	if crate.IsOffsale ~= true then
		v4 = "buy"

		if crate.IsRobuxOnly then
			text = `{utf8.char(57346)} {Util.FormatCurrency(crate.PriceInRobux)}`
		elseif
			crate.Price
			and crate.Price > 0
			and crate.Price < 2100000000
			and crate.PriceInRobux
			and crate.PriceInRobux > 0
		then
			v4 = "buysplit"
		else
			text = Util.FormatCurrency(crate.Price)
			image = "rbxassetid://97738735237837"
		end

		if ClientUtil.OwnsAllCrateSkins(p) then
			v4 = "inactive"
			text = "Complete"
			image = "rbxassetid://98977086061542"
		elseif (Data.Get("FreeCrates")[p] or 0) > 0 then
			v4 = "buy"
			text = "Spin"
		end
	else
		v4 = "inactive"
		text = "Offsale"
	end

	if v3 then
		if v3.ProductId and v3.Price then
			v4 = "buysplit"
		elseif v3.ProductId then
			text = `Buy All {utf8.char(57346)} {Util.FormatCurrency(v3.PriceInRobux)}`
			v4 = "buy"
			image = nil
		else
			text = `Buy All {Util.FormatCurrency(v3.Price)}`
			image = Shared.CURRENCY_ICONS[v3.Currency]
			v4 = "buy"
		end
	end

	for _, frame in clone:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		frame.Visible = frame.Name == v4

		if not frame.Visible then
			continue
		end

		if v4 == "buy" or v4 == "inactive" then
			local holder = frame:FindFirstChild("button") and frame.button:FindFirstChild("holder")

			if holder then
				holder.label.Text = text
				holder.icon.Visible = image ~= nil

				if holder.icon.Visible then
					holder.icon.Image = image
				end
			end
		elseif v4 == "buysplit" then
			if v3 then
				classObjectYields:SetRobuxPrice(v3.PriceInRobux)
				classObjectYields:SetCurrencyPrice(v3.Currency, v3.Price)
				classObjectYields:SetRobuxLabel("Buy All")
				classObjectYields:SetCurrencyLabel("Buy All")
			else
				classObjectYields:SetRobuxPrice(crate.PriceInRobux)
				classObjectYields:SetCurrencyPrice(crate.Currency or "Gold", crate.Price)
			end

			if Util.XPToLevelAndProgress(Data.Get("XP")) < crate.MinLevel then
				classObjectYields:SetCurrencyLocked(`Level {crate.MinLevel}`)
			else
				classObjectYields:ClearCurrencyLocked()
			end
		end
	end
end

function CratePreview:HideMainWindow()
	print("CratePreview:HideMainWindow()")

	for _, v3 in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v3:ClearState()
	end

	self.Root.Visible = false
end

function CratePreview:ShowMainWindow()
	self.Root.Visible = true
end

function CratePreview:ShowCrate(currCrate: string)
	self.CurrCrate = currCrate
	local root = self.Root
	local crateData = Crates.GetCrateData(currCrate)
	local text = Lang.Get(Lang.Strings.AssetInfo.Crates[currCrate].Name)
	local crate = ShopDataV2.Items.Crates[currCrate]
	root.icon.Image = crate.Image

	if crate.ShopCardOverrideAspectRatio then
		root.icon.UIAspectRatioConstraint.AspectRatio = crate.ShopCardOverrideAspectRatio
	else
		root.icon.UIAspectRatioConstraint.AspectRatio = 1
	end

	local v3 = Data.Get("FreeCrates")[currCrate] or 0
	root.Details.CrateName.Text = text
	root.Details.CrateDescription.Text = Lang.Get(Lang.Strings.AssetInfo.Crates[currCrate].Description)
	root.Details.Count.Visible = v3 > 0
	root.Details.Count.Label.Text = `You own {v3}`
	local perItemOddsByRarity = GetPerItemOddsByRarity(crateData)

	for _, frame in root.SkinHolder.ScrollingFrame:GetChildren() do
		if frame:IsA("Frame") and frame.Name ~= "template" then
			frame:Destroy()
		end
	end

	local gift = root.gift
	gift.Visible = crate.ProductId ~= nil and not (crate.IsOffsale or PurchaseHelper.ArePaidRandomItemsRestricted())
	self:SetupButtons(currCrate)
	task.spawn(function()
		for _, skin in crateData.Skins do
			local v4, v5 = unpack(string.split(skin.Name, "_"))
			local clone = root.SkinHolder.ScrollingFrame.template:Clone()
			clone.Frame.towername.Text = string.upper(v4)
			clone.Frame.skinname.Text = string.upper(v5)
			clone.Frame.rarity.Text = string.upper(skin.Rarity)
			clone.Frame.odds.Text = FormatOdds(perItemOddsByRarity[skin.Rarity]) -- inferred equivalent call
			clone.Frame.bg.ImageColor3 = Shared.RARITY_COLORS[skin.Rarity]
			clone.Frame.hover.ImageColor3 = Shared.RARITY_COLORS[skin.Rarity]
			clone.Frame.owned.Visible = ClientUtil.OwnsSkin(v4, v5)
			clone.Frame.MouseEnter:Connect(function()
				clone.Frame.hover.Visible = true
			end)
			clone.Frame.MouseLeave:Connect(function()
				clone.Frame.hover.Visible = false
			end)
			clone.Frame.TextButton.MouseButton1Down:Connect(function()
				SoundHandler.Play("ClickDown")
			end)
			clone.Frame.TextButton.MouseButton1Click:Connect(function()
				SoundHandler.Play("ClickUp")
				UIHelper.NavigateToTowerPreview(self.WindowHandlerGroupName, v4, v5, text, function()
					self:ShowCrate(currCrate)
					self:ShowMainWindow()
				end)
			end)
			task.defer(GetViewport, v4, v5, clone.Frame.icon)
			clone.Name = skin.Name
			clone.LayoutOrder = v[skin.Rarity]
			clone.Visible = true
			clone.Parent = root.SkinHolder.ScrollingFrame
			task.wait()

			if self.Root.Visible == false then
				break
			end
		end
	end)
end

function CratePreview:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { CratePreview }, game.Players)
return CratePreview