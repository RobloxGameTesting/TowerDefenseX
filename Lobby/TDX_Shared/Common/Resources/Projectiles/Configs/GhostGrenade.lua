local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GhostGrenade",
	ModelName = "GhostGrenade",
	ExplosionEffectName = Enums.VisualEffects.GhostGrenadeExplosion,
	Hitscan = false,
	Velocity = 15,
	MinimumTimeToHit = 0.15,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 2,
	RotationsInAirPerSecondMaximum = 4,
	AnimationTriggerTime = 0.533
}