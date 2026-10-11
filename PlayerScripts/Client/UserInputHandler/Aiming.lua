local Aiming = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Utilities"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local PathHandler = require(common:WaitForChild("PathHandler"))
local PathUtilities = require(common:WaitForChild("PathUtilities"))
local ValidArcsUtilities = require(common:WaitForChild("ValidArcsUtilities"))
require(common:WaitForChild("TowerBuffUtilities"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local v = nil
local position = nil
local v2 = nil
local v3 = nil
local v4 = false
local currentSplashRadius = nil
local v5 = false
local currentMinRange = nil
local v6 = nil
local isManualAimAtPath = false
local manualAimInfiniteRange = false
local currentRange = 0
local manualAimRespectMinMaxHeight = false

function Aiming.Run(p: number, vector: Vector3)
	if v then
		position = v.CFrame.Position
	end

	MapHandler.HidePathHighlight()

	if isManualAimAtPath then
		vector = PathUtilities.GetClosestPointOnPath(
			vector,
			PathHandler.GetPathLineSegments(TeamUtilities.GetLocalPlayerTeamIndex()),
			nil,
			MapHandler.GetFreeAimForPathTargeting()
		)

		if manualAimInfiniteRange then
			v4 = true
		else
			local maximumDistanceAtAngle = ValidArcsUtilities.GetMaximumDistanceAtAngle(
				position.X,
				position.Z,
				vector.X,
				vector.Z,
				v6
			)
			local magnitude = (Vector3.new(vector.X, position.Y, vector.Z) - position).Magnitude
			v4 = magnitude <= maximumDistanceAtAngle

			if v4 and currentMinRange then
				v4 = currentMinRange <= magnitude
			end
		end
	elseif manualAimInfiniteRange then
		v4 = true
	else
		v4 = (Vector3.new(vector.X, position.Y, vector.Z) - position).Magnitude <= currentRange
	end

	if v4 and manualAimRespectMinMaxHeight then
		local minMaxHeight, v7 = MapHandler.GetMinMaxHeight()

		if vector.Y < minMaxHeight or v7 < vector.Y then
			v4 = false
		end
	end

	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(position.X, position.Z)
	RangeCircleHandler.DrawRangeCircle(
		Vector3.new(position.X, rangeDisplayHeightAtXZ, position.Z),
		true,
		v6,
		nil,
		true,
		v2.RangeNoFill,
		manualAimInfiniteRange
	)

	if currentSplashRadius and v5 then
		currentSplashRadius = v:GetCurrentSplashRadius()
	end

	AimingGuideHandler.Show(p, position, vector, v4, currentSplashRadius)
	v3 = vector
end

function Aiming.BeginManualAimRetargeting(object)
	v = object
	position = object.CFrame.Position
	local levelStats = object.LevelHandler:GetLevelStats()
	currentRange = object:GetCurrentRange()
	currentMinRange = object:GetCurrentMinRange()
	isManualAimAtPath = true
	manualAimInfiniteRange = false
	v2 = ResourceManager.GetTowerConfig(object.Type)
	currentSplashRadius = object:GetCurrentSplashRadius()
	v5 = true
	v6 = PlacementHandler.GetValidArcs(position, v2, math.max(0.1, currentRange), nil, nil, levelStats.IgnoreObstacles)
end

function Aiming.BeginManualAimAbility(object, data)
	v = object
	position = object.CFrame.Position
	local levelStats = object.LevelHandler:GetLevelStats()
	currentRange = data.ManualAimCustomRange or object:GetCurrentRange()
	currentMinRange = object:GetCurrentMinRange()
	isManualAimAtPath = data.IsManualAimAtPath
	manualAimInfiniteRange = data.ManualAimInfiniteRange
	currentSplashRadius = nil
	v5 = false
	manualAimRespectMinMaxHeight = data.ManualAimRespectMinMaxHeight
	local config = data.Config
	local projectileHitData = config.ProjectileHitData
	local spawnStaticEntityData = config.SpawnStaticEntityData
	local v7 = projectileHitData or data.CustomTriggeredPowerUpData and data.CustomTriggeredPowerUpData.HitData

	if v7 then
		if v7.IsSplash then
			currentSplashRadius = v7.SplashRadius
		elseif v7.BurnEffectStats then
			currentSplashRadius = v7.BurnEffectStats.Radius
		end
	else
		local v8 = spawnStaticEntityData and spawnStaticEntityData[1]

		if v8 then
			local staticEntityConfig = ResourceManager.GetStaticEntityConfig(v8.StaticEntityType)
			local v9 = staticEntityConfig.AttackData and staticEntityConfig.AttackData[1]

			if v9 then
				currentSplashRadius = v9.Range
			end
		end
	end

	v2 = ResourceManager.GetTowerConfig(object.Type)
	v6 = PlacementHandler.GetValidArcs(position, v2, math.max(0.1, currentRange), nil, nil, levelStats.IgnoreObstacles)
end

function Aiming.GetCurrentAimPosition()
	return v4, v3
end

return Aiming