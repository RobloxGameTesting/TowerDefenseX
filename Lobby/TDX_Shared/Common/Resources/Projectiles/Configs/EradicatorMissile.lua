local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMissile",
	ModelName = "EradicatorMissile",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMissileBlast,
	Hitscan = false,
	Velocity = 60,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 8,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	SpiralData = { RotationsPerSecond = 3, MaximumRadius = 1.6 }
}