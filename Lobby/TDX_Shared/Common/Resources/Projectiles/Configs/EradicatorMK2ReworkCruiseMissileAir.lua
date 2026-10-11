local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK2ReworkCruiseMissileAir",
	ModelName = "EradicatorMK2ReworkCruiseMissile",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK2ReworkCruiseMissileBlastAir,
	Hitscan = false,
	Velocity = 90,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 35,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1.25,
	RegenerationDelay = 3,
	RegenerationTime = 1
}