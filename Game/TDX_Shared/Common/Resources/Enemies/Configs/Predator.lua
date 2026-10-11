local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Base",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.PredatorShotgunBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.5,
		VarianceY = 0.25
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
	AimTime = 1.167,
	AimResetTime = 1.3,
	ResetAimAfterEachShot = false,
	Damage = 50,
	ReloadTime = 2.2,
	Range = 12,
	IsBurst = true,
	BurstSize = 3,
	BurstInterval = 0.6,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = {
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
	Health = 35000,
	Speed = 2.6,
	BodyHeat = 2650,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	HoverHeight = 2.5035495716034273,
	AnimationTimeScale = 1,
	IsMiniBoss = true,
	BossMusicName = "PredatorBossMusic",
	AbilityNames = { Enums.EnemyAbilities.PredatorAttackBurst, Enums.EnemyAbilities.PredatorAttack },
	AbilityBufferTime = 3,
	AttackData = { v },
	HasAttack = true,
	AttackDisabledByDefault = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = false,
	GunModelName = "Shotgun",
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
	NoPathOffset = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.BigZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 1.5,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.3 }
	}
}