local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "LeechProjectile",
	ModelName = "LeechProjectile",
	ExplosionEffectName = Enums.VisualEffects.LeechHit,
	SpawnsAttachmentEntity = true,
	Hitscan = false,
	Velocity = 22,
	Gravity = 100,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 10,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TargetHeadInsteadOfGround = true,
	TargetBoundsInsteadOfCenter = true,
	HitVarianceXZ = 0.01
}