local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PsychoKnife",
	ModelName = "PsychoKnife",
	ExplosionEffectName = Enums.VisualEffects.KnifeHit,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 5,
	GoalCFrameRotation = CFrame.Angles(0, 0, 3.141592653589793),
	AdditionalRotationPerSecond = vector.create(0, 0, 12.566371),
	RandomizeAdditionalRotationPerSecond = true,
	TargetTorsoInsteadOfGround = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.4,
	HitVarianceY = 0.2,
	AnimationTriggerTime = 0.483,
	DelayProjectileEffectsUntilHoldingOver = true
}