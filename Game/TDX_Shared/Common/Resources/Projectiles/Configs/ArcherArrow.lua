local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ArcherArrow",
	ModelName = "ArcherArrow",
	ExplosionEffectName = Enums.VisualEffects.ArcherArrowImpact,
	Hitscan = false,
	Velocity = 80,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.2,
	AnimationTriggerTime = 0.72,
	DelayProjectileEffectsUntilHoldingOver = true
}