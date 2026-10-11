local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
return {
	OverrideDisplayName = "Fortress Snowlyn Gate",
	Radius = 1,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	AttackerShouldFaceMovementDirection = true,
	ForceCanUseEndNodes = true,
	RepairEffectOnHead = true,
	HasHealth = true,
	Health = 27000,
	DeathEffectInstanceNames = { "DeathVFX", "DeathVFX2" },
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999,
	NearbyTowerBuffRadius = 150,
	NoDisplayBuffRadius = true,
	NearbyTowerBuffData = { RangeBuff = 0.15, UseRange3 = true }
}