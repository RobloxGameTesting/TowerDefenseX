local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "M202Missile",
	ModelName = "M202Missile",
	ExplosionEffectName = Enums.VisualEffects.M202Blast,
	Hitscan = false,
	Velocity = 75,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25
}