local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 2900000,
	Shield = 250000,
	Speed = 2.2,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 120000,
	BodyHeatRegenerationRate = 800,
	OverrideDisplayName = "Corrupted Eradicator MK II",
	HasCustomCode = true,
	OverrideCustomCodeName = Enums.Enemies.CorruptedEradicatorMK2,
	OverrideCharacterModelName = Enums.Enemies.CorruptedEradicatorMK2,
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
		Enums.EnemyAbilities.CorruptedEradicatorMK2BaseAttack,
		Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunFocus,
		Enums.EnemyAbilities.CorruptedEradicatorMK2MinigunSweep,
		Enums.EnemyAbilities.CorruptedEradicatorMK2AirMissiles,
		Enums.EnemyAbilities.CorruptedEradicatorMK2GroundMissiles,
		Enums.EnemyAbilities.CorruptedEradicatorMK2Flamethrower,
		Enums.EnemyAbilities.CorruptedEradicatorMK2GrenadeLauncher
	},
	AbilityBufferTime = 3,
	DeathAbilityNames = { Enums.EnemyAbilities.CorruptedEradicatorMK2DeathExplosion },
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