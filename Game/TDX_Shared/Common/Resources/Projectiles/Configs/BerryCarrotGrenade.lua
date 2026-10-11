local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BerryCarrotGrenade",
	ModelName = "BerryCarrotGrenade",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionLarge,
	Hitscan = false,
	Velocity = 20,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	RegenerationDelay = 0.6,
	RegenerationTime = 0.2
}