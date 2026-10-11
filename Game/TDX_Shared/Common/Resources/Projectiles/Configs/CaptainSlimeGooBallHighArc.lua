local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "CaptainSlimeGooBallHighArc",
	ModelName = "CaptainSlimeGooBall",
	ExplosionEffectName = Enums.VisualEffects.CaptainSlimeGooBallHit,
	Hitscan = false,
	Velocity = 20,
	Gravity = 150,
	MinimumTimeToHit = 1.3,
	Arc = true,
	ArcAngle = 72,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 0.5
}