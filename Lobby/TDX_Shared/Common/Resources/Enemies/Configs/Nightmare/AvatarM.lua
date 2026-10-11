local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Avatar-M",
	Health = 42000,
	Shield = 12500,
	Speed = 2.2,
	AnimationCalibratedSpeed = 1.75,
	BodyHeat = 19000,
	BodyHeatRegenerationRate = 350,
	Radius = 1,
	HoverHeight = 3.2076000000000002,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.5,
	SpawnPathPercentageVariance = 0.125,
	SpawnAnimationTime = 3.333,
	SpawnInvulnerabilityTime = 0.75,
	AbilityNames = { Enums.EnemyAbilities.AvatarMFlamethrower },
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
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}