local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "IronBastionHammer",
	ModelName = "IronBastionHammer",
	ExplosionEffectName = Enums.VisualEffects.IronBastionHammerHit,
	Hitscan = false,
	Velocity = 25,
	MinimumTimeToHit = 0.1,
	Arc = false,
	TargetTorsoInsteadOfGround = true,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.4,
	HitVarianceY = 0.2,
	RegenerationDelay = 1.8,
	RegenerationTime = 0.1
}