local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BombardierC4Ground",
	ModelName = "BombardierC4Ground",
	ExplosionEffectName = Enums.VisualEffects.GrenadierGrenade,
	Hitscan = false,
	Velocity = 15,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 5,
	GoalCFrameRotation = CFrame.Angles(0, 1.5707963267948966, 0),
	AdditionalRotationPerSecond = vector.create(0, -4.712389, 0),
	RandomizeAdditionalRotationPerSecond = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}