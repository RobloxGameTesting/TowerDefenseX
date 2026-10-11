local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ArtilleryProjectileExtraLarge",
	ModelName = "ArtilleryProjectileExtraLarge",
	ExplosionEffectName = Enums.VisualEffects.ArtilleryImpactExtraLarge,
	Hitscan = false,
	Velocity = 30,
	Gravity = 200,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 30,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(3.141592653589793, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.75,
	AnimationTriggerTime = 0.25,
	HideProjectileDuringHoldTime = true,
	DelayProjectileEffectsUntilHoldingOver = true
}