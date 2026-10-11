local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "IceBreakerIceShardProjectile",
	ModelName = "IceBreakerIceShardProjectile",
	ExplosionEffectName = Enums.VisualEffects.IceBreakerIceShardSpawn,
	Hitscan = false,
	Velocity = 20,
	MinimumTimeToHit = 0.35,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 2,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.3
}