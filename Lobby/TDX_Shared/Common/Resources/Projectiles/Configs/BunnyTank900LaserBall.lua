local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BunnyTank900LaserBall",
	ModelName = "BunnyTank900LaserBall",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionLarge,
	Hitscan = false,
	Velocity = 35,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 10,
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.2,
	TargetTorsoInsteadOfGround = true,
	AnimationTriggerTime = 1.0999999999999999
}