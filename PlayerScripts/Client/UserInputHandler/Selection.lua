local Selection = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Utilities"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapHandler = require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("TowerBuffUtilities"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local color = Color3.fromRGB(170, 156, 127)
local color2 = Color3.fromRGB(255, 235, 147)
local v = nil
local vector = nil
local v2 = nil
local v3 = nil
local position = nil
local manualAimPosition = nil
local currentSplashRadius = nil

function Selection.Run(p: number)
	local mainAttackOverrideData = v and v:GetMainAttackOverrideData()
	local v4

	if v == nil then
		v4 = false
	else
		v4 = v:IsManualAiming()
	end

	RangeCircleHandler.DrawRangeCircle(
		vector,
		true,
		v3,
		true,
		v4,
		v2.RangeNoFill,
		false,
		mainAttackOverrideData and color,
		mainAttackOverrideData and color2
	)

	if not (v4 and manualAimPosition) then
		AimingGuideHandler.Hide()
		return
	end

	if v and currentSplashRadius then
		currentSplashRadius = v:GetCurrentSplashRadius()
	end

	AimingGuideHandler.Show(p, position, manualAimPosition, true, currentSplashRadius)
end

function Selection.SelectTower(object, _: boolean)
	v = object
	position = object.CFrame.Position
	local levelStats = object.LevelHandler:GetLevelStats()
	local currentRange = object:GetCurrentRange()
	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
	vector = Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z)
	v2 = ResourceManager.GetTowerConfig(object.Type)
	v3 = PlacementHandler.GetValidArcs(
		position,
		v2,
		math.max(0.1, currentRange),
		object.SpawnCFrame,
		levelStats.MaximumROM,
		levelStats.IgnoreObstacles
	)
	manualAimPosition = object.ManualAimPosition
	currentSplashRadius = levelStats.IsSplash and levelStats.SplashRadius

	if not object:ShouldShowRangeCircle() then
		RangeCircleHandler.Hide()
		return
	end

	local mainAttackOverrideData = object:GetMainAttackOverrideData()
	RangeCircleHandler.Show()
	RangeCircleHandler.DrawRangeCircle(
		vector,
		true,
		v3,
		true,
		object:IsManualAiming(),
		v2.RangeNoFill,
		false,
		mainAttackOverrideData and color,
		mainAttackOverrideData and color2
	)
end

function Selection.ManualAimPositionChanged(vector2: Vector3)
	manualAimPosition = vector2
end

function Selection.DeselectTower()
	v = nil
	RangeCircleHandler.Hide()
	AimingGuideHandler.Hide()
end

return Selection