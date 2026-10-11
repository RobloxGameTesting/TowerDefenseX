local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ScoutHelicopterBomb",
	ModelName = "ScoutHelicopterBomb",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.BombExplosionLarge,
	Hitscan = false,
	StraightDown = true,
	Velocity = 18,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	ProgressExponential = 2.2,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.1,
	RegenerationDelay = 3.5,
	RegenerationTime = 0.75
}