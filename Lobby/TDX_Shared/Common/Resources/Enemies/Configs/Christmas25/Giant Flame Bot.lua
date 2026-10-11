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
		{ TowerBuffName = Enums.TowerBuffs.GiantFlameBotBurn },
		{ TowerBuffName = Enums.TowerBuffs.GiantFlameBotFirerateDebuff }
	},
	TargetMinimumValue = 0,
	ConsiderTargetsWithNoAttack = true,
	IsProjectile = false,
	IsPiercing = true,
	PierceCount = 10,
	PierceRange = 15,
	AimTime = 17 / 30,
	AimResetTime = 1,
	ResetAimAfterEachShot = false,
	Damage = 1000,
	ReloadTime = 0.2,
	Range = 10,
	IsBurst = false,
	DifficultyToStatOverrideMap = {}
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Flamethrower", NoRotate = true }
	}
}
return {
	Health = 80000,
	Shield = 50000,
	Speed = 2,
	AnimationCalibratedSpeed = 2,
	AccelerationTime = 0.6,
	DecelerationTime = 1.2,
	BodyHeat = 25000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantFlameBotDeath,
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
	FootstepEffectInstanceNames = "HumanoidRootPart>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 1 }
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