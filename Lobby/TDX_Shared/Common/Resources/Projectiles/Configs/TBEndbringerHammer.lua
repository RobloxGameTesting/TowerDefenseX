local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "TBEndbringerHammer",
	ModelName = "TBEndbringerHammer",
	ExplosionEffectName = Enums.VisualEffects.Gun105Explosion,
	Hitscan = false,
	Velocity = 40,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 5,
	RotationsInAirPerSecondMinimum = 0,
	RotationsInAirPerSecondMaximum = 0,
	AdditionalRotationPerSecond = vector.create(6.2831855, 0, 0),
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true,
	AnimationTriggerTime = 1.133
}