local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "XNaderGrenade",
	ModelName = "XNaderGrenade",
	ExplosionEffectName = Enums.VisualEffects.EradicatorMissileBlast,
	Hitscan = false,
	Velocity = 45,
	MinimumTimeToHit = 0.6,
	Arc = true,
	ArcAngle = 2,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
}