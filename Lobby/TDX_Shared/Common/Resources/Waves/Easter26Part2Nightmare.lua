local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Easter Night (Nightmare)",
	DefeatScreenRenderName = "Easter26",
	PlayerCountToStartingCashMap = { 120000, 70000, 45000, 37500 },
	CashPerDamageData = {
		{ CashPerDamage = 1.3, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.65, CashPerDamageShared = 0.2 }
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
		{ WaveNumber = 1, GoldReward = 100, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 225, TokensReward = 75 },
		{ WaveNumber = 4, GoldReward = 250, TokensReward = 100 },
		{ WaveNumber = 7, GoldReward = 350, TokensReward = 150 },
		{ WaveNumber = 10, GoldReward = 550, TokensReward = 195 },
		{ WaveNumber = 12, GoldReward = 675, TokensReward = 250 },
		{ WaveNumber = 15, GoldReward = 875, TokensReward = 350 },
		{ WaveNumber = 18, GoldReward = 1200, TokensReward = 425 },
		{ WaveNumber = 19, GoldReward = 2100, TokensReward = 750 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 15000,
			GainHP = 1200
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 25000,
			GainHP = 1500
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 35000,
			GainHP = 1750
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 50000,
			GainHP = 2500
		},
		{
			WaveNumber = 12,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 100000,
			GainHP = 5000
		},
		{
			WaveNumber = 16,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 175000,
			GainHP = 12500
		},
		{
			WaveNumber = 18,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 250000,
			GainHP = 20000
		}
	},
	DefaultXPPerWavePassed = 625,
	VictoryBadgeIds = { 4397029998896997 },
	StartingLives = 67,
	SetUpTime = 25,
	PowerUpsDisabled = true,
	WaveSkippingDisabled = true,
	PreloadEnemyNames = { Enums.Enemies.RavagedPredator, Enums.Enemies.EasterEngineer },
	TowerCostMultiplierMap = { [Enums.Towers.Ranger] = 0.3 },
	AmbientPlaylist = {
		"Easter26_1",
		"Easter26_2",
		"Easter26_3",
		"Easter26_4",
		"Easter26_5",
		"Easter26_6",
		"Easter26_7",
		"Easter26_8",
		"HalloweenNight2_1",
		"HalloweenNight2_2",
		"HalloweenNight2_3",
		"HalloweenNight2_4"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobNormal,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 30,
					Interval = 1.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 6,
					SpawnOnAllPaths = true,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.PsychomobNormal,
					Count = 40,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 50,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 10,
					AdditionalSpeedBoostMultiplier = 0.2,
					SpawnOnAllPaths = true,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 1600,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 20,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 38,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 0.25
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Judge,
					Count = 2,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 12
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 5,
					AdditionalShieldMultiplier = 0.3,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 0.25
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.DuckHunter, Count = 15, Interval = 1.5 }
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TerryTheBunny,
					Count = 12,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 90,
					Interval = 0.2
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 10,
					AdditionalShieldMultiplier = 0.2,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1800,
			CashMultiplierOverride = 2,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 150,
					Interval = 0.35
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Zealot,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 1,
					Count = 10,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 6,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.Shady, Count = 4, Interval = 0.8 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.NailHead,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 12
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 150,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 136,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 1900,
			CashMultiplierOverride = 1,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Diabolist,
					Count = 25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 90,
					AdditionalShieldMultiplier = 1,
					Interval = 0.3
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 90,
					AdditionalShieldMultiplier = 1,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 28000,
			CustomWaveTime = 250,
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RavagedPredator,
					AdditionalShieldMultiplier = 0.25,
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedPredatorNightmare,
					AdditionalHealthMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Heretic,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 2100,
			CashMultiplierOverride = 1.5,
			CustomWaveTime = 160,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.PapaDuck, Count = 14, Interval = 5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.NailHead,
					Count = 4,
					AdditionalShieldMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 9
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.DuckHunter,
					AdditionalSpeedBoostMultiplier = 1,
					SpawnOnAllPaths = true,
					Count = 25,
					Interval = 2
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 12,
					AdditionalShieldMultiplier = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 10000,
			CashMultiplierOverride = 1,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RavagedPredator,
					Count = 7,
					ForcePathIndices = { 3, 4 },
					AdditionalSpeedBoostMultiplier = 0.4,
					Interval = 2.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 3,
					Count = 50,
					Interval = 1
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.NailHead,
					Count = 2,
					AdditionalHealthMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 2300,
			CustomWaveTime = 240,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 45,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.2,
					Count = 85,
					Interval = 0.2
				},
				{
					StartDelay = 4.2,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 10,
					SpawnOnAllPaths = true,
					Interval = 4
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.NailHead,
					Count = 4,
					SpawnOnAllPaths = true,
					Interval = 9
				}
			}
		},
		{
			CashBonus = 2400,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Hatchling3,
					Count = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.2,
					SpawnOnAllPaths = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 2500,
			CustomWaveTime = 140,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 3,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Hatchling3,
					Count = 5,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.2,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 2600,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Hatchling3,
					Count = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					SpawnOnAllPaths = true,
					Interval = 0.5
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 3,
					AdditionalShieldMultiplier = 1.5,
					AdditionalSpeedBoostMultiplier = 0.3,
					Interval = 2.3
				}
			}
		},
		{
			CashBonus = 2700,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Shady,
					Stealth = true,
					Count = 15,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PapaDuck,
					Count = 14,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalHealthMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 85,
					AdditionalShieldMultiplier = 1.5,
					AdditionalSpeedBoostMultiplier = 0.4,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.2,
					Count = 120,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 40000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier3,
					SpawnOnAllPaths = true,
					Count = 4,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBBoss4,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.MultiplierT,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 2800,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Shady,
					Stealth = true,
					AdditionalShieldMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 50,
					Interval = 0.6
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					Stealth = true,
					AdditionalShieldMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 2900,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.WallPusher,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 15,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 20,
					AdditionalSpeedBoostMultiplier = 0.8,
					SpawnOnAllPaths = true,
					Count = 2,
					Interval = 8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.NailHead,
					AdditionalShieldMultiplier = 5,
					SpawnOnAllPaths = true,
					Count = 2,
					Interval = 15
				}
			}
		},
		{
			CashBonus = 40000,
			CashMultiplierOverride = 0.45,
			CustomWaveTime = 550,
			OverrideXP = 3500,
			OverrideAmbientPlaylist = { "BunnyZillaWaveMusic" },
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyZilla,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 0.2,
					Count = 1,
					ForcePathIndices = { 3, 4 },
					Interval = 0.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.DuckHunter,
					AdditionalSpeedBoostMultiplier = 0.7,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 0.2,
					SpawnOnAllPaths = true,
					Count = 20,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.BunnyTank900,
					Count = 1,
					AdditionalShieldMultiplier = 0.25,
					ForcePathIndices = { 3 },
					Interval = 3
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.BunnyTank900,
					Count = 1,
					AdditionalShieldMultiplier = 0.25,
					ForcePathIndices = { 4 },
					Interval = 3
				}
			}
		},
		{
			CashBonus = 300000,
			CashMultiplierOverride = 0.7,
			OverrideXP = 11000,
			CustomWaveTime = 550,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.EasterEngineer,
					AdditionalShieldMultiplier = 3,
					AdditionalHealthMultiplier = 0.5,
					Count = 1,
					Interval = 0.5,
					ForcePathIndices = { 5 }
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.RavagedPredator,
					AdditionalHealthMultiplier = 0.5,
					Count = 5,
					Interval = 1.5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.BunnyOTron,
					ForcePathIndices = { 3 },
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.BunnyOTron,
					ForcePathIndices = { 4 },
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyGuardian,
					AdditionalShieldMultiplier = 0.25,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 4
				}
			}
		}
	}
}