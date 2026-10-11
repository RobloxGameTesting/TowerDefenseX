local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "DreadcubusBall",
	ModelName = "DreadcubusBall",
	ExplosionEffectName = Enums.VisualEffects.DreadcubusExplosion,
	Hitscan = false,
	Velocity = 90,
	MinimumTimeToHit = 0.2,
	Arc = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.3
}