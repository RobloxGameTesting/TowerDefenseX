local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "IceShardLarge",
	ModelName = "IceShardLarge",
	ExplosionEffectName = Enums.VisualEffects.IceShardHit,
	Hitscan = false,
	Velocity = 50,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	TimeToKeepAfterHit = 3,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.1
}