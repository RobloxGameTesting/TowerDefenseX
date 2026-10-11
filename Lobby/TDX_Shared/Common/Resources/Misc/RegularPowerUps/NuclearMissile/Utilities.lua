local Utilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)

function Utilities.GetPositionData(vector: Vector3, p: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.NuclearMissile)
	local vector2 = Vector3.new(
		vector.X + math.cos(p) * config.EntranceDistanceXZ,
		vector.Y + config.DropHeight,
		vector.Z + math.sin(p) * config.EntranceDistanceXZ
	)
	return {
		Start = vector2,
		End = vector,
		Time = (vector - vector2).Magnitude / config.Speed
	}
end

return Utilities