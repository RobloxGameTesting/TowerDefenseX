local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.KnifeHit,
		TargetTorsoInsteadOfGround = true
	},
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.1,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 100,
	DamageDelay = 0.733,
	ReloadTime = 2.2,
	Range = 1.25,
	MinimumRange = 0.9,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = {
			Damage = 300,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	Health = 1850,
	Speed = 2.7,
	AnimationCalibratedSpeed = 2.7,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 40,
	Radius = 1,
	HoverHeight = 1.404,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = nil, Shield = nil }
	}
}