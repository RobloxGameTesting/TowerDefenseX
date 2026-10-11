local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 7250,
			Health = 1000,
			AimTime = 0.9,
			AimResetTime = 1.6,
			DamageType = Enums.DamageTypes.Golden,
			Damage = 12,
			ReloadTime = 0.1,
			Range = 16,
			StealthDetection = false,
			Description = "Base",
			Icon = "rbxassetid://17125384166"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 900,
				HealthIncrease = 100,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.01,
				GainStunImmunity = true,
				RangeIncrease = 1,
				Description = "Power Gloves",
				Icon = "rbxassetid://17125383917",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 1750,
				HealthIncrease = 175,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.01,
				RangeIncrease = 0,
				Description = "Joint Suppressors",
				Icon = "rbxassetid://17125383917",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 12000,
				HealthIncrease = 500,
				DamageIncrease = 4,
				ReloadTimeDecrease = 0,
				GainStealthDetection = true,
				RangeIncrease = 5,
				Description = "Longer Barrel",
				Icon = "rbxassetid://17125383289",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 20000,
				HealthIncrease = 750,
				DamageIncrease = 8,
				ReloadTimeDecrease = -0.01,
				RangeIncrease = 4,
				Description = "Power Minigun",
				Icon = "rbxassetid://17155473946",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686164581",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 84000,
				HealthIncrease = 4250,
				GainIgnoreResistance = true,
				DamageIncrease = 19,
				PierceCountIncrease = 1,
				ReloadTimeDecrease = 0,
				RangeIncrease = 11,
				AbilityNames = { Enums.TowerAbilities.RebootSystems },
				Description = "Juggernaut",
				Icon = "rbxassetid://17125382549",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10730112026",
				UpgradeIconUseLegacySize = true
			}
		},
		Path2Data = {
			{
				Cost = 600,
				HealthIncrease = 100,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				Description = "Better Handling",
				Icon = "rbxassetid://17125383917",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 3650,
				HealthIncrease = 200,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "AP Ammo",
				Icon = "rbxassetid://17125383917",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 15000,
				HealthIncrease = 850,
				DamageIncrease = 6,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Dual Guns",
				GainStealthDetection = true,
				Icon = "rbxassetid://17125385921",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686163815",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 28000,
				HealthIncrease = 1250,
				DamageIncrease = 14,
				RangeIncrease = 0,
				Description = "Cybernetic Pulse",
				Icon = "rbxassetid://17125385695",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686163815",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 267000,
				HealthIncrease = 8000,
				DamageIncrease = 150,
				ReloadTimeDecrease = 0,
				RangeIncrease = 12,
				AbilityNames = { Enums.TowerAbilities.RebootSystems },
				Description = "Full Power",
				Icon = "rbxassetid://17125385343",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054560",
				UpgradeIconUseLegacySize = true
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	IsGolden = true,
	GunModelName = "Gun",
	MaxObstacleHeight = 1.6,
	Radius = 2.2,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	PlacementEffectName = Enums.VisualEffects.GoldenPlacement,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 300,
			CostIncreasePerLevel = 125,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 650,
			CostIncreasePerLevel = 500,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 200,
			CostIncreasePerLevel = 125,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 75,
			CostIncreasePerLevel = 15,
			Amount = 0.1
		}
	}
}