local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 3000,
	Shield = 2500,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 150,
	Radius = 1,
	AnimationTimeScale = 1,
	HasCustomCode = true,
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
			ProjectileName = Enums.Projectiles.GrenadierGrenadeStickLarge,
			TowerBuffName = Enums.TowerBuffs.SGrenadierGrenadeFirerateDebuff,
			IsSplash = true,
			SplashRadius = 0.5,
			AimTime = 97 / 60,
			AimResetTime = 97 / 60,
			ResetAimAfterEachShot = true,
			Damage = 100,
			ReloadTime = 1.2,
			Range = 18,
			IsBurst = false,
			DifficultyToStatOverrideMap = {}
		}
	},
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath1,
	AbilityNames = {},
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.35 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.25 }
	},
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Health = nil,
			Shield = nil,
			StealthDetection = nil
		}
	}
}