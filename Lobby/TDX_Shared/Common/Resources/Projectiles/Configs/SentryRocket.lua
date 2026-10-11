local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SentryRocket",
	ModelName = "SentryRocket",
	ExplosionEffectName = Enums.VisualEffects.SentryRocketBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 2,
	Hitscan = false,
	Velocity = 100,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	TargetTorsoInsteadOfGround = true,
	RegenerationDelay = 0.5,
	RegenerationTime = 0.75
}