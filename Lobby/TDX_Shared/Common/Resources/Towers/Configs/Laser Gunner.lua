local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local LaserGunner = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 925,
			Health = 250,
			ProjectileName = Enums.Projectiles.LaserRedSmall,
			Damage = 4,
			DamageType = Enums.DamageTypes.Laser,
			ReloadTime = 0.7,
			Range = 14,
			StealthDetection = true,
			Description = "BASE",
			Icon = "rbxassetid://14767815863"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 475,
				HealthIncrease = 25,
				ProjectileName = Enums.Projectiles.LaserRedSmall,
				DamageIncrease = 2,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				Description = "Laser Knowledge",
				Icon = "rbxassetid://14767815721",
				UpgradeIcon = "rbxassetid://15247556194"
			},
			{
				Cost = 1050,
				HealthIncrease = 50,
				ProjectileName = Enums.Projectiles.LaserRedSmall,
				DamageIncrease = 8,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Energy Cells",
				Icon = "rbxassetid://14767815592",
				UpgradeIcon = "rbxassetid://15247556464"
			},
			{
				Cost = 4200,
				HealthIncrease = 150,
				ProjectileName = Enums.Projectiles.LaserRedLarge,
				DamageIncrease = 8,
				ReloadTimeDecrease = 0,
				PierceCountIncrease = 1,
				RangeIncrease = 2,
				Description = "Laser BR",
				Icon = "rbxassetid://14767815294",
				UpgradeIcon = "rbxassetid://15247556328"
			},
			{
				Cost = 6500,
				HealthIncrease = 275,
				ProjectileName = Enums.Projectiles.LaserRedLarge,
				DamageIncrease = 13,
				ReloadTimeDecrease = 0.1,
				PierceCountIncrease = 0,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.LaserGunnerShockRounds },
				Description = "Reinforced Tech",
				Icon = "rbxassetid://14767814986",
				UpgradeIcon = "rbxassetid://15247556018"
			},
			{
				Cost = 28750,
				HealthIncrease = 1500,
				ProjectileName = Enums.Projectiles.LaserRedLarge,
				DamageIncrease = -15,
				ReloadTimeDecrease = 0.4,
				PierceCountIncrease = 1,
				RangeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.LaserGunnerShockRounds },
				Description = "Laser Minigun",
				Icon = "rbxassetid://14767814521",
				UpgradeIcon = "rbxassetid://15247556086"
			}
		},
		Path2Data = {
			{
				Cost = 150,
				HealthIncrease = 15,
				ProjectileName = Enums.Projectiles.LaserRedSmall,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 5,
				Description = "Upgraded Sensors",
				Icon = "rbxassetid://14767815592",
				UpgradeIcon = "rbxassetid://11425688309"
			},
			{
				Cost = 400,
				HealthIncrease = 25,
				ProjectileName = Enums.Projectiles.LaserRedSmall,
				DamageIncrease = 2,
				GainCanTargetAir = true,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 0,
				Description = "Advanced Tech",
				Icon = "rbxassetid://14767815721",
				UpgradeIcon = "rbxassetid://15247556718"
			},
			{
				Cost = 3275,
				HealthIncrease = 250,
				ProjectileName = Enums.Projectiles.LaserBlue,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0.27,
				RangeIncrease = -1,
				AbilityNames = { Enums.TowerAbilities.StealthSensorL1 },
				Description = "SMG",
				Icon = "rbxassetid://14767815463",
				UpgradeIcon = "rbxassetid://15247555832"
			},
			{
				Cost = 7000,
				HealthIncrease = 300,
				ProjectileName = Enums.Projectiles.LaserBlue,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.StealthSensorL2 },
				Description = "SMG+",
				Icon = "rbxassetid://14767815128",
				UpgradeIcon = "rbxassetid://15247555912"
			},
			{
				Cost = 16350,
				HealthIncrease = 1000,
				ProjectileName = Enums.Projectiles.LaserBlue,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0.08,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.StealthSensorL3 },
				Description = "Dual SMGs",
				Icon = "rbxassetid://14767814774",
				UpgradeIcon = "rbxassetid://15247556626"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Blaster",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0)
}
LaserGunner.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 75,
		CostIncreasePerLevel = 50,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 150,
		CostIncreasePerLevel = 65,
		Amount = 0.3
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 100,
		CostIncreasePerLevel = 30,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Pierce,
		Cost = 50,
		CostIncreasePerLevel = 20,
		Amount = 1,
		OverrideMaxLevel = 3
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 75,
		CostIncreasePerLevel = 25,
		Amount = 0.1
	}
}
return LaserGunner