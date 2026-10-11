local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "M2BradleyMissile",
	ModelName = "M2BradleyMissile",
	ExplosionEffectName = Enums.VisualEffects.HumveeMissileBlast,
	Hitscan = false,
	Velocity = 60,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.2,
	TimeToKeepAfterHit = 2
}