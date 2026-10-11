local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GoldenWarshipP1MaxProjectile",
	ModelName = "GoldenWarshipP1MaxProjectile",
	ExplosionEffectName = Enums.VisualEffects.GoldenWarshipBlastExtraLarge,
	Hitscan = false,
	Velocity = 200,
	Gravity = 200,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 5,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 3,
	RegenerationDelay = 4,
	RegenerationTime = 0.5
}