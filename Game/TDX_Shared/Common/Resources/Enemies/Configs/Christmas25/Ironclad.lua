local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "ChinGun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true, RotationConstraintConfig = {} }
	}
}
local v2 = {
	ModelName = "TopAATurret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	ForceMaintainC0Position = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			RotationConstraintConfig = { CanRotateX = true, MaxRotationX = 45, MinRotationX = -45 }
		}
	}
}
local v3 = {
	Description = "Chin Gun",
	ConsiderTargetsWithNoAttack = true,
	AlwaysTargetPathEntities = true,
	TargetPriorityArray = { Enums.EntityClass.PathEntity, Enums.EntityClass.Tower, Enums.EntityClass.MapEntity },
	CanTargetAir = false,
	IsProjectile = false,
	IsSplash = false,
	Damage = 250,
	DamagePercentage = 0.02,
	ReloadTime = 0.2,
	Range = 32
}
local v4 = {
	Description = "Missiles",
	IsProjectile = true,
	ProjectileName = Enums.Projectiles.IroncladMissile,
	AlwaysTargetPathEntities = true,
	TargetPriorityArray = { Enums.EntityClass.PathEntity, Enums.EntityClass.Tower, Enums.EntityClass.MapEntity },
	CanTargetAir = false,
	IsSplash = true,
	SplashRadius = 5.5,
	DamageType = Enums.DamageTypes.Explosive,
	IgnoreResistance = true,
	Damage = 800,
	ReloadTime = 7,
	Range = 100,
	MinimumRange = 15,
	IsBurst = true,
	BurstSize = 8,
	BurstInterval = 0.2,
	AlwaysMaintainBurst = false
}
return {
	Health = 3000000,
	SuperStunResistance = true,
	Shield = 500000,
	Speed = 0.75,
	AnimationCalibratedSpeed = 0.75,
	BodyHeat = 188840,
	BodyHeatRegenerationRate = 5200,
	Radius = 1,
	NoHead = true,
	NoTorso = true,
	IsBoss = true,
	BossMusicName = "IroncladBossMusic",
	OverrideDisplayName = "Ironclad MK II",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	FadeOutOnDeath = true,
	FadeOutDelay = 5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	DeathExplodePartsScale = 2,
	DeathExplodePartsDelay = 4 / 3,
	DeathEffectsData = {
		{ InstancePath = "DeathExplodePart" }
	},
	FootstepEffectInstanceNames = "RootPart>FootstepSFX",
	FakeEnemy = false,
	TurretConfigs = {
		v,
		v2,
		{
			ModelName = "MissileTurret",
			RotationConstraintConfig = {},
			TurretGunConfigs = {
				{ NoRotate = true, ModelName = "Gun" }
			}
		}
	},
	HasAttack = true,
	StopToAttack = false,
	ClientsideAttackTargetTorsoPosition = true,
	AttackData = {
		v3,
		{
			Description = "AA",
			CanTargetAir = true,
			IgnoreGround = true,
			IsProjectile = false,
			IsSplash = false,
			Damage = 200,
			ReloadTime = 0.25,
			Range = 25
		},
		v4
	},
	AbilityNames = { Enums.EnemyAbilities.IroncladRailgunBlast },
	DifficultyToAbilityStatOverridesMap = {
		[Enums.Difficulties.TBPart2Voidmare] = {
			[Enums.EnemyAbilities.IroncladRailgunBlast] = { DamageMultiplier = 0.45 }
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.25 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.2 }
	}
}