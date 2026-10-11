local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MLRSRocket",
	ModelName = "MLRSRocket",
	ExplosionEffectName = Enums.VisualEffects.MLRSRocketBlast,
	Hitscan = false,
	Velocity = 150,
	Gravity = 150,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 12,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25,
	TimeToKeepAfterHit = 2,
	RegenerationDelay = 3,
	RegenerationTime = 0.5
}