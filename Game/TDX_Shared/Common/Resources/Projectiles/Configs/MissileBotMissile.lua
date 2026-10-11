local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MissileBotMissile",
	ModelName = "MissileBotMissile",
	ExplosionEffectName = Enums.VisualEffects.BasicMissileBlast,
	Hitscan = false,
	Velocity = 60,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 1
}