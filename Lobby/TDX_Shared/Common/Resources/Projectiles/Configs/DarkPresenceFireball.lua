local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DarkPresenceFireball",
	ModelName = "DarkPresenceFireball",
	ExplosionEffectName = Enums.VisualEffects.HereticFireballBlast,
	Hitscan = false,
	Velocity = 60,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.8,
	HitVarianceY = 0.3,
	TargetTorsoInsteadOfGround = true,
	AnimationTriggerTime = 5 / 6
}