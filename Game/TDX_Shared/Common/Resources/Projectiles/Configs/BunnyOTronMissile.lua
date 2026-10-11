local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BunnyOTronMissile",
	ModelName = "BunnyOTronMissile",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionBoss,
	Hitscan = false,
	Velocity = 1000,
	Gravity = 150,
	MinimumTimeToHit = 2,
	Arc = true,
	ArcAngle = 85,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 1,
	FlyForwardsOverrideVelocity = -700,
	FlyForwardsVectorOffset = vector.create(0, 200, 0),
	FlyForwardsExponent = 5,
	RegenerationDelay = 3,
	RegenerationTime = 0.5
}