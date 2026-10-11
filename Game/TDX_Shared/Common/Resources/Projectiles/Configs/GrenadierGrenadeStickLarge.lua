local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GrenadierGrenadeStickLarge",
	ModelName = "GrenadierGrenadeStickLarge",
	ExplosionEffectName = Enums.VisualEffects.GrenadierGrenadeElectricBlastLarge,
	Hitscan = false,
	Velocity = 35,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 20,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	AnimationTriggerTime = 0.45
}