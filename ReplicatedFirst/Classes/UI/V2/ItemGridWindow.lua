local MarketplaceService = game:GetService("MarketplaceService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
require(Common:WaitForChild("ResourceManager"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
require(Common:WaitForChild("SkinHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Crates = require(TDX_Shared.Modules.Crates)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local Shared = require(TDX_Shared.Modules.Shared)
local Lang = require(TDX_Shared.Modules.Lang)
local Util = require(TDX_Shared.Modules.Util)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
require(script.Parent.PopupWindows)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local ViewportCuller = require(ReplicatedFirst.Util.ViewportCuller)
local Data = require(TDX_Shared.Client.Services.Data)
local Network = require(ReplicatedFirst.Client.Network)
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local udim = UDim2.new(1.05, 0, 1.15, 0)
local udim2 = UDim2.new(0.5, 0, 0.625, 0)
local LocalPlayer = game.Players.LocalPlayer
local flag = false
local v = {
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
local ItemGridWindow = { ClassName = script.Name, ClassModule = script }
ItemGridWindow.__index = ItemGridWindow

local function GetViewport(p: string, p2: string, icon, udim3: UDim2?) -- 2 equivalent calls inferred from this helper
	local viewport = TowerUtilities.GetViewport(icon, p, p2)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local function DestroyViewports(icon)
	for _, viewportFrame in icon:GetChildren() do
		if viewportFrame:IsA("ViewportFrame") then
			viewportFrame:Destroy()
		end
	end
end

local function format_int(p)
	local _, _, v2, v3, v4 = tostring(p):find("([-]?)(%d+)([.]?%d*)")
	return v2 .. v3:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. v4
end

local function updatePillColor(p, p2) -- 4 equivalent calls inferred from this helper
	local color = Color3.fromHex(p2 and "B4FF00" or "717171")
	p.UIStroke.Color = color
	p.label.TextColor3 = color
end

function ItemGridWindow.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		UnownedVisible = false,
		OwnedVisible = false,
		OffsaleVisible = false,
		CrateSkinsVisible = false,
		CurrPage = nil,
		CurrSort = "Default",
		Boxes = {}
	}, ItemGridWindow))
end

function ItemGridWindow:Init()
	self.Root.Frames.template.Visible = false
	local startPage = self.Root:GetAttribute("StartPage")

	if startPage then
		self:OpenCategory(startPage)
	end

	local allOwned = self.Root:FindFirstChild("AllOwned")

	if allOwned then
		local buttons = allOwned.Frame.buttons
		local interact = buttons.interact
		self.Cleaner:Add(interact.button.MouseEnter:Connect(function()
			interact.button.hover.ImageTransparency = 0
			interact.button.press.ImageTransparency = 1
		end))
		self.Cleaner:Add(interact.button.MouseLeave:Connect(function()
			interact.button.hover.ImageTransparency = 1
			interact.button.press.ImageTransparency = 1
		end))
		self.Cleaner:Add(interact.button.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
			interact.button.press.ImageTransparency = 0
		end))
		self.Cleaner:Add(interact.button.MouseButton1Up:Connect(function()
			interact.button.press.ImageTransparency = 1
		end))
		self.Cleaner:Add(interact.button.Activated:Connect(function()
			SoundHandler.Play("ClickUp")
			local v2 = buttons.interact.button.holder.label.Text:find("Shop") and "Shop" or "Inventory"

			for _, v3 in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
				v3:ClearState()
				v3:Navigate(v2)
			end

			if self.CurrPage then
				for _, v3 in Director.GetItemsFromClass(Director.Classes.CategoryNavigation) do
					if v3.NavType == v2 then
						v3:ViewCategory(self.CurrPage.Name)
					end
				end
			end
		end))
	end

	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if
			(p == "Inventory" or p == "Loadout" or p == "XP" or p == "TowerSkins" or p == "PowerUpsLoadout" or p == "NameTagEffect")
			and self.CurrPage
		then
			self:UpdateAllBoxes(self.CurrPage)

			if self.CurrPage.Name == "PowerUps" then
				self:UpdateBoxesFromVisibility(
					self.CurrPage,
					"",
					self.CurrSort,
					self.OffsaleVisible,
					self.OwnedVisible,
					self.CrateSkinsVisible,
					self.UnownedVisible
				)
			end
		end
	end))
	local options = self.Root.Parent.options
	self.Cleaner:Add(options.pills.unowned.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(options.pills.owned.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(options.pills.offsale.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(options.pills.crateskins.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(options.pills.owned.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		self.OwnedVisible = not self.OwnedVisible
		updatePillColor(self.Root.Parent.options.pills.owned, self.OwnedVisible) -- inferred equivalent call
		self:UpdateBoxesFromVisibility(
			self.CurrPage,
			nil,
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
	end))
	self.Cleaner:Add(options.pills.unowned.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		self.UnownedVisible = not self.UnownedVisible
		updatePillColor(self.Root.Parent.options.pills.unowned, self.UnownedVisible) -- inferred equivalent call
		self:UpdateBoxesFromVisibility(
			self.CurrPage,
			nil,
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
	end))
	self.Cleaner:Add(options.pills.offsale.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		self.OffsaleVisible = not self.OffsaleVisible
		updatePillColor(self.Root.Parent.options.pills.offsale, self.OffsaleVisible) -- inferred equivalent call
		self:UpdateBoxesFromVisibility(
			self.CurrPage,
			nil,
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
	end))
	self.Cleaner:Add(options.pills.crateskins.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		self.CrateSkinsVisible = not self.CrateSkinsVisible
		updatePillColor(self.Root.Parent.options.pills.crateskins, self.CrateSkinsVisible) -- inferred equivalent call
		self:UpdateBoxesFromVisibility(
			self.CurrPage,
			nil,
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
	end))
	self.Cleaner:Add(options.search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		local text = self.Root.parent.options.search.TextBox.Text
		local v2 = text ~= ""
		local name = self.CurrPage.Name
		local isInventory = self.Root:GetAttribute("IsInventory") == true
		local inventoryOverride = ShopDataV2.PageMeta[name]

		if isInventory then
			inventoryOverride = inventoryOverride.InventoryOverride
		end

		self.Root.Parent.options.pills.Visible = not v2
		self.Root.Parent.options.sort.Visible = not v2 and inventoryOverride.SortVisible
		self:UpdateBoxesFromVisibility(
			self.CurrPage,
			text,
			self.CurrSort,
			v2 and true or self.OffsaleVisible,
			v2 and true or self.OwnedVisible,
			v2 and true or self.CrateSkinsVisible,
			v2 and true or self.UnownedVisible
		)
	end))
	self.Cleaner:Add(options.search.TextBox.Focused:Connect(function()
		options.search.hover.Visible = false
		options.search.focus.Visible = true
		options.search.icon.focus.Visible = true
	end))
	self.Cleaner:Add(options.search.TextBox.FocusLost:Connect(function()
		options.search.focus.Visible = false
		options.search.icon.focus.Visible = false
	end))
	self.Cleaner:Add(options.search.MouseEnter:Connect(function()
		if options.search.focus.Visible == false then
			options.search.hover.Visible = true
		end
	end))
	self.Cleaner:Add(options.search.MouseLeave:Connect(function()
		options.search.hover.Visible = false
	end))
	local color = Color3.fromRGB(129, 170, 36)
	local color2 = Color3.fromHex("B4FF00")
	self.Cleaner:Add(options.sort.TextButton.MouseEnter:Connect(function()
		if not options.sort.dropdown.Visible then
			options.sort.label.TextColor3 = color2
			options.sort.default.Visible = false
			options.sort.open.Visible = false
			options.sort.hover.Visible = true
		end
	end))
	self.Cleaner:Add(options.sort.TextButton.MouseLeave:Connect(function()
		if not options.sort.dropdown.Visible then
			options.sort.label.TextColor3 = color
			options.sort.default.Visible = true
			options.sort.open.Visible = false
			options.sort.hover.Visible = false
		end
	end))
	self.Cleaner:Add(options.sort.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(options.sort.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")

		if options.sort.dropdown.Visible then
			options.sort.label.TextColor3 = color2
			options.sort.default.Visible = false
			options.sort.open.Visible = false
			options.sort.hover.Visible = true
			options.sort.dropdown.Visible = false
		else
			options.sort.label.TextColor3 = color2
			options.sort.default.Visible = false
			options.sort.open.Visible = true
			options.sort.hover.Visible = false
			options.sort.dropdown.Visible = true
		end
	end))
end

function ItemGridWindow:SetUpItemBoxEvents(data, itemType, internalName)
	local isInventory = self.Root:GetAttribute("IsInventory") == true
	local success, result = pcall(Lang.Get, Lang.Strings.AssetInfo[itemType][internalName].Name)

	if not success then
		result = internalName
	end

	local function buy()
		local v2 = ShopDataV2.Items[itemType][internalName]
		local currency = v2.Currency or "Gold"
		local currentBalance = Data.Get(currency)
		local firstItem = Director.GetFirstItemFromClass(Director.Classes.PopupWindows)
		local v3 = {
			DisplayName = result,
			InternalName = internalName,
			ItemType = itemType,
			Currency = currency,
			Price = v2.Price,
			CurrentBalance = currentBalance
		}

		if itemType == "Towers" then
			if v2.IsRobuxOnly then
				if Data.Get("Inventory").Towers[internalName] then
					return
				end

				if v2.ProductId then
					MarketplaceService:PromptProductPurchase(LocalPlayer, v2.ProductId)
				end
			elseif currentBalance < v2.Price then
				firstItem:DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, v3)
			else
				firstItem:DoPopup("Confirmation", function(flag2: boolean)
					if flag2 == true and Network.Invoke("PurchaseTower", internalName, "Shop") then
						v[math.random(1, #v)]:Play()
						Data.Update("Inventory", function(p)
							p.Towers[internalName] = true
							return p
						end)
						self:UpdateBox(data)
					end
				end, v3)
			end
		elseif itemType == "Bundles" then
			MarketplaceService:PromptProductPurchase(LocalPlayer, v2.ProductId)
		elseif itemType == "Crates" then
			if ClientUtil.OwnsAllCrateSkins(internalName) then
				return
			end

			if
				(Data.Get("FreeCrates")[internalName] or 0) > 0
				and Network.Invoke("ClientOpenFreeCrateRequest", internalName)
			then
				v[math.random(1, #v)]:Play()

				for _, v4 in { Director.Classes.ShopWindowV2 } do
					for _, v5 in Director.GetItemsFromClass(v4) do
						if v5.HideMainWindow then
							pcall(v5.HideMainWindow, v5)
						end
					end
				end
			else
				if PurchaseHelper.IsCratePurchaseRestricted(true, internalName, v2.IsRobuxOnly == true) then
					return
				end

				if v2.IsRobuxOnly then
					if v2.ProductId then
						MarketplaceService:PromptProductPurchase(LocalPlayer, v2.ProductId)
					end
				elseif currentBalance < v2.Price then
					firstItem:DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, v3)
				else
					firstItem:DoPopup("Confirmation", function(flag2: boolean)
						if flag2 == true then
							if flag then
								return
							end

							flag = true

							if Network.Invoke("ClientOpenCrateRequest", internalName, false, "Shop") then
								v[math.random(1, #v)]:Play()

								for _, v4 in { Director.Classes.ShopWindowV2 } do
									for _, v5 in Director.GetItemsFromClass(v4) do
										if v5.HideMainWindow then
											pcall(v5.HideMainWindow, v5)
										end
									end
								end
							elseif Data.Get(currency) < v2.Price then
								for _, v4 in Director.GetItemsFromClass(Director.Classes.Sidebar) do
									v4:ShowFrame(`{currency}Shop`)
								end

								SoundHandler.Play("CurrencyJingle")
							end

							flag = false
						end
					end, v3)
				end
			end
		elseif itemType == "Skins" then
			if v2.FromCrate then
				UIHelper.NavigateToCratePreview("V2", v2.FromCrate, isInventory and "Inventory" or nil)
			elseif not v2.IsRobuxOnly then
				print("Skin purchase for gold... coming soon")
			elseif v2.ProductId then
				MarketplaceService:PromptProductPurchase(LocalPlayer, v2.ProductId)
			end
		elseif itemType == "PowerUps" then
			if currentBalance < v2.Price then
				firstItem:DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, {
					DisplayName = result,
					InternalName = internalName,
					ItemType = itemType,
					Currency = currency,
					Price = v2.Price,
					CurrentBalance = currentBalance
				})
			else
				firstItem:DoPopup("Confirmation", function(flag2: boolean)
					if flag2 == true then
						Network.Fire("ClientPurchasePowerUpRequest", internalName)
						v[math.random(1, #v)]:Play()
					end
				end, {
					DisplayName = result,
					InternalName = internalName,
					ItemType = itemType,
					Currency = currency,
					Price = v2.Price,
					CurrentBalance = currentBalance
				})
			end
		elseif itemType == "Emotes" then
			if currentBalance < v2.Price then
				firstItem:DoPopup("NotEnoughGold", UIHelper.NOT_ENOUGH_CURRENCY_POPUP_CALLBACK, v3)
			else
				firstItem:DoPopup("Confirmation", function(flag2: boolean)
					if flag2 == true and Network.Invoke("PurchaseEmote", internalName) then
						v[math.random(1, #v)]:Play()
						Data.Update("Inventory", function(p)
							p.Emotes[internalName] = true
							return p
						end)
						self:UpdateBox(data)
					end
				end, v3)
			end
		end
	end

	data.TextButton.MouseEnter:Connect(function()
		if itemType == "Emotes" then
			return
		end

		data.borderhover.Visible = true
	end)
	data.TextButton.MouseLeave:Connect(function()
		if itemType == "Emotes" then
			return
		end

		data.borderhover.Visible = false
	end)
	data.TextButton.MouseButton1Down:Connect(function()
		if itemType == "Emotes" then
			return
		end

		SoundHandler.Play("ClickDown")
	end)
	data.TextButton.MouseButton1Click:Connect(function()
		if itemType == "Emotes" then
			return
		end

		SoundHandler.Play("ClickUp")
		data.borderhover.Visible = false
		local v2 = isInventory and "Inventory" or nil

		if itemType == "Crates" then
			UIHelper.NavigateToCratePreview("V2", internalName, v2)
		elseif itemType == "Towers" then
			UIHelper.NavigateToTowerPreview("V2", internalName, "Default", v2)
		elseif itemType == "Skins" then
			local v3, v4 = unpack(string.split(internalName, "_"))
			UIHelper.NavigateToTowerPreview("V2", v3, v4, v2)
		elseif itemType == "PowerUps" then
			UIHelper.NavigateToPowerUpPreview("V2", internalName, v2)
		end
	end)
	data.buttons.buy.button.MouseButton1Click:Connect(buy)
	data.buttons.buytwo.main.right.MouseButton1Click:Connect(buy)
	data.buttons.buytwo.main.left.MouseButton1Click:Connect(function()
		local v2 = ShopDataV2.Items[itemType][internalName]

		if v2.ProductId then
			MarketplaceService:PromptProductPurchase(LocalPlayer, v2.ProductId)
		end
	end)
	data.buttons.interact.button.MouseButton1Click:Connect(function()
		if ClientUtil.EquipItem(itemType, internalName) then
			SoundHandler.Play("Equip")
			self:UpdateBox(data)

			if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
				for _, frame in pairs(data.buttons:GetChildren()) do
					if not (frame:IsA("Frame") and frame.Visible == true and frame.button:IsA("GuiButton")) then
						continue
					end

					GuiService.SelectedObject = frame.button
				end
			end
		end
	end)
	data.buttons.interact2.button.MouseButton1Click:Connect(function()
		if itemType == "Skins" then
			local fromCrate = ShopDataV2.Items[itemType][internalName].FromCrate
			UIHelper.NavigateToCratePreview("V2", fromCrate, isInventory and "Inventory")
		end
	end)
	data.buttons.unequip.button.MouseButton1Click:Connect(function()
		if ClientUtil.UnequipItem(itemType, internalName) then
			SoundHandler.Play("Unequip")
			self:UpdateBox(data)

			if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
				for _, frame in pairs(data.buttons:GetChildren()) do
					if not (frame:IsA("Frame") and frame.Visible == true and frame.button:IsA("GuiButton")) then
						continue
					end

					GuiService.SelectedObject = frame.button
				end
			end
		end
	end)

	for _, v2 in { "buy", "interact", "unequip", "interact2" } do
		local button = data.buttons[v2]
		button.button.MouseEnter:Connect(function()
			button.button.hover.ImageTransparency = 0
			button.button.press.ImageTransparency = 1
		end)
		button.button.MouseLeave:Connect(function()
			button.button.hover.ImageTransparency = 1
			button.button.press.ImageTransparency = 1
		end)
		button.button.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
			button.button.press.ImageTransparency = 0
		end)
		button.button.MouseButton1Up:Connect(function()
			button.button.press.ImageTransparency = 1
		end)
		button.button.Activated:Connect(function()
			SoundHandler.Play("ClickUp")
		end)
	end

	local main = data.buttons.buytwo.main
	main.left.MouseEnter:Connect(function()
		main.hoverleft.ImageTransparency = 0
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 1
	end)
	main.left.MouseLeave:Connect(function()
		main.hoverleft.ImageTransparency = 1
	end)
	main.right.MouseEnter:Connect(function()
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 0
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 1
	end)
	main.right.MouseLeave:Connect(function()
		main.hoverright.ImageTransparency = 1
	end)
	main.left.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 0
		main.pressright.ImageTransparency = 1
	end)
	main.right.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 0
	end)
	main.left.MouseButton1Up:Connect(function()
		main.pressleft.ImageTransparency = 1
	end)
	main.left.Activated:Connect(function()
		SoundHandler.Play("ClickUp")
	end)
	main.right.MouseButton1Up:Connect(function()
		main.pressright.ImageTransparency = 1
	end)
	main.right.Activated:Connect(function()
		SoundHandler.Play("ClickUp")
	end)
end

function ItemGridWindow:OpenCategory(name: string)
	local isInventory = self.Root:GetAttribute("IsInventory") == true
	self.CurrSort = "Default"
	self.Root.Parent.options.sort.label.Text = "Default"
	local clone = self.Root.Frames:FindFirstChild(name)
	local v2 = clone == nil

	if clone == nil then
		clone = self.Root.Frames.template:Clone()
		clone.Visible = true
		clone.template.Visible = false
		clone.Name = name
		local v3 = ViewportCuller.new(clone)
		self.Cleaner:Add(v3)
		local v4 = {}

		for k, v5 in ShopDataV2.Items[name] do
			if not (not (v5.HideInShop or v5.PVPOnly) or isInventory) then
				continue
			end

			local rarity2 = nil
			local color = Color3.fromHex("b4fe00")

			if v5.Currency then
				color = Shared.CURRENCY_COLORS[v5.Currency]
			end

			local clone2 = clone.template:Clone()
			clone2.Visible = true
			clone2.Name = k

			if name == "Skins" then
				local text, displayName = unpack(string.split(k, "_"))
				local skinData = Crates.GetSkinData(k)
				local rarity = skinData.Rarity
				clone2.itemname.Text = text
				clone2.rarity.Visible = true
				clone2.rarity.TextColor3 = Shared.RARITY_COLORS[rarity]
				clone2.rarity.Text = rarity
				clone2.skinname.Visible = true
				local skinname = clone2.skinname

				if skinData then
					displayName = skinData.DisplayName or displayName
				end

				skinname.Text = string.upper(displayName)
				color = Shared.RARITY_COLORS[rarity]
				rarity2 = -(table.find(Shared.RARITY_ORDER, rarity) or 0)
			else
				clone2.itemname.Text = Lang.Get(Lang.Strings.AssetInfo[name][k].Name)
			end

			clone2.border.ImageColor3 = color
			clone2.borderhover.ImageColor3 = color
			clone2.tags.new.Visible = v5.New == true
			clone2.tags.limited.Visible = v5.LimitedTime == true
			clone2.tags.sale.Visible = v5.OnSale == true

			if name == "Towers" then
				clone2.icon.Image = ""
				local v6 = k
				v3:Add(clone2, function()
					return GetViewport(v6, "", clone2.icon) -- inferred equivalent call
				end, function()
					DestroyViewports(clone2.icon)
				end)
			elseif name == "Skins" then
				clone2.icon.Image = ""
				local v6, v7 = unpack(string.split(k, "_"))
				v3:Add(clone2, function()
					return GetViewport(v6, v7, clone2.icon) -- inferred equivalent call
				end, function()
					DestroyViewports(clone2.icon)
				end)
			elseif name == "Emotes" then
				clone2.icon.Image = ""

				if EmoteAnimationsV2[k] then
					local v6 = k
					v3:Add(clone2, function()
						local clone3 = ReplicatedStorage.LobbyResources.emotevp:Clone()
						clone3.Visible = true
						local baseCharacter = EmoteUtilities.CloneBaseCharacter()
						EmoteUtilities.SetupViewport(
							clone3,
							baseCharacter,
							EmoteAnimationsV2[EmoteVariants.Resolve(v6, baseCharacter)]
						)
						clone3.Parent = clone2.icon
						return clone3
					end, function()
						DestroyViewports(clone2.icon)
					end)
				end
			elseif name == "PowerUps" then
				clone2.icon2.Image = v5.Image or ""
			else
				clone2.icon.Image = v5.Image or ""

				if v5.ShopCardOverrideAspectRatio then
					clone2.icon.UIAspectRatioConstraint.AspectRatio = v5.ShopCardOverrideAspectRatio
				else
					clone2.icon.UIAspectRatioConstraint.AspectRatio = 1
				end
			end

			self:SetUpItemBoxEvents(clone2, name, k)
			clone2.Parent = clone
			table.insert(v4, { Box = clone2, Name = k, Data = v5, Rarity = rarity2 })
		end

		local sort = self.Root.Parent.options.sort
		local inventoryOverride = ShopDataV2.PageMeta[name]

		if isInventory then
			inventoryOverride = inventoryOverride.InventoryOverride
		end

		for k in inventoryOverride.SortOrders do
			local clone2 = sort.dropdown.ImageLabel.template:Clone()
			clone2.Name = `{name}_{k}`
			clone2.LayoutOrder = inventoryOverride.SortOrdering[k]
			clone2.TextButton.label.Text = k
			clone2.TextButton.MouseButton1Down:Connect(function()
				SoundHandler.Play("ClickDown")
			end)
			local v5 = k
			clone2.TextButton.MouseButton1Click:Connect(function()
				SoundHandler.Play("ClickUp")
				clone2.TextButton.BackgroundTransparency = 1
				self.CurrSort = v5
				sort.label.Text = v5
				self:UpdateBoxesFromVisibility(
					clone,
					"",
					self.CurrSort,
					self.OffsaleVisible,
					self.OwnedVisible,
					self.CrateSkinsVisible,
					self.UnownedVisible
				)
				sort.label.TextColor3 = Color3.fromRGB(129, 170, 36)
				sort.default.Visible = true
				sort.open.Visible = false
				sort.hover.Visible = false
				sort.dropdown.Visible = false
			end)
			clone2.TextButton.MouseEnter:Connect(function()
				clone2.TextButton.BackgroundTransparency = 0.8
			end)
			clone2.TextButton.MouseLeave:Connect(function()
				clone2.TextButton.BackgroundTransparency = 1
			end)
			clone2.Parent = sort.dropdown.ImageLabel
		end

		self.Boxes[clone] = v4
		self:UpdateAllBoxes(clone)
		self:UpdateBoxesFromVisibility(
			clone,
			"",
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
		clone.Parent = self.Root.Frames
	end

	if not v2 then
		self:UpdateAllBoxes(clone)
		self:UpdateBoxesFromVisibility(
			clone,
			"",
			self.CurrSort,
			self.OffsaleVisible,
			self.OwnedVisible,
			self.CrateSkinsVisible,
			self.UnownedVisible
		)
	end

	self.CurrPage = clone
	self.Root.Parent.options.search.TextBox.Text = ""

	for _, child in self.Root.Frames:GetChildren() do
		child.Visible = clone == child
	end

	local inventoryOverride = ShopDataV2.PageMeta[name]

	if isInventory then
		inventoryOverride = inventoryOverride.InventoryOverride
	end

	self.Root.Parent.options.pills.unowned.Visible = inventoryOverride.UnownedPillVisible
	self.Root.Parent.options.pills.owned.Visible = inventoryOverride.OwnedPillVisible
	self.Root.Parent.options.pills.offsale.Visible = inventoryOverride.OffsalePillVisible
	self.Root.Parent.options.pills.crateskins.Visible = inventoryOverride.CrateSkinsPillVisible
	self.Root.Parent.options.sort.Visible = inventoryOverride.SortVisible

	for _, frame in self.Root.Parent.options.sort.dropdown.ImageLabel:GetChildren() do
		if frame:IsA("Frame") then
			frame.Visible = string.find(frame.Name, `{name}_`)
		end
	end

	local v3 = {
		Towers = "rbxassetid://126768804351876",
		Skins = "rbxassetid://71009389699620",
		Emotes = "rbxassetid://125727703821406",
		PowerUps = "rbxassetid://119814240851138"
	}
	local v4 = {
		Skins = "skins",
		Towers = "towers",
		PowerUps = "power-ups",
		Emotes = "emotes",
		NameTagEffects = "name tags"
	}
	local v5 = {
		Skins = "Shop for new skins in the shop!",
		Towers = "How do you have zero towers breh",
		PowerUps = "Visit the power-up shop or restock on power-ups",
		Emotes = "Shop for emotes in the emotes shop!",
		NameTagEffects = "Get them from battle passes or achievements!"
	}
	local allOwned = self.Root:FindFirstChild("AllOwned")

	if allOwned then
		allOwned.Frame.ImageLabel.Image = v3[name] or ""

		if name == "NameTagEffects" then
			allOwned.Frame.buttons.interact.button.Visible = false
		end

		if isInventory then
			allOwned.Frame.toplabel.Text = `You have no {v4[name]}`
			allOwned.Frame.label.Text = v5[name]
			allOwned.Frame.buttons.interact.button.holder.label.Text = "View Shop"
		else
			allOwned.Frame.toplabel.Text = `You own all {v4[name]}`
			allOwned.Frame.label.Text = "Thanks for your support!"
			allOwned.Frame.buttons.interact.button.holder.label.Text = "View Inventory"
		end
	end
end

function ItemGridWindow:UpdateBox(instance)
	local isInventory = self.Root:GetAttribute("IsInventory") == true
	local name = instance.Name
	local name2 = instance.Parent.Name
	local v2 = ShopDataV2.Items[name2][name]
	local v3 = "inactive"
	local visible = false
	local v4 = false

	if name2 == "Towers" then
		v4 = table.find(Data.Get("Loadout"), name) ~= nil
		visible = Data.Get("Inventory").Towers[name]
	elseif name2 == "Emotes" then
		visible = Data.Get("Inventory").Emotes[name]
		v4 = table.find(Data.Get("Emotes"), name) ~= nil
	elseif name2 == "Skins" then
		local v5, v6 = unpack(string.split(name, "_"))
		visible = ClientUtil.OwnsSkin(v5, v6)
		v4 = Data.Get("TowerSkins")[v5] == v6
	elseif name2 == "PowerUps" and isInventory then
		visible = (Data.Get("Inventory").PowerUps[name] or 0) > 0
		v4 = table.find(Data.Get("PowerUpsLoadout"), name) ~= nil
	elseif name2 == "NameTagEffects" and isInventory then
		visible = Data.Get("Inventory").NameTagEffects[name] == true
		v4 = Data.Get("NameTagEffect") == name
	elseif name2 == "Bundles" then
		visible = ClientUtil.OwnsItem("Bundles", name)
	end

	instance.count.Visible = name2 == "PowerUps"

	if instance.count.Visible then
		instance.count.ZIndex = 50
		instance.count.labelOLD.Text = Data.Get("Inventory").PowerUps[name] or 0
	end

	instance.tags.owned.Visible = visible

	if instance.tags.owned.Visible then
		instance.tags.new.Visible = false
		instance.tags.limited.Visible = false
		instance.tags.sale.Visible = false
	end

	if isInventory then
		instance.tags.owned.Visible = false
	end

	local v5 = v2.IsOffsale ~= true
	local fromCrate = "???"
	local image = nil

	if visible and not v4 then
		v3 = "interact"

		if name2 == "Towers" or name2 == "PowerUps" then
			fromCrate = "Equip"
		elseif name2 == "Skins" then
			fromCrate = "Apply skin"
		elseif name2 == "Emotes" then
			if isInventory then
				fromCrate = "Equip"
			else
				v3 = "inactive"
				fromCrate = "Owned"
			end
		elseif name2 == "Bundles" then
			v3 = "inactive"
			fromCrate = "Owned"
		elseif name2 == "NameTagEffects" then
			fromCrate = "Equip"
		end
	elseif visible and v4 then
		v3 = "unequip"

		if name2 == "Towers" or name2 == "PowerUps" then
			fromCrate = "Unequip"
		elseif name2 == "Skins" then
			fromCrate = "Remove skin"
		elseif name2 == "Emotes" then
			if isInventory then
				fromCrate = "Unequip"
			else
				v3 = "inactive"
				fromCrate = "Owned"
			end
		elseif name2 == "NameTagEffects" then
			fromCrate = "Unequip"
		end
	elseif v5 then
		v3 = "buy"

		if v2.IsRobuxOnly then
			fromCrate = `{utf8.char(57346)} {format_int(v2.PriceInRobux)}`
		elseif v2.Price and v2.Price > 0 and v2.Price < 2100000000 and v2.PriceInRobux and v2.PriceInRobux > 0 then
			v3 = "buytwo"
		elseif name2 == "PowerUps" then
			if "PowerUps" == "PowerUps" then
				v3 = "buytwo"
			end
		else
			fromCrate = format_int(v2.Price)
			image = "rbxassetid://134837596456923"
		end

		if name2 == "Crates" then
			if ClientUtil.OwnsAllCrateSkins(name) then
				v3 = "inactive"
				fromCrate = "Complete"
				image = "rbxassetid://98977086061542"
			elseif (Data.Get("FreeCrates")[name] or 0) > 0 then
				v3 = "buy"
				fromCrate = "Spin"
			end
		elseif name2 == "Skins" and v2.FromCrate then
			fromCrate = v2.FromCrate
			v3 = "interact2"
			image = ""
		end
	else
		fromCrate = "Offsale"
	end

	for _, frame in instance.buttons:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		frame.Visible = frame.Name == v3

		if not frame.Visible then
			continue
		end

		if v3 == "buy" or v3 == "inactive" or v3 == "unequip" or v3 == "interact" then
			local holder = frame:FindFirstChild("button") and frame.button:FindFirstChild("holder")

			if holder then
				holder.label.Text = fromCrate
				holder.icon.Visible = image ~= nil

				if holder.icon.Visible then
					holder.icon.Image = image
				end
			end
		elseif v3 == "interact2" then
			local success, result = pcall(Lang.Get, Lang.Strings.AssetInfo.Crates[v2.FromCrate].Name)

			if not success then
				result = v2.CrateName
			end

			frame.button.Frame.bottom.Text = result
		elseif v3 == "buytwo" then
			if name2 == "PowerUps" then
				if "PowerUps" == "PowerUps" then
					frame.main.left.Frame.top.Text = `Buy {v2.SinglePriceInRobux == nil and "5" or "1"}`
					frame.main.left.Frame.top.TextColor3 = Color3.fromRGB(255, 255, 255)
					frame.main.left.Frame.top.ImageLabel.Image = ""
					frame.main.left.Frame.holder.label.Text = `{utf8.char(57346)} {format_int(v2.SinglePriceInRobux or v2.FivePriceInRobux)}`
					frame.main.left.Frame.holder.icon.Visible = false
					frame.main.right.Frame.top.Text = "Buy 1"
					frame.main.right.Frame.top.TextColor3 = Color3.fromRGB(255, 255, 255)
					frame.main.right.Frame.top.ImageLabel.Image = ""
					frame.main.right.Frame.holder.label.Text = format_int(v2.SinglePrice)
					frame.main.right.Frame.holder.icon.Visible = true

					if v2.Currency == "Crystals" then
						frame.main.right.Frame.holder.icon.Image = "rbxassetid://122394238360129"
						frame.main.Image = "rbxassetid://113566751068407"
						frame.main.hoverright.Image = "rbxassetid://138225211858380"
						frame.main.pressright.Image = "rbxassetid://93395899416157"
						frame.main.hoverleft.Image = "rbxassetid://125938173459824"
						frame.main.pressleft.Image = "rbxassetid://109761449991385"
						frame.main.right.Frame.holder.label.TextColor3 = Shared.CURRENCY_COLORS.Crystals
					else
						frame.main.right.Frame.holder.icon.Image = "rbxassetid://134837596456923"
						frame.main.Image = "rbxassetid://77116082534776"
						frame.main.hoverright.Image = "rbxassetid://86665758520969"
						frame.main.pressright.Image = "rbxassetid://99885780881492"
						frame.main.hoverleft.Image = "rbxassetid://70593875110735"
						frame.main.pressleft.Image = "rbxassetid://89098727950724"
					end

					frame.main.lockedlevel.Visible = Util.XPToLevelAndProgress(Data.Get("XP")) < v2.MinLevel

					if frame.main.lockedlevel.Visible then
						frame.main.lockedlevel.right.label.Text = `Level {v2.MinLevel}`
					end
				end
			else
				frame.main.left.Frame.top.Text = utf8.char(57346)
				frame.main.left.Frame.top.ImageLabel.Image = ""
				frame.main.left.Frame.holder.label.Text = format_int(v2.PriceInRobux)
				frame.main.left.Frame.holder.icon.Visible = false
				frame.main.right.Frame.top.Text = ""

				if v2.Currency == "Crystals" then
					frame.main.right.Frame.top.ImageLabel.Image = "rbxassetid://122394238360129"
					frame.main.Image = "rbxassetid://113566751068407"
					frame.main.hoverright.Image = "rbxassetid://138225211858380"
					frame.main.pressright.Image = "rbxassetid://93395899416157"
					frame.main.hoverleft.Image = "rbxassetid://125938173459824"
					frame.main.pressleft.Image = "rbxassetid://109761449991385"
					frame.main.right.Frame.holder.label.TextColor3 = Shared.CURRENCY_COLORS.Crystals
				else
					frame.main.right.Frame.top.ImageLabel.Image = "rbxassetid://134837596456923"
					frame.main.Image = "rbxassetid://77116082534776"
					frame.main.hoverright.Image = "rbxassetid://86665758520969"
					frame.main.pressright.Image = "rbxassetid://99885780881492"
					frame.main.hoverleft.Image = "rbxassetid://70593875110735"
					frame.main.pressleft.Image = "rbxassetid://89098727950724"
				end

				frame.main.right.Frame.holder.label.Text = format_int(v2.Price)
				frame.main.right.Frame.holder.icon.Visible = false
				frame.main.lockedlevel.Visible = Util.XPToLevelAndProgress(Data.Get("XP")) < v2.MinLevel

				if frame.main.lockedlevel.Visible then
					frame.main.lockedlevel.right.label.Text = `Level {v2.MinLevel}`
				end
			end
		end
	end
end

function ItemGridWindow:UpdateAllBoxes(instance)
	debug.profilebegin("ItemGridWindow:UpdateAllBoxes")

	for _, frame in instance:GetChildren() do
		if frame:IsA("Frame") and frame.Name ~= "template" then
			self:UpdateBox(frame)
		end
	end

	debug.profileend()
end

function ItemGridWindow:UpdateBoxesFromVisibility(p, value: string, value2: string, flag2: boolean?, flag3: boolean?, flag4: boolean?, flag5: boolean?)
	debug.profilebegin("ItemGridWindow:UpdateBoxesFromVisibility")
	local name = p.Name
	local v2 = string.lower(value or "")
	local v3 = false
	local inventoryOverride = ShopDataV2.PageMeta[name]
	local isInventory = self.Root:GetAttribute("IsInventory") == true

	if isInventory then
		inventoryOverride = inventoryOverride.InventoryOverride
	end

	local sortOrder = inventoryOverride.SortOrders[value2 or "Default"]
	table.sort(self.Boxes[p], sortOrder)

	for k, v4 in self.Boxes[p] do
		local box = v4.Box
		local name2 = box.Name
		local v5 = ShopDataV2.Items[name][name2]
		local v6 = false
		local isOffsale = v5.IsOffsale

		if name == "Towers" or name == "Emotes" then
			v6 = Data.Get("Inventory")[name][name2]
		elseif name == "Skins" then
			local v7, v8 = unpack(string.split(name2, "_"))
			v6 = ClientUtil.OwnsSkin(v7, v8)
		elseif name == "PowerUps" and isInventory then
			v6 = (Data.Get("Inventory").PowerUps[name2] or 0) > 0

			if v6 then
				isOffsale = false
			end
		elseif name == "NameTagEffects" then
			v6 = Data.Get("Inventory").NameTagEffects[name2] == true
		elseif name == "Bundles" then
			v6 = ClientUtil.OwnsItem("Bundles", name2)
		end

		if isInventory and v6 then
			isOffsale = false
		end

		local v7

		if isInventory then
			if flag5 == nil then
				v7 = false
			else
				v7 = v6 and true or flag5 and not v5.HideInShop
			end
		elseif flag3 == nil then
			v7 = false
		else
			v7 = not v6 or flag3
		end

		local v8

		if flag2 == nil then
			v8 = false
		else
			v8 = not isOffsale or (flag2 or flag5)
		end

		local v9

		if flag4 == nil then
			v9 = false
		else
			v9 = v5.FromCrate == nil or (flag4 or flag5)
		end

		local v10 = v7 and v8

		if name == "Skins" and not v9 then
			if not (v6 and flag3) then
				v10 = false
			end

			v10 = isInventory and v6 and true or v10
		end

		if name == "Bundles" then
			v10 = v8
		end

		local visible = v10 and (#v2 == 0 or string.find(string.lower(name2), v2))
		box.Visible = visible
		box.LayoutOrder = k

		if visible then
			v3 = true
		end
	end

	local noResults = self.Root.NoResults
	noResults.Visible = v2 ~= "" and (not v3 or false)
	local allOwned = self.Root:FindFirstChild("AllOwned")

	if allOwned then
		allOwned.Visible = not v3 and v2 == ""
	end

	debug.profileend()
end

function ItemGridWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { ItemGridWindow }, game.Players)
return ItemGridWindow