local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "BombardierC4Tower",
	ModelName = "BombardierC4Tower",
	SpawnsStaticEntity = true,
	AdjustHeightForSpawningStaticEntity = true,
	Hitscan = false,
	Velocity = 22,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 8,
	GoalCFrameRotation = CFrame.Angles(0, 1.5707963267948966, 0),
	AdditionalRotationPerSecond = vector.create(0, -4.712389, 0),
	RandomizeAdditionalRotationPerSecond = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 1.3,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}