local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "NightmareEndbringerHammer",
	ModelName = "NightmareEndbringerHammer",
	ExplosionEffectName = Enums.VisualEffects.NightmareEndbringerHammerHit,
	Hitscan = false,
	Velocity = 55,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 5,
	RotationsInAirPerSecondMinimum = 0,
	RotationsInAirPerSecondMaximum = 0,
	AdditionalRotationPerSecond = vector.create(28.274334, 0, 0),
	RotationOffset = CFrame.Angles(0, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true,
	RegenerationDelay = 1.1,
	RegenerationTime = 0.5
}