local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	ModelName = "Gun",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{ ModelName = "Barrel", NoRotate = true }
	}
}
local v2 = {
	ModelName = "Gun",
	RotationConstraintConfig = { CanRotateY = true },
	TurretGunConfigs = {
		{
			ModelName = "Barrel",
			RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
			RotationConstraintConfig = { CanRotateZ = true, MaxRotationZ = 45, MinRotationZ = -45 }
		}
	}
}
local Railgunner = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 3250,
			Health = 525,
			ProjectileName = Enums.Projectiles.RailgunProjectile,
			DamageType = Enums.DamageTypes.Laser,
			Damage = 150,
			ReloadTime = 5,
			Range = 22,
			StealthDetection = false,
			Description = "BASE",
			Icon = "rbxassetid://15638273119"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 1050,
				HealthIncrease = 25,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.75,
				RangeIncrease = 1,
				Description = "Cooling Cells",
				Icon = "rbxassetid://15638273052",
				UpgradeIcon = "rbxassetid://15643428690"
			},
			{
				Cost = 2500,
				HealthIncrease = 25,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.75,
				RangeIncrease = 4,
				Description = "Advanced Optics",
				Icon = "rbxassetid://15638272977",
				UpgradeIcon = "rbxassetid://15643428851"
			},
			{
				Cost = 5000,
				HealthIncrease = 450,
				GainCanTargetAir = true,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 1,
				GainStealthDetection = true,
				Description = "Rail Trooper",
				Icon = "rbxassetid://15638272703",
				UpgradeIcon = "rbxassetid://15643428235"
			},
			{
				Cost = 12000,
				HealthIncrease = 825,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 125,
				ReloadTimeDecrease = 0.75,
				PierceCountIncrease = 1,
				RangeIncrease = 2,
				Description = "Suited Up",
				Icon = "rbxassetid://15638272499",
				UpgradeIcon = "rbxassetid://15643427820"
			},
			{
				Cost = 27000,
				HealthIncrease = 2050,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 100,
				ReloadTimeDecrease = 1,
				RangeIncrease = 7,
				Description = "Super Rail Trooper",
				Icon = "rbxassetid://15638272193",
				UpgradeIcon = "rbxassetid://15643427691"
			}
		},
		Path2Data = {
			{
				Cost = 1850,
				HealthIncrease = 50,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 75,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Proto Ammo",
				Icon = "rbxassetid://15638273052",
				UpgradeIcon = "rbxassetid://15643428342"
			},
			{
				Cost = 3200,
				HealthIncrease = 50,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 100,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				Description = "Lightning Cells",
				Icon = "rbxassetid://15638272977",
				UpgradeIcon = "rbxassetid://15643428427"
			},
			{
				Cost = 8000,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 300,
				ReloadTimeDecrease = -2,
				RangeIncrease = 8,
				TurretConfigs = { v },
				Description = "Sentry",
				Icon = "rbxassetid://15638272813",
				UpgradeIcon = "rbxassetid://15643428002"
			},
			{
				Cost = 17000,
				HealthIncrease = 2000,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				DamageIncrease = 385,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 12,
				TurretConfigs = { v },
				Description = "Dual Barrels",
				Icon = "rbxassetid://15638272590",
				UpgradeIcon = "rbxassetid://15643428589"
			},
			{
				Cost = 200000,
				HealthIncrease = 6750,
				ProjectileName = Enums.Projectiles.RailgunProjectile,
				AimTimeOverride = 10,
				GainStunImmunity = true,
				ResetAimAfterEachShot = true,
				DamageIncrease = 18000,
				OverrideReloadTime = 0.85,
				RangeIncrease = 25,
				TurretConfigs = { v2 },
				Description = "XRT-9000",
				Icon = "rbxassetid://15638272375",
				UpgradeIcon = "rbxassetid://15643427545"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 2.2,
	RotationOffset = CFrame.Angles(0, 0, 0),
	ClientsideAttackTargetTorsoPosition = true
}
Railgunner.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 250,
		CostIncreasePerLevel = 125,
		Amount = 0.15
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 375,
		CostIncreasePerLevel = 135,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 185,
		CostIncreasePerLevel = 85,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Firerate,
		Cost = 250,
		CostIncreasePerLevel = 150,
		Amount = 0.1
	}
}
return Railgunner