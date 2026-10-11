local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ResurrectedCryoRangerGrenadeForDefaultAttack",
	ModelName = "ResurrectedCryoRangerGrenade",
	ExplosionEffectName = Enums.VisualEffects.CryoGrenade,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.05,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 2,
	RotationsInAirPerSecondMaximum = 4,
	AnimationTriggerTime = 0.5
}