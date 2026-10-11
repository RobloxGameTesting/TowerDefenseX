local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Base",
	CanTargetAir = false,
	IgnoreGround = false,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = true,
	OnlyAttackBase = true,
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	ActivateAbilityHandlerBufferTime = true,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.DreadnoughtStrikerMissileBase,
	IsSplash = true,
	SplashRadius = 1,
	AimTime = 0.5,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 200,
	ReloadTime = 5,
	Range = 20,
	IsBurst = true,
	BurstSize = 16,
	BurstInterval = 0.0625,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			Damage = 500,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	OverrideDisplayName = "Striker",
	Health = 170000,
	Shield = 100000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.95,
	BodyHeat = 80000,
	BodyHeatRegenerationRate = 20000,
	Radius = 3,
	HoverHeight = 2.971,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.2,
	StunResistance = true,
	SuperStunResistance = true,
	IsBoss = true,
	BossMusicName = "DreadnoughtBossMusic",
	AbilityNames = {
		Enums.EnemyAbilities.DreadnoughtStrikerGroundMissiles,
		Enums.EnemyAbilities.DreadnoughtStrikerAirMissiles
	},
	AbilityBufferTime = 3,
	ForceFaceIntroTime = 1,
	ForceFaceOutroTime = 1.2,
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			[Enums.EnemyAbilities.DreadnoughtStrikerGroundMissiles] = {
				StartingCooldown = nil,
				Cooldown = nil,
				StartingCooldownVariance = nil,
				CooldownVariance = nil,
				DamageMultiplier = 2
			},
			[Enums.EnemyAbilities.DreadnoughtStrikerAirMissiles] = {
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
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = false,
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
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = 200000, Shield = 100000 }
	}
}