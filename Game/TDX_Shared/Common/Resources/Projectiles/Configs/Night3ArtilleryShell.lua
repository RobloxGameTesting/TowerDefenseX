local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Night3ArtilleryShell",
	ModelName = "Night3ArtilleryShell",
	ExplosionEffectName = Enums.VisualEffects.Night3ArtilleryShellBlast,
	Hitscan = false,
	Velocity = 250,
	Gravity = 100,
	MinimumTimeToHit = 0.05,
	Arc = false,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 5,
	HitVarianceXZ = 2,
	HitVarianceY = 10,
	AnimationTriggerTime = 2,
	HideProjectileDuringHoldTime = true,
	DelayProjectileEffectsUntilHoldingOver = true
}