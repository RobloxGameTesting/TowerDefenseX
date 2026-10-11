local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ItemDiscountClient = require(ReplicatedFirst.Client.ItemDiscountClient)
local ClientUtil = require(ReplicatedFirst.Util.ClientUtil)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
require(Common:WaitForChild("Enums"))
local Director = require(TDX_Shared.Modules.Director)
local Tabs = require(game.ReplicatedFirst.Classes.UI.Frames.Tabs)
local ShopUtil = require(ReplicatedStorage.Modules.ShopUtil)
local Shared = require(TDX_Shared.Modules.Shared)
local Utilities = require(Common.Utilities)
local ItemBox = require(game.ReplicatedFirst.Classes.UI.V2.ItemBox)
local ItemBoxGrid = require(game.ReplicatedFirst.Classes.UI.V2.ItemBoxGrid)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Data = require(TDX_Shared.Client.Services.Data)

local function log(...)
	if RunService:IsStudio() then
		print("[PVPShopWindow]", ...)
	end
end

local PVPShopWindow = { ClassName = "PVPShopWindow", ClassModule = script }
PVPShopWindow.__index = PVPShopWindow
local v = {
	Featured = function(object)
		object.DailyDealCountdownThread = task.spawn(function()
			while true do
				local v = math.max(workspace:GetAttribute("PVPShopRefreshTimestamp") - os.time(), 0)
				object.Root.Pages.Featured.DailyDeal.TimerLabel.Text = Utilities.ConvertToTimeStringFull(v)
				task.wait(1)
			end
		end)
		local clone = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBox:Clone()
		clone.Parent = object.Root.Pages.Featured.DailyDeal.Container.Inner
		clone.Position = UDim2.fromScale(0.5, 0.5)
		clone.Size = UDim2.new(0, clone.Size.X.Offset, 0.9, 0)
		clone.AnchorPoint = Vector2.new(0.5, 0.5)
		clone.Visible = false
		clone:AddTag("ItemBox")
		object.DailyFeatureItemBox = Director.GetClassObjectYields(clone, ItemBox)
		object.DailyFeatureItemBox.Activated:Connect(function()
			object:_OnDailyFeatureClicked()
		end)
		object:_OnDailyFeatureUpdated()
		workspace:GetAttributeChangedSignal("PVPShopFeaturedItem"):Connect(function()
			object:_OnDailyFeatureUpdated()
		end)
		ItemDiscountClient.DiscountsChanged:Connect(function()
			object:_OnDailyFeatureUpdated()
		end)
		object:_InitBundleCards()
	end,
	Enemies = function(object)
		object.EnemiesItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.Enemies,
			Director.Classes.ItemBoxGrid
		)
		object.EnemiesItemBoxGrid:AddItemsFromShopData("Enemies", nil, function(data)
			data.Activated:Connect(function()
				UIHelper.NativateToEnemyPreview("PVP", data.ItemName, "PVP Shop", function()
					object:Show()
				end)
			end)
			data.Root.Buttons.GoToCrate.Button.Activated:Connect(function()
				local enemy = ShopDataV2.Items.Enemies[data.ItemName]

				if enemy and enemy.FromBundle then
					UIHelper.NavigateToBundlePreview("PVP", enemy.FromBundle, "PVP Shop", function()
						object:Show()
					end)
				end
			end)
		end)
		object.PageToItemBoxMap.Enemies = object.EnemiesItemBoxGrid
	end,
	PowerUps = function(object)
		ItemBoxGrid.ConfigureVirtualScrolling(object.Root.Pages.PowerUps, false)
		object.PowerUpsItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.PowerUps,
			Director.Classes.ItemBoxGrid
		)
		object.PowerUpsItemBoxGrid:AddItemsFromShopData("PowerUps", function(p)
			return ShopDataV2.Items.PowerUps[p].PVPOnly == true
		end, function(p)
			p.Activated:Connect(function()
				UIHelper.NavigateToPowerUpPreview("PVP", p.ItemName, "PVP Shop", function()
					object:Show()
				end)
			end)
		end)
		object.PowerUpsItemBoxGrid:DisableCategories()
		object.PageToItemBoxMap.PowerUps = object.PowerUpsItemBoxGrid
	end
}

