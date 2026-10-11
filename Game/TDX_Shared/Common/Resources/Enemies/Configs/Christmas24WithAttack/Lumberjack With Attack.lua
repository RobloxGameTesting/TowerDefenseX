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
	ConsiderTargetsWithNoAttack = true,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0.1,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 150,
	DamageDelay = 0.7,
	ReloadTime = 2,
	Range = 1,
	MinimumRange = 0.6,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
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
	OverrideDisplayName = "Lumberjack",
	Health = 1400,
	Speed = 2.2,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
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
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}