local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	Description = "Primary",
	ClientHitEffectData = {
		EffectName = Enums.VisualEffects.ExtraSmallBlast,
		TargetTorsoInsteadOfGround = true,
		VarianceXZ = 0.05,
		VarianceY = 0.05
	},
	ConsiderTargetsWithNoAttack = true,
	AlwaysTargetPathEntities = true,
	TargetPriorityArray = { Enums.EntityClass.PathEntity, Enums.EntityClass.Tower, Enums.EntityClass.MapEntity },
	DisabledUntilAbilityWithNameUsed = Enums.EnemyAbilities.GiantMGBotDeployAbility,
	IsProjectile = false,
	IsSplash = false,
	AimTime = 0,
	AimResetTime = 10000,
	ResetAimAfterEachShot = false,
	Damage = 1250,
	ReloadTime = 2,
	Range = 50,
	IsBurst = true,
	BurstSize = 300,
	BurstInterval = 0.1,
	DifficultyToStatOverrideMap = {}
}
return {
	Health = 45000,
	Shield = 82000,
	Speed = 3,
	AnimationCalibratedSpeed = 3,
	BodyHeat = 10000,
	BodyHeatRegenerationRate = 2000,
	Radius = 1,
	AnimationTimeScale = 1,
	NoAdjustMovementAnimationSpeed = true,
	IsGiantRobot = true,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.GiantRobotDeath1,
	FakeEnemy = false,
	AttackData = { v },
	AbilityNames = { Enums.EnemyAbilities.GiantMGBotDeployAbility },
	HasAttack = true,
	StopToAttack = true,
	StealthDetection = true,
	RangeVariance = false,
	GunModelName = "Machine Gun",
	ClientsideAttackTargetTorsoPosition = true,
	FootstepEffectInstanceNames = "Root>FootstepSFX",
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.5 },
		{ DamageType = Enums.DamageTypes.Laser, DamageReduction = 0.4 },
		{ DamageType = Enums.DamageTypes.Fire, DamageReduction = 0.75 },
		{ DamageType = Enums.DamageTypes.Collision, DamageReduction = 1 }
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