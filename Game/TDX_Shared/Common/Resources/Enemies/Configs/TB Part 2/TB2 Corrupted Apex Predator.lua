local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1500000,
	Shield = 450000,
	Speed = 2,
	AnimationCalibratedSpeed = 2.2,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 60000,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	OverrideDisplayName = "Corrupted Apex Predator",
	OverrideCharacterModelName = Enums.Enemies.CorruptedApexPredator,
	OverrideCustomCodeName = Enums.Enemies.CorruptedApexPredator,
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 5.37,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	IsBoss = true,
	BossMusicName = "CorruptedApexPredatorBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.CorrApexPredConversionBeam,
		Enums.EnemyAbilities.CorrApexPredCrossSlam,
		Enums.EnemyAbilities.CorrApexPredRocketsAir,
		Enums.EnemyAbilities.CorrApexPredRocketsAirAndGround,
		Enums.EnemyAbilities.TB2CorrApexPredSummon,
		Enums.EnemyAbilities.CorrApexPredCrossHeal,
		Enums.EnemyAbilities.CorrApexPredLeechSwarm
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	DeathAbilityNames = {},
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	HasAttack = false,
	StealthDetection = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 7,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 400000, Shield = 0 },
		[4] = { Health = 800000, Shield = 0 }
	}
}