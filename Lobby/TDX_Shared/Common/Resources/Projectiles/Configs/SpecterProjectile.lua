local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "SpecterProjectile",
	ModelName = "SpecterProjectile",
	ExplosionEffectName = Enums.VisualEffects.SpecterGrenade,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 20,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0)
}