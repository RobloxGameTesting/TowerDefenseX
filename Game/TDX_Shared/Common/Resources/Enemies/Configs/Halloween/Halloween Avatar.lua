local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Avatar",
	OverrideCharacterModelName = Enums.Enemies.Avatar,
	Health = 42000,
	Shield = 5000,
	Speed = 1.75,
	AnimationCalibratedSpeed = 1.75,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 1200,
	Radius = 1,
	HoverHeight = 3.2076000000000002,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.475,
	SpawnPathPercentageVariance = 0,
	SpawnAnimationTime = 3.333,
	SpawnInvulnerabilityTime = 0.35,
	AbilityNames = { Enums.EnemyAbilities.HalloweenAvatarMissiles },
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
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}