local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AATurretMissileSmall",
	ModelName = "AATurretMissileSmall",
	ExplosionEffectName = Enums.VisualEffects.AATurretMissileSmallBlast,
	Hitscan = false,
	Velocity = 88,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25,
	TimeToKeepAfterHit = 2,
	RegenerationDelay = 2,
	RegenerationTime = 0.25
}