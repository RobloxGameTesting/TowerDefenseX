local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 850,
			Health = 300,
			DamageType = Enums.DamageTypes.Golden,
			Damage = 6,
			ReloadTime = 1.25,
			Range = 12,
			StealthDetection = false,
			BurstSize = 2,
			BurstInterval = 0.15,
			Description = "BASE",
			Icon = "rbxassetid://17142843715"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 450,
				HealthIncrease = 50,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				BurstSizeIncrease = 1,
				RangeIncrease = 3,
				Description = "Extended Range",
				Icon = "rbxassetid://17142843461",
				UpgradeIcon = "rbxassetid://17230685958",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 950,
				HealthIncrease = 100,
				DamageIncrease = 1.5,
				ReloadTimeDecrease = 0.1,
				BurstSizeIncrease = 1,
				RangeIncrease = 2.5,
				Description = "Advanced Training",
				Icon = "rbxassetid://17142843217",
				UpgradeIcon = "rbxassetid://17230687528",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 3250,
				HealthIncrease = 350,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0.4,
				BurstSizeIncrease = 1,
				RangeIncrease = 5,
				Description = "More Equipment",
				Icon = "rbxassetid://17142842957",
				UpgradeIcon = "rbxassetid://17230685319",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 10500,
				HealthIncrease = 550,
				DamageIncrease = 6.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				RemoveBurst = true,
				OverrideReloadTime = 0.12,
				Description = "Heavy Caliber",
				Icon = "rbxassetid://17142842381",
				UpgradeIcon = "rbxassetid://17230685598",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 40000,
				HealthIncrease = 1650,
				DamageIncrease = 32.5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				OverrideReloadTime = 0.1,
				Description = "X LMG",
				Icon = "rbxassetid://17142841821",
				UpgradeIcon = "rbxassetid://17230684766",
				UpgradeIconUseLegacySize = true
			}
		},
		Path2Data = {
			{
				Cost = 350,
				HealthIncrease = 50,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "AP Ammo",
				Icon = "rbxassetid://17142843461",
				UpgradeIcon = "rbxassetid://17230686977",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 900,
				HealthIncrease = 75,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.25,
				GainStealthDetection = true,
				RangeIncrease = 2.5,
				Description = "Internal Upgrades",
				Icon = "rbxassetid://17142843217",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 5250,
				HealthIncrease = 300,
				GainCanTargetAir = true,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0.25,
				RangeIncrease = 3,
				BurstSizeIncrease = 1,
				Description = "Assault Loadout",
				Icon = "rbxassetid://17142842678",
				UpgradeIcon = "rbxassetid://17230686676",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 10000,
				HealthIncrease = 975,
				DamageIncrease = 13,
				ReloadTimeDecrease = 0,
				RangeIncrease = 1,
				BurstSizeIncrease = 3,
				Description = "Upgraded Cells",
				Icon = "rbxassetid://17142842107",
				UpgradeIcon = "rbxassetid://17230685045",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 32000,
				HealthIncrease = 2850,
				DamageIncrease = 24,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				BurstSizeIncrease = 1,
				AbilityNames = { Enums.TowerAbilities.GoldenRangerGrenade, Enums.TowerAbilities.GoldenM203 },
				Description = "Energy Assault",
				Icon = "rbxassetid://17142841385",
				UpgradeIcon = "rbxassetid://17230686217",
				UpgradeIconUseLegacySize = true
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	IsGolden = true,
	Radius = 1.5,
	RotationOffset = CFrame.Angles(0, 0, 0),
	PlacementEffectName = Enums.VisualEffects.GoldenPlacement,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 150,
			CostIncreasePerLevel = 150,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 300,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 175,
			CostIncreasePerLevel = 150,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 50,
			CostIncreasePerLevel = 25,
			Amount = 0.1
		}
	}
}