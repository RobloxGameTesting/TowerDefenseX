local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MOAB",
	ModelName = "MOAB",
	ExplosionEffectName = Enums.VisualEffects.MOABBlast,
	Hitscan = false,
	Velocity = 200,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 20,
	HitVarianceXZ = 2
}