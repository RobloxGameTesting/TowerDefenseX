local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Eggling2Projectile",
	Animated = true,
	ModelName = "Eggling2Projectile",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionMedium,
	Hitscan = false,
	Velocity = 20,
	MinimumTimeToHit = 0.5,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	TimeToKeepAfterHit = 3
}