local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "DeployerObjectDamage",
	ModelName = "DeployerObjectDamage",
	SpawnsStaticEntity = true,
	AdjustHeightForSpawningStaticEntity = true,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 15,
	GoalCFrameRotation = CFrame.Angles(0, 0, 0),
	AdditionalRotationPerSecond = vector.create(0, -4.712389, 0),
	RandomizeAdditionalRotationPerSecond = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.7,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}