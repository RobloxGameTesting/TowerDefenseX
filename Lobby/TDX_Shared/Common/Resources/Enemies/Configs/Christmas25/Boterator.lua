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
	OverrideDisplayName = "Operator Bot",
	Health = 800,
	Shield = 700,
	Speed = 4.5,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 30,
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
			IsBurst = true,
			BurstSize = 5,
			BurstInterval = 0.3,
			Damage = 15,
			ReloadTime = 1.8,
			Range = 35
		}
	},
	TurretConfigs = { v },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 }
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