local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SlimeKingAsteroidLarge",
	ModelName = "SlimeKingAsteroidLarge",
	ExplosionEffectName = Enums.VisualEffects.SlimeKingAsteroidBlastLarge,
	Hitscan = false,
	Velocity = 150,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = false,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 2
}