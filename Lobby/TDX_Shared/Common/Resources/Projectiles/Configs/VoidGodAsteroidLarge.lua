local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidGodAsteroidLarge",
	ModelName = "VoidGodAsteroidLarge",
	ExplosionEffectName = Enums.VisualEffects.VoidGodAsteroidBlastLarge,
	Hitscan = false,
	Velocity = 250,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = false,
	RotationsInAirPerSecondMinimum = 0.25,
	RotationsInAirPerSecondMaximum = 0.6,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 6
}