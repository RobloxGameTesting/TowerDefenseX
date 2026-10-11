local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.KickHit,
		TargetTorsoInsteadOfGround = true
	},
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	DisabledUntilAbilityWithNameUsed = Enums.EnemyAbilities.WallPusherTransition,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 3,
	AimTime = 0.25,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 1800,
	DamageDelay = 0.85,
	ReloadTime = 3,
	Range = 1.9,
	MinimumRange = 1.3,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = {
			Damage = 2500,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
local v2 = {
	Description = "Collision",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.VehicleCollisionHit,
		TargetTorsoInsteadOfGround = true
	},
	IgnoreOnClient = true,
	NoStopToAttack = true,
	CanTargetAir = false,
	IgnoreGround = false,
	CanTargetBase = false,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	DisabledWhenAbilityWithNameUsed = Enums.EnemyAbilities.WallPusherTransition,
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = false,
	Damage = 1000000,
	ReloadTime = 0.01,
	Range = 1.3,
	IsBurst = false
}
local v3 = {
	Description = "Collision Map Entity",
	IgnoreOnClient = true,
	NoStopToAttack = true,
	CanTargetAir = false,
	IgnoreGround = true,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = true,
	OnlyAttackBase = true,
	DisabledWhenAbilityWithNameUsed = Enums.EnemyAbilities.WallPusherTransition,
	DisableAndInstantUseAbility = Enums.EnemyAbilities.WallPusherTransition,
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = false,
	Damage = 10000,
	ReloadTime = 5,
	Range = 1.9,
	IsBurst = false
}
return {
	Health = 25000,
	Shield = 10000,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 1500,
	Radius = 2,
	HoverHeight = 2.442,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	SetUpFootstepKeyframeReachedEventForAllAnimations = true,
	AbilityNames = { Enums.EnemyAbilities.WallPusherTransition },
	AttackData = { v, v2, v3 },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	GunModelName = "Weapon",
	GunModelEffectsDelay = 0.85,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = { Health = nil, Shield = nil }
	}
}