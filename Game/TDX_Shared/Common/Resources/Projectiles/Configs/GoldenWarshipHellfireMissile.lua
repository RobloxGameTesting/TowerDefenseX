local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GoldenWarshipHellfireMissile",
	ModelName = "GoldenWarshipHellfireMissile",
	ExplosionEffectName = Enums.VisualEffects.GoldenWarshipHellfireMissileBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 8,
	Hitscan = false,
	Velocity = 250,
	MinimumTimeToHit = 1.2,
	Arc = true,
	ArcAngle = 25,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1,
	FlyForwardsTime = 0.7,
	FlyForwardsOverrideVelocity = 400,
	FlyForwardsRotationOffset = CFrame.Angles(0, -1.5707963267948966, -1.5707963267948966),
	RegenerationDelay = 3,
	RegenerationTime = 0.5
}