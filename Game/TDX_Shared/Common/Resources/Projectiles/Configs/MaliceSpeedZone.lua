local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "MaliceSpeedZone",
	ModelName = "MaliceSpeedZone",
	SpawnsStaticEntity = true,
	AdjustHeightForSpawningStaticEntity = true,
	Hitscan = false,
	Velocity = 100,
	MinimumTimeToHit = 0.05,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.1,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}