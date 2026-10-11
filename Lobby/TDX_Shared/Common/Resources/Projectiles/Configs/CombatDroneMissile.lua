local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CombatDroneMissile",
	ModelName = "CombatDroneMissile",
	ExplosionEffectName = Enums.VisualEffects.HelicopterMissileBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 2,
	Hitscan = false,
	Velocity = 100,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	FlyForwardsTime = 0.6,
	FlyForwardsOverrideVelocity = 200,
	FlyForwardsExponent = 1.5,
	RegenerationDelay = 1,
	RegenerationTime = 0.5
}