local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1100000,
	Speed = 1.7,
	BodyHeat = 99999999,
	BodyHeatRegenerationRate = 9999999,
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "GeneralCelgarBossMusic",
	AbilityNames = {
		{ Name = Enums.EnemyAbilities.GeneralCelgarBaseAttack },
		{
			Name = Enums.EnemyAbilities.GeneralCelgarRage,
			DisableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarRageNightmare,
			EnableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{ Name = Enums.EnemyAbilities.GeneralCelgarIceBreath },
		{
			Name = Enums.EnemyAbilities.GeneralCelgarShieldGain,
			DisableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarShieldGainNightmare,
			EnableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarSnowballArtillery,
			DisableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarSnowballArtilleryNightmare,
			EnableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarSummon,
			DisableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{
			Name = Enums.EnemyAbilities.GeneralCelgarSummonNightmare,
			EnableDifficulties = { Enums.Difficulties.Christmas24Part2Nightmare }
		},
		{ Name = Enums.EnemyAbilities.GeneralCelgarAxeSlam },
		{ Name = Enums.EnemyAbilities.GeneralCelgarAxeThrow }
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 0.5,
	ForceFaceOutroTime = 0.6,
	DeathAbilityNames = { Enums.EnemyAbilities.GeneralCelgarDeath },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			[Enums.EnemyAbilities.GeneralCelgarBaseAttack] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.GeneralCelgarIceBreath] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 4
			},
			[Enums.EnemyAbilities.GeneralCelgarAxeSlam] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 4
			},
			[Enums.EnemyAbilities.GeneralCelgarAxeThrow] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 4
			}
		}
	},
	FootstepEffectInstanceNames = { "RootPart>FootstepEffects", "RootPart>FootstepVFX1", "RootPart>FootstepVFX2" },
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	AttackData = {
		{
			Description = "Collision",
			IgnoreOnClient = true,
			NoStopToAttack = true,
			OverrideStealthDetection = true,
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
	StopToAttack = false,
	StealthDetection = true,
	RangeVariance = false,
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
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			OverrideDisplayName = "Commander Celgar",
			OverrideBossMusicName = "CommanderCelgarBossMusic",
			Health = 2500000
		}
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 400000 },
		[4] = { Health = 700000 }
	}
}