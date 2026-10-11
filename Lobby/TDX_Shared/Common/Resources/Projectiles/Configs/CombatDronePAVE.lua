local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CombatDronePAVE",
	ModelName = "CombatDronePAVE",
	ExplosionEffectName = Enums.VisualEffects.PAVEMissileBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 2,
	Hitscan = false,
	Velocity = 85,
	Gravity = 100,
	MinimumTimeToHit = 0.85,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	FlyForwardsTime = 0.8,
	FlyForwardsOverrideVelocity = 300,
	FlyForwardsExponent = 1.5,
	RegenerationDelay = 1,
	RegenerationTime = 0.5
}