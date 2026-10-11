local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidWardenCrystal",
	ModelName = "VoidWardenCrystal",
	ExplosionEffectName = Enums.VisualEffects.VoidWardenCrystalExplosion,
	Hitscan = false,
	Velocity = 130,
	MinimumTimeToHit = 0.1,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true
}