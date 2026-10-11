local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	AttackDisabled = true,
	UpgradePathData = {
		OnePathOnly = true,
		BaseLevelData = {
			Cost = 50,
			Health = 101,
			DamageType = Enums.DamageTypes.Bullet,
			Damage = 0,
			ReloadTime = 1,
			Range = 8,
			StealthDetection = false,
			BaitEnemyAttacks = true,
			IgnoreObstacles = true,
			Description = "",
			Icon = "rbxassetid://98515408612676"
		},
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 5,
				HealthIncrease = 15,
				RangeIncrease = 0,
				Description = "MORE HP",
				Icon = "rbxassetid://74909192021308",
				UpgradeIcon = "rbxassetid://76308581265344"
			},
			{
				Cost = 10,
				HealthIncrease = 15,
				RangeIncrease = 0,
				Description = "MORE HP...",
				Icon = "rbxassetid://110234265568659",
				UpgradeIcon = "rbxassetid://76308581265344"
			},
			{
				Cost = 15,
				HealthIncrease = 20,
				RangeIncrease = 0,
				Description = "EVEN MORE HP...",
				Icon = "rbxassetid://140542248450738",
				UpgradeIcon = "rbxassetid://76308581265344"
			},
			{
				Cost = 20,
				HealthIncrease = 25,
				RangeIncrease = 0,
				Description = "YOU KNOW WHAT IT IS",
				Icon = "rbxassetid://104099404412803",
				UpgradeIcon = "rbxassetid://76308581265344"
			},
			{
				Cost = 25,
				HealthIncrease = 50,
				RangeIncrease = 0,
				Description = "WE KNOW",
				Icon = "rbxassetid://93221706029177",
				UpgradeIcon = "rbxassetid://140691315859650"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	MaxObstacleHeight = 3,
	RangeDisabled = true,
	HasCustomCode = true,
	Radius = 1.35,
	HoverHeight = 1.384,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoDefaultDeathEffect = true,
	OverrideDisplayStats = { "BaitEnemyAttacks", "Health" },
	BannedInPVP = true,
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 50,
			CostIncreasePerLevel = 15,
			Amount = 0.5
		}
	}
}