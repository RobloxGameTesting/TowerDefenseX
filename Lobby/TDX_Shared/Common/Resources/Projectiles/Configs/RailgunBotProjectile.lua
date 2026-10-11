local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
return {
	Name = "RailgunBotProjectile",
	ModelName = "RailgunProjectile",
	Hitscan = false,
	Velocity = 100,
	AlwaysFaceTravelDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TimeToKeepAfterHit = 1,
	TargetTorsoInsteadOfGround = true,
	HitVarianceXZ = 0.75,
	HitVarianceY = 0.25,
	AnimationTriggerTime = 1 / 60,
	HideProjectileDuringHoldTime = true,
	DelayProjectileEffectsUntilHoldingOver = true
}