local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Air",
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 1,
	CanTargetAir = true,
	IgnoreGround = true,
	CanTargetBase = false,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	ActivateReloadForAllAttacks = true,
	IsPiercing = false,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.25,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 80,
	DamageDelay = 0.05,
	ReloadTime = 2,
	Range = 11,
	MinimumRange = 0.5,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 130,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
local v2 = {
	Description = "Ground",
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 1,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	ActivateReloadForAllAttacks = true,
	IsPiercing = true,
	PierceCount = 2,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.25,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 40,
	DamageDelay = 0.05,
	ReloadTime = 2,
	Range = 11,
	MinimumRange = 0.5,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 100,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	Health = 400,
	Speed = 2.2,
	BodyHeat = 55,
	BodyHeatRegenerationRate = 11,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AttackData = { v, v2 },
	UsePrimaryAttackDataForClient = true,
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	GunModelName = "Gun",
	GunModelEffectsDelay = 0.05,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}