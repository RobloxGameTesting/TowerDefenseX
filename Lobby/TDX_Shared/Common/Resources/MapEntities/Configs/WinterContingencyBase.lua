local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("TurretTypes"))
return {
	OverrideDisplayName = "GDA Helicopter",
	Radius = 4,
	HoverHeight = 0,
	NoAnimations = true,
	NoTweenOnSpawn = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true,
	HasHealth = true,
	Health = 25000,
	DeathEffectInstanceNames = {},
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 2,
	FadeOutRemoveDelay = 1e999
}