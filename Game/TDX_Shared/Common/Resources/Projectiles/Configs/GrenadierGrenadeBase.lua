local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GrenadierGrenadeBase",
	ModelName = "GrenadierGrenadeBase",
	ExplosionEffectName = Enums.VisualEffects.GrenadierGrenadeBlastSmall,
	Hitscan = false,
	Velocity = 19.5,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 12,
	RotationsInAirPerSecondMinimum = 2,
	RotationsInAirPerSecondMaximum = 4,
	AnimationTriggerTime = 7 / 13
}