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
	AimTime = 0.05,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 25,
	DamageDelay = 0.3,
	ReloadTime = 2,
	Range = 0.5,
	MinimumRange = 0.3,
	IsBurst = true,
	BurstSize = 2,
	BurstInterval = 0.6,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 50,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	OverrideDisplayName = "Frostbite",
	Health = 100,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 4,
	Radius = 1,
	HoverHeight = 1.377,
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
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}