local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AviatorMissile",
	ModelName = "AviatorMissile",
	ExplosionEffectName = Enums.VisualEffects.HelicopterRocketBlast,
	Hitscan = false,
	Velocity = 75,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	FlyForwardsTime = 0.6,
	FlyForwardsOverrideVelocity = 150,
	FlyForwardsExponent = 1.5,
	RegenerationDelay = 1,
	RegenerationTime = 0.5
}