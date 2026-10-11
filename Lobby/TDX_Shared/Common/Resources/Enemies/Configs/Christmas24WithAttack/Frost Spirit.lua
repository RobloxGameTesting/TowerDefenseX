local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	CanTargetBase = true,
	CanTargetBaseUsingEndNodes = false,
	PrioritizeBase = false,
	OnlyAttackBase = false,
	TriggerDefaultBeamEffect = true,
	CanTargetAir = true,
	IsSplash = false,
	AimTime = 0.05,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 100,
	ReloadTime = 1.2,
	Range = 11,
	MinimumRange = 1,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 250,
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
	Health = 750,
	Shield = 150,
	Speed = 3.3,
	BodyHeat = 500,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	HoverHeight = 6.5,
	HoverHeightVariance = 0.5,
	NoAnimations = true,
	NoHead = true,
	NoTorso = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AttackData = { v },
	DefaultBeamEffectHandlingData = {
		{
			BeamParentInstanceName = "Beam>LightningBeam",
			BeamDuration = 0.35,
			OscillationXZ = 0.3,
			OscillationXZPeriod = 0.7,
			OscillationY = 0.16,
			OscillationYPeriod = 0.5
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}