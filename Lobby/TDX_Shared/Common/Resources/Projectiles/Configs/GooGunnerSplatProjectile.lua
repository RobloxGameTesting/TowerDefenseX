local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GooGunnerSplatProjectile",
	ModelName = "GooGunnerSplatProjectile",
	ExplosionEffectName = Enums.VisualEffects.GooGunnerSplatBlast,
	CharacterNoFaceTarget = true,
	Hitscan = false,
	Velocity = 2000,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.3
}