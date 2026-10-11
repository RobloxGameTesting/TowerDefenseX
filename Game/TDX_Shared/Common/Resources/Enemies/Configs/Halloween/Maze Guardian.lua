local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.BigClawHit,
		TargetTorsoInsteadOfGround = true
	},
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.2,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 2000,
	DamageDelay = 0.75,
	ReloadTime = 1.8,
	Range = 2.7,
	MinimumRange = 2.2,
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
return {
	Health = 150000,
	Speed = 6,
	AnimationCalibratedSpeed = 5,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	HoverHeight = 4.198,
	AnimationTimeScale = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = true,
	MovementStartDelayLowerBound = 0.01,
	MovementStartDelayUpperBound = 0.015,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.5 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = { Health = nil, Shield = nil }
	}
}