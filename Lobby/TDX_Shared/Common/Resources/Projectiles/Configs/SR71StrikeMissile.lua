local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SR71StrikeMissile",
	ModelName = "SR71StrikeMissile",
	ExplosionEffectName = Enums.VisualEffects.SR71EMPBlast,
	Hitscan = false,
	Velocity = 400,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2
}