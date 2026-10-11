local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMKIC_MissileFast",
	ModelName = "EradicatorMKIC_Missile",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMKIC_MissileBlast,
	Hitscan = false,
	Velocity = 150,
	Gravity = 100,
	MinimumTimeToHit = 0.5,
	Arc = true,
	ArcAngle = 8,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 10,
	HitVarianceY = 2,
	FlyForwardsTime = 0.6,
	FlyForwardsOverrideVelocity = 300,
	FlyForwardsVectorOffset = vector.create(0, 8, 0)
}