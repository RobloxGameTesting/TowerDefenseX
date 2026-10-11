local UpgradeShopCardClass = {}
UpgradeShopCardClass.__index = UpgradeShopCardClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local v = NetworkingHandler.GetFunction("UpgradeShopOperationRequest")
local event = BindableHandler.GetEvent("ErrorPrompt")
local upgradeShopDataHandler = nil

local function SetUpTicks(upgradeTicks, p)
	local tick = upgradeTicks:FindFirstChild("Tick")
	local clones = {}

	for i = 1, p.OverrideMaxLevel or TowerUpgradeShopUtilities.GetDefaultMaxLevel() do
		local clone = tick:Clone()
		clone.Name = "Tick_" .. tostring(i)
		clone.Parent = upgradeTicks
		table.insert(clones, clone)
	end

	tick:Destroy()
	return clones
end

local function SetTicksLevel(ticks, currentLevelForTowerAndType: number) -- 1 equivalent call inferred from this helper
	for k, item in pairs(ticks) do
		if k <= currentLevelForTowerAndType then
			item.Image = "rbxassetid://114148142738878"
		else
			item.Image = "rbxassetid://98161343147456"
		end
	end
end

function UpgradeShopCardClass.New(instance, p: number, towerName: string, p2)
	local kind = p2.Type
	local upgradeShopTypeData = TowerUpgradeShopUtilities.GetUpgradeShopTypeData(kind)
	local clone = instance:Clone()
	clone.Name = tostring(p) .. "_" .. towerName .. "_" .. kind
	clone.LayoutOrder = upgradeShopTypeData.SortOrder
	clone.Parent = instance.Parent
	local icon = clone:FindFirstChild("Icon")
	icon.Image = upgradeShopTypeData.Icon

	if upgradeShopTypeData.IconColor then
		icon.ImageColor3 = upgradeShopTypeData.IconColor
	end

	local title = clone:FindFirstChild("Title")
	title.Text = TowerUpgradeShopUtilities.GetUpgradeString(upgradeShopTypeData, p2.Amount)
	local ticks = SetUpTicks(clone:FindFirstChild("UpgradeTicks"), p2)
	local textLabel = clone:FindFirstChild("CostFrame"):FindFirstChild("TextLabel")
	local minusButton = clone:FindFirstChild("MinusButton")
	local plusButton = clone:FindFirstChild("PlusButton")
	local v2 = {
		Index = p,
		TowerName = towerName,
		UpgradeType = p2.Type,
		NewFrame = clone,
		Ticks = ticks,
		CostTextLabel = textLabel,
		MinusButton = minusButton,
		PlusButton = plusButton,
		Connections = {}
	}
	setmetatable(v2, UpgradeShopCardClass)
	table.insert(v2.Connections, minusButton.Activated:Connect(function()
		v2:_MinusPressed()
	end))
	table.insert(v2.Connections, plusButton.Activated:Connect(function()
		v2:_PlusPressed()
	end))
	v2:UpdateState()
	return v2
end

function UpgradeShopCardClass.Matches(p, p2: string, p3: string?)
	if not p3 then
		return p.TowerName == p2
	end

	return p.TowerName == p2 and p.UpgradeType == p3
end

function UpgradeShopCardClass:UpdateState()
	local interactable = upgradeShopDataHandler:CheckOperation(self.TowerName, self.UpgradeType, true, true)
	local interactable2 = upgradeShopDataHandler:CheckOperation(self.TowerName, self.UpgradeType, false, true)
	local minusButton = self.MinusButton
	local plusButton = self.PlusButton
	minusButton.Interactable = interactable
	plusButton.Interactable = interactable2
	minusButton.Image = interactable and "rbxassetid://126731501010917" or "rbxassetid://122535146995926"
	plusButton.Image = interactable2 and "rbxassetid://114037298883583" or "rbxassetid://123963039678144"
	local currentLevelForTowerAndType = upgradeShopDataHandler:GetCurrentLevelForTowerAndType(
		self.TowerName,
		self.UpgradeType
	)
	SetTicksLevel(self.Ticks, currentLevelForTowerAndType) -- inferred equivalent call
	local nextUpgradeCostForTowerAndType = upgradeShopDataHandler:GetNextUpgradeCostForTowerAndType(
		self.TowerName,
		self.UpgradeType
	)

	if interactable2 then
		self.CostTextLabel.Text = tostring(nextUpgradeCostForTowerAndType) .. " Credits"
	else
		self.CostTextLabel.Text = "N/A"
	end
end

function UpgradeShopCardClass:_MinusPressed()
	if not self:_CheckOperation(true) then
		return
	end

	SoundHandler.PlayRandom({
		"UpgradeShopRemoveUpgrade1",
		"UpgradeShopRemoveUpgrade2",
		"UpgradeShopRemoveUpgrade3",
		"UpgradeShopRemoveUpgrade4"
	})
	self:_RequestOperation(true)
end

function UpgradeShopCardClass:_PlusPressed()
	if not self:_CheckOperation() then
		return
	end

	SoundHandler.PlayRandom({
		"UpgradeShopAddUpgrade1",
		"UpgradeShopAddUpgrade2",
		"UpgradeShopAddUpgrade3",
		"UpgradeShopAddUpgrade4"
	})
	self:_RequestOperation()
end

function UpgradeShopCardClass:_CheckOperation(flag: boolean?)
	local v2, v3 = upgradeShopDataHandler:CheckOperation(self.TowerName, self.UpgradeType, flag)

	if v2 then
		return true
	end

	event:Fire(v3)
	return false
end

function UpgradeShopCardClass:_RequestOperation(flag: boolean?)
	v:InvokeServer(self.TowerName, self.UpgradeType, flag)
end

function UpgradeShopCardClass.ToggleVisibleAtIndex(p, p2: number)
	p.NewFrame.Visible = p.Index == p2
end

function UpgradeShopCardClass:Destroy()
	self.NewFrame:Destroy()

	for _, connection in pairs(self.Connections) do
		connection:Disconnect()
	end
end

upgradeShopDataHandler = PlayerClass.GetLocalPlayerWrapper():GetUpgradeShopDataHandler()
return UpgradeShopCardClass