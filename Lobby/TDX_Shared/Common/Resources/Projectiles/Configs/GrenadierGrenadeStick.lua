local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GrenadierGrenadeStick",
	ModelName = "GrenadierGrenadeStick",
	ExplosionEffectName = Enums.VisualEffects.GrenadierGrenadeElectricBlastLarge,
	Hitscan = false,
	Velocity = 19.5,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 12,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	AnimationTriggerTime = 37 / 78
}