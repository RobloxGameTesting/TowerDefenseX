local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local baseLevelData = {
	Cost = 375,
	Health = 300,
	CashPerWave = 100,
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 0,
	ReloadTime = 0.1,
	Range = 10,
	StealthDetection = false,
	Description = "Base",
	Icon = "rbxassetid://12726253231"
}
return {
	AttackDisabled = true,
	LimitMap = { 10, 10, 10, 10 },
	DifficultyToLimitMapOverride = {
		[Enums.Difficulties.PVP_1V1] = { 5, 5, 5, 5 }
	},
	UpgradePathData = {
		BaseLevelData = baseLevelData,
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 50,
				HealthIncrease = 5,
				CashPerWaveIncrease = 0,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Precision Crates",
				Icon = "rbxassetid://12726252986",
				HoverDescriptionAdditions = "Crates drop 50% faster",
				UpgradeIcon = "rbxassetid://12726926301"
			},
			{
				Cost = 100,
				HealthIncrease = 5,
				CashPerWaveIncrease = 20,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "War Bonds",
				Icon = "rbxassetid://12726253082",
				UpgradeIcon = "rbxassetid://12726926431"
			},
			{
				Cost = 3000,
				HealthIncrease = 75,
				CashPerWaveIncrease = 150,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Medical Aid",
				HoverDescriptionAdditions = "Gain %dHP per crate",
				Icon = "rbxassetid://12726252816",
				UpgradeIcon = "rbxassetid://12726926169"
			},
			{
				Cost = 9750,
				HealthIncrease = 20,
				CashPerWaveIncrease = 175,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				GainPlacementDisplayDashedRange = true,
				Description = "Tower Economics",
				HoverDescriptionAdditions = "Gain 1% of value of nearby towers per crate (5000 MAX)",
				Icon = "rbxassetid://12726252451",
				UpgradeIcon = "rbxassetid://12726926080"
			},
			{
				Cost = 12500,
				HealthIncrease = 350,
				CashPerWaveIncrease = 1000,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Emergency Airdrop",
				HoverDescriptionAdditions = "Gain %dHP per crate",
				Icon = "rbxassetid://12726252100",
				UpgradeIcon = "rbxassetid://12726925911"
			}
		},
		Path2Data = {
			{
				Cost = 750,
				HealthIncrease = 5,
				CashPerWaveIncrease = 150,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "More Loot",
				Icon = "rbxassetid://12726253082",
				UpgradeIcon = "rbxassetid://12726925351"
			},
			{
				Cost = 1250,
				HealthIncrease = 5,
				CashPerWaveIncrease = 250,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Even More Loot",
				Icon = "rbxassetid://12726252986",
				UpgradeIcon = "rbxassetid://12726925153"
			},
			{
				Cost = 1850,
				HealthIncrease = 20,
				CashPerWaveIncrease = 375,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Valuable Goods",
				Icon = "rbxassetid://12726252673",
				UpgradeIcon = "rbxassetid://12726924879"
			},
			{
				Cost = 3250,
				HealthIncrease = 30,
				CashPerWaveIncrease = 550,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "GDA Funding",
				Icon = "rbxassetid://12726252315",
				UpgradeIcon = "rbxassetid://12726924655"
			},
			{
				Cost = 12750,
				HealthIncrease = 100,
				CashPerWaveIncrease = 300,
				DamageIncrease = 0,
				ReloadTimeDecrease = 0,
				RangeIncrease = 0,
				Description = "Double Crates",
				HoverDescriptionAdditions = "Crate count: 1 → 2",
				Icon = "rbxassetid://12726251972",
				UpgradeIcon = "rbxassetid://12726924487"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	NoAnimations = true,
	NoHead = true,
	NoTorso = true,
	Radius = 2,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	RangeDisabled = true,
	NoHeal = true,
	BaseCrateHP = 5,
	P1L3CrateHP = 25,
	P1L5CrateHP = 100,
	OverrideDisplayStats = { "CashPerWave" },
	PrimaryMinorStat = {
		Key = "CashEarned",
		Icon = "rbxassetid://15498074414",
		FormatString = "$%d"
	},
	TowerUpgradeShopData = {
		{
			Type = Enums.TowerUpgradeShopTypes.Health,
			Cost = 75,
			CostIncreasePerLevel = 25,
			Amount = 0.25
		},
		{
			Type = Enums.TowerUpgradeShopTypes.CashPerWave,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.2
		},
		{
			Type = Enums.TowerUpgradeShopTypes.HealthPerWave,
			Cost = 200,
			CostIncreasePerLevel = 100,
			Amount = 0.2
		}
	}
}