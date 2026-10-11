local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Corrupted Golden Juggernaut",
	Health = 69000,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2.5,
	BodyHeat = 6000,
	BodyHeatRegenerationRate = 405,
	Radius = 1,
	HoverHeight = 1.55,
	AnimationTimeScale = 1,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			CanTargetAir = false,
			IgnoreGround = false,
			CanTargetBase = true,
			CanTargetBaseUsingEndNodes = true,
			PrioritizeBase = false,
			OnlyAttackBase = false,
			IsProjectile = false,
			IsSplash = false,
			AimTime = 1,
			AimResetTime = 10000,
			ResetAimAfterEachShot = false,
			Damage = 450,
			ReloadTime = 0.09,
			Range = 9,
			IsBurst = false,
			DifficultyToStatOverrideMap = {
				[Enums.Difficulties.HalloweenNightmarePart4] = {
					Damage = 700,
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
	GunModelName = "Minigun",
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 1 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 1 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.HalloweenNightmarePart4] = { Health = nil, Shield = nil }
	},
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld1",
			TimeToMaxRotationSpeed = 0.7,
			TimeToSpinAfterShot = 1.7,
			TimeToStopRotation = 1.3,
			MaxRotationSpeedX = 25
		},
		{
			WeldPointerName = "RotatingBarrelWeld2",
			TimeToMaxRotationSpeed = 0.3,
			TimeToSpinAfterShot = 0.6,
			TimeToStopRotation = 0.3,
			MaxRotationSpeedX = 10
		},
		{
			WeldPointerName = "RotatingBarrelWeld3",
			TimeToMaxRotationSpeed = 0.3,
			TimeToSpinAfterShot = 1.5,
			TimeToStopRotation = 0.4,
			MaxRotationSpeedX = 20
		},
		{
			WeldPointerName = "RotatingBarrelWeld4",
			TimeToMaxRotationSpeed = 0.5,
			TimeToSpinAfterShot = 1.3,
			TimeToStopRotation = 0.8,
			MaxRotationSpeedX = 25
		},
		{
			WeldPointerName = "RotatingBarrelWeld5",
			TimeToMaxRotationSpeed = 0.3,
			TimeToSpinAfterShot = 1.9,
			TimeToStopRotation = 0.4,
			MaxRotationSpeedX = 20
		}
	}
}