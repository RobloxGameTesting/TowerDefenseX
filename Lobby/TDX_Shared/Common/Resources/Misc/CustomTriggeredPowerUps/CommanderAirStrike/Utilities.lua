local Config = require(script.Parent.Config)
return {
	GetPositionData = function(vector: Vector3, p: number)
		return {
			Start = Vector3.new(
				vector.X + math.cos(p) * Config.EntranceDistance,
				vector.Y,
				vector.Z + math.sin(p) * Config.EntranceDistance
			),
			End = Vector3.new(
				vector.X - math.cos(p) * Config.ExitDistance,
				vector.Y,
				vector.Z - math.sin(p) * Config.ExitDistance
			),
			Time = (Config.EntranceDistance + Config.ExitDistance) / Config.Speed
		}
	end
}