local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1100000,
	Shield = 100000,
	Speed = 2.2,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 100000000,
	BodyHeatRegenerationRate = 6000000,
	OverrideDisplayName = "Corrupted Eradicator MK II",
	HasCustomCode = true,
	Radius = 1,
	HoverHeight = 3.655,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "CorruptedEradicatorMK2BossMusic",
	AbilityNames = {
		{
			Name = Enums.EnemyAbilities.CorruptedEradicatorMK2Jumpscare,
			DisableDifficulties = { Enums.Difficulties.HalloweenNightmarePart3 }
		},
		{
			Name = Enums.EnemyAbilities.CorruptedEradicatorMK2JumpscareNightmare,
			EnableDifficulties = { Enums.Difficulties.HalloweenNightmarePart3 }
		},
		Enums.EnemyAbilities.CorruptedEradicatorMK2PreJumpscareShield,
		Enums.EnemyAbilities.CorruptedEradicatorMK2BaseAttack,
		Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunFocus,
		Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunSweep,
		Enums.EnemyAbilities.CorruptedEradicatorMK2AirMissiles,
		Enums.EnemyAbilities.CorruptedEradicatorMK2GroundMissiles,
		Enums.EnemyAbilities.CorruptedEradicatorMK2Flamethrower,
		Enums.EnemyAbilities.CorruptedEradicatorMK2GrenadeLauncher
	},
	NoUseAbilityTimes = {
		{
			StartTime = _G.CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME - 12,
			EndTime = _G.CORRUPTED_ERADICATOR_MK2_JUMPSCARE_TIME + 1,
			AllowedAbilities = {
				Enums.EnemyAbilities.CorruptedEradicatorMK2Jumpscare,
				Enums.EnemyAbilities.CorruptedEradicatorMK2JumpscareNightmare
			}
		}
	},
	AbilityBufferTime = 3,
	DeathAbilityNames = { Enums.EnemyAbilities.CorruptedEradicatorMK2DeathExplosion },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			[Enums.EnemyAbilities.CorruptedEradicatorMK2BaseAttack] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = nil
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunFocus] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 3
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunSweep] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 1.2
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2AirMissiles] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2GroundMissiles] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2Flamethrower] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 1.5
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2GrenadeLauncher] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 1.3
			},
			[Enums.EnemyAbilities.CorruptedEradicatorMK2DeathExplosion] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = nil
			}
		}
	},
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	AttackData = {
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
	StopToAttack = false,
	StealthDetection = false,
	RangeVariance = false,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	MinimumTimeBeforeSequenceEnds = 7,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	ShieldModelName = "ForceField",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			OverrideDisplayName = "Enraged Eradicator MK II",
			Health = 2650000,
			Shield = 425000
		}
	},
	PlayerCountToAdditionalStatsMap = {
		[3] = { Health = 50000, Shield = 100000 },
		[4] = { Health = 75000, Shield = 200000 }
	},
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld1",
			TimeToMaxRotationSpeed = 0.7,
			TimeToSpinAfterShot = 0.7,
			TimeToStopRotation = 1.3,
			MaxRotationSpeedY = 35
		},
		{
			WeldPointerName = "RotatingBarrelWeld2",
			TimeToMaxRotationSpeed = 0.5,
			TimeToSpinAfterShot = 0.7,
			TimeToStopRotation = 0.8,
			MaxRotationSpeedY = 35
		},
		{
			WeldPointerName = "RotatingBarrelWeld3",
			TimeToMaxRotationSpeed = 0.3,
			TimeToSpinAfterShot = 0.7,
			TimeToStopRotation = 0.4,
			MaxRotationSpeedY = 35
		}
	}
}