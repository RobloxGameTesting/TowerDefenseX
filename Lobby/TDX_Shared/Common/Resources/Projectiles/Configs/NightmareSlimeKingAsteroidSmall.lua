local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "NightmareSlimeKingAsteroidSmall",
	ModelName = "NightmareSlimeKingAsteroidSmall",
	ExplosionEffectName = Enums.VisualEffects.NightmareSlimeKingAsteroidBlastSmall,
	Hitscan = false,
	Velocity = 250,
	Gravity = 100,
	MinimumTimeToHit = 0.3,
	ProgressExponential = 2,
	Arc = false,
	TimeToKeepAfterHit = 10,
	HitVarianceXZ = 1
}