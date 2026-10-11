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
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.LaserBlueBot,
	TowerBuffName = Enums.TowerBuffs.GiantLaserBotDamageDebuff,
	IsSplash = false,
	IsBurst = true,
	BurstSize = 20,
	BurstInterval = 0.08,
	ReloadTime = 1,
	Damage = 50,
	Range = 25
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = {
		CanRotateX = true,
		MaxRotationX = 15,
		MinRotationX = -15,
		CanRotateY = true
	},
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 12000,
	Shield = 7500,
	Speed = 10,
	BodyHeat = 5000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantLaserBotDeath,
	FakeEnemy = false,
	AttackData = { v },
	TurretConfigs = { v2 },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = true,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.3 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Golden, DamageReduction = 0.75 }
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