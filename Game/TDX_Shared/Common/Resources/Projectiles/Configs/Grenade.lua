local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Grenade",
	ModelName = "Grenade",
	ExplosionEffectName = Enums.VisualEffects.Grenade,
	Hitscan = false,
	Velocity = 15,
	MinimumTimeToHit = 0.15,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 2,
	RotationsInAirPerSecondMaximum = 4,
	AnimationTriggerTime = 0.385
}