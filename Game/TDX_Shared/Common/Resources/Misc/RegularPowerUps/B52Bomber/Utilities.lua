local Utilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local PowerUpsConfigHandler = require(common.Resources.Misc.PowerUpsConfigHandler)
local Enums = require(common:WaitForChild("Enums"))
require(script.Parent.Types)

function Utilities.GetStrikeDirection(p: number)
	return (Vector3.new(math.cos(p), 0, (math.sin(p))))
end

function Utilities.GetPositionData(vector: Vector3, p: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.B52Bomber)
	local strikeDirection = Utilities.GetStrikeDirection(p)
	return {
		Start = vector - strikeDirection * config.EntranceDistance,
		End = vector + strikeDirection * config.ExitDistance,
		Time = (config.EntranceDistance + config.ExitDistance) / config.Speed
	}
end

function Utilities.GetBombTargetPositions(vector: Vector3, p: number)
	local config = PowerUpsConfigHandler.GetConfig(Enums.PowerUps.B52Bomber)
	local strikeDirection = Utilities.GetStrikeDirection(p)
	local result = {}

	for i = 1, config.BombCount do
		table.insert(
			result,
			vector + strikeDirection * (((not (config.BombCount > 1) and 0.5 or (i - 1) / (config.BombCount - 1)) - 0.5) * config.StrikeZoneLength)
		)
	end

	return result
end

return Utilities