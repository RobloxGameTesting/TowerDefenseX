local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
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
	AimTime = 1,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 100,
	ReloadTime = 0.08,
	Range = 12,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
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
	OverrideDisplayName = "Contemptor",
	Health = 275000,
	Shield = 200000,
	Speed = 1.5,
	AnimationCalibratedSpeed = 2.15,
	BodyHeat = 100000,
	BodyHeatRegenerationRate = 30000,
	Radius = 3,
	HoverHeight = 3.361,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "DreadnoughtBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.DreadnoughtContemptorMachineGun,
		Enums.EnemyAbilities.DreadnoughtContemptorStrafe,
		Enums.EnemyAbilities.DreadnoughtContemptorDamageBuff
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			[Enums.EnemyAbilities.DreadnoughtContemptorMachineGun] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.DreadnoughtContemptorStrafe] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			}
		}
	},
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
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.DreadnoughtDeath,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	DamageReductionTable = {},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = 300000, Shield = nil }
	}
}