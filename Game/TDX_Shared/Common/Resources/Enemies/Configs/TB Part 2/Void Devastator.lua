local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local VoidDevastator = {
	Health = 3500000,
	Shield = 100000,
	Speed = 2,
	BodyHeat = 130000,
	SuperStunResistance = true,
	FrozenMaximumTime = 3,
	FrozenDebounceTime = 12,
	BodyHeatRegenerationRate = 2000,
	HasCustomCode = true,
	PreventDeathUntilAbilityExecuted = Enums.EnemyAbilities.VoidDevastatorAwakening,
	InvulnerableWhilePreventingDeath = true,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.4,
	AnimationDefaultStopFadeTime = 0.4,
	KillAllOtherEnemiesOnDeath = true,
	KillAllOtherEnemiesOnDeathIgnoreOwnSequence = true,
	KillAllOtherEnemiesOnDeathIgnoreSequencesAfterOwn = true,
	KillBadgeId = 709501167182836,
	IsBoss = true,
	BossMusicName = "DevastatorBossMusic",
	BossHPBarColor = Color3.fromRGB(131, 65, 170),
	AbilityNames = {
		Enums.EnemyAbilities.VoidDevastatorCrystalInfection,
		Enums.EnemyAbilities.VoidDevastatorCrystalInfection_Summon,
		Enums.EnemyAbilities.VoidDevastatorAwakening,
		Enums.EnemyAbilities.VoidDevastatorAxeSlam,
		Enums.EnemyAbilities.VoidDevastatorEMPShock,
		Enums.EnemyAbilities.VoidDevastatorSummonCasual,
		Enums.EnemyAbilities.VoidDevastatorSummonHard,
		Enums.EnemyAbilities.VoidDevastatorSummonNightmare,
		Enums.EnemyAbilities.VoidDevastatorSummonVoidmare,
		Enums.EnemyAbilities.VoidDevastatorSwordSlash,
		Enums.EnemyAbilities.VoidDevastatorSwordRage,
		Enums.EnemyAbilities.VoidDevastatorEyeConfusion,
		Enums.EnemyAbilities.VoidDevastatorEyeLaser
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 1.2,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 16,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 20,
	DeathApplyGameResetData = {
		Delay = 10.2,
		SetCash = 3000000,
		SetCashSplitBetweenPlayers = true,
		SetLives = 8000,
		ClearAllEntities = true
	},
	DeathExplodePartsScale = 3,
	DeathExplodePartsDelay = 10.05,
	ExplodePartsExtraKeepTime = 25,
	DeathEffectsData = {
		{ InstancePath = "Death>RootPart" }
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.5 }
	}
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.TBPart2Voidmare] = {
		[Enums.EnemyAbilities.VoidDevastatorSwordRage] = { Cooldown = 50 }
	}
}
local TBPart2Casual = Enums.Difficulties.TBPart2Casual
difficultyToAbilityStatOverridesMap[TBPart2Casual] = {
	[Enums.EnemyAbilities.VoidDevastatorSwordRage] = { Cooldown = 60, DamageMultiplier = 0.1 },
	[Enums.EnemyAbilities.VoidDevastatorEyeConfusion] = { Cooldown = 60 },
	[Enums.EnemyAbilities.VoidDevastatorAxeSlam] = { DamageMultiplier = 0.2 },
	[Enums.EnemyAbilities.VoidDevastatorSwordSlash] = { DamageMultiplier = 0.3 }
}
VoidDevastator.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
VoidDevastator.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.TBPart2Nightmare] = {
		OverrideBossMusicName = "DevastatorNightmareBossMusic"
	},
	[Enums.Difficulties.TBPart2Voidmare] = {
		OverrideBossMusicName = "DevastatorNightmareBossMusic"
	},
	[Enums.Difficulties.TBPart2Casual] = { Health = 2000000 }
}
VoidDevastator.PlayerCountToAdditionalStatsMap = {
	[2] = { Health = 175000 },
	[3] = { Health = 300000 },
	[4] = { Health = 450000 }
}
return VoidDevastator