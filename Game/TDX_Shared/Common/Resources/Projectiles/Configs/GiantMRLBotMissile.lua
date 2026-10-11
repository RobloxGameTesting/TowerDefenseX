local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GiantMRLBotMissile",
	ModelName = "GiantMRLBotMissile",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMissileBlast,
	Hitscan = false,
	Velocity = 120,
	MinimumTimeToHit = 0.15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	AnimationTriggerTime = 1 / 60
}