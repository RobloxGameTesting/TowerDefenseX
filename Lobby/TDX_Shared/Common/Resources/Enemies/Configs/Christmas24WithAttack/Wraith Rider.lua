local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 1,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	TriggerDefaultBeamEffect = true,
	CanTargetAir = true,
	AirUnitDamageMultiplier = 5,
	IsSplash = false,
	AimTime = 0.05,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 350,
	DamageDelay = 0.2,
	ReloadTime = 2,
	Range = 13,
	MinimumRange = 1,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 1200,
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
	Health = 16000,
	Speed = 9,
	BodyHeat = 1800,
	BodyHeatRegenerationRate = 500,
	Radius = 1,
	HoverHeight = 8,
	HoverHeightVariance = 1,
	AnimationDefaultPlayFadeTime = 0.2,
	AnimationDefaultStopFadeTime = 0.2,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AttackData = { v },
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstanceName = "Beam>LightningBeam",
			BeamDuration = 0.75,
			OscillationXZ = 0.3,
			OscillationXZPeriod = 0.8,
			OscillationY = 0.16,
			OscillationYPeriod = 0.6
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}