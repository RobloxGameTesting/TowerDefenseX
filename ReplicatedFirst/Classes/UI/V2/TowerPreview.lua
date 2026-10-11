local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
require(ReplicatedStorage.TDX_Shared.Common.TowerBuffUtilities)
local StatDisplayUtilities = require(ReplicatedStorage.TDX_Shared.Common.StatDisplayUtilities)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
local ScalingCardClass = require(ReplicatedStorage.TDX_Shared.Common.ScalingCardClass)
local Crates = require(ReplicatedStorage.TDX_Shared.Modules.Crates)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Util = require(ReplicatedStorage.TDX_Shared.Modules.Util)
local SkinUtilities = require(ReplicatedStorage.TDX_Shared.SkinData.SkinUtilities)
local ClientUtil = require(ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local SPLASH_RADIUS_TO_TRANSFER_TO_AIR = _G.SPLASH_RADIUS_TO_TRANSFER_TO_AIR
local LocalPlayer = game.Players.LocalPlayer
local TowerPreview = { ClassName = script.Name, ClassModule = script }
TowerPreview.__index = TowerPreview
local udim = UDim2.new(1, 0, 1, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)

local function GetViewport(icon, udim3: UDim2?, currTowerName: string, p: string, path1: number?, path2: number?) -- 2 equivalent calls inferred from this helper
	local viewport = TowerUtilities.GetViewport(icon, currTowerName, p, nil, path1, path2, 0.95, true)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local v = {}

local function getCarouselForTower(currTowerName: string)
	local v2 = v[currTowerName]

	if v2 then
		return v2
	end

	local result = { "Default" }

	for k in SkinUtilities.GetAllSkinsForTower(currTowerName) or {} do
		local skinData = Crates.GetSkinData(`{currTowerName}_{k}`)

		if skinData and skinData.Rarity ~= Enums.SkinRarities.Hidden then
			table.insert(result, k)
		end
	end

	v[currTowerName] = result
	return result
end

function TowerPreview.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrTowerData = nil,
		Path1 = 0,
		Path2 = 0,
		DetectionIcon = nil,
		AirTargetingIcon = nil,
		NoGroundTargetingIcon = nil,
		SplashTransferIcon = nil,
		StunImmunityIcon = nil
	}, TowerPreview))
end

function TowerPreview:CanUpgrade(p: number, p2: number)
	local v2 = self["Path" .. p]
	local currTowerData = self.CurrTowerData
	local path1Data = p == 1 and currTowerData.UpgradePathData.Path1Data or currTowerData.UpgradePathData.Path2Data
	local v3 = not (math.max(self.Path1, self.Path2) >= currTowerData.UpgradePathData.PathLockLevel) and 0
		or self.Path1 > self.Path2 and 1
		or 2

	if #path1Data <= v2 and p2 == 1 then
		return false
	end

	if v3 == 0 or v3 == p or not (currTowerData.UpgradePathData.PathLockLevel - 1 <= v2) or p2 ~= 1 then
		return p2 ~= -1 or v2 ~= 0
	end

	return false
end

