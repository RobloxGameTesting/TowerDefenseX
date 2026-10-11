local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "A10MissileGreenBig",
	ModelName = "A10MissileGreenBig",
	ExplosionEffectName = Enums.VisualEffects.A10BigBlast,
	Hitscan = false,
	Velocity = 120,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}