local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MissileDroneMissile",
	ModelName = "MissileDroneMissile",
	ExplosionEffectName = Enums.VisualEffects.MissileDroneMissileBlast,
	Hitscan = false,
	Velocity = 50,
	Gravity = 100,
	MinimumTimeToHit = 0.45,
	Arc = true,
	ArcAngle = 5,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.4,
	FlyForwardsOverrideVelocity = 100,
	RegenerationDelay = 3,
	RegenerationTime = 1
}