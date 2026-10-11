local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "F22Missile",
	ModelName = "F22Missile",
	ExplosionEffectName = Enums.VisualEffects.F22MissileBlast,
	Hitscan = false,
	Velocity = 600,
	Gravity = 100,
	MinimumTimeToHit = 0.2,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}