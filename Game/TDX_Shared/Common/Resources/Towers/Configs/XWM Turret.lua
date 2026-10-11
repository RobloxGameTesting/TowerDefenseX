local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("FirstPersonTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "LeftGun",
	Animated = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 15, MinRotationZ = -45 }
}
local v2 = {
	ModelName = "RightGun",
	Animated = true,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 10, MinRotationZ = -45 }
}
local v3 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v, v2 }
}
local v4 = {
	ModelName = "LeftGun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 15, MinRotationZ = -45 }
}
local v5 = {
	ModelName = "RightGun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 10, MinRotationZ = -45 }
}
local v6 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v4, v5 }
}
local v7 = {
	ModelName = "LeftGun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	HasContinuousEffects = true,
	ContinuousEffectStopDelay = 1.1,
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		},
		{
			WeldPointerName = "RotatingBarrelWeld2",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 15, MinRotationZ = -45 }
}
local v8 = {
	ModelName = "RightGun",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotatingBarrelData = {
		{
			WeldPointerName = "RotatingBarrelWeld",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		},
		{
			WeldPointerName = "RotatingBarrelWeld2",
			TimeToMaxRotationSpeed = 0.25,
			TimeToSpinAfterShot = 1,
			TimeToStopRotation = 2,
			MaxRotationSpeedZ = 30
		}
	},
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 10, MinRotationZ = -45 }
}
local v9 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v7, v8 }
}
local v10 = {
	ModelName = "Main",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 10, MinRotationZ = -45 }
}
local v11 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v10 }
}
local v12 = {
	ModelName = "Main",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, -1718.8733853924696),
	RotationConstraintConfig = { CanRotateZ = false }
}
local v13 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, 0, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = { v12 }
}
local firstPersonConfig = {
	AttackConfigs = {
		{
			HeadshotMultiplier = 1.5,
			HeadshotIgnoreResistance = true,
			MagSize = 60,
			ReloadTime = 2,
			HitEffectName = Enums.VisualEffects.MinigunHit,
			DefaultSpreadDegrees = 1,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.9, -0.4, -0.2),
				CamKickMax = createVector(1.2, -0.1, 0.2),
				CamKickSpeed = 17
			},
			HeadHeight = 2.5
		}
	}
}
local firstPersonConfig2 = {
	AttackConfigs = {
		{
			DefaultSpreadDegrees = 1,
			CrosshairConfig = { Expansion = 15, Speed = 20, Damper = 1 },
			RecoilConfig = {
				CamKickMin = createVector(0.9, -0.4, -0.2),
				CamKickMax = createVector(1.2, -0.1, 0.2),
				CamKickSpeed = 17
			},
			HeadHeight = 2.5
		}
	}
}
local XWMTurret = {
	LimitMap = { 40, 20, 15, 10 },
	UpgradePathData = {
		BaseLevelData = {
			Cost = 4850,
			Health = 650,
			CanTargetAir = true,
			CanRebuild = true,
			RebuildTime = 9,
			RebuildTimeIncreaseEachDeath = 5,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 16,
			ReloadTime = 0.3,
			Range = 25,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.3,
			ClientsideBurstSize = 2,
			ClientsideBurstInterval = 0.25,
			TurretConfigs = { v3 },
			FirstPersonConfig = firstPersonConfig,
			Description = "BASE",
			Icon = "rbxassetid://17155093209"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1850,
				HealthIncrease = 250,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				TurretConfigs = { v3 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Bigger Caliber",
				Icon = "rbxassetid://17155092227",
				UpgradeIcon = "rbxassetid://17230666117",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 2750,
				HealthIncrease = 325,
				DamageIncrease = 6,
				GainIgnoreResistance = true,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				TurretConfigs = { v3 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Longer Barrels",
				Icon = "rbxassetid://17155092098",
				UpgradeIcon = "rbxassetid://17230665497",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 33000,
				HealthIncrease = 475,
				RemoveIgnoreResistance = true,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 4,
				GainStealthDetection = true,
				ClientsideRemoveBurst = true,
				TurretConfigs = { v6 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Dual Miniguns",
				Icon = "rbxassetid://17155094820",
				UpgradeIcon = "rbxassetid://17230664705",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 62000,
				HealthIncrease = 700,
				DamageIncrease = 18,
				ReloadTimeDecrease = 0,
				RangeIncrease = 6,
				TurretConfigs = { v9 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Quad Miniguns",
				Icon = "rbxassetid://17155094516",
				UpgradeIcon = "rbxassetid://17230665906",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 125000,
				DynamicPriceScaling = 1500,
				HealthIncrease = 3000,
				GainStunImmunity = true,
				DamageIncrease = 64,
				ReloadTimeDecrease = 0,
				RangeIncrease = 21,
				TurretConfigs = { v9 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Super Quad Miniguns",
				Icon = "rbxassetid://17155094119",
				UpgradeIcon = "rbxassetid://17230663487",
				UpgradeIconUseLegacySize = true
			}
		},
		Path2Data = {
			{
				Cost = 1500,
				HealthIncrease = 125,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				TurretConfigs = { v3 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Heavy Ammo",
				Icon = "rbxassetid://17155092227",
				UpgradeIcon = "rbxassetid://17230665690",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 1850,
				HealthIncrease = 175,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				TurretConfigs = { v3 },
				FirstPersonConfig = firstPersonConfig,
				Description = "Bigger Barrel",
				Icon = "rbxassetid://17155092098",
				UpgradeIcon = "rbxassetid://17230666414",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 8000,
				HealthIncrease = 700,
				RemoveIgnoreResistance = true,
				ProjectileName = Enums.Projectiles.XWM_SmallMissile,
				DamageIncrease = 50,
				DamageType = Enums.DamageTypes.Explosive,
				OverrideReloadTime = 2.5,
				RangeIncrease = 8,
				SplashRadiusIncrease = 3,
				BurstSizeIncrease = 3,
				ClientsideBurstSizeOverride = 4,
				ClientsideBurstIntervalOverride = 3,
				TurretConfigs = { v11 },
				FirstPersonConfig = firstPersonConfig2,
				Description = "Rocket Launchers",
				Icon = "rbxassetid://17155094681",
				UpgradeIcon = "rbxassetid://17230664464",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 62000,
				HealthIncrease = 1100,
				ProjectileName = Enums.Projectiles.XWM_BigMissile,
				DamageIncrease = 100,
				OverrideReloadTime = 2.5,
				GainStealthDetection = true,
				RangeIncrease = 12,
				MinRangeOverride = 14,
				BurstSizeIncrease = 8,
				ClientsideBurstSizeOverride = 12,
				ClientsideBurstIntervalOverride = 3,
				TurretConfigs = { v13 },
				FirstPersonConfig = firstPersonConfig2,
				Description = "Missile Pods",
				Icon = "rbxassetid://17155094333",
				UpgradeIcon = "rbxassetid://17230664228",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 182500,
				DynamicPriceScaling = 1000,
				HealthIncrease = 2000,
				ProjectileName = Enums.Projectiles.XWM_BigMissile,
				DamageIncrease = 100,
				OverrideReloadTime = 0.75,
				RangeIncrease = 75,
				GainStunImmunity = true,
				MinRangeOverride = 26,
				SplashRadiusIncrease = 1.5,
				BurstSizeOverride = 2,
				BurstIntervalOverride = 0.05,
				ClientsideBurstSizeOverride = 18,
				ClientsideBurstIntervalOverride = 3,
				TurretConfigs = { v13 },
				FirstPersonConfig = firstPersonConfig2,
				Description = "Super Missile Pods",
				Icon = "rbxassetid://17155093990",
				UpgradeIcon = "rbxassetid://17230663941",
				UpgradeIconUseLegacySize = true
			}
		}
	},
	IsMechanical = true,
	MaximumRebuilds = 4,
	RebuildVFX = Enums.VisualEffects.XWMTurretRebuilding,
	RebuildVFXOffset = createVector(0, 0.3, 0),
	DeathEffect = Enums.DeathEffects.XWMTurretDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 2.5,
	Radius = 3.2,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	NoBuffs = true,
	NoHeal = true,
	ClientsideAttackTargetTorsoPosition = true
}
XWMTurret.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 175,
		CostIncreasePerLevel = 125,
		Amount = 0.85
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 200,
		CostIncreasePerLevel = 550,
		Amount = 0.35
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 150,
		CostIncreasePerLevel = 125,
		Amount = 0.15
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Splash,
		Cost = 150,
		CostIncreasePerLevel = 175,
		Amount = 0.25
	}
}
return XWMTurret