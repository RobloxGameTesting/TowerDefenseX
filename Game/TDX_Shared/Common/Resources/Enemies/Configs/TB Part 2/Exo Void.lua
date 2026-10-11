local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ExoVoid = {
	Health = 4200000,
	Shield = 200000,
	StealthDetection = true,
	Speed = 4,
	BodyHeat = 130000,
	BodyHeatRegenerationRate = 1000,
	HasCustomCode = true,
	Radius = 1,
	AnimationTimeScale = 1,
	SpawnPathPercentage = 0.15,
	SpawnPathPercentageVariance = 0.1,
	KillBadgeId = 840841430147239,
	SpawnAnimationTime = 11.05,
	SpawnInvulnerabilityTime = 9.3,
	EnemyTeleportOnPathPercentageData = {
		TriggerPathPercentage = 0.94,
		GoalPathPercentage = 0.07,
		MaximumUses = 1
	},
	PreTeleportVFXName = Enums.VisualEffects.ExoVoidPreTeleportVFX,
	PostTeleportEffectParentInstanceNames = { "PostTeleport" },
	IsBoss = true,
	BossMusicName = "ExoVoidBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.ExoVoidSwordThrow,
		Enums.EnemyAbilities.ExoVoidSwordThrow_Throw,
		Enums.EnemyAbilities.ExoVoidPlasmaRifle,
		Enums.EnemyAbilities.ExoVoidPlasmaRifleAA,
		Enums.EnemyAbilities.ExoVoidEMPBlast,
		Enums.EnemyAbilities.ExoVoidSwordSwing,
		Enums.EnemyAbilities.ExoVoidSwordZap,
		Enums.EnemyAbilities.ExoVoidClawEarthquake,
		Enums.EnemyAbilities.ExoVoidSwordInferno,
		Enums.EnemyAbilities.ExoVoidSwordInferno_Heal,
		Enums.EnemyAbilities.ExoVoidSwordInferno_InitialSlam
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 1.2
}
local difficultyToAbilityStatOverridesMap = {
	[Enums.Difficulties.TBPart2Casual] = {
		[Enums.EnemyAbilities.ExoVoidPlasmaRifle] = { Cooldown = 40, DamageMultiplier = 0.3 },
		[Enums.EnemyAbilities.ExoVoidSwordInferno] = { DamageMultiplier = 0.1 },
		[Enums.EnemyAbilities.ExoVoidSwordSwing] = { DamageMultiplier = 0.15 },
		[Enums.EnemyAbilities.ExoVoidClawEarthquake] = { DamageMultiplier = 0.1 },
		[Enums.EnemyAbilities.ExoVoidPlasmaRifleAA] = { DamageMultiplier = 0.3 },
		[Enums.EnemyAbilities.ExoVoidSwordInferno_InitialSlam] = { DamageMultiplier = 0.2 }
	}
}
local TBPart2Voidmare = Enums.Difficulties.TBPart2Voidmare
difficultyToAbilityStatOverridesMap[TBPart2Voidmare] = {
	[Enums.EnemyAbilities.ExoVoidSwordThrow] = { HealAmountMultiplier = 6 },
	[Enums.EnemyAbilities.ExoVoidSwordThrow_Throw] = { DamageMultiplier = 0.05 },
	[Enums.EnemyAbilities.ExoVoidPlasmaRifle] = { Cooldown = 30, DamageMultiplier = 2 },
	[Enums.EnemyAbilities.ExoVoidPlasmaRifleAA] = { Cooldown = 35, DamageMultiplier = 2.5 },
	[Enums.EnemyAbilities.ExoVoidSwordInferno] = { DamageMultiplier = 2 },
	[Enums.EnemyAbilities.ExoVoidClawEarthquake] = { DamageMultiplier = 1.5 }
}
ExoVoid.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
ExoVoid.DeathAbilityNames = {}
ExoVoid.NoPathOffset = true
ExoVoid.RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0)
ExoVoid.MinimumTimeBeforeSequenceEnds = 5
ExoVoid.FakeEnemy = false
ExoVoid.FadeOutOnDeath = true
ExoVoid.FadeOutDelay = 0
ExoVoid.FadeOutCustomTime = 0.2
ExoVoid.FadeOutRemoveDelay = 2
ExoVoid.DamageReductionTable = {
	{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
	{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
	{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
	{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.7 }
}
ExoVoid.DifficultyToStatOverrideMap = {
	[Enums.Difficulties.TBPart2Nightmare] = { OverrideBossMusicName = "ExoVoidNightmareBossMusic" },
	[Enums.Difficulties.TBPart2Voidmare] = { OverrideBossMusicName = "ExoVoidNightmareBossMusic" },
	[Enums.Difficulties.TBPart2Casual] = { Health = 3700000 }
}
ExoVoid.PlayerCountToAdditionalStatsMap = {
	[2] = { Health = 175000, Shield = 100000 },
	[3] = { Health = 400000, Shield = 175000 },
	[4] = { Health = 450000, Shield = 220000 }
}
return ExoVoid