function PVPShopWindow.new(root)
	return (setmetatable({ Root = root, PageToItemBoxMap = {}, InitializedPages = {} }, PVPShopWindow))
end

function PVPShopWindow:Init()
	self.Tabs = Director.GetClassObjectYields(self.Root.Tabs, Tabs)
	self.Tabs.OnTabClicked:Connect(function(p)
		self:ShowPage(p)
	end)
	self:ShowPage("Featured")
	self.Root:FindFirstChild("CloseButton").Activated:Connect(function()
		self.Root.Visible = false
	end)
	UserInputService.InputBegan:Connect(function(input)
		if self.Root.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
			self.Root.Visible = false
		end
	end)

	if Shared.IS_DEV_PLACE then
		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if
				not gameProcessed
				and input.UserInputType == Enum.UserInputType.Keyboard
				and input.KeyCode == Enum.KeyCode.P
			then
				self.Root.Visible = not self.Root.Visible
			end
		end)
	end

	Data.Updated:Connect(function(p)
		if p == "Inventory" and self.InitializedPages.Featured then
			self:_UpdateBundleCards()
		end

		if
			p == "Inventory"
			or p == "Loadout"
			or p == "TowerSkins"
			or p == "PowerUpsLoadout"
			or p == "NameTagEffect"
			or p == "Emotes"
			or p == "EnemiesLoadout"
		then
			if not self.Root.Visible then
				log("Skipping ItemBox updates because window is not visible")
				return
			end

			local selectedTab = self.Tabs:GetSelectedTab()

			if self.PageToItemBoxMap[selectedTab] then
				self.PageToItemBoxMap[selectedTab]:Update(true, true)
			end
		end
	end)
	self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if self.Root.Visible then
			local selectedTab = self.Tabs:GetSelectedTab()
			local v2 = self.PageToItemBoxMap[selectedTab]

			if v2 then
				v2:Update(true)
			end
		end
	end)
end

function PVPShopWindow:ShowPage(p: string)
	if not self.InitializedPages[p] then
		self.InitializedPages[p] = true
		local v2 = v[p]

		if v2 then
			log(`Initializing page {p}`)
			v2(self)
		end
	end

	self.Tabs:SetSelectedTab(p)

	for _, frame in self.Root.Pages:GetChildren() do
		if frame:IsA("Frame") then
			frame.Visible = frame.Name == p
		end
	end

	local v2 = self.PageToItemBoxMap[p]

	if v2 then
		v2:Update(true)
	end
end

function PVPShopWindow:_OnDailyFeatureUpdated()
	local pvpShopFeaturedItem = workspace:GetAttribute("PVPShopFeaturedItem")

	if pvpShopFeaturedItem ~= nil then
		local decodeItemIdentifier = ShopUtil.DecodeItemIdentifier(pvpShopFeaturedItem)
		log(`Featured item = {decodeItemIdentifier.Name}, type = {decodeItemIdentifier.Type}`)
		self.DailyFeatureItemBox:SetItem(decodeItemIdentifier.Type, decodeItemIdentifier.Name)
		self.DailyFeatureItemBox.Root.Visible = true
		local discount = ItemDiscountClient.GetDiscount(decodeItemIdentifier)

		if discount ~= nil then
			self.Root.Pages.Featured.DailyDeal.Container.Discount.Text = string.format("-%d%%", (math.floor(discount * 100)))
		end
	end

	self.Root.Pages.Featured.DailyDeal.Container.Discount.Visible = pvpShopFeaturedItem ~= nil
end

function PVPShopWindow:_OnDailyFeatureClicked()
	local category = self.DailyFeatureItemBox.Category
	local itemName = self.DailyFeatureItemBox.ItemName

	if category == "Towers" then
		UIHelper.NavigateToTowerPreview("PVP", itemName, nil, "PVP Shop", function()
			self:Show()
		end)
	elseif category == "Enemies" then
		UIHelper.NativateToEnemyPreview("PVP", itemName, "PVP Shop", function()
			self:Show()
		end)
	else
		warn(`Unsupported category {category} for daily feature`)
	end
