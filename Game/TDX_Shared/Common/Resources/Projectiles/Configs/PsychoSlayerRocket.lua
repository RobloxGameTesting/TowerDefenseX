local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PsychoSlayerRocket",
	ModelName = "PsychoSlayerRocket",
	ExplosionEffectName = Enums.VisualEffects.PsychoSlayerRocketBlast,
	Hitscan = false,
	Velocity = 70,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 25,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.25,
	TargetTorsoInsteadOfGround = true,
	RegenerationDelay = 3,
	RegenerationTime = 1
}