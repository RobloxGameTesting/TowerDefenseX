local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DestructorHandShot",
	ModelName = "DestructorHandShot",
	ExplosionEffectName = Enums.VisualEffects.DestructorHandShotHit,
	Hitscan = false,
	Velocity = 77,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	TimeToKeepAfterHit = 1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25
}