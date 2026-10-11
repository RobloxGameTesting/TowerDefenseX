local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local V2Sidebar = { ClassName = script.Name, ClassModule = script }
V2Sidebar.__index = V2Sidebar

function V2Sidebar.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, V2Sidebar))
end

function V2Sidebar:HideAll()
	for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
		v:ShowFrame("no")
	end

	for _, v in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v:ClearState()
	end

	for _, childName in { "Shop", "Inventory", "CratePreview", "TowerPreview", "PowerUpPreview" } do
		local findFirstChild = self.Root.Parent.V2:FindFirstChild(childName)
		findFirstChild.Visible = false
	end

	if _G.SHOP_V3_ENABLED then
		for _, childName in {
			"NewInventory",
			"NewShop",
			"CratePreview",
			"TowerPreview",
			"PowerUpPreview",
			"EnemyPreview"
		} do
			local child = self.Root.Parent.V3:FindFirstChild(childName)

			if child then
				child.Visible = false
			end
		end
	end

	for _, childName in {
		"PVPShop",
		"TowerPreview",
		"EnemyPreview",
		"BundlePreview",
		"BundlePreview"
	} do
		if not self.Root.Parent:FindFirstChild("PVP") then
			continue
		end

		local findFirstChild = self.Root.Parent.PVP:FindFirstChild(childName)
		findFirstChild.Visible = false
	end
end

function V2Sidebar:NavigateToInventory(p: string?)
	local inventory = self.Root.Parent.V2.Inventory

	if _G.SHOP_V3_ENABLED then
		inventory = self.Root.Parent.V3.NewInventory

		if p then
			Director.GetFirstItemFromClass(Director.Classes.NewInventoryWindow):ShowPage(p)
		end
	end

	if inventory.Visible then
		self:HideAll()
		return
	end

	self:HideAll()
	inventory.Visible = true
end

function V2Sidebar:Init()
	self.Cleaner:Add(self.Root.ShopAndBackpack.ShopButton.Activated:Connect(function()
		if self.Root.Parent.V3.NewShop.Visible then
			self:HideAll()
			return
		end

		self:HideAll()
		self.Root.Parent.V3.NewShop.Visible = true
	end))
	self.Cleaner:Add(self.Root.ShopAndBackpack.InventoryButton.Activated:Connect(function()
		self:NavigateToInventory()
	end))
	self.Cleaner:Add(self.Root.BattlePassButton.Activated:Connect(function()
		for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
			if v:IsFrameVisible("BattlePass") then
				self:HideAll()
			else
				self:HideAll()
				v:ShowFrame("BattlePass")
			end
		end
	end))
	self.Root.NewInventoryButton.Visible = false
	self.Root.NewInventoryButton.Text = "Inventory V2 [OLD]"
	self.Root.NewInventoryButton.Activated:Connect(function()
		if self.Root.Parent.V2.Inventory.Visible then
			self:HideAll()
			return
		end

		self:HideAll()
		self.Root.Parent.V2.Inventory.Visible = true
	end)
	self.Root.NewShopButton.Visible = false
	self.Root.NewShopButton.Activated:Connect(function()
		if self.Root.Parent.V3.NewShop.Visible then
			self:HideAll()
			return
		end

		self:HideAll()
		self.Root.Parent.V3.NewShop.Visible = true
	end)
	self.Root.PVPShopButton.Visible = _G.PVP_SHOP_ENABLED
	self.Root.PVPShopButton.Activated:Connect(function()
		if self.Root.Parent.PVP.PVPShop.Visible then
			self:HideAll()
			return
		end

		self:HideAll()
		UIHelper.ShowPVPShop()
	end)
	self.Root.QuickPlayButton.Visible = not _G.NEW_PLAY_BUTTONS_ENABLED
end

function V2Sidebar.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { V2Sidebar }, game.Players)
return V2Sidebar