local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AvatarMissile",
	ModelName = "AvatarMissile",
	ExplosionEffectName = Enums.VisualEffects.AvatarMissileBlast,
	Hitscan = false,
	Velocity = 50,
	Gravity = 100,
	MinimumTimeToHit = 0.55,
	Arc = true,
	ArcAngle = 1,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.5,
	FlyForwardsOverrideVelocity = 125,
	FlyForwardsVectorOffset = vector.create(0, 4, 0)
}