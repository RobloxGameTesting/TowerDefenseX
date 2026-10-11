local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ConsiderTargetsWithNoAttack = true,
	TargetPathEntitiesIfNoTowers = true,
	PathEntityInitialQueryReduceRange = 1,
	IsProjectile = false,
	CanTargetAir = true,
	IsSplash = false,
	Damage = 225,
	ReloadTime = 2.4,
	Range = 24,
	IsBurst = true,
	BurstSize = 10,
	BurstInterval = 0.2,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Damage = 265,
			ReloadTime = 2.4,
			Range = 26,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		},
		[Enums.Difficulties.Christmas25Part2Nightmare] = {
			Damage = nil,
			ReloadTime = nil,
			Range = nil,
			MinimumRange = nil,
			IsSplash = nil,
			SplashRadius = nil
		}
	}
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0.17453292519943295, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	OverrideDisplayName = "Giant Ranger Bot",
	Health = 25000,
	Shield = 12000,
	Speed = 2.4,
	AnimationCalibratedSpeed = 2.4,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 2500,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	FakeEnemy = false,
	AttackData = { v },
	TurretConfigs = { v2 },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.2 }
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