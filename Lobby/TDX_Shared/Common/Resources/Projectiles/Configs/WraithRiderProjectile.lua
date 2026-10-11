local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "WraithRiderProjectile",
	ModelName = "WraithRiderProjectile",
	ExplosionEffectName = Enums.VisualEffects.WraithRiderFireballBlast,
	Hitscan = false,
	Velocity = 115,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = false,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.8,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true,
	AnimationTriggerTime = 0.417
}