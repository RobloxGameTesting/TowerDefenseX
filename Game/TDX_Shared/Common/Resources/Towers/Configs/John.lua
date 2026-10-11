local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local John = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 300,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 3,
			ReloadTime = 1.1,
			Range = 11,
			StealthDetection = false,
			BurstSize = 1,
			BurstInterval = 0.35,
			Description = "BASE",
			Icon = "rbxassetid://15126171823"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 125,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.1,
				RangeIncrease = 2,
				Description = "Vest",
				Icon = "rbxassetid://15126171585",
				UpgradeIcon = "rbxassetid://15247048575"
			},
			{
				Cost = 450,
				HealthIncrease = 10,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "+P Ammo",
				Icon = "rbxassetid://15126171425",
				UpgradeIcon = "rbxassetid://15247048937"
			},
			{
				Cost = 1400,
				HealthIncrease = 200,
				DamageIncrease = 12,
				ReloadTimeDecrease = 0,
				GainIgnoreResistance = true,
				RangeIncrease = 3,
				Description = "Desert Eagle",
				Icon = "rbxassetid://15126170951",
				UpgradeIcon = "rbxassetid://15247049279"
			},
			{
				Cost = 3250,
				HealthIncrease = 475,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 0,
				BurstSizeIncrease = 1,
				Description = "Deagles",
				Icon = "rbxassetid://15126170583",
				UpgradeIcon = "rbxassetid://15247049395"
			},
			{
				Cost = 52500,
				HealthIncrease = 1400,
				DamageIncrease = 7,
				ReloadTimeDecrease = 0.3,
				GainStealthDetection = true,
				RemoveIgnoreResistance = true,
				RangeIncrease = 4,
				BurstSizeIncrease = -1,
				AbilityNames = { Enums.TowerAbilities.JohnRageMode },
				Description = "John Rage",
				Icon = "rbxassetid://15126170205",
				UpgradeIcon = "rbxassetid://15247049093"
			}
		},
		Path2Data = {
			{
				Cost = 100,
				HealthIncrease = 15,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Visor Upgrade",
				Icon = "rbxassetid://15126171585",
				UpgradeIcon = "rbxassetid://15247048358"
			},
			{
				Cost = 225,
				HealthIncrease = 25,
				DamageIncrease = 1,
				ReloadTimeDecrease = 0.1,
				GainStunImmunity = true,
				RangeIncrease = 0,
				Description = "Chef Knowledge",
				Icon = "rbxassetid://15126171425",
				UpgradeIcon = "rbxassetid://15247049483"
			},
			{
				Cost = 2300,
				HealthIncrease = 250,
				DamageIncrease = 8,
				ReloadTimeDecrease = 0.15,
				RangeIncrease = 0,
				ArcSpreadAngleIncrease = 38,
				ArcMaximumTargetsHitIncrease = 2,
				Description = "AK Shotgun",
				Icon = "rbxassetid://15126173254",
				UpgradeIcon = "rbxassetid://15247049732"
			},
			{
				Cost = 6600,
				HealthIncrease = 500,
				DamageIncrease = 19,
				ReloadTimeDecrease = 0.2,
				RangeIncrease = 0,
				Description = "AK Shotgun+",
				Icon = "rbxassetid://15126173047",
				UpgradeIcon = "rbxassetid://15247048831"
			},
			{
				Cost = 19000,
				HealthIncrease = 1400,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0.35,
				GainIgnoreResistance = true,
				RangeIncrease = 0,
				BurstSizeIncrease = 1,
				ArcMaximumTargetsHitIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.JohnAxeAttack, Enums.TowerAbilities.JohnRailgun },
				Description = "Slayer",
				Icon = "rbxassetid://15126172803",
				UpgradeIcon = "rbxassetid://15247048740"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	SpecialBurstHandlingForModel = true,
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0)
}
John.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 250,
		CostIncreasePerLevel = 125,
		Amount = 0.2
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 275,
		CostIncreasePerLevel = 150,
		Amount = 0.9
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 175,
		CostIncreasePerLevel = 75,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 225,
		CostIncreasePerLevel = 100,
		Amount = 0.15
	}
}
return John