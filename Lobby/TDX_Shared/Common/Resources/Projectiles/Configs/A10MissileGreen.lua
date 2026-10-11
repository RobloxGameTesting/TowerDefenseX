local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "A10MissileGreen",
	ModelName = "A10MissileGreen",
	ExplosionEffectName = Enums.VisualEffects.A10SmallBlast,
	Hitscan = false,
	Velocity = 350,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}