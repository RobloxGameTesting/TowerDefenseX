game:GetService("MarketplaceService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(ReplicatedStorage.TDX_Shared.Common.Enums)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
require(ReplicatedStorage.TDX_Shared.Common.StatDisplayUtilities)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local ScalingCardClass = require(ReplicatedStorage.TDX_Shared.Common.ScalingCardClass)
require(ReplicatedStorage.TDX_Shared.Modules.Crates)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
require(ReplicatedStorage.TDX_Shared.Modules.Util)
local Utilities = require(ReplicatedStorage.TDX_Shared.Common.Utilities)
require(ReplicatedStorage.TDX_Shared.SkinData.SkinUtilities)
require(ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local EnemyViewport = require(ReplicatedStorage.TDX_Shared.Common.EnemyViewport)
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local EnemyPreview = { ClassName = script.Name, ClassModule = script }
EnemyPreview.__index = EnemyPreview

function EnemyPreview.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), CurrentEnemyData = nil }, EnemyPreview))
end

function EnemyPreview:Init()
	Data.Updated:Connect(function(p)
		if (p == "Inventory" or p == "Loadout" or p == "XP") and self.CurrentEnemyName then
			self:ShowEnemy(self.CurrentEnemyName)
		end
	end)
	ItemDiscountClient.DiscountsChanged:Connect(function()
		if self.CurrentEnemyName then
			self:ShowEnemy(self.CurrentEnemyName)
		end
	end)
	local closeButton = self.Root:FindFirstChild("CloseButton")

	if closeButton then
		closeButton.Activated:Connect(function()
			self:HideMainWindow()
		end)
		UserInputService.InputBegan:Connect(function(input)
			if self.Root.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
				self:HideMainWindow()
			end
		end)
	end

	local attributes = self.Root.Icon:FindFirstChild("Attributes")
	local attributesHover = self.Root.Icon:FindFirstChild("AttributesHover")
	local v = { (self.Root.Parent:FindFirstChild("UIScale")) }
	self.AttributeScalingCard = ScalingCardClass.New(attributesHover, 1, v, true)

	for _, button in attributes:GetChildren() do
		if not button:IsA("ImageButton") then
			continue
		end

		local currentHoveredAttribute = button
		button.MouseEnter:Connect(function()
			local v2 = currentHoveredAttribute.AbsolutePosition.Y - self.Root.Icon.AbsolutePosition.Y + currentHoveredAttribute.AbsoluteSize.Y / 2
			self.CurrentHoveredAttribute = currentHoveredAttribute
			self.AttributeScalingCard:DeactivateAllItems()
			self.AttributeScalingCard:ActivateItem(string.upper(currentHoveredAttribute:GetAttribute("TooltipText")), {
				LayoutOrder = 1
			})
			self.AttributeScalingCard:ScaleFrame()
			self.AttributeScalingCard:SetPosition(UDim2.new(1.025, 0, 0, v2))
			self.AttributeScalingCard:ShowIfActiveItems()
		end)
		local v2 = button
		button.MouseLeave:Connect(function()
			if v2 == self.CurrentHoveredAttribute then
				self.AttributeScalingCard:Hide()
				self.CurrentHoveredAttribute = nil
			end
		end)
	end

	self.Root.Gift.Activated:Connect(function()
		if self.CurrentEnemyName then
			local overrideDisplayName = ResourceManager.GetEnemyConfig(self.CurrentEnemyName).OverrideDisplayName
				or self.CurrentEnemyName
			local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
			firstItem:SetTargetPlayerId(nil, nil)
			firstItem:SetTargetGift("Enemies", self.CurrentEnemyName, overrideDisplayName)
			Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
		end
	end)
end

function EnemyPreview:_SetupButtons(name: string)
	local enemy = ShopDataV2.Items.Enemies[name]
	local currency = enemy.Currency or "Gold"
	local buttons = self.Root.Buttons
	local purchaseMode = PurchaseHelper.GetPurchaseMode("Enemies", name)
	local v = ItemDiscountClient.GetPriceWithDiscount({ Type = "Enemies", Name = name }) or enemy.Price

	for _, guiObject in buttons:GetChildren() do
		if guiObject:IsA("GuiObject") then
			guiObject.Visible = false
		end
	end

	self.Root.Gift.Visible = true

	if Data.Get("Inventory").Enemies[name] then
		buttons.Inactive.Visible = true
		buttons.Inactive.button.holder.label.Text = "Owned"
		buttons.Inactive.button.holder.icon.Visible = false
		self.Root.Gift.Visible = purchaseMode ~= "CurrencyOnly"
	elseif enemy.IsOffsale then
		if enemy.IsOffsale then
			buttons.Inactive.Visible = true
			buttons.Inactive.button.holder.label.Text = "Offsale"
			buttons.Inactive.button.holder.icon.Visible = false
			self.Root.Gift.Visible = false
		end
	else
		if purchaseMode == "RobuxOnly" then
			local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
			classObjectYields:SetRobuxPrice(enemy.PriceInRobux)
			buttons.Buy.Visible = true
			self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
				PurchaseHelper.PromptPurchaseWithRobux("Enemies", name)
			end))
		elseif purchaseMode == "CurrencyOnly" then
			local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
			classObjectYields:SetCurrencyPrice(currency, v)
			buttons.Buy.Visible = true
			self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
				PurchaseHelper.PromptEnemyPurchase(name)
			end))
		elseif purchaseMode == "Both" then
			local classObjectYields = Director.GetClassObjectYields(buttons.BuySplit, Director.Classes.SplitBuyButton)
			classObjectYields:SetRobuxPrice(enemy.PriceInRobux)
			classObjectYields:SetCurrencyPrice(currency, v)
			self.Cleaner:Add(classObjectYields.RobuxButton.Activated:Connect(function()
				PurchaseHelper.PromptPurchaseWithRobux("Enemies", name)
			end))
			self.Cleaner:Add(classObjectYields.CurrencyButton.Activated:Connect(function()
				PurchaseHelper.PromptEnemyPurchase(name)
			end))
			buttons.BuySplit.Visible = true
		elseif purchaseMode == "FromCrate" and enemy.FromBundle then
			local bundleLink = buttons.BundleLink
			bundleLink.button.Frame.bottom.Text = Lang.Get(Lang.Strings.AssetInfo.Bundles[enemy.FromBundle].Name)
			bundleLink.Visible = true
			self.Cleaner:Add(bundleLink.button.Activated:Connect(function()
				UIHelper.NavigateToBundlePreview("PVP", enemy.FromBundle, self.CurrentEnemyDisplayName, function()
					self:ShowEnemy(name)
					self.Root.Visible = true
				end)
			end))
		else
			warn("Purchase mode is not supported yet")
		end

		local gift = self.Root.Gift
		gift.Visible = purchaseMode ~= "CurrencyOnly" and purchaseMode ~= "FromCrate"
	end
