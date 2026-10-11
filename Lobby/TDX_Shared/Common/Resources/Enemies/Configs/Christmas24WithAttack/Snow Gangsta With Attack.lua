local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 0.2,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = true,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	IsProjectile = false,
	IsSplash = true,
	SplashRadius = 5,
	AimTime = 1.25,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 200,
	DamageDelay = 0.75,
	ReloadTime = 2.6,
	Range = 2.5,
	MinimumRange = 0.9,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 400,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	OverrideDisplayName = "Snow Gangsta",
	Health = 6000,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.2,
	BodyHeat = 7000,
	BodyHeatRegenerationRate = 1000,
	Radius = 1,
	HoverHeight = 2.46,
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
	GunModelName = "Weapon",
	GunModelEffectsDelay = 0.75,
	ClientsideAttackTargetTorsoPosition = true,
	SetUpKeyframeReachedForAnimationTriggeredEffects = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}