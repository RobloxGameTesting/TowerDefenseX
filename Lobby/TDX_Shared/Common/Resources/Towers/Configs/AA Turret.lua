local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 45, MinRotationZ = -45 }
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v }
}
local v3 = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedX = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true },
	SoundGroupName = "Minigun",
	SoundGroupStopDelay = 0.3
}
local v4 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v3 }
}
local v5 = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeldLeft",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedX = 30
		},
		{
			WeldPointerName = "RotatingBarrelWeldRight",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedX = -30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true },
	SoundGroupName = "Minigun",
	SoundGroupStopDelay = 0.3
}
local v6 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v5 }
}
local v7 = {
	ModelName = "Gun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeldTop",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedX = 30
		},
		{
			WeldPointerName = "RotatingBarrelWeldBottom",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedX = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true },
	SoundGroupName = "Minigun",
	SoundGroupStopDelay = 0.3
}
local v8 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v7 }
}
return {
	UpgradePathData = {
		BaseLevelData = {
			Description = "<PLACEHOLDER>",
			Icon = "rbxassetid://132741921281630",
			Cost = 450,
			Health = 85,
			CanTargetAir = true,
			IgnoreGround = true,
			CanRebuild = true,
			RebuildTime = 4,
			RebuildTimeIncreaseEachDeath = 5,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.AATurretMissileSmall,
			BurstSize = 1,
			BurstInterval = 0.25,
			ReloadTime = 6,
			Damage = 80,
			IsSplash = true,
			SplashRadius = 1,
			Range = 25,
			StealthDetection = false,
			TurretConfigs = { v2 }
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 300,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				BurstSizeIncrease = 1,
				TurretConfigs = { v2 },
				Description = "Double Shot",
				Icon = "rbxassetid://107567714867881",
				UpgradeIcon = "rbxassetid://107567714867881"
			},
			{
				Cost = 400,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 6,
				BurstSizeIncrease = 1,
				TurretConfigs = { v2 },
				Description = "Tri Shot",
				Icon = "rbxassetid://97172985409385",
				UpgradeIcon = "rbxassetid://97172985409385"
			},
			{
				Cost = 2400,
				HealthIncrease = 250,
				DamageIncrease = 25,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				MinRangeOverride = 7,
				ProjectileName = Enums.Projectiles.AATurretMissileMedium,
				BurstSizeIncrease = 1,
				BurstIntervalOverride = 0.35,
				TurretConfigs = { v2 },
				Description = "Quad Barrels",
				Icon = "rbxassetid://96168401823275",
				UpgradeIcon = "rbxassetid://96168401823275"
			},
			{
				Cost = 7500,
				HealthIncrease = 250,
				DamageIncrease = 100,
				SplashRadiusIncrease = 1,
				ReloadTimeDecrease = 0,
				RangeIncrease = 30,
				MinRangeOverride = 10,
				ProjectileName = Enums.Projectiles.AATurretMissileMedium,
				BurstSizeIncrease = 2,
				BurstIntervalOverride = 0.35,
				TurretConfigs = { v2 },
				Description = "AA-X Turret",
				Icon = "rbxassetid://136579038038016",
				UpgradeIcon = "rbxassetid://136579038038016"
			},
			{
				Cost = 145000,
				HealthIncrease = 850,
				DamageIncrease = 750,
				SplashRadiusIncrease = 2,
				ReloadTimeDecrease = 2,
				RangeIncrease = 91,
				MinRangeOverride = 40,
				ProjectileName = Enums.Projectiles.AATurretMissileLarge,
				BurstSizeIncrease = 2,
				BurstIntervalOverride = 0.35,
				TurretConfigs = { v2 },
				Description = "Patriot Turret",
				Icon = "rbxassetid://94143503583232",
				UpgradeIcon = "rbxassetid://94143503583232"
			}
		},
		Path2Data = {
			{
				Cost = 400,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 12,
				TurretConfigs = { v2 },
				Description = "Extended Range",
				Icon = "rbxassetid://107567714867881",
				UpgradeIcon = "rbxassetid://107567714867881"
			},
			{
				Cost = 1000,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				GainStealthDetection = true,
				RangeIncrease = 10,
				TurretConfigs = { v2 },
				Description = "Upgraded Radar",
				Icon = "rbxassetid://97172985409385",
				UpgradeIcon = "rbxassetid://97172985409385"
			},
			{
				Cost = 15000,
				HealthIncrease = 800,
				SplashRadiusIncrease = -1,
				DamageIncrease = -60,
				RangeIncrease = -14,
				RemoveProjectile = true,
				RemoveBurst = true,
				DamageType = Enums.DamageTypes.Bullet,
				OverrideReloadTime = 0.1,
				TurretConfigs = { v4 },
				Description = "C-RAM",
				Icon = "rbxassetid://98845978986529",
				UpgradeIcon = "rbxassetid://98845978986529"
			},
			{
				Cost = 28000,
				HealthIncrease = 1000,
				DamageIncrease = 50,
				RangeIncrease = 3,
				RemoveProjectile = true,
				RemoveBurst = true,
				OverrideReloadTime = 0.1,
				TurretConfigs = { v6 },
				Description = "Dual Barrels",
				Icon = "rbxassetid://97356005827251",
				UpgradeIcon = "rbxassetid://97356005827251"
			},
			{
				Cost = 125000,
				HealthIncrease = 3000,
				DamageIncrease = 88,
				RangeIncrease = 8,
				RemoveProjectile = true,
				RemoveBurst = true,
				OverrideReloadTime = 0.08,
				TurretConfigs = { v8 },
				Description = "CX-RAM",
				Icon = "rbxassetid://94930276158756",
				UpgradeIcon = "rbxassetid://94930276158756"
			}
		}
	},
	IsMechanical = true,
	MaximumRebuilds = 3,
	RebuildVFX = Enums.VisualEffects.XWMTurretRebuilding,
	RebuildVFXOffset = vector.create(0, 0.3, 0),
	DeathEffect = Enums.DeathEffects.XWMTurretDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	MaxObstacleHeight = 10,
	ValidArcsCustomDivisionCount = 80,
	Radius = 2.7,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoBuffs = true,
	NoHeal = true,
	ClientsideAttackTargetTorsoPosition = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 1.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 325,
			CostIncreasePerLevel = 150,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 225,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 225,
			CostIncreasePerLevel = 125,
			Amount = 0.15
		}
	}
}