game:GetService("MarketplaceService")
game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local ResourceManager = require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Signal = require(ReplicatedStorage.TDX_Shared.Modules.Signal)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local NewPowerUpsInventory = { ClassName = script.Name, ClassModule = script }
NewPowerUpsInventory.__index = NewPowerUpsInventory

function NewPowerUpsInventory.new(root)
	return (setmetatable({ Root = root, PageToItemBoxMap = {}, OnPowerUpClicked = Signal.new() }, NewPowerUpsInventory))
end

function NewPowerUpsInventory:Init()
	self.Tabs = Director.GetClassObjectYields(self.Root.Tabs, Director.Classes.Tabs)
	self.Tabs.OnTabClicked:Connect(function(p)
		self:ShowPage(p)
	end)
	self:ShowPage("Regular")
	local classObjectYields = Director.GetClassObjectYields(
		self.Root.Pages.Regular.Inventory.Grid,
		Director.Classes.ItemBoxGrid
	)
	classObjectYields:AddItemsFromShopData("PowerUps", function(p: string)
		return ShopDataV2.Items.PowerUps[p].PVPOnly ~= true
	end, function(p)
		p.Activated:Connect(function()
			self.OnPowerUpClicked:Fire(p.ItemName)
		end)
	end)
	self.PageToItemBoxMap.Regular = classObjectYields
	local classObjectYields2 = Director.GetClassObjectYields(
		self.Root.Pages.PVP.Inventory.Grid,
		Director.Classes.ItemBoxGrid
	)
	classObjectYields2:AddItemsFromShopData("PowerUps", function(p: string)
		return ShopDataV2.Items.PowerUps[p].PVPOnly == true
	end, function(p)
		p.Activated:Connect(function()
			self.OnPowerUpClicked:Fire(p.ItemName)
		end)
	end)
	self.PageToItemBoxMap.PVP = classObjectYields2

	for _, frame in self.Root.Pages.PVP.Loadout.Container.Slots:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		local name = frame.Name
		frame.Unequip.Activated:Connect(function()
			local v = Data.Get("PVPPowerUpsLoadout")[name]

			if v ~= "" then
				SoundHandler.Play("ClickUp")
				Network.Fire("ClientUnequipPowerUpRequest", v)
			end
		end)
	end
end

function NewPowerUpsInventory:ShowPage(p: string)
	self.Tabs:SetSelectedTab(p)

	for _, frame in self.Root.Pages:GetChildren() do
		if frame:IsA("Frame") then
			frame.Visible = frame.Name == p
		end
	end

	local v = self.PageToItemBoxMap[p]

	if v then
		v:Update(true)
	end

	if p == "PVP" then
		self:UpdatePVPLoadoutDisplay()
	end
end

function NewPowerUpsInventory:OnDataUpdated(flag: boolean?)
	self.PageToItemBoxMap[self.Tabs:GetSelectedTab()]:Update(flag)
	self:UpdatePVPLoadoutDisplay()
end

function NewPowerUpsInventory:UpdatePVPLoadoutDisplay()
	local pvpPowerUpsLoadout = Data.Get("PVPPowerUpsLoadout")
	local slots = self.Root.Pages.PVP.Loadout.Container.Slots

	for childName, v in pvpPowerUpsLoadout do
		local child = slots:FindFirstChild(childName)

		if child then
			if v == "" then
				child.Count.Visible = false
				child.Unequip.Visible = false
				child.Icon.Visible = false
			elseif ResourceManager.GetRegularPowerUpConfig(v) then
				local v2 = Data.Get("Inventory").PowerUps[v] or 0
				child.Count.Visible = true
				child.Count.Label.Text = tostring(v2)
				child.Unequip.Visible = true
				child.Icon.Image = PowerUpsData[v].MiniImage
				child.Icon.Visible = true
			else
				warn(`Could not find config for powerup {v}`)
			end
		else
			warn(`Could not find slot {childName} in the powerups loadout display.`)
		end
	end
end

function NewPowerUpsInventory.Destroy(_) end

Director.Register(script.Name, { NewPowerUpsInventory }, game.Players)
return NewPowerUpsInventory