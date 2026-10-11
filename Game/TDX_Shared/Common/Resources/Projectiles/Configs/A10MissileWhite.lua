local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "A10MissileWhite",
	ModelName = "A10MissileWhite",
	ExplosionEffectName = Enums.VisualEffects.A10MissileBlast,
	Hitscan = false,
	Velocity = 250,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}