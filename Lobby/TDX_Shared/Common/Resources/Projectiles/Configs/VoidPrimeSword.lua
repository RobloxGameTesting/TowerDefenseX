local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidPrimeSword",
	ModelName = "VoidPrimeSword",
	ExplosionEffectName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
	Hitscan = false,
	Velocity = 150,
	MinimumTimeToHit = 0.1,
	HitVarianceXZ = 0.15,
	HitVarianceY = 0.15,
	AlwaysFaceTravelDirection = true
}