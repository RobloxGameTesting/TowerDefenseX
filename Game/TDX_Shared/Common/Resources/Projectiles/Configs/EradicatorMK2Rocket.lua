local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK2Rocket",
	ModelName = "EradicatorMK2Rocket",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMissileBlast,
	Hitscan = false,
	Velocity = 50,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	Arc = true,
	ArcAngle = 8,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.6,
	FlyForwardsOverrideVelocity = 150,
	FlyForwardsVectorOffset = vector.create(0, 8, 0)
}