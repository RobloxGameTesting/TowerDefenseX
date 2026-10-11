local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CorruptedEradicatorMK2Grenade",
	ModelName = "CorruptedEradicatorMK2Grenade",
	ExplosionEffectName = Enums.VisualEffects.PurpleMissileBlastLarge,
	Hitscan = false,
	Velocity = 65,
	Gravity = 150,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	FlyForwardsTime = 0.05,
	FlyForwardsOverrideVelocity = 75,
	FlyForwardsVectorOffset = vector.create(0, 8, 0)
}