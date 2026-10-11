local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "XWM_BigMissile",
	ModelName = "XWM_BigMissile",
	ExplosionEffectName = Enums.VisualEffects.XWM_Blast,
	Hitscan = false,
	Velocity = 45,
	Gravity = 100,
	MinimumTimeToHit = 0.4,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.4,
	FlyForwardsOverrideVelocity = 45,
	FlyForwardsVectorOffset = vector.create(0, 10, 0)
}