local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ToxicGrenadePurple",
	ModelName = "ToxicGrenadePurple",
	ExplosionEffectName = Enums.VisualEffects.GasCloudPurple,
	Hitscan = false,
	Velocity = 85,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TimeToKeepAfterHit = 2,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.3
}