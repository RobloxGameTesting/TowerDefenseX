local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun", NoRotate = true }
	}
}
local v2 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	UseBurstIndexForGun = true,
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Gun1", NoRotate = true },
		{ ModelName = "Gun2", NoRotate = true }
	}
}
local v3 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			NoRotate = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedX = 20
				}
			}
		}
	}
}
local v4 = {
	ModelName = "Turret",
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Gun",
			NoRotate = true,
			RotatingBarrelData = {
				{
					WeldPointerName = "RotatingBarrelWeld",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedX = 30
				},
				{
					WeldPointerName = "RotatingBarrelWeld2",
					TimeToMaxRotationSpeed = 0.25,
					TimeToSpinAfterShot = 0.7,
					TimeToStopRotation = 1.3,
					MaxRotationSpeedX = 25
				}
			}
		}
	}
}
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 190,
			Health = 50,
			CanRebuild = true,
			RebuildTime = 7,
			RebuildTimeIncreaseEachDeath = 3,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 2,
			ReloadTime = 1,
			AimTime = 0.5,
			AimResetTime = 3,
			Range = 14,
			StealthDetection = false,
			MaximumROM = 120,
			TurretConfigs = { v },
			Description = "",
			Icon = "rbxassetid://86914365442313"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 225,
				HealthIncrease = 10,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 0,
				TurretConfigs = { v },
				Description = "Autoloader",
				Icon = "rbxassetid://136646470592999",
				UpgradeIcon = "rbxassetid://89582049909333"
			},
			{
				Cost = 450,
				HealthIncrease = 15,
				DamageIncrease = 1,
				RangeIncrease = 5,
				TurretConfigs = { v },
				Description = "Longer Barrel",
				Icon = "rbxassetid://86521009311504",
				UpgradeIcon = "rbxassetid://78906157865914"
			},
			{
				Cost = 1200,
				HealthIncrease = 20,
				DamageIncrease = 7,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 3,
				GainStealthDetection = true,
				TurretConfigs = { v },
				Description = "Bigger Gun",
				Icon = "rbxassetid://73569058637293",
				UpgradeIcon = "rbxassetid://76607578050563"
			},
			{
				Cost = 3375,
				HealthIncrease = 150,
				DamageIncrease = 20,
				GainIgnoreResistance = true,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				TurretConfigs = { v },
				Description = "Sabot Rounds",
				Icon = "rbxassetid://79786011577345",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 19000,
				HealthIncrease = 600,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				TurretConfigs = { v2 },
				Description = "X-Sentry",
				Icon = "rbxassetid://95184836533448",
				UpgradeIcon = "rbxassetid://130314656986202"
			}
		},
		Path2Data = {
			{
				Cost = 150,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				TurretConfigs = { v },
				Description = "Better Optics",
				Icon = "rbxassetid://136646470592999",
				UpgradeIcon = "rbxassetid://89989479254721"
			},
			{
				Cost = 250,
				HealthIncrease = 10,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				TurretConfigs = { v },
				Description = "Heavy Ammo",
				Icon = "rbxassetid://86521009311504",
				UpgradeIcon = "rbxassetid://15266660711"
			},
			{
				Cost = 5000,
				HealthIncrease = 300,
				DamageIncrease = 0,
				RangeIncrease = 0,
				ReloadTimeDecrease = 0.6,
				MaximumROMIncrease = 150,
				AbilityNames = { Enums.TowerAbilities.SentryRocketsLevel1 },
				TurretConfigs = { v3 },
				Description = "Minigun",
				Icon = "rbxassetid://97823626207615",
				UpgradeIcon = "rbxassetid://87364294935240"
			},
			{
				Cost = 8000,
				HealthIncrease = 400,
				DamageIncrease = 10,
				RangeIncrease = 0,
				ReloadTimeDecrease = 0,
				AbilityNames = { Enums.TowerAbilities.SentryRocketsLevel2 },
				TurretConfigs = { v3 },
				Description = "Full Minigun",
				Icon = "rbxassetid://116281664388601",
				UpgradeIcon = "rbxassetid://86734305931015"
			},
			{
				Cost = 36500,
				HealthIncrease = 550,
				DamageIncrease = 14,
				RangeIncrease = 2,
				ReloadTimeDecrease = 0.11,
				MaximumROMIncrease = 20,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.SentryRocketsLevel3 },
				TurretConfigs = { v4 },
				Description = "XW-M Turret",
				Icon = "rbxassetid://77618801195322",
				UpgradeIcon = "rbxassetid://100065357023600"
			}
		}
	},
	IsMechanical = true,
	MaximumRebuilds = 8,
	RebuildVFX = Enums.VisualEffects.XWMTurretRebuilding,
	RebuildVFXOffset = vector.create(0, 0.3, 0),
	DeathEffect = Enums.DeathEffects.XWMTurretDeath,
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	MaxObstacleHeight = 1.6,
	ValidArcsCustomDivisionCount = 80,
	Radius = 1.35,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	NoBuffs = true,
	NoHeal = true,
	ClientsideAttackTargetTorsoPosition = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 0.8
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 100,
			CostIncreasePerLevel = 150,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 75,
			Amount = 0.15
		}
	}
}