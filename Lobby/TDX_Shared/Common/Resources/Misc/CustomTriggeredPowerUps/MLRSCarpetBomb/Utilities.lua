local Utilities = {}
local Config = require(script.Parent.Config)

function Utilities.GetStrikeDirection(p: number)
	return (Vector3.new(math.cos(p), 0, (math.sin(p))))
end

function Utilities.GetPositionData(vector: Vector3, p: number)
	local strikeDirection = Utilities.GetStrikeDirection(p)
	return {
		Start = vector - strikeDirection * Config.EntranceDistance,
		End = vector + strikeDirection * Config.ExitDistance,
		Time = (Config.EntranceDistance + Config.ExitDistance) / Config.Speed
	}
end

function Utilities.GetBombTargetPositions(vector: Vector3, p: number)
	local strikeDirection = Utilities.GetStrikeDirection(p)
	local result = {}

	for i = 1, Config.BombCount do
		table.insert(
			result,
			vector + strikeDirection * (((not (Config.BombCount > 1) and 0.5 or (i - 1) / (Config.BombCount - 1)) - 0.5) * Config.StrikeZoneLength)
		)
	end

	return result
end

return Utilities