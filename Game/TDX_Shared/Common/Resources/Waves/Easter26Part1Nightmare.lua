local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Easter Day (Nightmare)",
	DefeatScreenRenderName = "Easter26",
	PlayerCountToStartingCashMap = { 26000, 13000, 10000, 9000 },
	CashPerDamageData = {
		{ CashPerDamage = 1.1, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.65, CashPerDamageShared = 0.25 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 20, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.25, CashPerDamageShared = 0 },
		{ MaxLevel = 50, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 70, CashPerDamage = 0.15, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.1, CashPerDamageShared = 0 },
		{ MaxLevel = 100, CashPerDamage = 0.1, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 100, TokensReward = 75 },
		{ WaveNumber = 2, GoldReward = 200, TokensReward = 150 },
		{ WaveNumber = 3, GoldReward = 300, TokensReward = 225 },
		{ WaveNumber = 4, GoldReward = 400, TokensReward = 300 },
		{ WaveNumber = 5, GoldReward = 800, TokensReward = 485 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 5000,
			GainHP = 250
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 10000,
			GainHP = 450
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 15000,
			GainHP = 750
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 25000,
			GainHP = 1250
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 10000,
			GainHP = 2500
		}
	},
	DefaultXPPerWavePassed = 850,
	VictoryBadgeIds = { 188331636533071 },
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "EasterCastrumBase" },
	SetUpTime = 35,
	PowerUpsDisabled = true,
	WaveSkippingDisabled = true,
	PreloadEnemyNames = {},
	AmbientPlaylist = {
		"Easter26_1",
		"Easter26_2",
		"Easter26_3",
		"Easter26_4",
		"Easter26_5",
		"Easter26_6",
		"Easter26_7",
		"Easter26_8"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 360,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling3,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 2550,
					Interval = 0.08
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Terry,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 200,
					Interval = 0.8
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.BunnyGangNormal,
					Count = 12,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 8.5
				},
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.Berry,
					AdditionalShieldMultiplier = 1.5,
					Count = 6,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 550,
			SpawnSequences = {
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Eggling2,
					Count = 500,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling3,
					Count = 300,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 5,
					Interval = 0.04
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 230,
					AdditionalSpeedBoostMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.25,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Berry,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 1.5,
					Count = 25,
					Stealth = true,
					Interval = 7
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.BunnyGangNormal,
					Count = 60,
					AdditionalSpeedBoostMultiplier = 0.35,
					Interval = 4
				},
				{ StartDelay = 140, EnemyType = Enums.Enemies.MamaDuck, Count = 1, Interval = 3 },
				{ StartDelay = 225, EnemyType = Enums.Enemies.BigEntling, Count = 1, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Eggling1,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 18,
					Interval = 13
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling4,
					Count = 200,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 0.5
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 300,
					AdditionalSpeedBoostMultiplier = 0.85,
					AdditionalShieldMultiplier = 0.8,
					Interval = 0.8
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.BabyDuck, Count = 70, Interval = 3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Eggling1, Count = 27, Interval = 6 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.LilEntling, Count = 5, Interval = 3 },
				{ StartDelay = 75, EnemyType = Enums.Enemies.LilEntling, Count = 7, Interval = 3 },
				{ StartDelay = 110, EnemyType = Enums.Enemies.LilEntling, Count = 9, Interval = 3 },
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.Berry,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 45,
					Interval = 4.5
				},
				{ StartDelay = 150, EnemyType = Enums.Enemies.LilEntling, Count = 12, Interval = 3 },
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.BigEntling,
					Count = 5,
					AdditionalShieldMultiplier = 0.25,
					Interval = 15
				},
				{ StartDelay = 230, EnemyType = Enums.Enemies.LilEntling, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 0,
			CashMultiplierOverride = 1.5,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 225,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 1.2,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Berry,
					Count = 60,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 4.2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.BabyDuck,
					Count = 70,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling1,
					Count = 22,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.1,
					Interval = 6
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.LilEntling,
					Count = 30,
					AdditionalShieldMultiplier = 1.5,
					Interval = 3
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.MamaDuck,
					Count = 7,
					AdditionalShieldMultiplier = 0.3,
					Interval = 10
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.BigEntling,
					Count = 8,
					AdditionalShieldMultiplier = 0.85,
					Interval = 7
				},
				{
					StartDelay = 72,
					EnemyType = Enums.Enemies.MamaDuck,
					Count = 7,
					AdditionalShieldMultiplier = 0.3,
					Interval = 12
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.LilEntling,
					AdditionalSpeedBoostMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.8,
					SpawnOnAllPaths = true,
					Count = 17,
					Interval = 1.25
				}
			}
		},
		{
			CashBonus = 175000,
			CashMultiplierOverride = 3.75,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyOTron,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 1.2
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.BunnyOTron,
					Count = 1,
					ForcePathIndices = { 2 },
					Interval = 1.2
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.BigEntling,
					Count = 5,
					SpawnOnAllPaths = true,
					Interval = 18
				}
			}
		}
	}
}