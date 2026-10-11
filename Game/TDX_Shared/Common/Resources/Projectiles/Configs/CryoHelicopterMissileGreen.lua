local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CryoHelicopterMissileGreen",
	ModelName = "CryoHelicopterMissileGreen",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.CryoMissileBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 8,
	Hitscan = false,
	Velocity = 95,
	Gravity = 100,
	MinimumTimeToHit = 0.15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	RegenerationDelay = 3.5,
	RegenerationTime = 0.75
}