local ProjectileUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))

function ProjectileUtilities.GetTimeToHitForRangedProjectile(vector: Vector3, vector2: Vector3, data, p: number?)
	local velocity = data.Velocity
	local minimumTimeToHit = data.MinimumTimeToHit
	local straightDown = data.StraightDown

	if not (velocity or minimumTimeToHit) then
		error("Error: using projecile without proper stats!")
	end

	local v = vector2 - vector
	local magnitude = v.Magnitude
	local v2

	if velocity then
		local y = v.Y

		if straightDown then
			if p then
				v2 = p / velocity
				minimumTimeToHit = nil
			else
				v2 = minimumTimeToHit or 1
			end
		else
			v2 = magnitude / velocity

			if data.Arc then
				v2 = math.max(v2, math.sqrt((math.abs(y / (data.Gravity or 120)))) * 2)
			end
		end
	end

	if minimumTimeToHit then
		v2 = math.max(v2 or 0, minimumTimeToHit)
	end

	return v2, magnitude
end

function ProjectileUtilities.RandomOffsetPosition(vector: Vector3, value: number?, value2: number?, flag: boolean?)
	return vector + Vector3.new(
		math.random(-10000 * (value or 0), 10000 * (value or 0)) / 10000,
		math.random(-10000 * (value2 or 0), 10000 * ((flag or not value2) and 0 or value2)) / 10000,
		math.random(-10000 * (value or 0), 10000 * (value or 0)) / 10000
	)
end

return ProjectileUtilities