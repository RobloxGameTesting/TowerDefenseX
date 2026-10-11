local UpgradeShopTabButtonClass = {}
UpgradeShopTabButtonClass.__index = UpgradeShopTabButtonClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local color = Color3.fromHex("84B60B")
local color2 = Color3.fromHex("B4FF00")

local function GetTowerIcon(p: string, p2)
	if p2.TowerUpgradeShopTabIcon then
		return p2.TowerUpgradeShopTabIcon, false
	end

	local v = p == Enums.Towers.Juggernaut
	local upgradePathData = p2.UpgradePathData
	local path1Data = upgradePathData.Path1Data
	local path2Data = upgradePathData.Path2Data
	return path2Data and path2Data[#path2Data].Icon or path1Data[#path1Data].Icon, v
end

function UpgradeShopTabButtonClass.New(instance, layoutOrder: number, p: string, callback)
	local towerConfig = ResourceManager.GetTowerConfig(p)

	if not towerConfig then
		return
	end

	local towerUpgradeShopTabIcon, v

	if towerConfig.TowerUpgradeShopTabIcon then
		towerUpgradeShopTabIcon = towerConfig.TowerUpgradeShopTabIcon
		v = false
	else
		v = p == Enums.Towers.Juggernaut
		local upgradePathData = towerConfig.UpgradePathData
		local path1Data = upgradePathData.Path1Data
		local path2Data = upgradePathData.Path2Data
		towerUpgradeShopTabIcon = path2Data and path2Data[#path2Data].Icon or path1Data[#path1Data].Icon
	end

	local clone = instance:Clone()
	clone.Name = tostring(layoutOrder) .. "_" .. p
	clone.LayoutOrder = layoutOrder
	clone.Parent = instance.Parent
	local towerName = clone:FindFirstChild("TowerName")
	local uiTextSizeConstraint = towerName:FindFirstChild("UITextSizeConstraint")
	towerName.Text = towerConfig.OverrideDisplayName or p
	local hoveredFrame = clone:FindFirstChild("HoveredFrame")
	local selectedFrame = clone:FindFirstChild("SelectedFrame")
	local selectedGlow = clone:FindFirstChild("SelectedGlow")
	local towerIcon = clone:FindFirstChild("TowerIcon")
	local towerIconOld = clone:FindFirstChild("TowerIconOld")

	if v then
		towerIconOld.Image = towerUpgradeShopTabIcon
		towerIconOld.Visible = true
		towerIcon.Visible = false
	else
		towerIcon.Image = towerUpgradeShopTabIcon
		towerIconOld.Visible = false
		towerIcon.Visible = true
	end

	local v2 = {
		Index = layoutOrder,
		Button = clone,
		TextLabel = towerName,
		TextSizeConstraint = uiTextSizeConstraint,
		HoveredFrame = hoveredFrame,
		SelectedFrame = selectedFrame,
		SelectedGlow = selectedGlow,
		Hovered = false,
		Selected = false,
		Connections = {}
	}
	setmetatable(v2, UpgradeShopTabButtonClass)
	table.insert(v2.Connections, clone.Activated:Connect(function()
		callback(layoutOrder)
	end))
	table.insert(v2.Connections, clone.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	table.insert(v2.Connections, clone.MouseButton1Up:Connect(function()
		SoundHandler.Play("ClickUp")
	end))
	table.insert(v2.Connections, clone.MouseEnter:Connect(function()
		v2:_ToggleHovered(true)
	end))
	table.insert(v2.Connections, clone.MouseLeave:Connect(function()
		v2:_ToggleHovered(false)
	end))
	v2:_UpdateState()
	clone.Visible = true
	return v2
end

function UpgradeShopTabButtonClass.GetTextLabel(p)
	return p.TextLabel, p.TextSizeConstraint
end

function UpgradeShopTabButtonClass:_ToggleHovered(hovered: boolean)
	if self.Hovered == hovered then
		return
	end

	self.Hovered = hovered
	self:_UpdateState()
end

function UpgradeShopTabButtonClass:ToggleSelected(selected: boolean)
	if self.Selected == selected then
		return
	end

	self.Selected = selected
	self:_UpdateState()
end

function UpgradeShopTabButtonClass:Destroy()
	self.Button:Destroy()

	for _, connection in pairs(self.Connections) do
		connection:Disconnect()
	end
end

function UpgradeShopTabButtonClass:_UpdateState()
	if self.Selected then
		self.SelectedFrame.Visible = true
		self.SelectedGlow.Visible = true
		self.HoveredFrame.Visible = true
		self.TextLabel.TextColor3 = color2
	elseif self.Hovered then
		self.SelectedFrame.Visible = false
		self.SelectedGlow.Visible = false
		self.HoveredFrame.Visible = true
		self.TextLabel.TextColor3 = color2
	else
		self.SelectedFrame.Visible = false
		self.SelectedGlow.Visible = false
		self.HoveredFrame.Visible = false
		self.TextLabel.TextColor3 = color
	end
end

return UpgradeShopTabButtonClass