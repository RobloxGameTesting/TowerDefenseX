local RotationAiming = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local PlacementHandler = require(common:WaitForChild("PlacementHandler"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local RangeCircleHandler = require(script.Parent:WaitForChild("RangeCircleHandler"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local event = BindableHandler.GetEvent("TowerPlacementRotationIncrement")
local v = 0
local v2 = nil
local spawnCFrame = nil
local v3 = nil
local v4 = nil
local v5 = nil

function GetRotationIncrementFromCFrame(cframe: CFrame)
	local _, v6, _ = cframe:ToOrientation()
	return (math.floor(v6 / 0.7853981633974483 % 8))
end

function RotationAiming.Run(_: number, vector: Vector3, p)
	v5 = p
	MapHandler.HidePathHighlight()

	if v2 ~= vector and v5 ~= Enum.UserInputType.Touch then
		v = GetRotationIncrementFromCFrame(CFrame.new(spawnCFrame.Position, vector))
		v2 = vector
	end

	local v6 = CFrame.new(spawnCFrame.Position) * CFrame.Angles(0, v * 3.141592653589793 / 4, 0)
	local validArcs = PlacementHandler.GetValidArcs(
		v6.Position,
		v3.Config,
		v4.Range,
		v6,
		v4.MaximumROM,
		v4.IgnoreObstacles
	)
	local rangeDisplayHeightAtXZ = MapHandler.GetRangeDisplayHeightAtXZ(v6.Position.X, v6.Position.Z)
	RangeCircleHandler.DrawRangeCircle(
		Vector3.new(v6.Position.X, rangeDisplayHeightAtXZ, v6.Position.Z),
		true,
		validArcs,
		nil,
		true,
		v3.Config.RangeNoFill
	)
end

function RotationAiming.BeginRotationAiming(data)
	v3 = data
	spawnCFrame = data.SpawnCFrame
	v = GetRotationIncrementFromCFrame(spawnCFrame)
	v4 = TowerUtilities.GetLevelStats(
		data.Config.UpgradePathData,
		data.LevelHandler.Path1Level,
		data.LevelHandler.Path2Level
	)
end

function RotationAiming.GetCurrentAimRotation()
	return true, v * 3.141592653589793 / 4
end

function RotationAiming.Hide()
	v3 = nil
	AimingGuideHandler.Hide()
	v = 0
	v4 = nil
end

event:AttachCallback(function()
	if v3 then
		if v5 ~= Enum.UserInputType.Touch and v5 ~= Enum.UserInputType.Gamepad1 then
			return
		end

		v = (v + 1) % 8
	end
end)
return RotationAiming