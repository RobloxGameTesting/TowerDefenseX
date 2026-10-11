local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EasterEngineerPredLaserProjectile",
	ModelName = "EasterEngineerPredLaserProjectile",
	ExplosionEffectName = Enums.VisualEffects.EasterEngineerPredLaserProjectileHit,
	Hitscan = false,
	Velocity = 150,
	MinimumTimeToHit = 0.2,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 0.1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.25,
	FlyForwardsTime = 0.15,
	FlyForwardsOverrideVelocity = 150
}