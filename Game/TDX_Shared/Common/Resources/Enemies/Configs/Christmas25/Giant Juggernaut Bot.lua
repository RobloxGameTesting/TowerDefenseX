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
	Damage = 600,
	ReloadTime = 2,
	Range = 26,
	IsBurst = true,
	BurstSize = 90,
	BurstInterval = 0.09,
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
	RotationOffset = CFrame.Angles(0, 0.05235987755982989, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Minigun",
			HasContinuousEffects = true,
			ContinuousEffectStopDelay = 0.5,
			NoRotate = true,
			RotatingBarrelData = {
				{
					PathToBarrelWeld = "Gun>Barrel1",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedZ = 20
				},
				{
					PathToBarrelWeld = "Gun>Barrel2",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedZ = 20
				},
				{
					PathToBarrelWeld = "Gun>Barrel3",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedZ = 20
				},
				{
					PathToBarrelWeld = "Gun>Barrel4",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedZ = 20
				}
			}
		}
	}
}
return {
	Health = 100000,
	Shield = 50000,
	Speed = 2,
	AnimationCalibratedSpeed = 2.1,
	SuperStunResistance = true,
	BodyHeat = 30000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath2,
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
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.85 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.95 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.5 }
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