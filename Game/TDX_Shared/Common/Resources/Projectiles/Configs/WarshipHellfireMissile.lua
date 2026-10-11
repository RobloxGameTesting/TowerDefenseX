local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "MissileTurret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
return {
	Name = "WarshipHellfireMissile",
	ModelName = "WarshipHellfireMissile",
	ExplosionEffectName = Enums.VisualEffects.WarshipHellfireMissileBlast,
	TurretConfigs = { v },
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 8,
	Hitscan = false,
	Velocity = 250,
	MinimumTimeToHit = 0.15,
	Arc = true,
	ArcAngle = 15,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1
}