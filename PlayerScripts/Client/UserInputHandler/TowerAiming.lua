local TowerAiming = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Utilities"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapHandler = require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("PathHandler"))
require(common:WaitForChild("PathUtilities"))
local ValidArcsUtilities = require(common:WaitForChild("ValidArcsUtilities"))
require(common:WaitForChild("TowerBuffUtilities"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local towerClass = script.Parent.Parent:WaitForChild("GameClass"):WaitForChild("TowerClass")
local position = nil
local v = nil
local v2 = nil
local v3 = nil
local v4 = false
local manualAimTargetMustBeHealable = false
local v5 = nil

function TowerAiming.Run(p: number, vector: Vector3)
	MapHandler.HidePathHighlight()
	local module = require(towerClass)
	v3 = module.GetClosestFriendlyTower(vector)

	if not v3 then
		return
	end

	local position2 = v3:GetPosition()
	local maximumDistanceAtAngle = ValidArcsUtilities.GetMaximumDistanceAtAngle(
		position.X,
		position.Z,
		position2.X,
		position2.Z,
		v5
	)
	local v6 = v3 == v2
	local v7 = (position - position2).Magnitude <= maximumDistanceAtAngle
	local v8 = not (manualAimTargetMustBeHealable and v3.NoHeal)
	v4 = not v6 and v7 and v8
	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
	RangeCircleHandler.DrawRangeCircle(
		Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
		true,
		v5,
		nil,
		true,
		v.RangeNoFill
	)
	AimingGuideHandler.Show(p, position, position2, v4)
end

function TowerAiming.BeginAimingAtTowerAbility(object, p)
	v2 = object
	position = object.CFrame.Position
	manualAimTargetMustBeHealable = p.ManualAimTargetMustBeHealable

	if p.ManualAimInfiniteRange then
		warn("ManualAimInfiniteRange not implemented yet")
	end

	local levelStats = object.LevelHandler:GetLevelStats()
	local currentRange = object:GetCurrentRange()
	v = ResourceManager.GetTowerConfig(object.Type)
	v5 = PlacementHandler.GetValidArcs(position, v, math.max(0.1, currentRange), nil, nil, levelStats.IgnoreObstacles)
end

function TowerAiming.GetCurrentAimTower()
	return v4, v3
end

return TowerAiming