end

function PVPShopWindow:_InitBundleCards()
	local bundles = self.Root.Pages.Featured.Bundles
	local bundleCardTemplate = bundles.BundleCardTemplate
	bundleCardTemplate.Visible = false
	local v2 = {}

	for k, bundle in ShopDataV2.Items.Bundles do
		if not bundle.PVPOnly or bundle.IsOffsale then
			continue
		end

		local clone = bundleCardTemplate:Clone()
		clone.Parent = bundles
		clone.Visible = true
		clone.Name = k
		clone.LayoutOrder = bundle.LayoutOrder or 0
		clone.NameLabel.Text = Lang.Get(Lang.Strings.AssetInfo.Bundles[k].Name)
		clone.ImageLabel.Image = bundle.Image or "rbxassetid://0"
		local v3 = k
		clone.Activated:Connect(function()
			UIHelper.NavigateToBundlePreview("PVP", v3, "PVP Shop", function()
				self:Show()
			end)
		end)
		local classObjectYields = Director.GetClassObjectYields(clone.Buttons.BuyRobux, Director.Classes.BuyButton)
		local v4 = k
		classObjectYields.Root.Button.Activated:Connect(function()
			log(`Clicked button to purchase bundle {v4} with Robux`)
			PurchaseHelper.PromptPurchaseWithRobux("Bundles", v4)
		end)
		local v5 = k
		Director.GetClassObjectYields(clone.Buttons.BuyCurrency, Director.Classes.BuyButton).Root.Button.Activated:Connect(function()
			log(`Clicked button to purchase bundle {v5} with currency`)
			PurchaseHelper.PromptBundlePurchase(v5)
		end)
		table.insert(v2, { Card = clone, BuyRobuxButton = classObjectYields.Root.Button })
		self:_UpdateBundleCards()
	end

	table.sort(v2, function(a, b)
		if a.Card.LayoutOrder == b.Card.LayoutOrder then
			return a.Card.Name < b.Card.Name
		end

		return a.Card.LayoutOrder < b.Card.LayoutOrder
	end)

	for k, v3 in v2 do
		local v4 = v2[k - 1]
		local v5 = v2[k + 1]

		if v4 then
			v3.Card.NextSelectionUp = v4.Card
		end

		if v5 then
			v3.Card.NextSelectionDown = v5.Card
		end

		v3.Card.NextSelectionRight = v3.BuyRobuxButton
	end
end

function PVPShopWindow:_UpdateBundleCards()
	for childName, bundle in ShopDataV2.Items.Bundles do
		if not bundle.PVPOnly or bundle.IsOffsale then
			continue
		end

		local child = self.Root.Pages.Featured.Bundles:FindFirstChild(childName)

		if not child then
			continue
		end

		local classObjectYields = Director.GetClassObjectYields(child.Buttons.BuyRobux, Director.Classes.BuyButton)
		local classObjectYields2 = Director.GetClassObjectYields(child.Buttons.BuyCurrency, Director.Classes.BuyButton)

		if ClientUtil.OwnsItem("Bundles", childName) then
			classObjectYields.Root.Visible = false
			classObjectYields2.Root.Visible = false
			child.Buttons.Owned.Visible = true
		else
			if bundle.PriceInRobux == nil then
				classObjectYields.Root.Visible = false
			else
				classObjectYields:SetRobuxPrice(bundle.PriceInRobux)
			end

			if bundle.IsRobuxOnly then
				classObjectYields2.Root.Visible = false
			else
				classObjectYields2:SetCurrencyPrice(bundle.Currency or "Gold", bundle.Price)
			end
		end
	end
end

function PVPShopWindow:Show()
	self.Root.Visible = true
end

if _G.PVP_SHOP_ENABLED then
	Director.Register("PVPShopWindow", { PVPShopWindow }, Players)
end

return PVPShopWindow