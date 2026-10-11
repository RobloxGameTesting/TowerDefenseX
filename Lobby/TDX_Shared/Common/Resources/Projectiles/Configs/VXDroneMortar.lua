local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VXDroneMortar",
	ModelName = "VXDroneMortar",
	ExplosionEffectName = Enums.VisualEffects.ArtilleryImpactExtraLarge,
	Hitscan = false,
	Velocity = 35,
	Gravity = 150,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5
}