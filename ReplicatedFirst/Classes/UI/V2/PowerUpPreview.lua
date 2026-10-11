local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(ReplicatedStorage.TDX_Shared.Modules.Util)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
require(ReplicatedFirst.Util.UIHelper)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local PowerUpPreview = { ClassName = script.Name, ClassModule = script }
PowerUpPreview.__index = PowerUpPreview

function PowerUpPreview.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), CurrPowerUp = nil }, PowerUpPreview))
end

function PowerUpPreview:Init()
	self.Root.Gift.Activated:Connect(function()
		if not self.CurrPowerUp then
			return
		end

		local powerUp = ShopDataV2.Items.PowerUps[self.CurrPowerUp]
		local quantityForRobux = powerUp.QuantityForRobux or powerUp.Quantity or 1
		local formatted = `x{quantityForRobux} {self.CurrPowerUp}`
		local formatted2 = `x{quantityForRobux} {Lang.Get(Lang.Strings.AssetInfo.PowerUps[self.CurrPowerUp].Name)}`
		local firstItem = Director.GetFirstItemFromClass(Director.Classes.GiftingWindow)
		firstItem:SetTargetPlayerId(nil, nil)
		firstItem:SetTargetGift("PowerUp", formatted, formatted2)
		Director.GetFirstItemFromClass(Director.Classes.PopupWindows):DoPopup("Gifting", function() end)
	end)
	Data.Updated:Connect(function(p)
		if p == "Inventory" and self.CurrPowerUp then
			self:ShowPowerUp(self.CurrPowerUp)
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
end

function PowerUpPreview:SetupButtons(name: string)
	local powerUp = ShopDataV2.Items.PowerUps[name]
	local currency = powerUp.Currency or "Gold"
	local buttons = self.Root.Buttons
	local purchaseMode = PurchaseHelper.GetPurchaseMode("PowerUps", name)
	local v = ItemDiscountClient.GetPriceWithDiscount({ Type = "PowerUps", Name = name }) or powerUp.Price

	for _, guiObject in buttons:GetChildren() do
		if guiObject:IsA("GuiObject") then
			guiObject.Visible = false
		end
	end

	self.Root.Gift.Visible = true

	if powerUp.IsOffsale then
		buttons.Inactive.Visible = true
		buttons.Inactive.button.holder.label.Text = "Offsale"
		buttons.Inactive.button.holder.icon.Visible = false
		self.Root.Gift.Visible = false
	elseif purchaseMode == "RobuxOnly" then
		local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
		classObjectYields:SetRobuxPrice(powerUp.PriceInRobux)
		buttons.Buy.Visible = true
		self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
			PurchaseHelper.PromptPurchaseWithRobux("PowerUps", name)
		end))
	elseif purchaseMode == "CurrencyOnly" then
		local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
		classObjectYields:SetCurrencyPrice(currency, v)
		buttons.Buy.Visible = true
		self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
			PurchaseHelper.PromptPowerUpPurchase(name)
		end))
	else
		if purchaseMode ~= "Both" then
			warn("Purchase mode is not supported yet")
			return
		end

		local classObjectYields = Director.GetClassObjectYields(buttons.BuySplit, Director.Classes.SplitBuyButton)
		classObjectYields:SetRobuxPrice(powerUp.PriceInRobux)
		classObjectYields:SetRobuxLabel(`Buy {powerUp.QuantityForRobux or 1}`)
		classObjectYields:SetCurrencyPrice(currency, powerUp.Price)
		classObjectYields:SetCurrencyLabel(`Buy {powerUp.Quantity or 1}`)
		self.Cleaner:Add(classObjectYields.RobuxButton.Activated:Connect(function()
			PurchaseHelper.PromptPurchaseWithRobux("PowerUps", name)
		end))
		self.Cleaner:Add(classObjectYields.CurrencyButton.Activated:Connect(function()
			PurchaseHelper.PromptPowerUpPurchase(name)
		end))
		buttons.BuySplit.Visible = true
	end
end

function PowerUpPreview:ShowPowerUp(currPowerUp: string)
	self.Cleaner:Clean()
	self.CurrPowerUp = currPowerUp
	local text = Lang.Get(Lang.Strings.AssetInfo.PowerUps[currPowerUp].Name)
	local powerUp = ShopDataV2.Items.PowerUps[currPowerUp]
	self.Root.Icon.Image = PowerUpsData[currPowerUp].NoBGImage
	local v = Data.Get("Inventory").PowerUps[self.CurrPowerUp] or 0
	self.Root.Details.PowerUpName.Text = text
	self.Root.Details.Count.Visible = v > 0
	self.Root.Details.Count.Label.Text = `You own {v}`
	self.Root.Details.PowerUpDescription.Text = Lang.Get(Lang.Strings.AssetInfo.PowerUps[currPowerUp].Description)
	local gift = self.Root.Gift
	gift.Visible = powerUp.ProductId ~= nil and not powerUp.IsOffsale
	self.Root.Details.PVPOnly.Visible = powerUp.PVPOnly == true
	self:SetupButtons(currPowerUp)
end

function PowerUpPreview:HideMainWindow()
	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
	end

	self.Root.Visible = false
	self.CurrPowerUp = false
end

function PowerUpPreview.ShowMainWindow(p)
	p.Root.Visible = true
end

function PowerUpPreview.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { PowerUpPreview }, game.Players)
return PowerUpPreview