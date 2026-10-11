local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK4GrenadeRed",
	ModelName = "EradicatorMK4GrenadeRed",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK4HighExplosiveHit,
	Hitscan = false,
	Velocity = 30,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 15,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	HitVarianceXZ = 1.5
}