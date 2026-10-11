local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "FrostSpiritProjectile",
	ModelName = "FrostSpiritProjectile",
	ExplosionEffectName = Enums.VisualEffects.FrostSpiritFireballBlast,
	Hitscan = false,
	Velocity = 75,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = false,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.8,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true
}