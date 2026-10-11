local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "IroncladMissile",
	ModelName = "IroncladMissile",
	ExplosionEffectName = Enums.VisualEffects.AATurretMissileLargeBlast,
	Hitscan = false,
	Velocity = 70,
	Arc = true,
	ArcAngle = 30,
	FlyForwardsTime = 1,
	MinimumTimeToHit = 1.25,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.25,
	TimeToKeepAfterHit = 2,
	RegenerationDelay = 2,
	RegenerationTime = 0.25
}