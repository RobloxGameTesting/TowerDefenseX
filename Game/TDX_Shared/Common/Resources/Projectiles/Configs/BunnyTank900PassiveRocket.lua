local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BunnyTank900PassiveRocket",
	ModelName = "BunnyTank900PassiveRocket",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionMedium,
	Hitscan = false,
	Velocity = 45,
	Gravity = 100,
	MinimumTimeToHit = 0.6,
	Arc = true,
	ArcAngle = 6,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.6,
	FlyForwardsOverrideVelocity = 125,
	FlyForwardsRadialSpread = 15,
	RegenerationDelay = 3,
	RegenerationTime = 0.4
}