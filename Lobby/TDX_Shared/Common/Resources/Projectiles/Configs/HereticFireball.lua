local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "HereticFireball",
	ModelName = "HereticFireball",
	ExplosionEffectName = Enums.VisualEffects.HereticFireballBlast,
	Hitscan = false,
	Velocity = 30,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 25,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	TargetTorsoInsteadOfGround = true,
	AnimationTriggerTime = 0.465
}