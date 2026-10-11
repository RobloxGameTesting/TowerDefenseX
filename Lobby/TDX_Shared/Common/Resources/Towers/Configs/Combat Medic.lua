local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 1000,
			Health = 300,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 1,
			CanTargetAir = true,
			ReloadTime = 1,
			Range = 13,
			StealthDetection = false,
			BurstSize = 17,
			BurstInterval = 0.1,
			NearbyTowerHealPerSecond = 25,
			PlacementDisplayDashedRange = true,
			ReviveDuration = 5,
			Description = "",
			Icon = ""
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 550,
				HealthIncrease = 50,
				DamageIncrease = 0,
				BurstSizeIncrease = 7,
				ReloadTimeDecrease = 0,
				Description = "BURST INCREASE",
				Icon = "",
				UpgradeIcon = "rbxassetid://131634846571000"
			},
			{
				Cost = 1800,
				HealthIncrease = 150,
				DamageIncrease = 3.5,
				RangeIncrease = 1,
				Description = "+P AMMO",
				Icon = "",
				UpgradeIcon = "rbxassetid://15247048937"
			},
			{
				Cost = 6500,
				HealthIncrease = 300,
				DamageIncrease = 1.5,
				RangeIncrease = 0,
				NearbyTowerHealPerSecondIncrease = 10,
				AbilityNames = { Enums.TowerAbilities.CombatMedicReviveLevel1 },
				Description = "REVIVE PACK",
				Icon = "",
				UpgradeIcon = "rbxassetid://96677800355977"
			},
			{
				Cost = 10000,
				HealthIncrease = 500,
				DamageIncrease = 2,
				RangeIncrease = 0,
				NearbyTowerHealPerSecondIncrease = 10,
				AbilityNames = { Enums.TowerAbilities.CombatMedicReviveLevel2 },
				Description = "REVIVE CHARGE",
				Icon = "",
				UpgradeIcon = "rbxassetid://136369808843731"
			},
			{
				Cost = 25000,
				HealthIncrease = 1100,
				DamageIncrease = 12,
				RangeIncrease = 1,
				NearbyTowerHealPerSecondIncrease = 10,
				ReviveDurationDecrease = 1.5,
				AbilityNames = { Enums.TowerAbilities.CombatMedicReviveLevel3 },
				Description = "COMBAT MEDIC",
				Icon = "",
				UpgradeIcon = "rbxassetid://118871483917510"
			}
		},
		Path2Data = {
			{
				Cost = 1200,
				HealthIncrease = 75,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "MEDICAL+",
				NearbyTowerHealPerSecondIncrease = 35,
				Icon = "",
				UpgradeIcon = "rbxassetid://137177954850196"
			},
			{
				Cost = 2000,
				HealthIncrease = 100,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				NearbyTowerHealPerSecondIncrease = 60,
				RangeIncrease = 2,
				Description = "MORE HEALS",
				Icon = "",
				UpgradeIcon = "rbxassetid://86772101803549"
			},
			{
				Cost = 7250,
				HealthIncrease = 450,
				DamageIncrease = 2,
				NearbyTowerHealPerSecondIncrease = 25,
				OverrideReloadTime = 0.1,
				RangeIncrease = 7,
				AbilityNames = { Enums.TowerAbilities.CombatMedicDroneLevel1 },
				Description = "MEDIC DRONE",
				Icon = "",
				UpgradeIcon = "rbxassetid://92179054517293"
			},
			{
				Cost = 18500,
				HealthIncrease = 800,
				DamageIncrease = 4,
				OverrideReloadTime = 0.09,
				NearbyTowerHealPerSecondIncrease = 70,
				RangeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.CombatMedicDroneLevel2 },
				Description = "EVEN MORE HEALS",
				Icon = "",
				UpgradeIcon = "rbxassetid://76264522559379"
			},
			{
				Cost = 36000,
				HealthIncrease = 2175,
				DamageIncrease = 10,
				GainStealthDetection = true,
				OverrideReloadTime = 0.08,
				NearbyTowerHealPerSecondIncrease = 210,
				RangeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.CombatMedicDroneLevel3 },
				Description = "RAPID SUPPORT",
				Icon = "",
				UpgradeIcon = "rbxassetid://71105933829653"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	LimitMap = { 7, 5, 4, 3 },
	GunModelName = "Gun_",
	MaxObstacleHeight = 1.6,
	Radius = 1.15,
	HoverHeight = 1.22,
	RotationOffset = CFrame.Angles(0, 0, 0),
	AdditionalDisplayStats = { "NearbyTowerHealPerSecond", "PassiveAbility" },
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 100,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 250,
			CostIncreasePerLevel = 300,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 300,
			CostIncreasePerLevel = 200,
			Amount = 0.1
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://87900098644484"
}