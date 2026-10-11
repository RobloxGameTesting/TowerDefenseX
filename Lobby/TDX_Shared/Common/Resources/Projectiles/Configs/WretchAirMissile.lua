local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "WretchAirMissile",
	ModelName = "DreadnoughtStrikerMissile",
	ExplosionEffectName = Enums.VisualEffects.PurpleMissileBlastLarge,
	Hitscan = false,
	Velocity = 150,
	Gravity = 100,
	MinimumTimeToHit = 0.4,
	Arc = true,
	ArcAngle = 7,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.3,
	FlyForwardsOverrideVelocity = 150,
	FlyForwardsVectorOffset = vector.create(0, 6, 0),
	RegenerationDelay = 3,
	RegenerationTime = 0.5
}