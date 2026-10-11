local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "PapaDuckAxe",
	ModelName = "PapaDuckAxe",
	ExplosionEffectName = Enums.VisualEffects.DefaultAxeHit,
	Hitscan = false,
	Velocity = 30,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 15,
	RotationsInAirPerSecondMinimum = 1,
	RotationsInAirPerSecondMaximum = 4,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.1,
	HitVarianceY = 0.1,
	TargetTorsoInsteadOfGround = true
}