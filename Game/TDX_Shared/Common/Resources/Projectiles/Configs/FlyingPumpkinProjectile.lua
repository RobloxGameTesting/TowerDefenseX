local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "FlyingPumpkinProjectile",
	Animated = true,
	ModelName = "FlyingPumpkinProjectile",
	ExplosionEffectName = Enums.VisualEffects.FlyingPumpkinExplosion,
	Hitscan = false,
	Velocity = 12,
	MinimumTimeToHit = 0.7,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	TimeToKeepAfterHit = 3
}