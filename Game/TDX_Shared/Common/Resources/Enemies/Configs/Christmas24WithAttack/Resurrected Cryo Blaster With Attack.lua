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
	Damage = 12,
	DamageDelay = 0.25,
	ReloadTime = 0.5,
	Range = 1,
	MinimumRange = 0.7,
	IsBurst = false,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = {
			Damage = 30,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
return {
	OverrideDisplayName = "Resurrected Cryo Blaster",
	Health = 250,
	Speed = 2.7,
	AnimationCalibratedSpeed = 2,
	BodyHeat = 200,
	BodyHeatRegenerationRate = 30,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.ResurrectedCryoBlasterSnow },
	AttackData = { v },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	MovementStartDelayLowerBound = 0.1,
	MovementStartDelayUpperBound = 0.15,
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas24Part2Nightmare] = { Health = nil, Shield = nil }
	}
}