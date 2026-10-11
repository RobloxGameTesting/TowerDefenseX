local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Tower Battles Part 2 (Nightmare)",
	DisplayNameShort = "TB II Nightmare",
	DifficultyVoteScreenV2Icon = "rbxassetid://110410820739533",
	DifficultyVoteScreenV2Title = "Nightmare",
	VictoryScreenRenderName = "TBPart2",
	DefeatScreenRenderName = "TBPart2",
	PlayerCountToStartingCashMap = { 15000, 9000, 7250, 6000 },
	CashPerDamageData = {
		{ CashPerDamage = 1, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.85, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.6, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.4, CashPerDamageShared = 0.25 }
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
		{ WaveNumber = 1, CrystalsReward = 1, TokensReward = 2 },
		{ WaveNumber = 3, CrystalsReward = 10, TokensReward = 45 },
		{ WaveNumber = 5, CrystalsReward = 20, TokensReward = 75 },
		{ WaveNumber = 7, CrystalsReward = 30, TokensReward = 125 },
		{ WaveNumber = 10, CrystalsReward = 35, TokensReward = 150 },
		{ WaveNumber = 14, CrystalsReward = 50, TokensReward = 250 },
		{ WaveNumber = 17, CrystalsReward = 75, TokensReward = 325 },
		{ WaveNumber = 21, CrystalsReward = 100, TokensReward = 425 },
		{ WaveNumber = 26, CrystalsReward = 150, TokensReward = 625 },
		{ WaveNumber = 31, CrystalsReward = 175, TokensReward = 800 },
		{ WaveNumber = 36, CrystalsReward = 200, TokensReward = 1000 },
		{ WaveNumber = 40, CrystalsReward = 225, TokensReward = 1450 },
		{ WaveNumber = 46, CrystalsReward = 250, TokensReward = 1600 },
		{ WaveNumber = 48, CrystalsReward = 300, TokensReward = 2500 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 1000,
			GainHP = 150
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 2500,
			GainHP = 200
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 5000,
			GainHP = 300
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 7000,
			GainHP = 400
		},
		{
			WaveNumber = 11,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 10000,
			GainHP = 500
		},
		{
			WaveNumber = 15,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 22000,
			GainHP = 750
		},
		{
			WaveNumber = 20,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 30000,
			GainHP = 1500
		},
		{
			WaveNumber = 25,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 50000,
			GainHP = 2500
		},
		{
			WaveNumber = 30,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 75000,
			GainHP = 4000
		},
		{
			WaveNumber = 35,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 100000,
			GainHP = 5000
		},
		{
			WaveNumber = 40,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_105,
			GainCash = 150000,
			GainHP = 7000
		},
		{
			WaveNumber = 47,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_125,
			GainCash = 250000,
			GainHP = 10000
		}
	},
	DefaultXPPerWavePassed = 700,
	VictoryBadgeIds = { 1878006087643446 },
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "ExegesisBase", "GenesisBase" },
	SetUpTime = 30,
	PowerUpsDisabled = true,
	PreloadEnemyNames = {},
	AmbientPlaylist = {
		"TB2_1",
		"TB2_2",
		"TB2_3",
		"TB2_4",
		"TB2_5",
		"TB2_6",
		"TB2_7",
		"TB2_8",
		"TB2_9",
		"TB2_10",
		"TB2_11",
		"TB2_12",
		"TB2_13",
		"TB2_14",
		"TB2_15",
		"TB2_16",
		"TB2_17",
		"TB2_18",
		"TB2_19",
		"TB2_20"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Normal, Count = 17, Interval = 0.9 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Slow, Count = 4, Interval = 5 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.TB2Speed, Count = 2, Interval = 8 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Normal, Count = 20, Interval = 0.7 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 1600,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Slow, Count = 7, Interval = 2.5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 7
				},
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Speed, Count = 15, Interval = 2 }
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 45,
			SpawnSequences = {
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Speed, Count = 75, Interval = 0.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Slow, Count = 14, Interval = 2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Cyst, Count = 4, Interval = 0.7 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.Cyst, Count = 3, Interval = 0.6 }
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Nosowy,
					Count = 4,
					AdditionalShieldMultiplier = 0.5,
					Interval = 8
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Normal, Count = 28, Interval = 0.7 }
			}
		},
		{
			CashBonus = 2100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss1, Count = 4, Interval = 6 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Cyst, Count = 12, Interval = 2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Normal, Count = 25, Interval = 0.5 }
			}
		},
		{
			CashBonus = 2200,
			CustomWaveTime = 40,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Nosowy,
					Count = 3,
					AdditionalShieldMultiplier = 0.5,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 2,
					Interval = 3
				},
				{ StartDelay = 14, EnemyType = Enums.Enemies.TB2Boss1, Count = 2, Interval = 2.5 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Cyst, Count = 14, Interval = 2 }
			}
		},
		{
			CashBonus = 2300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 5.3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Malice, Count = 2, Interval = 7 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Boss1, Count = 4, Interval = 7 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TB2Slow, Count = 30, Interval = 0.7 }
			}
		},
		{
			CashBonus = 2400,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Shade, Count = 7, Interval = 1.25 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Stealth = true,
					Count = 1,
					Interval = 7
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.Cyst, Count = 8, Interval = 3 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 3, Interval = 7 }
			}
		},
		{
			CashBonus = 3000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MysteryV, Count = 24, Interval = 1 },
				{ StartDelay = 13, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 0.7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cyst, Count = 8, Interval = 3 }
			}
		},
		{
			CashBonus = 3250,
			CustomWaveTime = 70,
			SpawnSequences = {
				{ StartDelay = 7, EnemyType = Enums.Enemies.Malignant, Count = 1, Interval = 18 },
				{ StartDelay = 21, EnemyType = Enums.Enemies.Cyst, Count = 6, Interval = 3 },
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.Nosowy, Count = 11, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss1, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 3500,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 2, Interval = 12 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Cyst, Count = 8, Interval = 1 },
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Boss2, Count = 6, Interval = 4 },
				{ StartDelay = 28, EnemyType = Enums.Enemies.Nosowy, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 3750,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Malignant, Count = 2, Interval = 18 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Nosowy, Count = 5, Interval = 0.7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 1, Interval = 15 }
			}
		},
		{
			CashBonus = 4000,
			CashMultiplierOverride = 0.4,
			CustomWaveTime = 40,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Boss2, Count = 20, Interval = 4.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 4, Interval = 26 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.TB2Speed,
					Count = 60,
					AdditionalHealthMultiplier = 0.2,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 4500,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 12, Interval = 2 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.TB2Slow,
					Count = 30,
					AdditionalHealthMultiplier = 0.2,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 25,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slag, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 5500,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 15, Interval = 0.8 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Boss2, Count = 10, Interval = 3 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Cyst, Count = 15, Interval = 0.8 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Cyst, Count = 15, Interval = 0.8 }
			}
		},
		{
			CashBonus = 10000,
			OverrideXP = 1500,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.VoidLich,
					Count = 1,
					AdditionalShieldMultiplier = 0.4,
					Interval = 3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 6, Interval = 2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Slag, Count = 14, Interval = 1 }
			}
		},
		{
			CashBonus = 6500,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Tumor, Count = 1, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 3, Interval = 1 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Malice, Count = 6, Interval = 0.7 }
			}
		},
		{
			CashBonus = 7000,
			CustomWaveTime = 70,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Malignant, Count = 5, Interval = 5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 6.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.MysteryV, Count = 30, Interval = 0.8 }
			}
		},
		{
			CashBonus = 8000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 18,
					AdditionalSpeedBoostMultiplier = 0.7,
					Interval = 0.4
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					AdditionalHealthMultiplier = 0.2,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 3,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 9000,
			CustomWaveTime = 40,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SludgeBoss,
					Count = 1,
					Interval = 1.5,
					AdditionalShieldMultiplier = 0.3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slag, Count = 10, Interval = 0.7 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 7,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 70,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Tumor, Count = 1, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.SludgeBoss, Count = 1, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 11000,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Slag,
					Count = 30,
					Interval = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 11, Interval = 3 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Malignant, Count = 1, Interval = 1.5 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 25,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 12000,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 2,
					Interval = 8.5
				},
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.Neuron, Count = 3, Interval = 0.6 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Cyst,
					Count = 30,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Interval = 0.9
				}
			}
		},
		{
			CashBonus = 100000,
			CashMultiplierOverride = 0.9,
			OverrideXP = 2800,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBVoid,
					Count = 2,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 21.2
				},
				{ StartDelay = 35, EnemyType = Enums.Enemies.VoidWarden, Count = 2, Interval = 2.5 }
			}
		},
		{
			CashBonus = 13000,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Tumor,
					Count = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Interval = 6
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 1,
					Interval = 8.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 2, Interval = 7 }
			}
		},
		{
			CashBonus = 14000,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidWarden,
					Count = 7,
					Interval = 5.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 50,
					Interval = 0.7,
					AdditionalShieldMultiplier = 0.3
				}
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SuperSlow,
					Count = 1,
					Interval = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 6, Interval = 4 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.VoidWarden,
					Count = 5,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 8
				},
				{
					StartDelay = 27,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 2,
					Interval = 12
				}
			}
		},
		{
			CashBonus = 250000,
			CustomWaveTime = 500,
			OverrideXP = 3250,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidPrime, Count = 1, Interval = 64 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidTank, Count = 3, Interval = 6 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.VoidGuard, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 16000,
			CashMultiplierOverride = 0.4,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.SuperSlow, Count = 1, Interval = 8 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 50,
					Interval = 0.7
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.SludgeBoss, Count = 6, Interval = 7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 7, Interval = 3 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.Malignant,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 17000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalShieldMultiplier = 7,
					Count = 20,
					Interval = 0.4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Neuron,
					Count = 2,
					AdditionalShieldMultiplier = 1,
					Interval = 0.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Tumor,
					AdditionalShieldMultiplier = 0.35,
					Count = 4,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 19000,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.Blister, Count = 3, Interval = 12 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Anomalous, Count = 15, Interval = 2.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 21000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 15, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 23000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Blister, Count = 5, Interval = 7 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Cyst,
					Count = 50,
					AdditionalShieldMultiplier = 10,
					Interval = 0.5
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.VoidDozer, Count = 1, Interval = 12 }
			}
		},
		{
			CashBonus = 25000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidGolem,
					Count = 2,
					AdditionalShieldMultiplier = 0.5,
					Interval = 5
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.VoidDozer, Count = 1, Interval = 12 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Malice,
					Count = 16,
					AdditionalShieldMultiplier = 3,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 525000,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ExoVoid, Count = 1, Interval = 0.75 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidEmpress,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 16
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.Giant2, Count = 15, Interval = 3.5 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.SuperSlow, Count = 2, Interval = 12 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.VoidRunner, Count = 2, Interval = 5 },
				{ StartDelay = 80, EnemyType = Enums.Enemies.VoidGuard, Count = 2, Interval = 7 }
			}
		},
		{
			CashBonus = 29000,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidGolem,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Count = 5,
					Interval = 6
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.MegaHiddenBoss,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Malice,
					AdditionalShieldMultiplier = 40,
					Count = 16,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 30000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SpeedyBoss1,
					Count = 25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Blister, Count = 5, Interval = 6 }
			}
		},
		{
			CashBonus = 32000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidEmpress,
					AdditionalShieldMultiplier = 0.75,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.VoidRunner, Count = 3, Interval = 6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 20, Interval = 0.8 }
			}
		},
		{
			CashBonus = 34000,
			CustomWaveTime = 200,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					Count = 1,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Neuron,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 35,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 36000,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Neuron,
					Count = 40,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Malice, Count = 10, Interval = 0.3 },
				{ StartDelay = 18, EnemyType = Enums.Enemies.Malice, Count = 10, Interval = 0.3 }
			}
		},
		{
			CashBonus = 1500000,
			CashMultiplierOverride = 1.1,
			OverrideXP = 3800,
			CustomWaveTime = 1e999,
			SkipWaveDisabled = true,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidDevastator,
					Count = 1,
					AdditionalHealthMultiplier = 0.3,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 800000,
			CashMultiplierOverride = 0.8,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MegaHiddenBoss,
					Count = 2,
					Interval = 10
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Mystery, Count = 3, Interval = 3 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ShadyBoss,
					Count = 2,
					AdditionalShieldMultiplier = 0.2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 350000,
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidGuard,
					Count = 2,
					AdditionalShieldMultiplier = 0.2,
					Interval = 8
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.VoidTank,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidRunner, Count = 2, Interval = 8 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.MegaHiddenBoss,
					Count = 1,
					Interval = 10
				}
			}
		},
		{
			CashBonus = 500000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 80, Interval = 0.2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Malice, Count = 15, Interval = 0.5 }
			}
		},
		{
			CashBonus = 800000,
			CustomWaveTime = 160,
			SpawnSequences = {
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.VoidDozer,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 1.7
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 5,
					AdditionalShieldMultiplier = 0.4,
					Interval = 7
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.SuperSlow,
					Count = 8,
					AdditionalShieldMultiplier = 0.2,
					Interval = 5
				},
				{ StartDelay = 50, EnemyType = Enums.Enemies.VoidRunner, Count = 6, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Giant2, Count = 10, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidRunner, Count = 2, Interval = 8 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.VoidWarden,
					AdditionalShieldMultiplier = 2,
					Count = 5,
					Interval = 2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidGuard,
					Count = 4,
					AdditionalShieldMultiplier = 0.2,
					Interval = 8
				}
			}
		},
		{
			CashBonus = 800000,
			CustomWaveTime = 1e999,
			SkipWaveDisabled = true,
			OverrideXP = 5000,
			LockSpeedMultiplierTo1 = true,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{ StartDelay = 40, EnemyType = Enums.Enemies.Giant2, Count = 80, Interval = 5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidGod, Count = 1, Interval = 12 }
			}
		}
	}
}