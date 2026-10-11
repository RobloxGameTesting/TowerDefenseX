local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "ShadyBossKnife",
	ModelName = "ShadyBossKnife",
	ExplosionEffectName = Enums.VisualEffects.Gun20Explosion,
	Hitscan = false,
	Velocity = 65,
	MinimumTimeToHit = 0.1,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	HitVarianceXZ = 0.15,
	HitVarianceY = 0.15,
	AlwaysFaceTravelDirection = true,
	TargetTorsoInsteadOfGround = true,
	RegenerationDelay = 0.1,
	RegenerationTime = 0.1
}