local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "WarMachineP2Rocket",
	ModelName = "WarMachineP2Rocket",
	ExplosionEffectName = Enums.VisualEffects.WarMachineP2RocketExplosion,
	CharacterNoFaceTarget = true,
	Hitscan = false,
	Velocity = 75,
	Gravity = 100,
	MinimumTimeToHit = 0.4,
	Arc = true,
	ArcAngle = 10,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.3,
	FlyForwardsOverrideVelocity = 150,
	FlyForwardsVectorOffset = vector.create(0, 8, 0),
	RegenerationDelay = 3,
	RegenerationTime = 0.25
}