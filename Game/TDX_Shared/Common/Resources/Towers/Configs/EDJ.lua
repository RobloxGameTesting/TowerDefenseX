local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local EDJ = {
	AttackDisabled = true,
	UpgradePathData = {
		BaseLevelData = {
			Cost = 2000,
			Health = 400,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 0.1,
			Range = 8.5,
			StealthDetection = false,
			NearbyTowerFirerateBuff = 0.05,
			NearbyTowerRangeBuff = 0.05,
			NearbyTowerDiscount = 0,
			NearbyTowerSellback = 0,
			PlacementDisplayDashedRange = true,
			IgnoreObstacles = true,
			Description = "Base",
			Icon = "rbxassetid://15422312409"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 500,
				HealthIncrease = 20,
				RangeIncrease = 2,
				Description = "Bass Boosted",
				Icon = "rbxassetid://15422312226",
				UpgradeIcon = "rbxassetid://11425689064"
			},
			{
				Cost = 1500,
				HealthIncrease = 50,
				RangeIncrease = 0,
				NearbyTowerFirerateBuffIncrease = 0.05,
				Description = "Aggressive Tracks",
				Icon = "rbxassetid://15422312059",
				UpgradeIcon = "rbxassetid://11425688309"
			},
			{
				Cost = 4300,
				HealthIncrease = 150,
				RangeIncrease = 1,
				NearbyTowerFirerateBuffIncrease = 0.1,
				NearbyTowerRangeBuffIncrease = 0.05,
				AbilityNames = { Enums.TowerAbilities.Encore },
				Description = "Rally Call",
				Icon = "rbxassetid://15422311664",
				UpgradeIcon = "rbxassetid://11425687864"
			},
			{
				Cost = 5500,
				HealthIncrease = 350,
				RangeIncrease = 0,
				NearbyTowerFirerateBuffIncrease = 0.1,
				AbilityNames = { Enums.TowerAbilities.Encore },
				Description = "Encore",
				Icon = "rbxassetid://15422311210",
				UpgradeIcon = "rbxassetid://11425687336"
			},
			{
				Cost = 20000,
				HealthIncrease = 1000,
				RangeIncrease = 0,
				NearbyTowerFirerateBuffIncrease = 0.1,
				NearbyTowerRangeBuffIncrease = 0.1,
				AbilityNames = { Enums.TowerAbilities.SuperEncore },
				Description = "Showdown",
				Icon = "rbxassetid://15422310713",
				UpgradeIcon = "rbxassetid://11425686915"
			}
		},
		Path2Data = {
			{
				Cost = 850,
				HealthIncrease = 20,
				RangeIncrease = 1,
				NearbyTowerRangeBuffIncrease = 0.05,
				Description = "Sound Effects",
				Icon = "rbxassetid://15422312226",
				UpgradeIcon = "rbxassetid://11425688833"
			},
			{
				Cost = 1100,
				HealthIncrease = 50,
				RangeIncrease = 0,
				NearbyTowerRangeBuffIncrease = 0.05,
				Description = "Nice Rhythm",
				Icon = "rbxassetid://15422312059",
				UpgradeIcon = "rbxassetid://11425688567"
			},
			{
				Cost = 3250,
				HealthIncrease = 175,
				RangeIncrease = 0,
				NearbyTowerDiscountIncrease = 0.1,
				NearbyTowerSellbackIncrease = 0.1,
				Description = "Budget Costs",
				Icon = "rbxassetid://15422311885",
				UpgradeIcon = "rbxassetid://11425687549"
			},
			{
				Cost = 7000,
				HealthIncrease = 500,
				RangeIncrease = 1,
				NearbyTowerDiscountIncrease = 0.1,
				NearbyTowerRangeBuffIncrease = 0.05,
				Description = "Cosplay Party",
				Icon = "rbxassetid://15422311432",
				UpgradeIcon = "rbxassetid://11425688079"
			},
			{
				Cost = 16000,
				HealthIncrease = 1100,
				RangeIncrease = 2,
				NearbyTowerDiscountIncrease = 0.1,
				NearbyTowerSellbackIncrease = 0.05,
				Description = "DJ Rave",
				Icon = "rbxassetid://15422311002",
				HoverDescriptionAdditions = "NEARBY TOWER ABILITY COOLDOWNS REDUCED BY 15%",
				UpgradeIcon = "rbxassetid://11425687077"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 3,
	Radius = 1.75,
	RotationOffset = CFrame.Angles(0, 0, 0),
	OverrideDisplayStats = {
		"NearbyTowerFirerateBuff",
		"NearbyTowerRangeBuff",
		"NearbyTowerDiscount",
		"NearbyTowerSellback",
		"Range"
	}
}
EDJ.TowerUpgradeShopData = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		Cost = 100,
		CostIncreasePerLevel = 275,
		Amount = 5
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		Cost = 275,
		CostIncreasePerLevel = 125,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.RangeBuff,
		Cost = 350,
		CostIncreasePerLevel = 150,
		Amount = 0.1
	},
	{
		Type = Enums.TowerUpgradeShopTypes.NearbyTowerSellbackValue,
		Cost = 250,
		CostIncreasePerLevel = 100,
		Amount = 0.05
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		Cost = 400,
		CostIncreasePerLevel = 250,
		Amount = 0.15
	}
}
return EDJ