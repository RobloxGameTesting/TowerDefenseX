local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 250,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 1,
			ReloadTime = 1.75,
			Range = 9,
			StealthDetection = false,
			BurstSize = 2,
			BurstInterval = 0.15,
			Description = "BASE",
			Icon = "rbxassetid://11397163703"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 165,
				HealthIncrease = 10,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				BurstSizeIncrease = 1,
				RangeIncrease = 3,
				Description = "Laser Sight",
				Icon = "rbxassetid://11382240510",
				UpgradeIcon = "rbxassetid://11425688309"
			},
			{
				Cost = 350,
				HealthIncrease = 25,
				DamageIncrease = 0.5,
				ReloadTimeDecrease = 0.1,
				BurstSizeIncrease = 1,
				RangeIncrease = 1,
				Description = "Advanced Training",
				Icon = "rbxassetid://11382240613",
				UpgradeIcon = "rbxassetid://11425689064"
			},
			{
				Cost = 750,
				HealthIncrease = 50,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.4,
				BurstSizeIncrease = 1,
				RangeIncrease = 0,
				GainStealthDetection = true,
				Description = "Stealth Sight",
				Icon = "rbxassetid://11382240332",
				UpgradeIcon = "rbxassetid://11425687864"
			},
			{
				Cost = 2500,
				HealthIncrease = 20,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Heavy Caliber",
				Icon = "rbxassetid://11382240183",
				UpgradeIcon = "rbxassetid://11425687336"
			},
			{
				Cost = 8750,
				HealthIncrease = 125,
				DamageIncrease = 9,
				ReloadTimeDecrease = 1,
				RangeIncrease = 3,
				RemoveBurst = true,
				OverrideReloadTime = 0.15,
				Description = "LMG",
				Icon = "rbxassetid://11382240061",
				UpgradeIcon = "rbxassetid://11425686915"
			}
		},
		Path2Data = {
			{
				Cost = 250,
				HealthIncrease = 10,
				DamageIncrease = 1.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "AP Ammo",
				Icon = "rbxassetid://11382240613",
				UpgradeIcon = "rbxassetid://11425688833"
			},
			{
				Cost = 425,
				HealthIncrease = 25,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 2,
				Description = "Internal Upgrades",
				Icon = "rbxassetid://11382240510",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 1400,
				HealthIncrease = 100,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 1,
				GainIgnoreResistance = true,
				BurstSizeIncrease = 1,
				Description = "Assault Loadout",
				Icon = "rbxassetid://11382240398",
				UpgradeIcon = "rbxassetid://11425687549"
			},
			{
				Cost = 2400,
				HealthIncrease = 60,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				BurstSizeIncrease = 3,
				AbilityNames = { Enums.TowerAbilities.GrenadeLevel1 },
				Description = "Explosive Points",
				Icon = "rbxassetid://11382240259",
				UpgradeIcon = "rbxassetid://11425688079"
			},
			{
				Cost = 7250,
				HealthIncrease = 325,
				DamageIncrease = 7,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				BurstSizeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.GrenadeLevel2, Enums.TowerAbilities.M203 },
				Description = "Direct Assault",
				Icon = "rbxassetid://11382240117",
				UpgradeIcon = "rbxassetid://11425687077"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	HasCustomCode = true,
	Radius = 1.5,
	HoverHeight = 1.218,
	RotationOffset = CFrame.Angles(0, 0, 0),
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 100,
			CostIncreasePerLevel = 100,
			Amount = 0.3
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 225,
			CostIncreasePerLevel = 100,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 75,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 10,
			Amount = 0.15
		}
	}
}