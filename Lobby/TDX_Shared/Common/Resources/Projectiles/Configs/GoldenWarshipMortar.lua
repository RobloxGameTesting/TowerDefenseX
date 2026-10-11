local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "GoldenWarshipMortar",
	ModelName = "GoldenWarshipMortar",
	ExplosionEffectName = Enums.VisualEffects.BattleshipMortarBlast,
	Hitscan = false,
	Velocity = 110,
	Gravity = 200,
	MinimumTimeToHit = 0.2,
	Arc = true,
	ArcAngle = 30,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(-1.5707963267948966, 0, 0),
	TimeToKeepAfterHit = 2,
	HitVarianceXZ = 2.5
}