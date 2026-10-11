local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "HelicopterAntiAirMissile",
	ModelName = "HelicopterAntiAirMissile",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.HelicopterMissileBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 2,
	Hitscan = false,
	Velocity = 75,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	RegenerationDelay = 0.75,
	RegenerationTime = 0.75
}