local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AviatorBombL3",
	ModelName = "AviatorBombL3",
	CharacterNoFaceTarget = true,
	ExplosionEffectName = Enums.VisualEffects.AviatorBombBlastSmall,
	Hitscan = false,
	StraightDown = true,
	Velocity = 18,
	Gravity = 100,
	MinimumTimeToHit = 0.65,
	ProgressExponential = 2.2,
	AlwaysFaceTravelDirection = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.1,
	RegenerationDelay = 2,
	RegenerationTime = 0.5
}