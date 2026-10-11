local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MageFireball",
	ModelName = "MageFireball",
	ExplosionEffectName = Enums.VisualEffects.MageFireballBlast,
	Hitscan = false,
	Velocity = 30,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.8,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true
}