local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ScoutHelicopterRocket",
	ModelName = "ScoutHelicopterRocket",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.HelicopterRocketBlast,
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 18,
	Hitscan = false,
	Velocity = 135,
	Gravity = 100,
	MinimumTimeToHit = 0.15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	RegenerationDelay = 3.5,
	RegenerationTime = 0.75
}