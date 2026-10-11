local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "NorthforgeNuke",
	ModelName = "NorthforgeNuke",
	ExplosionEffectName = Enums.VisualEffects.NorthforgeNukeBlast,
	Hitscan = false,
	Velocity = 200000,
	Gravity = 200,
	MinimumTimeToHit = 6,
	Arc = true,
	ArcAngle = 80,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 5,
	HitVarianceXZ = 2,
	HitVarianceY = 0.5
}