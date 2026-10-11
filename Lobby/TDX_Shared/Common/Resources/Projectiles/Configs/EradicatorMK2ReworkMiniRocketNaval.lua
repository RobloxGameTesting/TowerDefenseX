local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EradicatorMK2ReworkMiniRocketNaval",
	ModelName = "EradicatorMK2ReworkMiniRocket",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK2ReworkMiniRocketBlastNaval,
	Hitscan = false,
	Velocity = 75,
	Gravity = 100,
	MinimumTimeToHit = 1,
	Arc = true,
	ArcAngle = 45,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.7,
	FlyForwardsOverrideVelocity = 250,
	FlyForwardsVectorOffset = vector.create(0, 12, 0),
	FlyForwardsExponent = 2,
	RegenerationDelay = 0.2,
	RegenerationTime = 0.2
}