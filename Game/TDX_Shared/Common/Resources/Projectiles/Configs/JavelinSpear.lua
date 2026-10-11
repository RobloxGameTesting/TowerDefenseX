local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "JavelinSpear",
	ModelName = "JavelinSpear",
	ExplosionEffectName = Enums.VisualEffects.KnifeHit,
	Hitscan = false,
	Velocity = 40,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 0,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.15,
	HitVarianceY = 0.1,
	RegenerationDelay = 0.7,
	RegenerationTime = 0.1
}