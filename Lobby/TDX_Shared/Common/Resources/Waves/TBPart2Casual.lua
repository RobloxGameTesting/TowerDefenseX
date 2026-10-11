local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Tower Battles Part 2 (Casual)",
	DifficultyVoteScreenV2Icon = "rbxassetid://114528682953062",
	DifficultyVoteScreenV2Title = "Casual",
	VictoryScreenRenderName = "TBPart2",
	DefeatScreenRenderName = "TBPart2",
	PlayerCountToStartingCashMap = { 28000, 16000, 14000, 11000 },
	CashPerDamageData = {
		{ CashPerDamage = 1.4, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.15, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.85, CashPerDamageShared = 0.3 }
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
		{ WaveNumber = 1, CrystalsReward = 1, TokensReward = 1 },
		{ WaveNumber = 3, CrystalsReward = 2, TokensReward = 35 },
		{ WaveNumber = 5, CrystalsReward = 4, TokensReward = 70 },
		{ WaveNumber = 7, CrystalsReward = 15, TokensReward = 100 },
		{ WaveNumber = 10, CrystalsReward = 25, TokensReward = 135 },
		{ WaveNumber = 14, CrystalsReward = 35, TokensReward = 235 },
		{ WaveNumber = 17, CrystalsReward = 70, TokensReward = 275 },
		{ WaveNumber = 21, CrystalsReward = 85, TokensReward = 325 },
		{ WaveNumber = 26, CrystalsReward = 100, TokensReward = 375 },
		{ WaveNumber = 31, CrystalsReward = 110, TokensReward = 400 },
		{ WaveNumber = 36, CrystalsReward = 130, TokensReward = 500 },
		{ WaveNumber = 40, CrystalsReward = 150, TokensReward = 600 },
		{ WaveNumber = 43, CrystalsReward = 200, TokensReward = 825 }
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
			GainCash = 4500,
			GainHP = 300
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7000,
			GainHP = 400
		},
		{
			WaveNumber = 11,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 9000,
			GainHP = 500
		},
		{
			WaveNumber = 15,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 15000,
			GainHP = 750
		},
		{
			WaveNumber = 20,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 25000,
			GainHP = 1500
		},
		{
			WaveNumber = 25,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 75000,
			GainHP = 2500
		},
		{
			WaveNumber = 30,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 100000,
			GainHP = 4000
		},
		{
			WaveNumber = 35,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 140000,
			GainHP = 5000
		},
		{
			WaveNumber = 40,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 170000,
			GainHP = 5000
		},
		{
			WaveNumber = 42,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 275000,
			GainHP = 8250
		}
	},
	DefaultXPPerWavePassed = 700,
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "ExegesisBase", "GenesisBase" },
	SetUpTime = 30,
	HasDialogueSequenceData = true,
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
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Slow, Count = 3, Interval = 5 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.TB2Speed, Count = 2, Interval = 8 }
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Normal, Count = 20, Interval = 0.9 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 1800,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Slow, Count = 5, Interval = 2.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TB2Normal, Count = 7, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 7
				},
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Speed, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 1900,
			SpawnSequences = {
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Speed, Count = 35, Interval = 0.9 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Slow, Count = 17, Interval = 2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Cyst, Count = 1, Interval = 0.7 }
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 2, Interval = 12 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Normal, Count = 28, Interval = 0.7 }
			}
		},
		{
			CashBonus = 2100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss1, Count = 3, Interval = 14 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Normal, Count = 19, Interval = 0.8 }
			}
		},
		{
			CashBonus = 2200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 3, Interval = 8 },
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.Malice,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 7
				},
				{ StartDelay = 14, EnemyType = Enums.Enemies.TB2Boss1, Count = 2, Interval = 6 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Cyst, Count = 3, Interval = 3 }
			}
		},
		{
			CashBonus = 2300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 5.3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Malice, Count = 1, Interval = 7 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Boss1, Count = 4, Interval = 8 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TB2Slow, Count = 30, Interval = 0.7 }
			}
		},
		{
			CashBonus = 2400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Shade, Count = 5, Interval = 2 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 4, Interval = 7 }
			}
		},
		{
			CashBonus = 3000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MysteryV, Count = 24, Interval = 1 }
			}
		},
		{
			CashBonus = 3250,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 7, EnemyType = Enums.Enemies.Malignant, Count = 1, Interval = 18 },
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.Nosowy, Count = 4, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss1, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 3500,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 2, Interval = 16 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Cyst, Count = 4, Interval = 1 },
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.TB2Boss2, Count = 6, Interval = 4 },
				{ StartDelay = 28, EnemyType = Enums.Enemies.Nosowy, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 3750,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Malignant, Count = 2, Interval = 24 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Nosowy, Count = 2, Interval = 0.7 }
			}
		},
		{
			CashBonus = 4000,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Boss2, Count = 20, Interval = 4.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 3, Interval = 26 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TB2Speed, Count = 60, Interval = 0.2 }
			}
		},
		{
			CashBonus = 4500,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 12, Interval = 2 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TB2Slow, Count = 30, Interval = 0.2 }
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slag, Count = 5, Interval = 2 }
			}
		},
		{
			CashBonus = 5500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 15, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TB2Boss2, Count = 10, Interval = 3 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Cyst, Count = 15, Interval = 0.8 }
			}
		},
		{
			CashBonus = 20000,
			OverrideXP = 1500,
			CustomWaveTime = 180,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.VoidLich, Count = 1, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 1, Interval = 2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Slag, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 6500,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Tumor, Count = 1, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Carcin, Count = 2, Interval = 2 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Malice, Count = 1, Interval = 0.7 }
			}
		},
		{
			CashBonus = 7000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Malignant, Count = 4, Interval = 6.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 6.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.MysteryV, Count = 20, Interval = 0.8 }
			}
		},
		{
			CashBonus = 8000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 18,
					Interval = 0.4
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					AdditionalHealthMultiplier = 0.2,
					AdditionalShieldMultiplier = 2,
					Count = 3,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 9000,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.SludgeBoss, Count = 1, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slag, Count = 7, Interval = 0.9 },
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
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Tumor, Count = 1, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.SludgeBoss, Count = 1, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 1, Interval = 6 }
			}
		},
		{
			CashBonus = 11000,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Slag, Count = 20, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 6, Interval = 5 },
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
					Count = 1,
					Interval = 8.5
				},
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.Neuron, Count = 1, Interval = 0.6 }
			}
		},
		{
			CashBonus = 350000,
			CashMultiplierOverride = 0.9,
			OverrideXP = 1500,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBVoid,
					AdditionalHealthMultiplier = 0.3,
					Count = 1,
					Interval = 21.2
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 1,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 13000,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Tumor, Count = 3, Interval = 6 },
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
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidTank, Count = 1, Interval = 5.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					Count = 50,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.SuperSlow, Count = 1, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 15, Interval = 4 },
				{
					StartDelay = 27,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 2,
					Interval = 19
				}
			}
		},
		{
			CashBonus = 800000,
			CustomWaveTime = 500,
			OverrideXP = 2500,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidPrime, Count = 1, Interval = 64 }
			}
		},
		{
			CashBonus = 25000,
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
				{ StartDelay = 0, EnemyType = Enums.Enemies.SludgeBoss, Count = 4, Interval = 12 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 3, Interval = 3 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.Malignant,
					AdditionalHealthMultiplier = 1.5,
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
					AdditionalShieldMultiplier = 2,
					Count = 20,
					Interval = 0.4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 2, Interval = 0.5 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Tumor,
					AdditionalShieldMultiplier = 0.2,
					Count = 2,
					Interval = 11
				}
			}
		},
		{
			CashBonus = 19000,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.Blister, Count = 2, Interval = 18 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Anomalous, Count = 15, Interval = 2.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 2, Interval = 9.5 }
			}
		},
		{
			CashBonus = 21000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 10, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VoidBerserker, Count = 1, Interval = 7 }
			}
		},
		{
			CashBonus = 23000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Blister, Count = 3, Interval = 0 }
			}
		},
		{
			CashBonus = 25000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidGolem, Count = 1, Interval = 5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Malice, Count = 16, Interval = 1 }
			}
		},
		{
			CashBonus = 1000000,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ExoVoid, Count = 1, Interval = 0.75 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidEmpress, Count = 1, Interval = 16 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Giant2, Count = 4, Interval = 9 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.VoidGolem, Count = 1, Interval = 5 }
			}
		},
		{
			CashBonus = 29000,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidGolem, Count = 5, Interval = 7 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Malice,
					AdditionalShieldMultiplier = 5,
					Count = 16,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 30000,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SpeedyBoss1, Count = 25, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Blister, Count = 5, Interval = 3 }
			}
		},
		{
			CashBonus = 32000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidEmpress, Count = 1, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 50, Interval = 0.7 }
			}
		},
		{
			CashBonus = 34000,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 160,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 9, Interval = 0.7 }
			}
		},
		{
			CashBonus = 500000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Neuron, Count = 30, Interval = 0.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Malice, Count = 10, Interval = 0.3 },
				{ StartDelay = 18, EnemyType = Enums.Enemies.Malice, Count = 10, Interval = 0.3 }
			}
		},
		{
			CashBonus = 800000,
			CashMultiplierOverride = 1,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidDevastator,
					Count = 1,
					Interval = 0.7
				}
			}
		}
	}
}