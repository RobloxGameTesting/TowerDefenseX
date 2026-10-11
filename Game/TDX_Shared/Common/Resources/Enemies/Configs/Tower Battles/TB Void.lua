local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TBVoid = {
	OverrideDisplayName = "Void",
	Health = 900000,
	SuperStunResistance = true,
	Speed = 1,
	AnimationCalibratedSpeed = 1.2,
	BodyHeat = 1000000,
	BodyHeatRegenerationRate = 350000,
	FrozenDebounceTime = 10,
	FrozenMaximumTime = 1,
	ThawTime = 0.1,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	IsBoss = true,
	BossMusicName = "TBVoidBossMusic",
	BossHPBarColor = Color3.fromRGB(131, 65, 170),
	AbilityNames = {
		Enums.EnemyAbilities.TBVoidSpawnRageScream,
		Enums.EnemyAbilities.TBVoidMeteorites,
		Enums.EnemyAbilities.TBVoidConversion,
		Enums.EnemyAbilities.TBVoidTowerDestruction,
		Enums.EnemyAbilities.TBVoidTowerDestructionGolden,
		Enums.EnemyAbilities.TBVoidStomp,
		Enums.EnemyAbilities.TBVoidSummon
	},
	AbilityBufferTime = 5,
	ForceFaceIntroTime = 0.65,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = 0,
	FootstepEffectInstanceNames = "FootstepSoundsPart",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = 0,
	MinimumTimeBeforeSequenceEnds = 8,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 3,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 5
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.TBPart2Casual] = {
		[Enums.EnemyAbilities.TBVoidSpawnRageScream] = {
			StartingCooldown = 1e999,
			Cooldown = 5,
			DamageMultiplier = 1
		},
		[Enums.EnemyAbilities.TBVoidSummon] = { StartingCooldown = 20, Cooldown = 120 }
	}
}
local TBPart2Hard = Enums.Difficulties.TBPart2Hard
difficultyToAbilityStatOverridesMap[TBPart2Hard] = {
	[Enums.EnemyAbilities.TBVoidSpawnRageScream] = {
		StartingCooldown = 1e999,
		Cooldown = 5,
		DamageMultiplier = 1
	},
	[Enums.EnemyAbilities.TBVoidSummon] = { StartingCooldown = 20, Cooldown = 100 }
}
TBVoid.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
TBVoid.RotationOffset = CFrame.Angles(0, 0, 0)
return TBVoid