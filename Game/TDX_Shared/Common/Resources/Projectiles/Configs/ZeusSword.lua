local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ZeusSword",
	ModelName = "ZeusSword",
	ExplosionEffectName = Enums.VisualEffects.ZeusSwordExplosion,
	Hitscan = false,
	Velocity = 75,
	MinimumTimeToHit = 0.1,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}