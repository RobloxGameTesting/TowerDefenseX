local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SnowMeteoriteLarge",
	ModelName = "SnowMeteoriteLarge",
	ExplosionEffectName = Enums.VisualEffects.SnowMeteoriteBlastLarge,
	Hitscan = false,
	Velocity = 250,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = true,
	ArcAngle = 35,
	RotationsInAirPerSecondMinimum = 0.25,
	RotationsInAirPerSecondMaximum = 0.6,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 6
}