local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local baseLevelData = {
	Cost = 575,
	Health = 800,
	CashPerWave = 0,
	CashPerTick = 45,
	CashTickDuration = 6,
	CashPerDamageMultiplier = 0,
	GoldWinBonus = 0,
	DamageType = Enums.DamageTypes.Bullet,
	Damage = 0,
	ReloadTime = 0.1,
	Range = 10,
	StealthDetection = false,
	Description = "Base",
	Icon = "rbxassetid://107232507317127"
}
return {
	AttackDisabled = true,
	LimitMap = { 4, 3, 2, 2 },
	DifficultyToLimitMapOverride = {
		[Enums.Difficulties.TBPart2Voidmare] = { 4, 2, 1, 1 }
	},
	UpgradePathData = {
		BaseLevelData = baseLevelData,
		PathLockLevel = 3,
		Path1Data = {
			{
				Cost = 400,
				HealthIncrease = 150,
				CashPerTickOverride = 65,
				CashTickDurationOverride = 6,
				Description = "Extra Gas Cans",
				Icon = "rbxassetid://132466748025923",
				UpgradeIcon = "rbxassetid://75374080398575"
			},
			{
				Cost = 1500,
				HealthIncrease = 200,
				CashPerTickOverride = 135,
				CashTickDurationOverride = 6,
				Description = "Oil Barrels",
				Icon = "rbxassetid://110569383837001",
				UpgradeIcon = "rbxassetid://119507257492974"
			},
			{
				Cost = 6500,
				HealthIncrease = 700,
				CashPerTickOverride = 295,
				CashTickDurationOverride = 6,
				Description = "Oil Drill",
				Icon = "rbxassetid://75223067216719",
				UpgradeIcon = "rbxassetid://100974014010257"
			},
			{
				Cost = 13000,
				HealthIncrease = 1800,
				CashPerTickOverride = 445,
				CashTickDurationOverride = 5,
				Description = "Supply Lines",
				Icon = "rbxassetid://139602173506951",
				UpgradeIcon = "rbxassetid://127949400517369"
			},
			{
				Cost = 40000,
				HealthIncrease = 4000,
				CashPerTickOverride = 605,
				CashTickDurationOverride = 4,
				Description = "USA Grade Oil",
				Icon = "rbxassetid://134723903177458",
				UpgradeIcon = "rbxassetid://124084188582428"
			}
		},
		Path2Data = {
			{
				Cost = 1550,
				HealthIncrease = 150,
				CashPerWaveIncrease = 200,
				Description = "US Bonds",
				Icon = "rbxassetid://132466748025923",
				UpgradeIcon = "rbxassetid://127183690154487"
			},
			{
				Cost = 5250,
				HealthIncrease = 250,
				CashPerWaveIncrease = 600,
				Description = "Extra Funding",
				Icon = "rbxassetid://110569383837001",
				UpgradeIcon = "rbxassetid://136255184893487"
			},
			{
				Cost = 12000,
				HealthIncrease = 1000,
				CashPerTickOverride = 175,
				CashPerWaveIncrease = 1000,
				CashPerDamageMultiplierIncrease = 0.03,
				Description = "Cash Back",
				Icon = "rbxassetid://90763102497093",
				UpgradeIcon = "rbxassetid://97998459059950"
			},
			{
				Cost = 38100,
				HealthIncrease = 1800,
				CashPerWaveIncrease = 2800,
				CashPerTickOverride = 250,
				CashPerDamageMultiplierIncrease = 0.05,
				Description = "War Budget",
				Icon = "rbxassetid://114558960735683",
				UpgradeIcon = "rbxassetid://111393976722036"
			},
			{
				Cost = 75000,
				HealthIncrease = 6000,
				CashPerWaveIncrease = 5000,
				CashPerTickOverride = 300,
				CashPerDamageMultiplierIncrease = 0.1,
				GoldWinBonusOverride = 200,
				Description = "US Military Budget",
				Icon = "rbxassetid://107904080641561",
				UpgradeIcon = "rbxassetid://103866775089426"
			}
		}
	},
	PlacementType = Enums.PlacementTypes.Ground,
	AnimationTimeScale = 1,
	Radius = 6,
	HoverHeight = 0,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	RangeDisabled = true,
	NoHeal = true,
	HasCustomCode = true,
	OverrideDisplayStats = {
		"CashPerTick",
		"CashPerDamageMultiplier",
		"GoldWinBonus",
		"CashPerWave"
	},
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
		},
		{
			Type = Enums.TowerUpgradeShopTypes.CashPerWave,
			Cost = 50,
			CostIncreasePerLevel = 25,
			Amount = 0.2
		}
	}
}