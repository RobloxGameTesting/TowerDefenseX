local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DreadnoughtStrikerMissileAir",
	ModelName = "DreadnoughtStrikerMissile",
	ExplosionEffectName = Enums.VisualEffects.PurpleMissileBlast,
	Hitscan = false,
	Velocity = 100,
	Gravity = 100,
	MinimumTimeToHit = 0.35,
	Arc = true,
	ArcAngle = 7,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.25,
	FlyForwardsOverrideVelocity = 100,
	FlyForwardsVectorOffset = vector.create(0, 6, 0),
	TargetTorsoInsteadOfGround = true,
	RegenerationDelay = 3,
	RegenerationTime = 0.5
}