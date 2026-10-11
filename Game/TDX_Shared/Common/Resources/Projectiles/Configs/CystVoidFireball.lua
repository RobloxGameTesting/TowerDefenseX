local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CystVoidFireball",
	ModelName = "CystVoidFireball",
	ExplosionEffectName = Enums.VisualEffects.CystVoidFireballHit,
	Hitscan = false,
	Velocity = 55,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.25,
	RegenerationDelay = 0.1,
	RegenerationTime = 0.1
}