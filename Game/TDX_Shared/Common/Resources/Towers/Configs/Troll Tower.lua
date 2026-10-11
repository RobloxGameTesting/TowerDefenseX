local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 75,
			Health = 100,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 7,
			StealthDetection = false,
			BaitEnemyAttacks = true,
			IgnoreObstacles = true,
			Description = "",
			Icon = "rbxassetid://84077749941668"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 5,
				HealthIncrease = 15,
				RangeIncrease = 0,
				Description = "something",
				Icon = "rbxassetid://84077749941668",
				UpgradeIcon = "rbxassetid://122773859609688"
			},
			{
				Cost = 10,
				HealthIncrease = 15,
				RangeIncrease = 0,
				Description = "yeah HP...",
				Icon = "rbxassetid://84077749941668",
				UpgradeIcon = "rbxassetid://122773859609688"
			},
			{
				Cost = 300,
				HealthIncrease = 20,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.TrollTowerRandomAbility1 },
				Description = "roblox",
				Icon = "rbxassetid://84077749941668",
				UpgradeIcon = "rbxassetid://122773859609688"
			},
			{
				Cost = 700,
				HealthIncrease = 25,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.TrollTowerRandomAbility2 },
				Description = "cheese",
				Icon = "rbxassetid://84077749941668",
				UpgradeIcon = "rbxassetid://122773859609688"
			},
			{
				Cost = 1000,
				HealthIncrease = 200,
				RangeIncrease = 0,
				AbilityNames = { Enums.TowerAbilities.TrollTowerRandomAbility3 },
				Description = "hang on guys let me think of a name",
				Icon = "rbxassetid://84077749941668",
				UpgradeIcon = "rbxassetid://122773859609688"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 3,
	RangeDisabled = true,
	HasCustomCode = true,
	Radius = 1.35,
	HoverHeight = 1.794,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	NoDefaultDeathEffect = true,
	OverrideDisplayStats = { "BaitEnemyAttacks", "Health" },
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 150,
			CostIncreasePerLevel = 50,
			Amount = 0.5
		},
		{
			Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
			Cost = 100,
			CostIncreasePerLevel = 50,
			Amount = 0.1
		}
	}
}