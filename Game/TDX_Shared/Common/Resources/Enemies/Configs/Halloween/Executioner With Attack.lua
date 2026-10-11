local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 4,
	AimTime = 0.1,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 80,
	DamageDelay = 0.933,
	ReloadTime = 3.2,
	Range = 3,
	MinimumRange = 2.7,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			Damage = 200,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	OverrideDisplayName = "Executioner",
	OverrideCharacterModelName = "Executioner",
	Health = 1750,
	Speed = 1.9,
	SuperStunResistance = true,
	AnimationCalibratedSpeed = 1.4,
	BodyHeat = 800,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	HoverHeight = 2.142,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.3,
	AnimationDefaultStopFadeTime = 0.2,
	GunModelName = "Weapon",
	GunModelEffectsDelay = 0.933,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = nil, Shield = nil }
	}
}