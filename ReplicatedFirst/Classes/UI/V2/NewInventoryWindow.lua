game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(ReplicatedFirst.Util.ClientUtil)
require(ReplicatedFirst.Util.PurchaseHelper)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
require(Common:WaitForChild("Enums"))
local Director = require(TDX_Shared.Modules.Director)
local Tabs = require(game.ReplicatedFirst.Classes.UI.Frames.Tabs)
require(ReplicatedStorage.Modules.ShopUtil)
require(TDX_Shared.Modules.Shared)
require(Common.Utilities)
require(game.ReplicatedFirst.Classes.UI.V2.ItemBox)
require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local Data = require(TDX_Shared.Client.Services.Data)
local NewPowerUpsInventory = require(script.Parent.NewPowerUpsInventory)
local ItemBoxGrid = require(script.Parent.ItemBoxGrid)

local function log(...)
	if RunService:IsStudio() then
		print("[NewInventoryWindow]", ...)
	end
end

local NewInventoryWindow = { ClassName = "NewInventoryWindow", ClassModule = script }
NewInventoryWindow.__index = NewInventoryWindow
local v = {
	Towers = function(object)
		object.TowersItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.Towers.Inventory.Grid,
			Director.Classes.ItemBoxGrid
		)
		object.TowersItemBoxGrid:AddItemsFromShopData("Towers", nil, function(p)
			p.Activated:Connect(function()
				UIHelper.NavigateToTowerPreview("V3", p.ItemName, nil, "Inventory", function()
					object:Show()
				end)
			end)
		end)
		object.PageToItemBoxMap.Towers = object.TowersItemBoxGrid
	end,
	Skins = function(object)
		object.SkinsItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.Skins.Inventory.Grid,
			Director.Classes.ItemBoxGrid
		)
		object.SkinsItemBoxGrid:AddItemsFromShopData("Skins", nil, function(p)
			p.Activated:Connect(function()
				local v, v2 = unpack(p.ItemName:split("_"))
				UIHelper.NavigateToTowerPreview("V3", v, v2, "Inventory", function()
					object:Show()
				end)
			end)
		end)
		object.SkinsItemBoxGrid:DisableCategories()
		object.PageToItemBoxMap.Skins = object.SkinsItemBoxGrid
	end,
	PowerUps = function(object)
		object.PowerUpsInventory = Director.GetClassObjectYields(object.Root.Pages.PowerUps, NewPowerUpsInventory)
		object.PowerUpsInventory.OnPowerUpClicked:Connect(function(p: string)
			UIHelper.NavigateToPowerUpPreview("V3", p, "Inventory", function()
				object:Show()
			end)
		end)
	end,
	NameTagEffects = function(state)
		state.NameTagEffectsItemBoxGrid = Director.GetClassObjectYields(
			state.Root.Pages.NameTagEffects.Inventory.Grid,
			Director.Classes.ItemBoxGrid
		)
		state.NameTagEffectsItemBoxGrid:AddItemsFromShopData("NameTagEffects", nil, nil)
		state.NameTagEffectsItemBoxGrid:DisableCategories()
		state.PageToItemBoxMap.NameTagEffects = state.NameTagEffectsItemBoxGrid
	end,
	Emotes = function(state)
		state.EmotesItemBoxGrid = Director.GetClassObjectYields(
			state.Root.Pages.Emotes.Inventory.Grid,
			Director.Classes.ItemBoxGrid
		)
		state.EmotesItemBoxGrid:AddItemsFromShopData("Emotes", nil, nil)
		state.EmotesItemBoxGrid:DisableCategories()
		state.PageToItemBoxMap.Emotes = state.EmotesItemBoxGrid
	end,
	Enemies = function(object)
		object.EnemiesItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.Enemies.Inventory.Grid,
			Director.Classes.ItemBoxGrid
		)
		object.EnemiesItemBoxGrid:AddItemsFromShopData("Enemies", nil, function(data)
			data.Activated:Connect(function()
				UIHelper.NativateToEnemyPreview("V3", data.ItemName, "Inventory", function()
					object:Show()
				end)
			end)
			data.Root.Buttons.GoToCrate.Button.Activated:Connect(function()
				local v = ShopDataV2.Items[data.Category][data.ItemName]

				if v.FromBundle then
					UIHelper.NavigateToBundlePreview("V3", v.FromBundle, "Inventory", function()
						object:Show()
					end)
				end
			end)
		end)
		object.PageToItemBoxMap.Enemies = object.EnemiesItemBoxGrid
	end
}

function NewInventoryWindow.new(root)
	return (setmetatable({ Root = root, PageToItemBoxMap = {}, InitializedPages = {} }, NewInventoryWindow))
end

function NewInventoryWindow:Init()
	ItemBoxGrid.ConfigureVirtualScrolling(self.Root.Pages.Skins.Inventory.Grid, true)
	self.Tabs = Director.GetClassObjectYields(self.Root.Tabs, Tabs)
	self.Tabs.OnTabClicked:Connect(function(p)
		self:ShowPage(p)
	end)
	self:ShowPage("Towers")
	Data.Updated:Connect(function(p)
		if
			p == "Inventory"
			or p == "Loadout"
			or p == "TowerSkins"
			or p == "PowerUpsLoadout"
			or p == "PVPPowerUpsLoadout"
			or p == "NameTagEffect"
			or p == "Emotes"
			or p == "EnemiesLoadout"
		then
			if not self.Root.Visible then
				return
			end

			local selectedTab = self.Tabs:GetSelectedTab()

			if selectedTab == "PowerUps" then
				if self.PowerUpsInventory then
					self.PowerUpsInventory:OnDataUpdated(p == "Inventory")
				end
			else
				local v2 = self.PageToItemBoxMap[selectedTab]

				if v2 then
					v2:Update(p == "Inventory")
				end
			end
		end
	end)
	self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if self.Root.Visible then
			local selectedTab = self.Tabs:GetSelectedTab()

			if selectedTab == "PowerUps" then
				if self.PowerUpsInventory then
					self.PowerUpsInventory:OnDataUpdated(true)
				end
			else
				local v2 = self.PageToItemBoxMap[selectedTab]

				if v2 then
					v2:Update(true)
				end
			end
		end
	end)
end

function NewInventoryWindow:ShowPage(p: string)
	if not self.InitializedPages[p] then
		self.InitializedPages[p] = true
		local v2 = v[p]

		if v2 then
			v2(self)
		end
	end

	self.Tabs:SetSelectedTab(p)

	for _, frame in self.Root.Pages:GetChildren() do
		if frame:IsA("Frame") then
			frame.Visible = frame.Name == p
		end
	end

	if p == "PowerUps" then
		if self.PowerUpsInventory then
			self.PowerUpsInventory:OnDataUpdated(true)
		end
	else
		local v2 = self.PageToItemBoxMap[p]

		if v2 then
			v2:Update(true)
		end
	end
end

function NewInventoryWindow:Show()
	self.Root.Visible = true
end

if _G.PVP_SHOP_ENABLED then
	Director.Register("NewInventoryWindow", { NewInventoryWindow }, Players)
end

return NewInventoryWindow