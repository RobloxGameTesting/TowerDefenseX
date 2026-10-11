local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = {
		CanRotateY = true,
		CanRotateZ = true,
		MaxRotationZ = 45,
		MinRotationZ = -15
	},
	TurretGunConfigs = {
		{ ModelName = "Barrel", NoRotate = true }
	}
}
local v2 = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Barrel1", NoRotate = true },
		{ ModelName = "Barrel2", NoRotate = true }
	}
}
local v3 = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Barrel",
			NoRotate = true,
			HasContinuousEffects = true,
			ContinuousEffectStopDelay = 0.3
		}
	}
}
local clientHitEffectData = {
	EffectName = Enums.VisualEffects.SmallBlast,
	TargetTorsoInsteadOfGround = true,
	VarianceXZ = 0.35,
	VarianceY = 0.25
}
return {
	LimitMap = { 10, 6, 5, 4 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 775,
			Health = 1500,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 3,
			ReloadTime = 0.35,
			Range = 25,
			StealthDetection = false,
			TurretConfigs = { v },
			Description = "BASE",
			Icon = "rbxassetid://15266677304"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 450,
				HealthIncrease = 50,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Heavy Ammo",
				TurretConfigs = { v },
				Icon = "rbxassetid://15266677019",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 600,
				HealthIncrease = 200,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 10,
				TurretConfigs = { v },
				Description = "RHIB+",
				Icon = "rbxassetid://15266676686",
				UpgradeIcon = "rbxassetid://15266660144"
			},
			{
				Cost = 2150,
				HealthIncrease = 500,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0,
				RangeIncrease = 45,
				SplashRadiusIncrease = 1.5,
				DamageType = Enums.DamageTypes.Explosive,
				GainCanTargetAir = true,
				TurretConfigs = { v },
				ClientHitEffectData = clientHitEffectData,
				Description = "Attack Boat",
				Icon = "rbxassetid://15266676296",
				UpgradeIcon = "rbxassetid://15266661680"
			},
			{
				Cost = 6000,
				HealthIncrease = 400,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				SplashRadiusIncrease = 0,
				TurretConfigs = { v2 },
				ClientHitEffectData = clientHitEffectData,
				Description = "Dual Guns",
				Icon = "rbxassetid://15266675725",
				UpgradeIcon = "rbxassetid://15266661334"
			},
			{
				Cost = 32000,
				HealthIncrease = 1500,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0,
				RangeIncrease = 110,
				GainIgnoreResistance = true,
				TurretConfigs = { v2 },
				ClientHitEffectData = clientHitEffectData,
				AbilityNames = { Enums.TowerAbilities.PatrolBoatHellfireMissiles },
				Description = "Hellfire Missiles",
				Icon = "rbxassetid://15266675147",
				UpgradeIcon = "rbxassetid://15266660565"
			}
		},
		Path2Data = {
			{
				Cost = 600,
				HealthIncrease = 70,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 7,
				TurretConfigs = { v },
				Description = "Smart Gun",
				Icon = "rbxassetid://15266677019",
				UpgradeIcon = "rbxassetid://15266659960"
			},
			{
				Cost = 700,
				HealthIncrease = 100,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 0,
				TurretConfigs = { v },
				Description = "Cooling Barrels",
				Icon = "rbxassetid://15266676686",
				UpgradeIcon = "rbxassetid://15266661533"
			},
			{
				Cost = 2500,
				HealthIncrease = 2000,
				ProjectileName = Enums.Projectiles.PatrolBoatFlamethrowerProjectile,
				DamageIncrease = -3,
				PierceCountIncrease = 20,
				NoDisplayPierceCount = true,
				ReloadTimeDecrease = 0,
				OverrideReloadTime = 0.2,
				RangeIncrease = -15,
				DamageType = Enums.DamageTypes.Fire,
				TurretConfigs = { v3 },
				Description = "Flamethrower",
				Icon = "rbxassetid://15266676518",
				UpgradeIcon = "rbxassetid://15266660875",
				ApplyBurnStats = { DamagePerSecond = 3, StickDuration = 5 }
			},
			{
				Cost = 4900,
				HealthIncrease = 2200,
				ProjectileName = Enums.Projectiles.PatrolBoatFlamethrowerProjectile,
				DamageIncrease = 10,
				ReloadTimeDecrease = 0,
				GainStunImmunity = true,
				RangeIncrease = 0,
				OverrideReloadTime = 0.2,
				TurretConfigs = { v3 },
				Description = "Monitor",
				Icon = "rbxassetid://15266675992",
				UpgradeIcon = "rbxassetid://15266660410",
				ApplyBurnStats = { DamagePerSecond = 12, StickDuration = 12 }
			},
			{
				Cost = 40000,
				HealthIncrease = 5000,
				ProjectileName = Enums.Projectiles.PatrolBoatFlamethrowerProjectile,
				DamageIncrease = 28,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				OverrideReloadTime = 0.1,
				GainIgnoreResistance = true,
				ExtraDamageDurationIncrease = 18,
				ExtraDamageMultiplierIncrease = 0.05,
				TurretConfigs = { v3 },
				Description = "Flame Tanks",
				Icon = "rbxassetid://15266675462",
				UpgradeIcon = "rbxassetid://15266661075",
				ApplyBurnStats = { DamagePerSecond = 35, StickDuration = 18 }
			}
		}
	},
	IsMechanical = true,
	DeathEffect = Enums.DeathEffects.GenericExplosionDeath,
	PlacementType = Enums.PlacementTypes.Water,
	AnimationTimeScale = 1,
	NoAnimations = true,
	MaxObstacleHeight = 4,
	Radius = 5.5,
	HoverHeight = -0.5,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	BuffEffectScale = 2,
	IsSmallShip = true,
	NoHeal = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.05
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Pierce,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 1,
			OverrideMaxLevel = 3
		}
	}
}