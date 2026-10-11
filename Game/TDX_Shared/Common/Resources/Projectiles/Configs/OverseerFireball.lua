local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "OverseerFireball",
	ModelName = "OverseerFireball",
	ExplosionEffectName = Enums.VisualEffects.OverseerFireballBlast,
	Hitscan = false,
	Velocity = 40,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 20,
	TimeToKeepAfterHit = 3,
	HitVarianceXZ = 0.8,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true,
	AnimationTriggerTime = 0.3500000000000001
}