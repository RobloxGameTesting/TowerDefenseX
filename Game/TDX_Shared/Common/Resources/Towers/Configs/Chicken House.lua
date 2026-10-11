local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	LimitMap = { 16, 16, 16, 16 },
	AttackDisabled = true,
	HasCustomCode = true,
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 100,
			Health = 50,
			CashPerTick = 4,
			CashTickDuration = 8,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 0,
			Range = 10,
			StealthDetection = false,
			BaitEnemyAttacks = true,
			IgnoreObstacles = true,
			Description = "BASE",
			Icon = "rbxassetid://0"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 75,
				HealthIncrease = 20,
				CashPerTickOverride = 4,
				CashTickDurationOverride = 7,
				Description = "MORE EGGS",
				Icon = "rbxassetid://0",
				UpgradeIcon = "rbxassetid://96040045734527"
			},
			{
				Cost = 105,
				HealthIncrease = 25,
				CashPerTickOverride = 5,
				CashTickDurationOverride = 7,
				Description = "MORE CHICKEN",
				Icon = "rbxassetid://0",
				UpgradeIcon = "rbxassetid://81065668111354"
			},
			{
				Cost = 125,
				HealthIncrease = 35,
				CashPerTickOverride = 6,
				CashTickDurationOverride = 6,
				Description = "STRONGER HOUSE",
				Icon = "rbxassetid://0",
				UpgradeIcon = "rbxassetid://136875381495740"
			},
			{
				Cost = 150,
				HealthIncrease = 40,
				CashPerTickOverride = 7,
				CashTickDurationOverride = 5,
				Description = "HOUSE-X",
				Icon = "rbxassetid://0",
				UpgradeIcon = "rbxassetid://123259634251736"
			},
			{
				Cost = 250,
				HealthIncrease = 150,
				CashPerTickOverride = 12,
				CashTickDurationOverride = 3,
				Description = "chicken",
				Icon = "rbxassetid://0",
				UpgradeIcon = "rbxassetid://82762958220877"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	Radius = 3,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	RangeDisabled = true,
	OverrideDisplayStats = { "BaitEnemyAttacks", "CashPerTick" },
	PrimaryMinorStat = {
		Key = "CashEarned",
		Icon = "rbxassetid://15498074414",
		FormatString = "$%d"
	},
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 1
		},
		{
			Type = Enums.TowerUpgradeShopTypes.CashPerSecond,
			Cost = 750,
			CostIncreasePerLevel = 1500,
			Amount = 0.5
		}
	},
	TowerUpgradeShopTabIcon = "rbxassetid://139642874836925"
}