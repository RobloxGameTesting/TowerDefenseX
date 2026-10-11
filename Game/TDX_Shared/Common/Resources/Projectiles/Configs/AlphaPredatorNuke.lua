local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "AlphaPredatorNuke",
	ModelName = "AlphaPredatorNuke",
	ExplosionEffectName = Enums.VisualEffects.AlphaPredatorNukeBlast,
	Hitscan = false,
	Velocity = 30,
	MinimumTimeToHit = 0.1,
	Arc = true,
	ArcAngle = 30,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	HitVarianceXZ = 0.88,
	HitVarianceY = 0.01,
	HitVarianceYOnlyDown = true,
	AnimationTriggerTime = 1.9500000000000002
}