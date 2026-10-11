local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MRL",
	ModelName = "MRL",
	ExplosionEffectName = Enums.VisualEffects.MRLBlast,
	Hitscan = false,
	Velocity = 100,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5
}