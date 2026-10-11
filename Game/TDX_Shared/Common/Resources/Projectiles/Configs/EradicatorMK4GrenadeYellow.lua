local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK4GrenadeYellow",
	ModelName = "EradicatorMK4GrenadeYellow",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK4NapalmHit,
	Hitscan = false,
	Velocity = 30,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 15,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	HitVarianceXZ = 1.5
}