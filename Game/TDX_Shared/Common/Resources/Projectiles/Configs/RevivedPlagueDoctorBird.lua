local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "RevivedPlagueDoctorBird",
	Animated = true,
	ModelName = "Revived Bird",
	ExplosionEffectName = Enums.VisualEffects.RevivedBirdSuicide,
	Hitscan = false,
	Velocity = 7,
	Gravity = 120,
	MinimumTimeToHit = 0.8,
	Arc = true,
	ArcAngle = 35,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true
}