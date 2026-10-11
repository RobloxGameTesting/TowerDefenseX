local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EasterCastrumBaseProjectile2",
	ModelName = "EasterCastrumBaseProjectile2",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionMedium,
	Hitscan = false,
	Velocity = 80,
	Gravity = 100,
	MinimumTimeToHit = 0.05,
	Arc = true,
	ArcAngle = 10,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.3,
	HitVarianceY = 0.15
}