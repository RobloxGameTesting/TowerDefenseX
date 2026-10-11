local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Utilities = {}
Utilities.States = { ENTRANCE = 1, DEFAULT = 2, EXIT = 3, FINISHED = 4 }

function Utilities.GetEntranceData(vector: Vector3, vector2: Vector3, startingAngle: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.ReconDrone)
	local v = vector.X - vector2.X
	local start = vector + Vector3.new(-(vector.Z - vector2.Z), 0, v).Unit * config.EntranceDistance
	local entranceSpeed = config.EntranceSpeed
	local pylonSpeed = config.PylonSpeed
	local entranceDistance = config.EntranceDistance
	local acceleration = (pylonSpeed ^ 2 - entranceSpeed ^ 2) / (2 * entranceDistance)
	return {
		Start = start,
		End = vector,
		StartingAngle = startingAngle,
		Distance = entranceDistance,
		InitialSpeed = entranceSpeed,
		Acceleration = acceleration,
		Time = (pylonSpeed - entranceSpeed) / acceleration,
		MovementUnitVector = (vector - start).Unit
	}
end

function Utilities.GetExitData(vector: Vector3, vector2: Vector3)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.ReconDrone)
	local v = vector.X - vector2.X
	local planeExitPont = vector + Vector3.new(vector.Z - vector2.Z, 0, -v).Unit * config.ExitDistance
	local pylonSpeed = config.PylonSpeed
	local exitSpeed = config.ExitSpeed
	local exitDistance = config.ExitDistance
	local acceleration = (exitSpeed ^ 2 - pylonSpeed ^ 2) / (2 * exitDistance)
	return {
		PylonExitPoint = vector,
		PlaneExitPont = planeExitPont,
		Distance = exitDistance,
		InitialSpeed = pylonSpeed,
		Acceleration = acceleration,
		Time = (exitSpeed - pylonSpeed) / acceleration,
		MovementUnitVector = (planeExitPont - vector).Unit
	}
end

return Utilities