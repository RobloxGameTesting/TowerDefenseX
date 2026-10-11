local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local Juggernaut = {
	UpgradePathData = {
		BaseLevelData = {
			Cost = 6350,
			Health = 850,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 8,
			ReloadTime = 0.1,
			Range = 15,
			StealthDetection = false,
			Description = "Base",
			Icon = "http://www.roblox.com/asset/?id=10686157920"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 850,
				HealthIncrease = 75,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.01,
				RangeIncrease = 1,
				Description = "Power Gloves",
				Icon = "http://www.roblox.com/asset/?id=10709052611",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 1600,
				HealthIncrease = 100,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.01,
				RangeIncrease = 0,
				Description = "Joint Suppressors",
				Icon = "http://www.roblox.com/asset/?id=10709052611",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 6250,
				HealthIncrease = 275,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Longer Barrel",
				Icon = "http://www.roblox.com/asset/?id=10709051790",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 9000,
				HealthIncrease = 400,
				DamageIncrease = 4,
				GainIgnoreResistance = true,
				ReloadTimeDecrease = -0.01,
				RangeIncrease = 4,
				Description = "Power Minigun",
				Icon = "http://www.roblox.com/asset/?id=10709051790",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686164581",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 67000,
				HealthIncrease = 2200,
				DamageIncrease = 26,
				ReloadTimeDecrease = 0,
				RangeIncrease = 4,
				AbilityNames = { Enums.TowerAbilities.JuggernautHERounds },
				Description = "Juggernaut",
				Icon = "http://www.roblox.com/asset/?id=10709053272",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10730112026",
				UpgradeIconUseLegacySize = true
			}
		},
		Path2Data = {
			{
				Cost = 600,
				HealthIncrease = 40,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 2,
				Description = "Better Handling",
				Icon = "http://www.roblox.com/asset/?id=10709052611",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 3650,
				HealthIncrease = 65,
				DamageIncrease = 3,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "AP Ammo",
				Icon = "http://www.roblox.com/asset/?id=10709052611",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054127",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 7500,
				HealthIncrease = 750,
				DamageIncrease = 5,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Dual Guns",
				GainStealthDetection = true,
				Icon = "http://www.roblox.com/asset/?id=10709051300",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686163815",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 14000,
				HealthIncrease = 950,
				DamageIncrease = 12,
				RangeIncrease = 0,
				Description = "Cybernetic Pulse",
				Icon = "http://www.roblox.com/asset/?id=10709051300",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10686163815",
				UpgradeIconUseLegacySize = true
			},
			{
				Cost = 120000,
				HealthIncrease = 3525,
				AimTimeOverride = 1.2,
				AimResetTimeOverride = 1.6,
				DamageIncrease = 59,
				ReloadTimeDecrease = 0,
				RangeIncrease = 3,
				GainStunImmunity = true,
				AbilityNames = { Enums.TowerAbilities.JuggernautOvercharge },
				Description = "Full Power",
				Icon = "http://www.roblox.com/asset/?id=10664462041",
				UpgradeIcon = "http://www.roblox.com/asset/?id=10709054560",
				UpgradeIconUseLegacySize = true
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Minigun",
	MaxObstacleHeight = 1.6,
	Radius = 2.2,
	HoverHeight = 1.4655,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0)
}
Juggernaut.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 100,
		CostIncreasePerLevel = 100,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		Cost = 225,
		CostIncreasePerLevel = 300,
		Amount = 0.25
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 75,
		CostIncreasePerLevel = 125,
		Amount = 0.15
	}
}
return Juggernaut