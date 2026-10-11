local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "InvisibleTurret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {}
}
return {
	Name = "WarshipTomahawk",
	ModelName = "WarshipTomahawk",
	ExplosionEffectName = Enums.VisualEffects.WarshipTomahawkBlast,
	TurretConfigs = { v },
	AlternateProjectileOrigins = true,
	AlternateProjectileOriginCount = 4,
	Hitscan = false,
	Velocity = 80,
	Gravity = 200,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 55,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 1.25
}