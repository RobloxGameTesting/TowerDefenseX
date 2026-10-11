local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "RavagedPredatorProjectile",
	ModelName = "RavagedPredatorProjectile",
	ExplosionEffectName = Enums.VisualEffects.BasicMissileBlast,
	Hitscan = false,
	Velocity = 75,
	MinimumTimeToHit = 0.1,
	AdditionalRotationPerSecond = vector.create(0, 0, -12.566371),
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.1,
	HitVarianceY = 0.1,
	TargetTorsoInsteadOfGround = true
}