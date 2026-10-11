local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PunkbusterMissile",
	ModelName = "PunkbusterMissile",
	ExplosionEffectName = Enums.VisualEffects.PunkbusterMissileBlast,
	Hitscan = false,
	Velocity = 300,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}