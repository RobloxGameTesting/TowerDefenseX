local ReplicatedFirst = game:GetService("ReplicatedFirst")
game:GetService("MarketplaceService")
game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
TDX_Shared:WaitForChild("Common")
local Director = require(TDX_Shared.Modules.Director)
local ItemBoxGrid = require(game.ReplicatedFirst.Classes.UI.V2.ItemBoxGrid)
local Tabs = require(game.ReplicatedFirst.Classes.UI.Frames.Tabs)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local Data = require(TDX_Shared.Client.Services.Data)

local function log(...)
	if RunService:IsStudio() then
		print("[NewShopWindow]", ...)
	end
end

local NewShopWindow = { ClassName = "NewShopWindow", ClassModule = script }
NewShopWindow.__index = NewShopWindow
local v = {
	Towers = function(object)
		object.TowersItemBoxGrid = Director.GetClassObjectYields(object.Root.Pages.Towers, Director.Classes.ItemBoxGrid)
		object.TowersItemBoxGrid:AddItemsFromShopData("Towers", nil, function(p)
			p.Activated:Connect(function()
				UIHelper.NavigateToTowerPreview("V3", p.ItemName, nil, "Shop", function()
					object:Show()
				end)
			end)
		end)
		object.PageToItemBoxMap.Towers = object.TowersItemBoxGrid
	end,
	Skins = function(object)
		ItemBoxGrid.ConfigureVirtualScrolling(object.Root.Pages.Skins, false)
		object.SkinsItemBoxGrid = Director.GetClassObjectYields(object.Root.Pages.Skins, Director.Classes.ItemBoxGrid)
		object.SkinsItemBoxGrid:AddItemsFromShopData("Skins", nil, function(data)
			data.Activated:Connect(function()
				local v, v2 = unpack(data.ItemName:split("_"))
				UIHelper.NavigateToTowerPreview("V3", v, v2, "Shop", function()
					object:Show()
				end)
			end)
			data.Root.Buttons.GoToCrate.Button.Activated:Connect(function()
				local skin = ShopDataV2.Items.Skins[data.ItemName]

				if skin and skin.FromCrate then
					UIHelper.NavigateToCratePreview("V3", skin.FromCrate, "Shop", function()
						object:Show()
					end)
				end
			end)
		end)
		object.SkinsItemBoxGrid:DisableCategories()
		object.PageToItemBoxMap.Skins = object.SkinsItemBoxGrid
	end,
	Crates = function(object)
		ItemBoxGrid.ConfigureVirtualScrolling(object.Root.Pages.Crates, false)
		object.CratesItemBoxGrid = Director.GetClassObjectYields(object.Root.Pages.Crates, Director.Classes.ItemBoxGrid)
		object.CratesItemBoxGrid:AddItemsFromShopData("Crates", nil, function(p)
			p.Activated:Connect(function()
				UIHelper.NavigateToCratePreview("V3", p.ItemName, "Shop", function()
					object:Show()
				end)
			end)
		end)
		object.CratesItemBoxGrid:DisableCategories()
		object.PageToItemBoxMap.Crates = object.CratesItemBoxGrid
	end,
	PowerUps = function(object)
		ItemBoxGrid.ConfigureVirtualScrolling(object.Root.Pages.PowerUps, false)
		object.PowerUpsItemBoxGrid = Director.GetClassObjectYields(
			object.Root.Pages.PowerUps,
			Director.Classes.ItemBoxGrid
		)
		object.PowerUpsItemBoxGrid:AddItemsFromShopData("PowerUps", function(p: string)
			return ShopDataV2.Items.PowerUps[p].PVPOnly ~= true
		end, function(p)
			p.Activated:Connect(function()
				UIHelper.NavigateToPowerUpPreview("V3", p.ItemName, "Shop", function()
					object:Show()
				end)
			end)
		end)
		object.PowerUpsItemBoxGrid:DisableCategories()
		object.PageToItemBoxMap.PowerUps = object.PowerUpsItemBoxGrid
	end,
	Emotes = function(state)
		ItemBoxGrid.ConfigureVirtualScrolling(state.Root.Pages.Emotes, false)
		state.EmotesItemBoxGrid = Director.GetClassObjectYields(state.Root.Pages.Emotes, Director.Classes.ItemBoxGrid)
		state.EmotesItemBoxGrid:AddItemsFromShopData("Emotes", nil, nil)
		state.EmotesItemBoxGrid:DisableCategories()
		state.PageToItemBoxMap.Emotes = state.EmotesItemBoxGrid
	end
}

function NewShopWindow.new(root)
	return (setmetatable({ Root = root, PageToItemBoxMap = {}, InitializedPages = {} }, NewShopWindow))
end

function NewShopWindow:Init()
	self.Tabs = Director.GetClassObjectYields(self.Root.Tabs, Tabs)
	self.Tabs.OnTabClicked:Connect(function(p)
		self:ShowCategory(p)
	end)
	self:ShowCategory("Towers")
	Data.Updated:Connect(function(p)
		if not self.Root.Visible then
			log("Skipping ItemBox updates because window is not visible")
		elseif
			p == "Inventory"
			or p == "Loadout"
			or p == "TowerSkins"
			or p == "PowerUpsLoadout"
			or p == "NameTagEffect"
			or p == "Emotes"
			or p == "EnemiesLoadout"
		then
			local selectedTab = self.Tabs:GetSelectedTab()
			local v2 = self.PageToItemBoxMap[selectedTab]

			if v2 then
				v2:Update(true, true)
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

function NewShopWindow:ShowCategory(p: string)
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

	local v2 = self.PageToItemBoxMap[p]

	if v2 then
		v2:Update(true)
	end
end

function NewShopWindow:Show()
	self.Root.Visible = true
end

function NewShopWindow.HideMainWindow(p)
	for _, v2 in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v2:ClearState()
	end

	p.Root.Visible = false
end

if _G.SHOP_V3_ENABLED then
	Director.Register("NewShopWindow", { NewShopWindow }, game.Players)
end

return NewShopWindow