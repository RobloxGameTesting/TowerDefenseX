local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK4SmallRocket",
	ModelName = "EradicatorMK4SmallRocket",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK4MissileBlast,
	Hitscan = false,
	Velocity = 70,
	Gravity = 100,
	MinimumTimeToHit = 0.55,
	Arc = true,
	ArcAngle = 8,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.5,
	FlyForwardsOverrideVelocity = 180,
	FlyForwardsVectorOffset = vector.create(0, 5, 0)
}