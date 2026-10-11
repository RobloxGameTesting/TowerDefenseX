local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "XTankDirectProjectile",
	ModelName = "XTankBaseProjectile",
	ExplosionEffectName = Enums.VisualEffects.ArtilleryImpactLarge,
	Hitscan = false,
	Velocity = 70,
	Gravity = 100,
	MinimumTimeToHit = 0.05,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5,
	TargetTorsoInsteadOfGround = true
}