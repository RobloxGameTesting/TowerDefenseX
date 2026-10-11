local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "M203",
	ModelName = "M203",
	ExplosionEffectName = Enums.VisualEffects.M203,
	Hitscan = false,
	Velocity = 45,
	MinimumTimeToHit = 0.4,
	Arc = true,
	ArcAngle = 0,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(3.141592653589793, 0, 0)
}