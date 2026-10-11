local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 650,
			Health = 115,
			DamageType = Enums.DamageTypes.Explosive,
			ProjectileName = Enums.Projectiles.StingerMissile,
			CanTargetAir = true,
			IsSplash = true,
			SplashRadius = 0.5,
			Damage = 20,
			ReloadTime = 4.5,
			Range = 23,
			StealthDetection = false,
			AirUnitDamageMultiplier = 6,
			SlowdownPercentage = 0.1,
			SlowdownDuration = 5,
			AbilityNames = { Enums.TowerAbilities.StingerHandgunL0 },
			Description = "",
			Icon = "",
			BurstSize = 1,
			BurstInterval = 0.25
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 300,
				HealthIncrease = 25,
				DamageIncrease = 6,
				RangeIncrease = 4,
				SlowdownPercentageIncrease = 0,
				SlowdownDurationIncrease = 0,
				Description = "Advanced Training",
				Icon = "",
				UpgradeIcon = "rbxassetid://134203453720394",
				AbilityNames = { Enums.TowerAbilities.StingerHandgunL1 }
			},
			{
				Cost = 600,
				HealthIncrease = 40,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0.5,
				RangeIncrease = 15,
				SlowdownPercentageIncrease = 0,
				SlowdownDurationIncrease = 0,
				Description = "Radar Sensor",
				Icon = "",
				UpgradeIcon = "rbxassetid://76643227356612",
				AbilityNames = { Enums.TowerAbilities.StingerHandgunL2 }
			},
			{
				Cost = 1600,
				HealthIncrease = 150,
				DamageIncrease = 22,
				SplashRadiusIncrease = 1,
				RangeIncrease = 2,
				SlowdownPercentageIncrease = 0.05,
				SlowdownDurationIncrease = 0,
				Description = "Stinger+",
				Icon = "",
				UpgradeIcon = "rbxassetid://113422588307446",
				AbilityNames = { Enums.TowerAbilities.StingerHandgunL3 }
			},
			{
				Cost = 6500,
				HealthIncrease = 400,
				ReloadTimeDecrease = -1,
				BurstSizeOverride = 4,
				SlowdownPercentageIncrease = 0,
				SlowdownDurationIncrease = 0,
				Description = "QUAD BURST",
				Icon = "",
				UpgradeIcon = "rbxassetid://99161682650838",
				AbilityNames = { Enums.TowerAbilities.StingerHandgunL4 }
			},
			{
				Cost = 14700,
				HealthIncrease = 1200,
				ReloadTimeDecrease = 1,
				DamageIncrease = 277,
				SplashRadiusIncrease = 1,
				GainStealthDetection = true,
				RangeIncrease = 20,
				BurstSizeOverride = 1,
				SlowdownPercentageIncrease = 0.05,
				SlowdownDurationIncrease = 3,
				Description = "X-STINGER",
				Icon = "",
				UpgradeIcon = "rbxassetid://79210695294292",
				AbilityNames = { Enums.TowerAbilities.StingerHandgunL5 }
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	ReplicateReloading = true,
	GunModelName = "Stinger",
	MaxObstacleHeight = 1.6,
	Radius = 1.5,
	HoverHeight = 1.321,
	RotationOffset = CFrame.Angles(0, 1.5707963267948966, 0),
	AdditionalDisplayStats = { "PassiveAbility" },
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 150,
			CostIncreasePerLevel = 125,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 125,
			CostIncreasePerLevel = 50,
			Amount = 0.15
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Splash,
			Cost = 225,
			CostIncreasePerLevel = 100,
			Amount = 0.25
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://128614740481893"
}