local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "B52Bomb",
	ModelName = "B52Bomb",
	ExplosionEffectName = Enums.VisualEffects.F22MissileBlast,
	Hitscan = false,
	StraightDown = true,
	Velocity = 70,
	Gravity = 125,
	MinimumTimeToHit = 2,
	Arc = true,
	ProgressExponential = 0.6,
	RotationsInAirPerSecondMinimum = 0,
	RotationsInAirPerSecondMaximum = 0,
	AdditionalRotationPerSecond = vector.create(-0.67, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 3
}