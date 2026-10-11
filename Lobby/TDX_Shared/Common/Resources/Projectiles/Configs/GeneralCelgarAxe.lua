local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GeneralCelgarAxe",
	ModelName = "GeneralCelgarAxe",
	ExplosionEffectName = Enums.VisualEffects.GeneralCelgarAxeExplosion,
	Hitscan = false,
	Velocity = 90,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 5,
	AdditionalRotationPerSecond = vector.create(-12.566371, 0, 0),
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true
}