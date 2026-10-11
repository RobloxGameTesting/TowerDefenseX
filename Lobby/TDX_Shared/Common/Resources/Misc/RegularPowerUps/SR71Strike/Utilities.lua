local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
return {
	GetPositionData = function(vector: Vector3, p: number)
		local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.SR71Strike)
		return {
			Start = Vector3.new(
				vector.X + math.cos(p) * config.EntranceDistance,
				vector.Y,
				vector.Z + math.sin(p) * config.EntranceDistance
			),
			End = Vector3.new(
				vector.X - math.cos(p) * config.ExitDistance,
				vector.Y,
				vector.Z - math.sin(p) * config.ExitDistance
			),
			Time = (config.EntranceDistance + config.ExitDistance) / config.Speed
		}
	end
}