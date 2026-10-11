local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CombatDroneBomb",
	ModelName = "CombatDroneBomb",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.EradicatorMK4HighExplosiveHit,
	Hitscan = false,
	StraightDown = true,
	Velocity = 18,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	ProgressExponential = 2.2,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.1
}