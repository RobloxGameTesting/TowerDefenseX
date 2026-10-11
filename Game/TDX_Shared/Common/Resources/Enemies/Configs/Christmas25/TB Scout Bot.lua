local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.12217304763960307, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 175,
	Shield = 175,
	Speed = 6,
	BodyHeat = 80,
	BodyHeatRegenerationRate = 12,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
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
			Damage = 10,
			ReloadTime = 2,
			Range = 15,
			IsBurst = true,
			BurstSize = 11,
			BurstInterval = 0.3,
			AlwaysMaintainBurst = true
		}
	},
	TurretConfigs = { v },
	AbilityNames = { Enums.EnemyAbilities.OldTimeyScoutBotBuffAbility },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.15 },
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