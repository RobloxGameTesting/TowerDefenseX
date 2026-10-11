local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "RocketDroneMissile",
	ModelName = "RocketDroneMissile",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMissileBlast,
	Hitscan = false,
	Velocity = 30,
	Gravity = 100,
	MinimumTimeToHit = 0.6,
	Arc = true,
	ArcAngle = 4,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.4,
	FlyForwardsOverrideVelocity = 125,
	FlyForwardsVectorOffset = vector.create(0, 8, 0)
}