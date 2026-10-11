local TowersBar = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local ScalingHandler = require(common:WaitForChild("ScalingHandler"))
local BarButtonClass = require(script:WaitForChild("BarButtonClass"))
local TOWERS_BAR_COUNT = _G.TOWERS_BAR_COUNT
local udim = UDim2.new(0.5, 0, 1.16, 0)
local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local event = NetworkingHandler.GetEvent("ForceRefreshTowersBar")
local event2 = BindableHandler.GetEvent("StartTowerPlacement")
local event3 = BindableHandler.GetEvent("HotkeyStartTowerPlacement")
local event4 = BindableHandler.GetEvent("PVPHotkeyContextChanged")
local event5 = BindableHandler.GetEvent("SelectTowerBarButton")
local event6 = BindableHandler.GetEvent("DeselectTowerBarButton")
local event7 = BindableHandler.GetEvent("CycleTowerBarLeft")
local event8 = BindableHandler.GetEvent("CycleTowerBarRight")
local event9 = BindableHandler.GetEvent("PVPTowersBarVisibilityChanged")
local event10 = BindableHandler.GetEvent("RandomizeTowers")
local event11 = BindableHandler.GetEvent("RefreshTowersBar")
local v = {}
local bottomBar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar")
local towersBar = bottomBar:WaitForChild("TowersBar")
local towerTemplate = towersBar:WaitForChild("TowerTemplate")
local uiAspectRatioConstraint = bottomBar:FindFirstChildOfClass("UIAspectRatioConstraint")
local uiGridLayout = towersBar:FindFirstChildOfClass("UIGridLayout")
local v2 = -1
local v3 = 1
local v4 = nil
local v5 = nil
local v6 = false
local v7 = nil
local v8 = nil
local v9 = nil
local v10 = false

function TowersBar.Initialize(list)
	for i = 1, TOWERS_BAR_COUNT do
		local v11 = list[i]
		local v12 = v[i]

		if v11 then
			v12:SetTower(v11)
		else
			v12:Disable()
		end
	end
end

function TowersBar.RefreshCosts()
	for i = 1, TOWERS_BAR_COUNT do
		v[i]:RefreshCost()
	end
end

function TowersBar.Enable(flag: boolean?)
	local positionForElement = ScalingHandler.GetPositionForElement(bottomBar)

	if flag then
		bottomBar.Position = udim
		TweenService:Create(bottomBar, tweenInfo, { Position = positionForElement }):Play()
	else
		bottomBar.Position = positionForElement
	end

	bottomBar.Visible = true
	v10 = true
end

function TowersBar:Disable()
	if self then
		local tween = TweenService:Create(bottomBar, tweenInfo, { Position = udim })
		tween.Completed:Connect(function(p)
			if p ~= Enum.PlaybackState.Completed or v10 then
				return
			end

			bottomBar.Visible = false
		end)
		tween:Play()
	else
		bottomBar.Visible = false
	end

	v10 = false
end

function TowersBar:SetTower(p: string?)
	local v11 = v[self]

	if not v11 then
		return
	end

	if p then
		v11:SetTower(p)
	else
		v11:Disable()
	end
end

function TowersBar.SetTutorialMode(flag: boolean?)
	v7 = flag
	v8 = false
	BarButtonClass.SetTutorialMode(flag)
end

function TowersBar.EnableTutorialFreebuild()
	v8 = true
	BarButtonClass.EnableTutorialFreebuild()
end

function TowersBar.SetTutorialForceIndex(p: number?)
	v9 = p
	BarButtonClass.SetTutorialForceIndex(p)
end

local function SelectTowerButtonAtIndex(p: number) -- 2 equivalent calls inferred from this helper
	local v11 = v[p]

	if not v11 then
		print("Tower index out of range")
	elseif v11:GetTower() then
		v11:PlayClickedAnimation()
		event2:Fire(p, v11:GetTower())
	end
end

if TOWERS_BAR_COUNT ~= 6 then
	local v11 = TOWERS_BAR_COUNT / 6
	local scale = uiGridLayout.CellPadding.X.Scale
	local scale2 = uiGridLayout.CellSize.X.Scale
	local v12 = scale / v11
	local v13 = scale2 / v11

	while TOWERS_BAR_COUNT * v13 + (TOWERS_BAR_COUNT - 1) * v12 >= 1 do
		v12 -= 0.001
	end

	uiAspectRatioConstraint.AspectRatio *= v11
	uiGridLayout.CellPadding = UDim2.new(v12, 0, 1, 0)
	uiGridLayout.CellSize = UDim2.new(v13, 0, 1, 0)
	local offset = bottomBar.Size.Y.Offset
	bottomBar.Size = UDim2.new(0, offset * uiAspectRatioConstraint.AspectRatio, 0, offset)
end

for i = 1, TOWERS_BAR_COUNT do
	table.insert(v, BarButtonClass.New(i))
end

towerTemplate:Destroy()
event5:AttachCallback(function(p: number)
	local v11 = v[p]
	assert(v11, "Index out of range")

	if v7 and not v8 then
		if not (v9 and p == v9) then
			return
		end
	end

	if v5 ~= v11 then
		if v5 then
			v5:Deselect()
		end

		v11:Select()
		v5 = v11
	end

	v3 = p
	v4 = nil
	SoundHandler.Play("ClickTower")
end)
event6:AttachCallback(function()
	if v5 then
		v5:Deselect()
		v5 = nil
	end
end)
local v11 = "Towers"
event4:AttachCallback(function(p: string)
	v11 = p
end)
event3:AttachCallback(function(p: number)
	assert(p, "Start tower placement expected index")

	if v11 == "Enemies" then
		return
	end

	if v7 and not v8 then
		if not (v9 and p == v9) then
			return
		end
	end

	SelectTowerButtonAtIndex(p == 0 and 10 or p) -- inferred equivalent call
end)
event10:AttachCallback(function(flag: boolean?)
	local towers = {}

	for _, tower in pairs(Enums.Towers) do
		table.insert(towers, tower)
	end

	v2 += flag and -1 or 1

	if v2 * TOWERS_BAR_COUNT >= #towers then
		v2 = 0
	elseif v2 < 0 then
		v2 = math.ceil(#towers / TOWERS_BAR_COUNT) - 1
	end

	for i = 1, TOWERS_BAR_COUNT do
		local v12 = towers[v2 * TOWERS_BAR_COUNT + i]
		local v13 = v[i]

		if v12 then
			v13:SetTower(v12)
		else
			v13:Disable()
		end
	end
end)
event11:AttachCallback(function(p: string?)
	for i = 1, TOWERS_BAR_COUNT do
		local v12 = v[i]

		if v12.TowerName then
			if not p or v12.TowerName == p then
				v12:SetTower(v12.TowerName)
			end
		else
			v12:Disable()
		end
	end
end)
event:AttachCallback(function()
	event11:Fire()
end)
event9:AttachCallback(function(flag: boolean)
	v6 = flag
end)

local function Cycle(p: number)
	if v6 then
		return
	end

	local v12 = false

	for i = 1, TOWERS_BAR_COUNT do
		if not v[i]:IsSelected() then
			continue
		end

		v12 = true
		break
	end

	if v12 or v3 == v4 then
		v3 = math.clamp(v3 + p, 1, TOWERS_BAR_COUNT)
	end

	v4 = v3
	SelectTowerButtonAtIndex(v3) -- inferred equivalent call
end

event7:AttachCallback(function()
	Cycle(-1)
end)
event8:AttachCallback(function()
	Cycle(1)
end)
return TowersBar