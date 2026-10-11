local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "ToxicGrenadeGreen",
	ModelName = "ToxicGrenadeGreen",
	Hitscan = false,
	Velocity = 65,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	TimeToKeepAfterHit = 2,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.3
}