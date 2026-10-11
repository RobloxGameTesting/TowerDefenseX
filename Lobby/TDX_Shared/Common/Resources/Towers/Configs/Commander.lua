local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	AttackEnabledByAbility = true,
	AttackEnabledDefaultAnimation = "Idle_AttackEnabled",
	AttackDisabledAnimation = "AttackDisabled",
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 1250,
			Health = 300,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 20,
			IgnoreResistance = true,
			ReloadTime = 1,
			Range = 8,
			StealthDetection = false,
			NearbyTowerRangeBuff = 0.05,
			NearbyTowerDamageBuff = 0.05,
			BuffUseDamage2 = true,
			PlacementDisplayDashedRange = true,
			IgnoreObstacles = true,
			Description = "Base",
			Icon = "rbxassetid://18450192904"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 500,
				HealthIncrease = 15,
				RangeIncrease = 5,
				Description = "Stronger Signals",
				Icon = "rbxassetid://18450192722",
				UpgradeIcon = "rbxassetid://18462087894"
			},
			{
				Cost = 1500,
				HealthIncrease = 25,
				RangeIncrease = 0,
				NearbyTowerRangeBuffIncrease = 0.05,
				Description = "Range training",
				Icon = "rbxassetid://18450192539",
				UpgradeIcon = "rbxassetid://18462087894"
			},
			{
				Cost = 4300,
				HealthIncrease = 150,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.CommanderCTA1 },
				Description = "Call To Arms",
				Icon = "rbxassetid://18450192285",
				UpgradeIcon = "rbxassetid://18462087894"
			},
			{
				Cost = 8000,
				HealthIncrease = 350,
				RangeIncrease = 0,
				NearbyTowerDamageBuffIncrease = 0.02,
				NearbyTowerRangeBuffIncrease = 0.1,
				AbilityNames = { Enums.TowerAbilities.CommanderCTA2, Enums.TowerAbilities.CommanderAPC },
				Description = "Organized Militia",
				Icon = "rbxassetid://18450192063",
				UpgradeIcon = "rbxassetid://18462087894"
			},
			{
				Cost = 28000,
				HealthIncrease = 1250,
				RangeIncrease = 8,
				NearbyTowerDamageBuffIncrease = 0.03,
				NearbyTowerRangeBuffIncrease = 0.2,
				AbilityNames = {
					Enums.TowerAbilities.CommanderCTA3,
					Enums.TowerAbilities.CommanderAPC,
					Enums.TowerAbilities.CommanderAirStrike
				},
				AddSpawnPathEntityData = {
					{
						PathEntityType = Enums.PathEntities.APC,
						StartDelay = 45,
						Interval = 85,
						BurstSize = 1,
						BurstInterval = 1,
						MaximumCount = 3
					}
				},
				Description = "Airstrike",
				Icon = "rbxassetid://18450191865",
				UpgradeIcon = "rbxassetid://18462087894"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	GunModelName = "Gun",
	MaxObstacleHeight = 3,
	Radius = 1.5,
	HoverHeight = 2.274,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	OverrideDisplayStats = { "NearbyTowerRangeBuff", "NearbyTowerDamageBuff", "Range" },
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 175,
			CostIncreasePerLevel = 150,
			Amount = 4.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Damage,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.Range,
			Cost = 325,
			CostIncreasePerLevel = 175,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.DamageBuff,
			Cost = 500,
			CostIncreasePerLevel = 850,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.RangeBuff,
			Cost = 350,
			CostIncreasePerLevel = 150,
			Amount = 0.1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 550,
			CostIncreasePerLevel = 325,
			Amount = 0.15
		}
	}
}