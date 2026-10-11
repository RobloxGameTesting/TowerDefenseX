local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "RailgunProjectile",
	ModelName = "RailgunProjectile",
	Hitscan = false,
	Velocity = 88,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25
}