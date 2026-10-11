local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "NightmareCyberSantaGift",
	ModelName = "NightmareCyberSantaGift",
	ExplosionEffectName = Enums.VisualEffects.SantaGiftBlast,
	Hitscan = false,
	Velocity = 40,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 10,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2
}