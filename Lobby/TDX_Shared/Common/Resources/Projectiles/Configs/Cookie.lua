local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Cookie",
	ModelName = "Cookie",
	ExplosionEffectName = Enums.VisualEffects.CookieExplosion,
	Hitscan = false,
	Velocity = 60,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 10,
	GoalCFrameRotation = CFrame.Angles(0, 1.5707963267948966, 0),
	AdditionalRotationPerSecond = vector.create(0, -12.566371, 0),
	RandomizeAdditionalRotationPerSecond = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}