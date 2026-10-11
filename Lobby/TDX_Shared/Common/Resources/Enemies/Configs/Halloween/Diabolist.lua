local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 1650,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 600,
	BodyHeatRegenerationRate = 45,
	Radius = 1,
	HoverHeight = 1.552,
	AnimationTimeScale = 1,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			CanTargetAir = true,
			IgnoreGround = false,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			IsProjectile = true,
			ProjectileName = Enums.Projectiles.DiabolistFireball,
			IsSplash = false,
			AimTime = 0.1,
			AimResetTime = 10000,
			ResetAimAfterEachShot = false,
			Damage = 55,
			ReloadTime = 2.6,
			Range = 15,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.HalloweenNightmarePart3] = {
					Damage = 150,
					ReloadTime = nil,
					Range = nil,
					MinimumRange = nil,
					IsSplash = nil,
					SplashRadius = nil
				},
				[Enums.Difficulties.Easter26Part2] = {
					Damage = 50,
					ReloadTime = nil,
					Range = nil,
					MinimumRange = nil,
					IsSplash = nil,
					SplashRadius = nil
				},
				[Enums.Difficulties.Easter26Part2Easy] = {
					Damage = 25,
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
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.6 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.6 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart3] = { Health = nil, Shield = nil }
	}
}