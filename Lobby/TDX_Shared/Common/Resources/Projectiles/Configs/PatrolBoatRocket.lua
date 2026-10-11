local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "AbilityTurret",
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
return {
	Name = "PatrolBoatRocket",
	ModelName = "PatrolBoatRocket",
	ExplosionEffectName = Enums.VisualEffects.BasicMissileBlast,
	TurretConfigs = { v },
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 4,
	Hitscan = false,
	Velocity = 65,
	MinimumTimeToHit = 0.15,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	HitVarianceXZ = 1
}