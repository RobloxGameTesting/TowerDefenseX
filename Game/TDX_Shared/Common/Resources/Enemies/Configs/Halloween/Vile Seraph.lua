local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AirUnit = true,
	Health = 3500,
	Shield = 2500,
	Speed = 4.2,
	AnimationCalibratedSpeed = 3.5,
	BodyHeat = 600,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	HoverHeight = 9.25,
	HoverHeightVariance = 0.5,
	AnimationTimeScale = 1,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = false,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			CanTargetAir = true,
			IsProjectile = true,
			ProjectileName = Enums.Projectiles.VileSeraphFireball,
			IsSplash = false,
			AimTime = 0.5,
			AimResetTime = 10000,
			ResetAimAfterEachShot = false,
			Damage = 500,
			ReloadTime = 2.7,
			Range = 10,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.HalloweenNightmarePart3] = {
					Damage = 1000,
					ReloadTime = nil,
					Range = nil,
					MinimumRange = nil,
					IsSplash = nil,
					SplashRadius = nil
				}
			}
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = nil, Shield = nil }
	}
}