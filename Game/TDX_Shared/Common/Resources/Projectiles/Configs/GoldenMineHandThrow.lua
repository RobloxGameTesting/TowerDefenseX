local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GoldenMineHandThrow",
	ModelName = "GoldenMine",
	VariableProjectileModel = true,
	OverridePathLevelString = "2_5",
	ExplosionEffectName = Enums.VisualEffects.GoldenMineLayerCrystalExplosion,
	NoOverrideExplosionEffect = true,
	Hitscan = false,
	Velocity = 80,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	GoalCFrameRotation = CFrame.Angles(0, 1.5707963267948966, 0),
	AdditionalRotationPerSecond = vector.create(0, -12.566371, 0),
	RandomizeAdditionalRotationPerSecond = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true,
	AnimationTriggerTime = 1.25
}