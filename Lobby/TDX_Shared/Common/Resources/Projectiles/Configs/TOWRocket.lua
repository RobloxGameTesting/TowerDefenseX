local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "TOWRocket",
	ModelName = "TOWRocket",
	ExplosionEffectName = Enums.VisualEffects.M202Blast,
	Hitscan = false,
	Velocity = 55,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.2,
	TimeToKeepAfterHit = 2
}