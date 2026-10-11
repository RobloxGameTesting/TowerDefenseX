local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.13962634015954636, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			HasContinuousEffects = true,
			ContinuousEffectStopDelay = 0.5,
			NoRotate = true,
			RotatingBarrelData = {
				{
					PathToBarrelWeld = "Body>Barrel",
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
	Health = 2200,
	Shield = 1200,
	Speed = 1.8,
	AnimationCalibratedSpeed = 1.8,
	BodyHeat = 800,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath2,
	FakeEnemy = false,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 1,
			IsProjectile = false,
			IsSplash = false,
			Damage = 9,
			ReloadTime = 4,
			Range = 24,
			IsBurst = true,
			BurstSize = 60,
			BurstInterval = 0.1,
			DifficultyToStatOverrideMap = {}
		}
	},
	TurretConfigs = { v },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.3 }
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