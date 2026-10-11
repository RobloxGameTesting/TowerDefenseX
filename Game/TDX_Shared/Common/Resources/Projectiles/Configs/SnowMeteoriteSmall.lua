local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SnowMeteoriteSmall",
	ModelName = "SnowMeteoriteSmall",
	ExplosionEffectName = Enums.VisualEffects.SnowMeteoriteBlastSmall,
	Hitscan = false,
	Velocity = 450,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = true,
	ArcAngle = 35,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 3,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 2
}