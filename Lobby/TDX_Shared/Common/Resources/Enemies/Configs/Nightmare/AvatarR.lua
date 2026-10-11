local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Avatar-R",
	Health = 70000,
	Shield = 80000,
	Speed = 1.75,
	AnimationCalibratedSpeed = 1.75,
	BodyHeat = 15000,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	HoverHeight = 3.2076000000000002,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.375,
	SpawnPathPercentageVariance = 0.125,
	SpawnAnimationTime = 3.333,
	SpawnInvulnerabilityTime = 0.35,
	AbilityNames = { Enums.EnemyAbilities.AvatarRRailgun },
	AbilityBufferTime = 3,
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	MinimumTimeBeforeSequenceEnds = 3,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 2,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	NoTweenOnSpawn = true,
	SpawnEffectInstanceNames = { "AvatarSpawnEffects" },
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 }
	}
}