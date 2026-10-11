local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SlimeBruteProjectile",
	Animated = true,
	ModelName = "SlimeBruteProjectile",
	ExplosionEffectName = Enums.VisualEffects.RedSlimeSuicide,
	Hitscan = false,
	Velocity = 12,
	Gravity = 100,
	MinimumTimeToHit = 0.7,
	Arc = true,
	ArcAngle = 35,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true
}