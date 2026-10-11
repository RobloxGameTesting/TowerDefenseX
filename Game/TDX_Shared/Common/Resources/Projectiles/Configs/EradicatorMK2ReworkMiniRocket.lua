local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK2ReworkMiniRocket",
	ModelName = "EradicatorMK2ReworkMiniRocket",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK2ReworkMiniRocketBlast,
	Hitscan = false,
	Velocity = 20,
	Gravity = 150,
	MinimumTimeToHit = 2,
	Arc = true,
	ArcAngle = 85,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 1,
	FlyForwardsOverrideVelocity = 500,
	FlyForwardsVectorOffset = vector.create(0, 50, 0),
	FlyForwardsExponent = 4,
	RegenerationDelay = 0.2,
	RegenerationTime = 0.2
}