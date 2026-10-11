local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GraveGuardianTomahawk",
	ModelName = "GraveGuardianTomahawk",
	ExplosionEffectName = Enums.VisualEffects.Dirt,
	Hitscan = false,
	Velocity = 90,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 2,
	AdditionalRotationPerSecond = vector.create(-12.566371, 0, 0)
}