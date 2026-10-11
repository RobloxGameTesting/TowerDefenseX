local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AATurretMissileMedium",
	ModelName = "AATurretMissileLarge",
	ExplosionEffectName = Enums.VisualEffects.AATurretMissileMediumBlast,
	Hitscan = false,
	Velocity = 140,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25,
	TimeToKeepAfterHit = 2,
	RegenerationDelay = 2,
	RegenerationTime = 0.25
}