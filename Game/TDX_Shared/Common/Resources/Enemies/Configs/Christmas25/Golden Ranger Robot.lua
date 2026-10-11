local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.17453292519943295, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	OverrideDisplayName = "Golden Ranger Bot",
	Health = 5000,
	Shield = 5000,
	Speed = 5.9,
	BodyHeat = 600,
	BodyHeatRegenerationRate = 200,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath1,
	FakeEnemy = false,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 1,
			IsProjectile = false,
			IsSplash = false,
			Damage = 100,
			ReloadTime = 3,
			Range = 24,
			IsBurst = true,
			BurstSize = 10,
			BurstInterval = 0.2
		}
	},
	TurretConfigs = { v },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.8 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.5 }
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