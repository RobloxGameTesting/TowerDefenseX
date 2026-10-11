local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 42000,
	Shield = 5000,
	Speed = 1.75,
	AnimationCalibratedSpeed = 1.75,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 350,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	ThawTime = 0.6,
	Radius = 1,
	HoverHeight = 3.2076000000000002,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.375,
	SpawnPathPercentageVariance = 0.125,
	SpawnAnimationTime = 3.333,
	SpawnInvulnerabilityTime = 0.35,
	AbilityNames = { Enums.EnemyAbilities.AvatarMissiles },
	AbilityBufferTime = 3,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
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
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.55 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 }
	}
}