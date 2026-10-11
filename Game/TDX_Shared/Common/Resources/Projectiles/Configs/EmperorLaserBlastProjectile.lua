local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "EmperorLaserBlastProjectile",
	ModelName = "EmperorLaserBlastProjectile",
	ExplosionEffectName = Enums.VisualEffects.EmperorLaserBlastHit,
	Hitscan = false,
	Velocity = 150,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 5,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.5,
	HitVarianceY = 0.25
}