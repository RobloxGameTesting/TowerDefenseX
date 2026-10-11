local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DoomsdayRioterMolotov",
	ModelName = "DoomsdayRioterMolotov",
	ExplosionEffectName = Enums.VisualEffects.Molotov,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 25,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2
}