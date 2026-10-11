local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "XTankArcProjectile",
	ModelName = "XTankBaseProjectile",
	ExplosionEffectName = Enums.VisualEffects.ArtilleryImpactLarge,
	Hitscan = false,
	Velocity = 50,
	Gravity = 100,
	MinimumTimeToHit = 0.05,
	Arc = true,
	ArcAngle = 25,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1
}