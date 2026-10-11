local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
return {
	Health = 50000,
	Shield = 0,
	Speed = 1.8,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 100,
	Radius = 5,
	AnimationCalibratedSpeed = 1.5,
	BaseDamageOverride = 0,
	SummonedNoVFX = true,
	SpawnEffectInstanceNames = { "SpawnVFX" },
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	RotationOffset = CFrame.Angles(0, 0, 0),
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1
}