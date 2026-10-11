local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1800000,
	Shield = 150000,
	Speed = 1.7,
	BodyHeat = 99999999,
	BodyHeatRegenerationRate = 9999999,
	OverrideDisplayName = "Party Celgar",
	HasCustomCode = true,
	OverrideCustomCodeName = "General Celgar",
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "CommanderCelgarBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.PartyGeneralCelgarRage,
		Enums.EnemyAbilities.PartyGeneralCelgarIceBreath,
		Enums.EnemyAbilities.PartyGeneralCelgarShieldGain,
		Enums.EnemyAbilities.PartyGeneralCelgarSummon,
		Enums.EnemyAbilities.PartyGeneralCelgarSnowballArtillery,
		Enums.EnemyAbilities.PartyGeneralCelgarAxeSlam,
		Enums.EnemyAbilities.PartyGeneralCelgarAxeThrow
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.GeneralCelgarDeath },
	FootstepEffectInstanceNames = { "RootPart>FootstepEffects", "RootPart>FootstepVFX1", "RootPart>FootstepVFX2" },
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	StealthDetection = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	MinimumTimeBeforeSequenceEnds = 5,
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 }
	},
	PlayerCountToAdditionalStatsMap = {
		[2] = { Health = 100000 },
		[3] = { Health = 150000 },
		[4] = { Health = 300000 }
	}
}