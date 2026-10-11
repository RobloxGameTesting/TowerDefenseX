local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ToiletGrenadierGrenade",
	ModelName = "GrenadierGrenade",
	ExplosionEffectName = Enums.VisualEffects.ToiletGrenadierGrenade,
	Hitscan = false,
	Velocity = 20,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 15,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2
}