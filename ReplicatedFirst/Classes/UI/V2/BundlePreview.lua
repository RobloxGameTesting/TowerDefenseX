local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Crates = require(ReplicatedStorage.TDX_Shared.Modules.Crates)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local ClientUtil = require(ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local EnemyViewport = require(ReplicatedStorage.TDX_Shared.Common.EnemyViewport)
local BundlePreview = { ClassName = script.Name, ClassModule = script }
BundlePreview.__index = BundlePreview

function BundlePreview.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrentBundleName = nil,
		WindowHandlerGroupName = UIHelper.FindWindowHandlerGroup(root) or "V3"
	}, BundlePreview))
end

function BundlePreview:Init()
	Data.Updated:Connect(function(p)
		if (p == "Inventory" or p == "Loadout" or p == "XP") and self.CurrentBundleName then
			self:ShowBundle(self.CurrentBundleName)
		end
	end)
	ItemDiscountClient.DiscountsChanged:Connect(function()
		if self.CurrentBundleName then
			self:ShowBundle(self.CurrentBundleName)
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

function BundlePreview:_SetupButtons(name: string)
	local bundle = ShopDataV2.Items.Bundles[name]
	local currency = bundle.Currency or "Gold"
	local buttons = self.Root.Buttons
	local purchaseMode = PurchaseHelper.GetPurchaseMode("Bundles", name)
	local v = ItemDiscountClient.GetPriceWithDiscount({ Type = "Bundles", Name = name }) or bundle.Price

	for _, guiObject in buttons:GetChildren() do
		if guiObject:IsA("GuiObject") then
			guiObject.Visible = false
		end
	end

	if self.Root:FindFirstChild("Gift") then
		self.Root.Gift.Visible = false
	end

	if ClientUtil.OwnsItem("Bundles", name) then
		buttons.Inactive.Visible = true
		buttons.Inactive.button.holder.label.Text = "Owned"
		buttons.Inactive.button.holder.icon.Visible = false
	elseif bundle.IsOffsale then
		if bundle.IsOffsale then
			buttons.Inactive.Visible = true
			buttons.Inactive.button.holder.label.Text = "Offsale"
			buttons.Inactive.button.holder.icon.Visible = false
		end
	elseif purchaseMode == "RobuxOnly" then
		local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
		classObjectYields:SetRobuxPrice(bundle.PriceInRobux)
		buttons.Buy.Visible = true
		self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
			PurchaseHelper.PromptPurchaseWithRobux("Bundles", name)
		end))
	elseif purchaseMode == "CurrencyOnly" then
		local classObjectYields = Director.GetClassObjectYields(buttons.Buy, Director.Classes.BuyButton)
		classObjectYields:SetCurrencyPrice(currency, v)
		buttons.Buy.Visible = true
		self.Cleaner:Add(classObjectYields.Root.Button.Activated:Connect(function()
			PurchaseHelper.PromptBundlePurchase(name)
		end))
	else
		if purchaseMode ~= "Both" then
			warn("Purchase mode is not supported yet")
			return
		end

		local classObjectYields = Director.GetClassObjectYields(buttons.BuySplit, Director.Classes.SplitBuyButton)
		classObjectYields:SetRobuxPrice(bundle.PriceInRobux)
		classObjectYields:SetCurrencyPrice(currency, v)
		self.Cleaner:Add(classObjectYields.RobuxButton.Activated:Connect(function()
			PurchaseHelper.PromptPurchaseWithRobux("Bundles", name)
		end))
		self.Cleaner:Add(classObjectYields.CurrencyButton.Activated:Connect(function()
			PurchaseHelper.PromptBundlePurchase(name)
		end))
		buttons.BuySplit.Visible = true
	end
end

function BundlePreview:ShowBundle(currentBundleName: string)
	self.Cleaner:Clean()
	self.CurrentBundleName = currentBundleName
	local bundle = ShopDataV2.Items.Bundles[currentBundleName]
	local text = string.upper(Lang.Get(Lang.Strings.AssetInfo.Bundles[currentBundleName].Name))
	self.Root.Details.BundleName.Text = text
	self.Root.Details.BundleDescription.Text = Lang.Get(Lang.Strings.AssetInfo.Bundles[currentBundleName].Description)
	local scrollingFrame = self.Root.Contents.ScrollingFrame

	for _, button in scrollingFrame:GetChildren() do
		if button:IsA("ImageButton") and button.Name ~= "Template" then
			button:Destroy()
		end
	end

	if bundle.Contents then
		for k, content in bundle.Contents do
			for _, name in content do
				local clone = scrollingFrame.Template:Clone()
				clone.Name = name
				clone.Owned.Visible = ClientUtil.OwnsItem(k, name)
				clone.Visible = true
				clone.Parent = scrollingFrame
				self.Cleaner:Add(clone)
				local v = ShopDataV2.Items[k][name]

				if k == "Skins" then
					local skinData = Crates.GetSkinData(name)
					local v2, v3 = unpack(string.split(name, "_"))
					clone.Icon.Image = skinData.Image or ""
					clone.SkinName.Text = string.upper(skinData.DisplayName or v3)
					clone.ItemName.Text = string.upper(v2)
					self.Cleaner:Add(clone.Activated:Connect(function()
						UIHelper.NavigateToTowerPreview(self.WindowHandlerGroupName, v2, v3, text, function()
							self:ShowBundle(currentBundleName)
							self.Root.Visible = true
						end)
					end))
				elseif k == "Enemies" then
					local overrideDisplayName = ResourceManager.GetEnemyConfig(name).OverrideDisplayName or name
					clone.Icon.Image = ""
					EnemyViewport.Build(clone.Icon, name, {
						RotationOffset = v.ViewportRotationOffset,
						Zoom = v.ViewportZoom
					})
					clone.SkinName.Text = ""
					clone.ItemName.Text = string.upper(overrideDisplayName)
					local v2 = name
					self.Cleaner:Add(clone.Activated:Connect(function()
						UIHelper.NativateToEnemyPreview(self.WindowHandlerGroupName, v2, text, function()
							self:ShowBundle(currentBundleName)
							self.Root.Visible = true
						end)
					end))
				else
					clone.SkinName.Text = ""
					clone.ItemName.Text = string.upper(name)
				end
			end
		end
	end

	self:_SetupButtons(currentBundleName)
end

function BundlePreview:HideMainWindow()
	self.Cleaner:Clean()
	self.CurrentBundleName = nil

	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
	end

	self.Root.Visible = false
end

function BundlePreview:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { BundlePreview }, game.Players)
return BundlePreview