local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ResurrectedCryoRangerGrenade",
	ModelName = "ResurrectedCryoRangerGrenade",
	ExplosionEffectName = Enums.VisualEffects.CryoGrenade,
	Hitscan = false,
	Velocity = 15,
	MinimumTimeToHit = 0.05,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 4,
	RotationsInAirPerSecondMaximum = 6,
	AnimationTriggerTime = 0.35000000000000003
}