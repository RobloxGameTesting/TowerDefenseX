local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EmperorDrone",
	ModelName = "EmperorDrone",
	ExplosionEffectName = Enums.VisualEffects.EmperorDroneBlast,
	Hitscan = false,
	Velocity = 100,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	AlwaysFaceTravelDirection = true,
	ProgressExponential = 2,
	Arc = false,
	TimeToKeepAfterHit = 3,
	HitVarianceXZ = 1,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
}