function TowerPreview:Init()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if (p == "Inventory" or p == "Loadout" or p == "XP" or p == "TowerSkins") and self.CurrTowerName then
			self:ShowTowerAndSkin(self.CurrTowerName, self.CurrCarousel[self.CurrCarouselIndex], true)
		end
	end))
	self.Cleaner:Add(ItemDiscountClient.DiscountsChanged:Connect(function()
		if self.CurrTowerName then
			self:ShowTowerAndSkin(self.CurrTowerName, self.CurrCarousel[self.CurrCarouselIndex], true)
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Plus.MouseButton1Click:Connect(function()
		if self:CanUpgrade(1, 1) then
			SoundHandler.Play("ClickUp")
			self.Path1 += 1
			self:UpdatePaths()
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Minus.MouseButton1Click:Connect(function()
		if self:CanUpgrade(1, -1) then
			SoundHandler.Play("ClickUp")
			self.Path1 -= 1
			self:UpdatePaths()
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Plus.MouseButton1Click:Connect(function()
		if self:CanUpgrade(2, 1) then
			SoundHandler.Play("ClickUp")
			self.Path2 += 1
			self:UpdatePaths()
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Minus.MouseButton1Click:Connect(function()
		if self:CanUpgrade(2, -1) then
			SoundHandler.Play("ClickUp")
			self.Path2 -= 1
			self:UpdatePaths()
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Plus.MouseButton1Down:Connect(function()
		if self:CanUpgrade(1, 1) then
			SoundHandler.Play("ClickDown")
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Minus.MouseButton1Down:Connect(function()
		if self:CanUpgrade(1, -1) then
			SoundHandler.Play("ClickDown")
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Plus.MouseButton1Down:Connect(function()
		if self:CanUpgrade(2, 1) then
			SoundHandler.Play("ClickDown")
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Minus.MouseButton1Down:Connect(function()
		if self:CanUpgrade(2, -1) then
			SoundHandler.Play("ClickDown")
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Plus.MouseEnter:Connect(function()
		if self.Root.Paths.Frame.Path1.Frame.Plus.Inactive.Visible == false then
			self.Root.Paths.Frame.Path1.Frame.Plus.Hover.Visible = true
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Minus.MouseEnter:Connect(function()
		if self.Root.Paths.Frame.Path1.Frame.Minus.Inactive.Visible == false then
			self.Root.Paths.Frame.Path1.Frame.Minus.Hover.Visible = true
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Plus.MouseLeave:Connect(function()
		self.Root.Paths.Frame.Path1.Frame.Plus.Hover.Visible = false
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path1.Frame.Minus.MouseEnter:Connect(function()
		self.Root.Paths.Frame.Path1.Frame.Minus.Hover.Visible = false
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Plus.MouseEnter:Connect(function()
		if self.Root.Paths.Frame.Path2.Frame.Plus.Inactive.Visible == false then
			self.Root.Paths.Frame.Path2.Frame.Plus.Hover.Visible = true
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Minus.MouseEnter:Connect(function()
		if self.Root.Paths.Frame.Path2.Frame.Minus.Inactive.Visible == false then
			self.Root.Paths.Frame.Path2.Frame.Minus.Hover.Visible = true
		end
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Plus.MouseLeave:Connect(function()
		self.Root.Paths.Frame.Path2.Frame.Plus.Hover.Visible = false
	end))
	self.Cleaner:Add(self.Root.Paths.Frame.Path2.Frame.Minus.MouseEnter:Connect(function()
		self.Root.Paths.Frame.Path2.Frame.Minus.Hover.Visible = false
	end))
	self.Cleaner:Add(self.Root.CarouselMoveLeft.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(self.Root.CarouselMoveRight.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(self.Root.CarouselMoveLeft.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		local v2 = (self.CurrCarouselIndex or 1) - 1
		local v3 = v2 < 1 and #self.CurrCarousel or v2
		self:ShowTowerAndSkin(self.CurrTowerName, self.CurrCarousel[v3], true)
	end))
	self.Cleaner:Add(self.Root.CarouselMoveRight.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		local v2 = (self.CurrCarouselIndex or 1) + 1
		local v3 = #self.CurrCarousel < v2 and 1 or v2
		self:ShowTowerAndSkin(self.CurrTowerName, self.CurrCarousel[v3], true)
	end))
	local closeButton = self.Root:FindFirstChild("CloseButton")

	if closeButton then
		self.Cleaner:Add(closeButton.Activated:Connect(function()
			self:HideMainWindow()
		end))
		self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input)
			if self.Root.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
				self:HideMainWindow()
			end
		end))
	end

	local attributes = self.Root.Icon:WaitForChild("Attributes")
	local detection = attributes:WaitForChild("Detection")
	local airTargeting = attributes:WaitForChild("AirTargeting")
	local noGroundTargeting = attributes:WaitForChild("NoGroundTargeting")
	local splashTransfer = attributes:WaitForChild("SplashTransfer")
	local stunImmunity = attributes:WaitForChild("StunImmunity")
	self.DetectionIcon = detection
	self.AirTargetingIcon = airTargeting
	self.NoGroundTargetingIcon = noGroundTargeting
	self.SplashTransferIcon = splashTransfer
	self.StunImmunityIcon = stunImmunity
	local attributesHover = self.Root.Icon:WaitForChild("AttributesHover")
	local v2 = { (self.Root.Parent:FindFirstChild("UIScale")) }
	self.AttributeScalingCard = ScalingCardClass.New(attributesHover, 1, v2, true)
	local v3 = {
		[detection] = "Stealth detection",
		[airTargeting] = "Can target air enemies",
		[noGroundTargeting] = "Cannot target ground enemies",
		[splashTransfer] = "Splash damage hits air and ground enemies",
		[stunImmunity] = "Stun immunity"
	}
	local v4 = nil

	for _, v5 in pairs({ detection, airTargeting, noGroundTargeting, splashTransfer, stunImmunity }) do
		local v6 = v5
		self.Cleaner:Add(v5.MouseEnter:Connect(function()
			v4 = v6
			local v7 = v3[v6]
			local v8 = v6.AbsolutePosition.Y - self.Root.Icon.AbsolutePosition.Y + v6.AbsoluteSize.Y / 2
			self.AttributeScalingCard:DeactivateAllItems()
			self.AttributeScalingCard:ActivateItem(string.upper(v7), { LayoutOrder = 1 })
			self.AttributeScalingCard:ScaleFrame()
			self.AttributeScalingCard:SetPosition(UDim2.new(1.025, 0, 0, v8))
			self.AttributeScalingCard:ShowIfActiveItems()
		end))
		local v7 = v5
		self.Cleaner:Add(v5.MouseLeave:Connect(function()
			if v7 == v4 then
				self.AttributeScalingCard:Hide()
			end
		end))
	end

	self.Cleaner:Add(self.Root.Gift.MouseButton1Click:Connect(function()
		local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
		firstItem:SetTargetPlayerId(nil, nil)
		firstItem:SetTargetGift(
			"Tower",
			self.CurrTowerName,
			Lang.Get(Lang.Strings.AssetInfo.Towers[self.CurrTowerName].Name)
		)
		Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
	end))
end

function TowerPreview:SetupButtons(name: string, p: string)
	local v2 = p == "Tower" and "Towers" or p == "Skin" and "Skins" or false
	local newbuttons = self.Root:FindFirstChild("newbuttons")

	if newbuttons then
		newbuttons:Destroy()
	end

	local clone = self.Root.Buttons:Clone()
	clone.Name = "newbuttons"
	clone.Visible = true
	clone.Parent = self.Root
	local _, _ = pcall(Lang.Get, Lang.Strings.AssetInfo[v2][name].Name)

	local function buy()
		local v3 = ShopDataV2.Items[v2][name]

		if v2 == "Skins" then
			if v3.FromCrate then
				local v4 = _G.SHOP_V3_ENABLED and "V3" or "V2"
				local currTowerName = self.CurrTowerName
				local v5 = self.CurrCarousel[self.CurrCarouselIndex]
				UIHelper.NavigateToCratePreview(v4, v3.FromCrate, currTowerName, function()
					self:ShowTowerAndSkin(currTowerName, v5)
					self.Root.Visible = true
				end)
			elseif v3.IsRobuxOnly then
				MarketplaceService:PromptProductPurchase(LocalPlayer, v3.ProductId)
			else
				PurchaseHelper.PromptSkinPurchase(name)
			end
		elseif v2 == "Towers" then
			if v3.IsRobuxOnly then
				if Data.Get("Inventory").Towers[name] then
					return
				end

				if v3.ProductId then
					MarketplaceService:PromptProductPurchase(LocalPlayer, v3.ProductId)
				end
			else
				PurchaseHelper.PromptTowerPurchase(name, function()
					print(`Tower {name} purchased!`)
					self:ShowTowerAndSkin(name, self.CurrCarousel[self.CurrCarouselIndex])
				end)
			end
		end
	end

	clone.buy.button.MouseButton1Click:Connect(buy)
	clone.buy3.button.MouseButton1Click:Connect(buy)
	clone.unequip.button.MouseButton1Click:Connect(function()
		local currTowerName = self.CurrTowerName
		local v3 = self.CurrCarousel[self.CurrCarouselIndex]
		local unequipItem = ClientUtil.UnequipItem
		local v4

		if v2 == "Towers" then
			v4 = currTowerName
		else
			v4 = `{currTowerName}_{v3}`
		end

		if unequipItem(v2, v4) then
			SoundHandler.Play(v2 == "Towers" and "Unequip" or "ClickUp")
			self:ShowTowerAndSkin(currTowerName, v3)
		end
	end)
	clone.interact.button.MouseButton1Click:Connect(function()
		local currTowerName = self.CurrTowerName
		local v3 = self.CurrCarousel[self.CurrCarouselIndex]
		local equipItem = ClientUtil.EquipItem
		local v4

		if v2 == "Towers" then
			v4 = currTowerName
		else
			v4 = `{currTowerName}_{v3}`
		end

		if equipItem(v2, v4) then
			SoundHandler.Play(v2 == "Towers" and "Equip" or "ClickUp")
			self:ShowTowerAndSkin(currTowerName, v3)
		end
	end)

	for _, v3 in { "buy", "unequip", "interact", "buy3" } do
		local v4 = clone[v3]
		v4.button.MouseEnter:Connect(function()
			v4.button.hover.ImageTransparency = 0
			v4.button.press.ImageTransparency = 1
		end)
		v4.button.MouseLeave:Connect(function()
			v4.button.hover.ImageTransparency = 1
			v4.button.press.ImageTransparency = 1
		end)
		v4.button.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
			v4.button.press.ImageTransparency = 0
		end)
		v4.button.MouseButton1Up:Connect(function()
			v4.button.press.ImageTransparency = 1
		end)
		v4.button.Activated:Connect(function()
			SoundHandler.Play("ClickUp")
		end)
	end

	local classObjectYields = Director.GetClassObjectYields(clone.buysplit, Director.Classes.SplitBuyButton)
	classObjectYields:SetRobuxStyle("Primary")
	classObjectYields.CurrencyButton.Activated:Connect(buy)
	classObjectYields.RobuxButton.Activated:Connect(function()
		local v3 = ShopDataV2.Items[v2][name]

		if v3.ProductId then
			MarketplaceService:PromptProductPurchase(LocalPlayer, v3.ProductId)
		end
	end)
	local v3 = "inactive"
	local v4 = ShopDataV2.Items[v2][name]
	local v5 = false
	local v6 = false
	local v7 = v4.IsOffsale ~= true
	local fromCrate = "???"
	local image = nil
	local v8 = ItemDiscountClient.GetPriceWithDiscount({ Type = v2, Name = name }) or v4.Price

	if v2 == "Towers" then
		v6 = table.find(Data.Get("Loadout"), name) ~= nil
		v5 = Data.Get("Inventory")[v2][name]
	elseif v2 == "Skins" then
		local v9, v10 = unpack(string.split(name, "_"))
		v5 = ClientUtil.OwnsSkin(v9, v10)

		if Data.Get("TowerSkins")[v9] == v10 then
			v6 = true
		else
			v6 = false
		end
	end

	if v5 and v6 then
		v3 = "unequip"

		if v2 == "Towers" then
			fromCrate = "Unequip"
		elseif v2 == "Skins" then
			fromCrate = "Remove skin"
		end
	elseif v5 and not v6 then
		v3 = "interact"

		if v2 == "Towers" then
			fromCrate = "Equip tower"
		elseif v2 == "Skins" then
			fromCrate = "Apply skin"
		end
	elseif v7 then
		v3 = "buy"

		if v4.IsRobuxOnly then
			fromCrate = `{utf8.char(57346)} {Util.FormatCurrency(v4.PriceInRobux)}`
		elseif v8 and v8 > 0 and v8 < 2100000000 and v4.PriceInRobux and v4.PriceInRobux > 0 then
			v3 = "buysplit"
		else
			fromCrate = Util.FormatCurrency(v8)
			image = "rbxassetid://97738735237837"
		end

		if v2 == "Skins" and v4.FromCrate then
			fromCrate = v4.FromCrate
			v3 = "buy3"
			image = ""
		end
	else
		fromCrate = "Offsale"
	end

	for _, frame in clone:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		frame.Visible = frame.Name == v3

		if not frame.Visible then
			continue
		end

		if v3 == "buy" or v3 == "inactive" or v3 == "interact" or v3 == "unequip" then
			local holder = frame:FindFirstChild("button") and frame.button:FindFirstChild("holder")

			if holder then
				holder.label.Text = fromCrate
				holder.icon.Visible = image ~= nil

				if holder.icon.Visible then
					holder.icon.Image = image
				end
			end
		elseif v3 == "buy3" then
			local success, result = pcall(Lang.Get, Lang.Strings.AssetInfo.Crates[v4.FromCrate].Name)

			if not success then
				result = v4.CrateName
			end

			frame.button.Frame.bottom.Text = result
		elseif v3 == "buysplit" then
			classObjectYields:SetRobuxPrice(v4.PriceInRobux)
			classObjectYields:SetCurrencyPrice(v4.Currency or "Gold", v8)

			if Util.XPToLevelAndProgress(Data.Get("XP")) < v4.MinLevel then
				classObjectYields:SetCurrencyLocked(`Level {v4.MinLevel}`)
			else
				classObjectYields:ClearCurrencyLocked()
			end
		end
	end
end

function TowerPreview:UpdatePaths(flag: boolean?)
	local frame = self.Root.Paths.Frame
	local currTowerName = self.CurrTowerName
	local currTowerData = self.CurrTowerData
	local levelStats = TowerUtilities.GetLevelStats(currTowerData.UpgradePathData, self.Path1, self.Path2)

	for i = 1, 2 do
		if currTowerData.UpgradePathData.OnePathOnly and i == 2 then
			frame.Path2.Visible = false
			break
		end

		local v2 = self["Path" .. i]
		local child = frame:FindFirstChild("Path" .. i)
		local path1Data = i == 1 and currTowerData.UpgradePathData.Path1Data or currTowerData.UpgradePathData.Path2Data
		local count = #path1Data
		local v3 = path1Data[v2 + 1] or path1Data[v2]

		if
			i == (not (math.max(self.Path1, self.Path2) >= currTowerData.UpgradePathData.PathLockLevel) and 0 or self.Path1 > self.Path2 and 1 or 2)
			and v2 == count
		then
			child.CostText.Text = "MAX"
			child.DescriptionText.Text = "MAX"
		else
			child.CostText.Text = `${v3.Cost}`
			child.DescriptionText.Text = string.upper(v3.Description)
		end

		child.UpgradeImage.Image = v3.UpgradeIcon
		child.UpgradeImage.UIAspectRatioConstraint.AspectRatio = v3.UpgradeIconUseLegacySize and 1.777 or 1.333
		local canUpgrade = self:CanUpgrade(i, 1)
		local canUpgrade2 = self:CanUpgrade(i, -1)
		child.Frame.Plus.Inactive.Visible = not canUpgrade
		child.Frame.Minus.Inactive.Visible = not canUpgrade2

		if child.Frame.Plus.Inactive.Visible then
			child.Frame.Plus.Hover.Visible = false
		end

		if child.Frame.Minus.Inactive.Visible then
			child.Frame.Minus.Hover.Visible = false
		end

		child.LockedOverlay.Visible = not canUpgrade and v2 ~= count

		for j = 1, 5 do
			child.Ticks[j].Image = j <= v2 and "rbxassetid://10386176449" or "rbxassetid://10386176353"
		end

		child.Visible = true
	end

	for _, frame2 in self.Root.Stats.Frame:GetChildren() do
		if frame2:IsA("Frame") and frame2.Name ~= "Template" then
			frame2:Destroy()
		end
	end

	local shipData = levelStats.ShipData
	local v2 = shipData and TowerUtilities.GetMainAttackCount(shipData) or 1
	local displayStats = StatDisplayUtilities.GetDisplayStats(currTowerData)

	local function NewRow(layoutOrder: number, name: string, p: string, image: string, p2: number?)
		local clone = self.Root.Stats.Frame.Template:Clone()
		clone.Name = name
		clone.LayoutOrder = layoutOrder
		clone.Icon.Image = image

		if p2 then
			clone.Icon.Size = UDim2.new(1.2 * p2, 0, 1.2 * p2, 0)
		end

		clone.Label.Text = ` {p}`
		clone.Visible = true
		clone.Parent = self.Root.Stats.Frame
	end

	for i, displayStat in ipairs(displayStats) do
		if not (not levelStats.NoDisplayPierceCount or displayStat ~= "PierceCount") then
			continue
		end

		local statInfoData = StatDisplayUtilities.GetStatInfoData(displayStat)

		if statInfoData then
			if
				not StatDisplayUtilities.ShouldIgnore(statInfoData, levelStats)
				and (statInfoData.StatName ~= "AttackCount" or not (v2 <= 1))
			then
				local descriptionFunction = statInfoData:DescriptionFunction(levelStats, nil, v2, true)

				if descriptionFunction then
					if typeof(descriptionFunction) == "table" then
						for _, v3 in ipairs(descriptionFunction) do
							NewRow(i, statInfoData.StatName, v3, statInfoData.ImageId, statInfoData.ImageScale)
						end
					else
						NewRow(
							i,
							statInfoData.StatName,
							descriptionFunction,
							statInfoData.ImageId,
							statInfoData.ImageScale
						)
					end
				end
			end
		else
			warn("StatInfoData not implemented for", displayStat)
		end
	end

	if currTowerName == Enums.Towers.Farm then
		local farmAdditionalStatStrings = StatDisplayUtilities.GetFarmAdditionalStatStrings(
			self.Path1,
			self.Path2,
			true
		)

		for i, farmAdditionalStatString in ipairs(farmAdditionalStatStrings) do
			NewRow(97 + i, "Farm" .. i, farmAdditionalStatString, StatDisplayUtilities.GetDefaultHoverAdditionIcon(), 1)
		end
	end

	for i, v3 in ipairs(levelStats.SpawnPathEntityData) do
		local pathEntityConfig = ResourceManager.GetPathEntityConfig(v3.PathEntityType)
		local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or v3.PathEntityType)
		local health = pathEntityConfig.Health
		local attacksDPS = TowerUtilities.CalculateAttacksDPS(pathEntityConfig.AttackData)

		if attacksDPS then
			local v4 = math.round(attacksDPS)
			NewRow(
				105 + i,
				"SpawnPathEntity" .. i,
				string.upper(`{overrideDisplayName} | {health} HP | {v4} DPS`),
				"rbxassetid://12191388343",
				1
			)
		else
			NewRow(
				105 + i,
				"SpawnPathEntity" .. i,
				string.upper(`{overrideDisplayName} | {health} HP`),
				"rbxassetid://12191388343",
				1
			)
		end
	end

	if currTowerData.NoBuffs then
		local clone = self.Root.Stats.Frame.Template:Clone()
		clone.Name = "NoBuffs"
		clone.LayoutOrder = 110
		clone.Icon.Image = "rbxassetid://15498074529"
		clone.Icon.Size = UDim2.new(1.08, 0, 1.08, 0)
		clone.Label.Text = " NO FRIENDLY BUFFS"
		clone.Visible = true
		clone.Parent = self.Root.Stats.Frame
	end

	if not flag and self.CurrCarousel then
		self:ShowTowerAndSkin(self.CurrTowerName, self.CurrCarousel[self.CurrCarouselIndex], true)
	end

	self.DetectionIcon.Visible = levelStats.StealthDetection
	self.AirTargetingIcon.Visible = levelStats.CanTargetAir
	self.NoGroundTargetingIcon.Visible = levelStats.IgnoreGround
	local splashTransferIcon = self.SplashTransferIcon
	local splashAlwaysHitAirAndGround = not levelStats.NoAirToGroundSplashTransfer

	if splashAlwaysHitAirAndGround then
		splashAlwaysHitAirAndGround = levelStats.SplashAlwaysHitAirAndGround

		if not splashAlwaysHitAirAndGround then
			splashAlwaysHitAirAndGround = levelStats.IsSplash

			if splashAlwaysHitAirAndGround then
				splashAlwaysHitAirAndGround = SPLASH_RADIUS_TO_TRANSFER_TO_AIR <= levelStats.SplashRadius
			end
		end
	end

	splashTransferIcon.Visible = splashAlwaysHitAirAndGround
	self.StunImmunityIcon.Visible = levelStats.StunImmunity
end

function TowerPreview:ShowTowerAndSkin(currTowerName: string, value: string?, flag: boolean?)
	local v2 = value or "Default"
	local root = self.Root
	local towerConfig = ResourceManager.GetTowerConfig(currTowerName)
	self.CurrTowerName = currTowerName
	self.CurrTowerData = towerConfig
	local tower = ShopDataV2.Items.Towers[currTowerName]
	local gift = root.Gift

	if tower then
		if tower.ProductId == nil then
			tower = false
		else
			tower = not tower.IsOffsale
		end
	end

	gift.Visible = tower

	if not flag then
		self.Path1 = 0
		self.Path2 = 0
		self:UpdatePaths(true)
	end

	root.Details.TowerName.Text = string.upper(Lang.Get(Lang.Strings.AssetInfo.Towers[currTowerName].Name))
	root.Details.TowerDescription.Text = Lang.Get(Lang.Strings.AssetInfo.Towers[currTowerName].Description)
	root.Details.PlacementCost.Cost.Text = `${towerConfig.UpgradePathData.BaseLevelData.Cost}`
	root.Details.BannedInPVP.Visible = _G.PVP_SHOP_ENABLED and towerConfig.BannedInPVP == true

	for _, viewportFrame in root.Icon:GetChildren() do
		if viewportFrame:IsA("ViewportFrame") then
			viewportFrame:Destroy()
		end
	end

	GetViewport(root.Icon, nil, currTowerName, v2 == "Default" and "" or v2 or "", self.Path1, self.Path2) -- inferred equivalent call
	local tower2 = Data.Get("Inventory").Towers[currTowerName]
	local v3

	if v2 == "Default" then
		v3 = Data.Get("Inventory").Towers[currTowerName]
	else
		v3 = ClientUtil.OwnsSkin(currTowerName, v2 or "")
	end

	root.ButtonsTitle.Text = `BUY {(v2 == "Default" or not tower2) and "TOWER" or "SKIN"}`
	root.ButtonsTitle.Visible = not v3
	local carouselForTower = getCarouselForTower(currTowerName)
	local index = table.find(carouselForTower, v2)
	self.CurrCarouselIndex = index
	self.CurrCarousel = carouselForTower
	local skinData = Crates.GetSkinData(`{currTowerName}_{v2}`)
	local rarity = root.CarouselCurr.Rarity
	rarity.Visible = v2 ~= "Default"
	local title = root.Selectedskin.Title
	local text

	if skinData then
		text = skinData.DisplayName or v2
	else
		text = v2
	end

	title.Text = text

	if rarity.Visible then
		if skinData then
			local v4 = Shared.RARITY_COLORS[skinData.Rarity]
			rarity.Title.Text = skinData.Rarity
			rarity.Title.TextColor3 = v4
			rarity.UIStroke.Color = v4
			rarity.BackgroundColor3 = v4
		else
			rarity.Visible = false
		end
	end

	for i = -1, 1 do
		local carouselLeft = i == -1 and root.CarouselLeft or i == 0 and root.CarouselCurr

		if not carouselLeft then
			if i == 1 then
				carouselLeft = root.CarouselRight
			else
				carouselLeft = false
			end
		end

		local v4 = index + i
		local v5 = carouselForTower[#carouselForTower < v4 and 1 or v4 < 1 and #carouselForTower or v4]

		for _, viewportFrame in carouselLeft.Icon:GetChildren() do
			if viewportFrame:IsA("ViewportFrame") then
				viewportFrame:Destroy()
			end
		end

		local v6 = v5 == "Default" or ClientUtil.OwnsSkin(currTowerName, v5)
		local v7 = Data.Get("TowerSkins")[currTowerName]
		local visible

		if v7 == v5 then
			visible = true
		elseif v5 == "Default" then
			visible = v7 == "" or v7 == nil
		else
			visible = false
		end

		carouselLeft.Iconholder.Equipped.Visible = visible
		carouselLeft.Iconholder.Locked.Visible = not v6
		GetViewport(carouselLeft.Icon, nil, currTowerName, v5 == "Default" and "" or v5, self.Path1, self.Path2) -- inferred equivalent call

		if v6 then
			continue
		end

		local viewportFrame = carouselLeft.Icon:FindFirstChildOfClass("ViewportFrame")

		if viewportFrame then
			viewportFrame.ImageTransparency = 0.5
		end
	end

	if v2 == "Default" then
		tower2 = false
	end

	if tower2 then
		currTowerName = `{currTowerName}_{v2}` or currTowerName
	end

	self:SetupButtons(currTowerName, tower2 and "Skin" or "Tower")
end

function TowerPreview:HideMainWindow()
	for _, v2 in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v2:ClearState()
	end

	self.Root.Visible = false
end

function TowerPreview:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { TowerPreview }, game.Players)
return TowerPreview