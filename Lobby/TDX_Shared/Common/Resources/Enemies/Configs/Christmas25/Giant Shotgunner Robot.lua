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
	IsSplash = false,
	Damage = 300,
	ReloadTime = 1,
	Range = 17,
	IsBurst = true,
	BurstSize = 10,
	BurstInterval = 0.2,
	DifficultyToStatOverrideMap = {
		[Enums.Difficulties.Christmas25Part1Nightmare] = {
			Damage = nil,
			ReloadTime = nil,
			Range = nil,
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
	RotationOffset = CFrame.Angles(0, 0.10471975511965978, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Auto Shotgun", NoRotate = true }
	}
}
return {
	OverrideDisplayName = "Giant Shotgunner Bot",
	Health = 20000,
	Shield = 15000,
	Speed = 2.7,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 2500,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
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
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 }
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