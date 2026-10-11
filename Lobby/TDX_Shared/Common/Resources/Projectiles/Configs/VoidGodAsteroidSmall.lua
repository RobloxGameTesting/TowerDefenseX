local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidGodAsteroidSmall",
	ModelName = "VoidGodAsteroidSmall",
	ExplosionEffectName = Enums.VisualEffects.VoidGodAsteroidBlastSmall,
	Hitscan = false,
	Velocity = 450,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = false,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 3,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 2
}