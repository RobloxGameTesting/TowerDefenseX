local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 8250,
	Shield = 5000,
	Speed = 1.9,
	BodyHeat = 1200,
	BodyHeatRegenerationRate = 300,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath3,
	FakeEnemy = false,
	AttackData = {
		{
			Description = "Primary",
			ConsiderTargetsWithNoAttack = true,
			TargetPathEntitiesIfNoTowers = true,
			PathEntityInitialQueryReduceRange = 1,
			IsProjectile = false,
			IsSplash = false,
			Damage = 150,
			ReloadTime = 3,
			Range = 32,
			IsBurst = true,
			BurstSize = 3,
			BurstInterval = 0.7
		}
	},
	TurretConfigs = { v },
	AbilityNames = { Enums.EnemyAbilities.CommanderBotSummon, Enums.EnemyAbilities.CommanderBotDamageBuffAbility },
	AbilityBufferTime = 1.5,
	HasAttack = true,
	StopToAttack = false,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Ice, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Melee, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.25 },
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