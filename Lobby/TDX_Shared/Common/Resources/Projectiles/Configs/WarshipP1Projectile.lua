local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "WarshipP1Projectile",
	ModelName = "WarshipP1Projectile",
	ExplosionEffectName = Enums.VisualEffects.WarshipBasicMissileBlastLarge,
	Hitscan = false,
	Velocity = 225,
	Gravity = 200,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1.25
}