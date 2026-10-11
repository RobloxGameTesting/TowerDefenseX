local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "TerryTheBunnyAxe",
	ModelName = "TerryTheBunnyAxe",
	ExplosionEffectName = Enums.VisualEffects.DefaultAxeHit,
	Hitscan = false,
	Velocity = 30,
	MinimumTimeToHit = 0.1,
	AdditionalRotationPerSecond = vector.create(0, 0, -12.566371),
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 3.141592653589793, 0),
	HitVarianceXZ = 0.1,
	HitVarianceY = 0.1,
	TargetTorsoInsteadOfGround = true
}