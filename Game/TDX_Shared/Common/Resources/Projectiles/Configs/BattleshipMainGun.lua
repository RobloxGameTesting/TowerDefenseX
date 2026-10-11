local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "BattleshipMainGun",
	ModelName = "BattleshipMainGunShell",
	ExplosionEffectName = Enums.VisualEffects.BattleshipMainGunBlast,
	Hitscan = false,
	Velocity = 300,
	Gravity = 300,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 5,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 5
}