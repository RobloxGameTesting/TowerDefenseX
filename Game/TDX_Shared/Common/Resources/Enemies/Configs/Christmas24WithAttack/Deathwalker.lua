local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	PathEntityInitialQueryReduceRange = 1,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	CanTargetAir = true,
	AirUnitDamageMultiplier = 5,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.DeathwalkerProjectile,
	IsSplash = false,
	AimTime = 0.05,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 200,
	ReloadTime = 2.6,
	Range = 10,
	MinimumRange = 1,
	IsBurst = true,
	BurstSize = 2,
	BurstInterval = 0.8,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 650,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	AirUnit = true,
	Health = 2000,
	Shield = 500,
	Speed = 3.2,
	BodyHeat = 600,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	HoverHeight = 9,
	HoverHeightVariance = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}