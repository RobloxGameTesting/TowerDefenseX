local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	TargetMostExpensiveTower = true,
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 1,
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.GiantMRLBotMissile,
	IsSplash = false,
	MinimumRange = 8,
	CanTargetAir = true,
	IsBurst = true,
	BurstInterval = 0.1,
	BurstSize = 9,
	Damage = 3500,
	ReloadTime = 7,
	Range = 35,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Damage = 8000,
			ReloadTime = 4,
			Range = 37,
			MinimumRange = 8,
			IsSplash = true,
			SplashRadius = 3
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Damage = 10000,
			ReloadTime = 4,
			Range = 40,
			MinimumRange = 8,
			IsSplash = true,
			SplashRadius = 3
		}
	}
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0.08726646259971647, -0.05235987755982989, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = {
		CanRotateX = true,
		MaxRotationX = 25,
		MinRotationX = -25,
		CanRotateY = true
	},
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 145000,
	Shield = 75000,
	Speed = 1.8,
	BodyHeat = 25000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantMRLBotDeath,
	FakeEnemy = false,
	AttackData = { v },
	TurretConfigs = { v2 },
	HasAttack = true,
	StopToAttack = false,
	ClientsideAttackTargetTorsoPosition = true,
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.7 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 }
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