local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidGodAsteroidMedium",
	ModelName = "VoidGodAsteroidMedium",
	ExplosionEffectName = Enums.VisualEffects.VoidGodAsteroidBlastMedium,
	Hitscan = false,
	Velocity = 350,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = false,
	RotationsInAirPerSecondMinimum = 0.6,
	RotationsInAirPerSecondMaximum = 1,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 4
}