end

function EnemyPreview:ShowEnemy(currentEnemyName: string)
	self.Cleaner:Clean()
	local enemyConfig = ResourceManager.GetEnemyConfig(currentEnemyName)
	local enemy = ShopDataV2.Items.Enemies[currentEnemyName]
	self.CurrentEnemyName = currentEnemyName
	self.CurrentEnemyData = enemyConfig
	self.CurrentEnemyDisplayName = enemyConfig.OverrideDisplayName or currentEnemyName
	self.Root.Details.EnemyName.Text = string.upper(self.CurrentEnemyDisplayName)
	self.Root.Details.EnemyDescription.Text = Lang.Get(Lang.Strings.AssetInfo.Enemies[currentEnemyName].Description)
	self.Root.Details.DeployCost.Value.Text = `${Utilities.FormatNumberWithCommas(enemyConfig.SendCost or 0)}`
	self.Root.Details.DeployCost.Visible = enemyConfig.SendCost ~= nil
	self.Root.Details.MinWave.Value.Text = tostring(enemyConfig.UnlockWave)
	self.Root.Details.MinWave.Visible = enemyConfig.UnlockWave ~= nil
	self.Root.Details.BuildTime.Value.Text = tostring(enemyConfig.BuildDuration)
	self.Root.Details.BuildTime.Visible = enemyConfig.BuildDuration ~= nil
	local eco = self.Root.Details:FindFirstChild("Eco")

	if eco then
		local sendEco = enemyConfig.SendEco
		eco.Visible = sendEco ~= nil

		if sendEco ~= nil then
			eco.Value.Text = Utilities.FormatNumberWithCommas((math.abs(sendEco)))
			local v = sendEco >= 0
			local color

			if v then
				color = Color3.fromRGB(0, 255, 0)
			else
				color = Color3.fromRGB(255, 0, 0)
			end

			eco.Value.TextColor3 = color
			eco.IconFrame.Icon.ImageColor3 = color
			eco.IconFrame.Icon.Rotation = v and 0 or 180
		end
	end

	self:_AddStatLine(`Health: {Utilities.FormatNumberWithCommas(enemyConfig.Health)}`, "rbxassetid://103814500469848")

	if enemyConfig.Shield ~= nil then
		self:_AddStatLine(
			`Shield: {Utilities.FormatNumberWithCommas(enemyConfig.Shield)}`,
			"rbxassetid://129365774406947"
		)
	end

	self:_AddStatLine(`Speed: {enemyConfig.Speed}`, "rbxassetid://83017077237761")

	if enemyConfig.DamageReductionTable then
		for _, v in enemyConfig.DamageReductionTable do
			if not (v.DamageReduction and v.DamageReduction > 0) then
				continue
			end

			local v2 = math.round(v.DamageReduction * 100)
			local v3 = Shared.DAMAGE_TYPE_ICONS[v.DamageType] or "rbxassetid://95034411513042"
			local v4 = Shared.DAMAGE_TYPE_ICON_COLORS[v.DamageType] or Color3.fromRGB(255, 255, 255)
			self:_AddStatLine(`{v.DamageType} Resistance: {v2}%`, v3, v4)
		end
	end

	local attributes = self.Root.Icon.Attributes
	attributes.Flying.Visible = enemyConfig.AirUnit == true
	attributes.StealthDetection.Visible = enemyConfig.StealthDetection == true
	attributes.StunImmunity.Visible = enemyConfig.StunResistance == true
	EnemyViewport.Build(self.Root.Icon, currentEnemyName, {
		RotationOffset = enemy.ViewportRotationOffset,
		PositionOffset = enemy.ViewportPositionOffset,
		Zoom = enemy.ViewportZoom
	})
	self:_SetupButtons(currentEnemyName)
end

function EnemyPreview:HideMainWindow()
	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
	end

	self.Root.Visible = false
end

function EnemyPreview:_AddStatLine(text: string, image: string, color: Color3?)
	local clone = self.Root.Stats.Frame.Template:Clone()
	clone.Visible = true
	clone.Icon.Image = image
	clone.Icon.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
	clone.Label.Text = text
	clone.Parent = self.Root.Stats.Frame
	self.Cleaner:Add(clone)
end

function EnemyPreview.Destroy(_) end

Director.Register(script.Name, { EnemyPreview }, game.Players)
return EnemyPreview