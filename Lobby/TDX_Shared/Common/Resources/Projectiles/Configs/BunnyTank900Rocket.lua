local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BunnyTank900Rocket",
	ModelName = "BunnyTank900Rocket",
	ExplosionEffectName = Enums.VisualEffects.PinkExplosionMedium,
	Hitscan = false,
	Velocity = 45,
	Gravity = 1,
	MinimumTimeToHit = 0.6,
	Arc = true,
	ArcAngle = 6,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	TimeToKeepAfterHit = 2,
	FlyForwardsTime = 0.4,
	FlyForwardsOverrideVelocity = 45,
	FlyForwardsRadialSpread = 20,
	RegenerationDelay = 3,
	RegenerationTime = 0.4
}