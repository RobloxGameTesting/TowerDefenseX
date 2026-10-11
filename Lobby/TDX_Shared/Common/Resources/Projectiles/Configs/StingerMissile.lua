local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "StingerMissile",
	ModelName = "StingerMissile",
	ExplosionEffectName = Enums.VisualEffects.BasicMissileBlast,
	Hitscan = false,
	Velocity = 75,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 1
}