local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PsychoSlayerMortarShell",
	ModelName = "PsychoSlayerMortarShell",
	ExplosionEffectName = Enums.VisualEffects.PsychoSlayerMortarShellHit,
	Hitscan = false,
	Velocity = 40,
	Gravity = 200,
	MinimumTimeToHit = 0.5,
	Arc = true,
	ArcAngle = 45,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	AnimationTriggerTime = 0.25,
	HideProjectileDuringHoldTime = true,
	DelayProjectileEffectsUntilHoldingOver = true
}