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
	ProjectileName = Enums.Projectiles.M202Missile,
	IsSplash = true,
	SplashRadius = 3,
	Damage = 200,
	ReloadTime = 4.5,
	Range = 18,
	IsBurst = true,
	BurstSize = 4,
	BurstInterval = 0.3,
	AlwaysMaintainBurst = true
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -0.03490658503988659, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
return {
	Health = 3000,
	Shield = 3000,
	Speed = 2.4,
	BodyHeat = 1250,
	BodyHeatRegenerationRate = 400,
	Radius = 1,
	AnimationTimeScale = 1,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.RobotDeath2,
	FakeEnemy = false,
	AttackData = { v },
	TurretConfigs = { v2 },
	HasAttack = true,
	StopToAttack = false,
	StealthDetection = false,
	RangeVariance = true,
	ClientsideAttackTargetTorsoPosition = true,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.9 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.2 }
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