local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Base",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.05,
		VarianceY = 0.05
	},
	CanTargetAir = false,
	IgnoreGround = false,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = true,
	OnlyAttackBase = true,
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	ActivateAbilityHandlerBufferTime = true,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 2.6,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 100,
	ReloadTime = 0.08,
	Range = 7,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = {
			Damage = 275,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	Health = 4000000,
	Shield = 0,
	Speed = 2,
	AnimationCalibratedSpeed = 2.2,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 60000,
	FrozenDebounceTime = 8,
	FrozenMaximumTime = 10,
	OverrideDisplayName = "Corrupted Apex Predator",
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
		Enums.EnemyAbilities.CorrApexPredCrossSummon,
		Enums.EnemyAbilities.CorrApexPredCrossHeal,
		Enums.EnemyAbilities.CorrApexPredLeechSwarm
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	DeathAbilityNames = {},
	DifficultyToAbilityStatOverridesMap = { [Enums.Difficulties.HalloweenNightmarePart4] = {} },
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	AttackData = {
		v,
		{
			Description = "Collision",
			IgnoreOnClient = true,
			NoStopToAttack = true,
			CanTargetAir = false,
			IgnoreGround = false,
			CanTargetBase = false,
			CanTargetBaseUsingEndNodes = false,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			TargetMinimumValue = 0,
			ConsiderTargetsWithNoAttack = true,
			IsProjectile = false,
			IsSplash = false,
			Damage = 1000000,
			ReloadTime = 0.01,
			Range = 1.5,
			IsBurst = false
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = false,
	GunModelName = "Gun",
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
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
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = {
			OverrideDisplayName = "Enraged Apex Predator",
			Health = 5000000,
			Shield = 0
		}
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 400000, Shield = 0 },
		[4] = { Health = 800000, Shield = 0 }
	},
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.7,
			TimeToSpinAfterShot = 0.7,
			TimeToStopRotation = 1.3,
			MaxRotationSpeedY = 35
		}
	}
}