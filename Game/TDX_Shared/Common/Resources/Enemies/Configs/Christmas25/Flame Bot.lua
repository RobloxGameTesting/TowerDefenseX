local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	CanTargetAir = false,
	IgnoreGround = false,
	TowerBuffArray = {
		{ TowerBuffName = Enums.TowerBuffs.FlameBotBurn },
		{ TowerBuffName = Enums.TowerBuffs.FlameBotFirerateDebuff }
	},
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsPiercing = true,
	PierceCount = 5,
	PierceRange = 11,
	Damage = 10,
	ReloadTime = 0.2,
	Range = 9,
	IsBurst = false,
	DifficultyToStatOverrideMap = {}
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.12217304763960307, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Flamethrower", NoRotate = true }
	}
}
return {
	Health = 700,
	Shield = 250,
	Speed = 2.5,
	AnimationCalibratedSpeed = 2,
	AccelerationTime = 0.6,
	DecelerationTime = 1.2,
	BodyHeat = 150,
	BodyHeatRegenerationRate = 50,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath3,
	IsGiantRobot = true,
	AbilityNames = {},
	TurretConfigs = { v2 },
	AttackData = { v },
	HasAttack = true,
	StopToAttack = false,
	RangeVariance = false,
	GunModelName = "Turret>Flamethrower",
	ClientsideAttackTargetTorsoPosition = true,
	NoRestartAttackAnimationIfPlaying = true,
	FakeEnemy = false,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.1 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.9 }
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