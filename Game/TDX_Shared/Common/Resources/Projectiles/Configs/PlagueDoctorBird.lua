local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PlagueDoctorBird",
	Animated = true,
	ModelName = "Bird",
	ExplosionEffectName = Enums.VisualEffects.BirdSuicide,
	Hitscan = false,
	Velocity = 5,
	Gravity = 200,
	MinimumTimeToHit = 1,
	Arc = true,
	ArcAngle = 55,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	TargetTorsoInsteadOfGround = true
}