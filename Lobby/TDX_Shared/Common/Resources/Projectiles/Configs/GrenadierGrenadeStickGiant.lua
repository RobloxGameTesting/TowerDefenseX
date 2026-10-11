local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GrenadierGrenadeStickGiant",
	ModelName = "GrenadierGrenadeStickGiant",
	ExplosionEffectName = Enums.VisualEffects.GrenadierGrenadeBlastHuge,
	Hitscan = false,
	Velocity = 50,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 2,
	AnimationTriggerTime = 0.5
}