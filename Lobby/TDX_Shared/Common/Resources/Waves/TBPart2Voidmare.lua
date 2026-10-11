local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local towerCostMultiplierMap = {
	[Enums.Towers.CombatDrone] = 1.15,
	[Enums.Towers.Helicopter] = 1.1,
	[Enums.Towers.Farm] = 0.9
}
return {
	DisplayName = "Tower Battles Part 2 (Voidmare)",
	DisplayNameShort = "TB II Voidmare",
	DifficultyVoteScreenV2Icon = "rbxassetid://81701783098025",
	DifficultyVoteScreenV2Title = "Voidmare",
	VictoryScreenRenderName = "TBPart2",
	DefeatScreenRenderName = "TBPart2",
	PlayerCountToStartingCashMap = { 1380, 1130, 875, 675 },
	CashPerDamageData = {
		{ CashPerDamage = 1.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.45 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.65, CashPerDamageShared = 0.3 }
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
		{ WaveNumber = 1, CrystalsReward = 1, TokensReward = 3 },
		{ WaveNumber = 3, CrystalsReward = 3, TokensReward = 4 },
		{ WaveNumber = 9, CrystalsReward = 20, TokensReward = 50 },
		{ WaveNumber = 15, CrystalsReward = 25, TokensReward = 75 },
		{ WaveNumber = 20, CrystalsReward = 30, TokensReward = 125 },
		{ WaveNumber = 27, CrystalsReward = 40, TokensReward = 175 },
		{ WaveNumber = 35, CrystalsReward = 75, TokensReward = 250 },
		{ WaveNumber = 47, CrystalsReward = 90, TokensReward = 500 },
		{ WaveNumber = 50, CrystalsReward = 125, TokensReward = 800 },
		{ WaveNumber = 51, CrystalsReward = 500, TokensReward = 5000 }
	},
	DefaultXPPerWavePassed = 1045,
	VictoryBadgeIds = { 1474613594382081 },
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "ExegesisBase", "GenesisBase" },
	SetUpTime = 35,
	PowerUpsDisabled = true,
	SpeedControlDisabled = true,
	PreloadEnemyNames = {},
	TowerCostMultiplierMap = towerCostMultiplierMap,
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
			CashBonus = 300,
			CustomWaveTime = 45,
			CashMultiplierOverride = 1.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TB2Normal,
					AdditionalHealthMultiplier = -0.825,
					AdditionalShieldMultiplier = -5,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.TB2Normal,
					AdditionalHealthMultiplier = -0.825,
					AdditionalShieldMultiplier = -5,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalHealthMultiplier = -0.745,
					AdditionalShieldMultiplier = -4,
					Count = 5,
					Interval = 10
				}
			}
		},
		{
			CashBonus = 550,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.TB2Speed,
					AdditionalHealthMultiplier = -0.75,
					AdditionalShieldMultiplier = -4,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 4,
					Interval = 5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = -0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalHealthMultiplier = -0.745,
					AdditionalShieldMultiplier = -4,
					Count = 10,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 425,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Clot,
					AdditionalHealthMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 450,
			CustomWaveTime = 55,
			CashMultiplierOverride = 0.95,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalHealthMultiplier = -0.645,
					AdditionalShieldMultiplier = -4,
					Count = 12,
					Interval = 0.85
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TB2Speed,
					AdditionalHealthMultiplier = -0.8,
					AdditionalShieldMultiplier = -4,
					AdditionalSpeedBoostMultiplier = 0.2,
					Stealth = true,
					Count = 7,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 500,
			CustomWaveTime = 41,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidFragment, Count = 1, Interval = 1 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TBSpawn1,
					AdditionalHealthMultiplier = -0.99,
					Count = 12,
					Interval = 0.45
				}
			}
		},
		{
			CashBonus = 550,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TBNecromancer,
					AdditionalHealthMultiplier = 2,
					Count = 3,
					Interval = 15
				}
			}
		},
		{
			CashBonus = 575,
			CustomWaveTime = 45,
			CashMultiplierOverride = 0.75,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TB2Boss1,
					AdditionalHealthMultiplier = -0.5,
					AdditionalShieldMultiplier = -0.275,
					Count = 2,
					Interval = 5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNecromancer,
					AdditionalHealthMultiplier = 2,
					Count = 4,
					Interval = 10
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.VoidFragment, Count = 2, Interval = 5 }
			}
		},
		{
			CashBonus = 600,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Slow, Count = 15, Interval = 0.65 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TB2Slow, Count = 15, Interval = 0.65 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TB2Speed,
					AdditionalHealthMultiplier = -0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = -0.25,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 650,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TB2Speed,
					Stealth = true,
					Count = 10,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 1 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TB2Speed,
					AdditionalHealthMultiplier = -0.5,
					AdditionalShieldMultiplier = -4,
					Count = 10,
					Interval = 5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TBNecromancer,
					AdditionalHealthMultiplier = 3,
					Count = 3,
					Interval = 15
				},
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 15,
					Interval = 0.55
				},
				{
					StartDelay = 0.85,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalSpeedBoostMultiplier = 0.1,
					Stealth = true,
					Count = 15,
					Interval = 0.55
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = -0.25,
					Count = 4,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cyst, Count = 5, Interval = 0.85 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 3, Interval = 10 }
			}
		},
		{
			CashBonus = 1050,
			CustomWaveTime = 45,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 1, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Carcin,
					AdditionalShieldMultiplier = -1,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.TB2Speed, Count = 10, Interval = 0.85 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBNecromancer,
					AdditionalHealthMultiplier = 2,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TB2Slow,
					AdditionalSpeedBoostMultiplier = 0.1,
					Stealth = true,
					Count = 12,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 1075,
			CustomWaveTime = 65,
			CashMultiplierOverride = 0.85,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TB2Boss1,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 4,
					Interval = 0.85
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSpawn2,
					AdditionalHealthMultiplier = -0.9,
					AdditionalShieldMultiplier = 1,
					Count = 8,
					Interval = 0.85
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Cyst, Count = 4, Interval = 5 }
			}
		},
		{
			CashBonus = 1100,
			CustomWaveTime = 35,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MysteryV,
					AdditionalHealthMultiplier = -0.5,
					Count = 12,
					Interval = 0.9
				}
			}
		},
		{
			CashBonus = 1125,
			CustomWaveTime = 55,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Malignant, Count = 1, Interval = 1 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.TB2Normal, Count = 12, Interval = 0.85 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TB2Speed, Count = 12, Interval = 2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSpawn4,
					AdditionalHealthMultiplier = -0.9,
					AdditionalShieldMultiplier = 0,
					Count = 8,
					Interval = 0.85
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Cyst, Count = 6, Interval = 0.65 }
			}
		},
		{
			CashBonus = 1150,
			CashMultiplierOverride = 1.02,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Shade, Count = 10, Interval = 2 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					AdditionalHealthMultiplier = 0.1,
					Count = 2,
					Interval = 8
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 1, Interval = 1 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Malignant, Count = 2, Interval = 20 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Clot, Count = 20, Interval = 0.65 },
				{
					StartDelay = 8.5,
					EnemyType = Enums.Enemies.VoidFragment,
					Count = 3,
					Interval = 4.5
				},
				{
					StartDelay = 8.25,
					EnemyType = Enums.Enemies.VoidFragment,
					Count = 3,
					Interval = 4.25
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.VoidFragment, Count = 3, Interval = 4 }
			}
		},
		{
			CashBonus = 1175,
			CustomWaveTime = 45,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malignant, Count = 1, Interval = 1 },
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.Malignant,
					AdditionalHealthMultiplier = -0.25,
					Stealth = true,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Slag, Count = 10, Interval = 0.45 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Nosowy, Count = 8, Interval = 4 },
				{ StartDelay = 18, EnemyType = Enums.Enemies.TB2Boss1, Count = 8, Interval = 0.85 },
				{ StartDelay = 24, EnemyType = Enums.Enemies.TB2Boss2, Count = 1, Interval = 1 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.TB2Slow, Count = 12, Interval = 0.35 }
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 11,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 0,
					Count = 8,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1225,
			CustomWaveTime = 55,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ShadyBoss,
					AdditionalHealthMultiplier = -0.7,
					AdditionalShieldMultiplier = -0.75,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Shade, Count = 12, Interval = 2 }
			}
		},
		{
			CashBonus = 1250,
			CustomWaveTime = 210,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidLich,
					AdditionalHealthMultiplier = 1.5,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.TB2Boss2, Count = 4, Interval = 4 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TB2Slow, Count = 14, Interval = 0.45 },
				{ StartDelay = 14, EnemyType = Enums.Enemies.Cyst, Count = 6, Interval = 6 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Blister,
					AdditionalHealthMultiplier = -0.85,
					AdditionalShieldMultiplier = -0.85,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSpawn4,
					AdditionalHealthMultiplier = -0.8,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 20,
					Interval = 4
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.TBSpawn3,
					AdditionalHealthMultiplier = -0.8,
					Count = 12,
					Interval = 10
				},
				{
					StartDelay = 24.25,
					EnemyType = Enums.Enemies.TBSpawn3,
					AdditionalHealthMultiplier = -0.8,
					Count = 12,
					Interval = 10
				},
				{
					StartDelay = 24.5,
					EnemyType = Enums.Enemies.TBSpawn3,
					AdditionalHealthMultiplier = -0.8,
					Count = 12,
					Interval = 10
				}
			}
		},
		{
			CashBonus = 1275,
			CustomWaveTime = 40,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Tumor, Count = 1, Interval = 1 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Malice, Count = 4, Interval = 6 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 3,
					Count = 12,
					Interval = 3.5
				}
			}
		},
		{
			CashBonus = 1300,
			CustomWaveTime = 30,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Nosowy, Count = 6, Interval = 2 },
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.Neuron,
					AdditionalHealthMultiplier = -0.25,
					Count = 2,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 1400,
			CustomWaveTime = 55,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalShieldMultiplier = 0.5,
					Count = 3,
					Interval = 6
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TBSpawn1,
					AdditionalHealthMultiplier = -0.8,
					Count = 20,
					Interval = 0.85
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TBSpawn2,
					AdditionalHealthMultiplier = -0.8,
					Count = 8,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSpawn3,
					AdditionalHealthMultiplier = -0.8,
					Count = 6,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSpawn4,
					AdditionalHealthMultiplier = -0.7,
					Count = 6,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 65,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSlimeBoss,
					AdditionalHealthMultiplier = 9,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 1,
					Interval = 12
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Sludge, Count = 3, Interval = 8 },
				{ StartDelay = 4.25, EnemyType = Enums.Enemies.Sludge, Count = 3, Interval = 8 },
				{ StartDelay = 4.5, EnemyType = Enums.Enemies.Sludge, Count = 2, Interval = 8 },
				{ StartDelay = 4.75, EnemyType = Enums.Enemies.Sludge, Count = 2, Interval = 8 }
			}
		},
		{
			CashBonus = 1600,
			CustomWaveTime = 55,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SpeedyBoss1, Count = 2, Interval = 3 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Carcin,
					AdditionalHealthMultiplier = 1,
					Count = 6,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 45,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Sludge, Count = 8, Interval = 0.45 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Blister,
					AdditionalShieldMultiplier = -1,
					Count = 3,
					Interval = 4
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 3,
					Count = 12,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1800,
			CustomWaveTime = 160,
			CashMultiplierOverride = 0.65,
			SpawnSequences = {
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					AdditionalHealthMultiplier = -0.7,
					AdditionalShieldMultiplier = -15,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Tumor,
					AdditionalHealthMultiplier = -0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperSlow,
					AdditionalHealthMultiplier = -0.85,
					AdditionalShieldMultiplier = -0.85,
					Count = 5,
					Interval = 10
				}
			}
		},
		{
			CashBonus = 1900,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperSlow,
					AdditionalShieldMultiplier = -1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.TBSpawn1,
					AdditionalHealthMultiplier = -0.5,
					Count = 12,
					Interval = 0.25
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBSpawn2,
					AdditionalHealthMultiplier = -0.5,
					Count = 14,
					Interval = 4
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TBSpawn4,
					AdditionalHealthMultiplier = -0.5,
					Count = 4,
					Interval = 6
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					AdditionalHealthMultiplier = -0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.TBGuardian,
					AdditionalHealthMultiplier = -0.5,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 2,
					Interval = 4
				},
				{ StartDelay = 18, EnemyType = Enums.Enemies.TBSpawn1, Count = 12, Interval = 0.25 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cyst, Count = 30, Interval = 5 }
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 215,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					AdditionalHealthMultiplier = -0.55,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 21, EnemyType = Enums.Enemies.VoidEmpress, Count = 1, Interval = 1 },
				{ StartDelay = 21, EnemyType = Enums.Enemies.VoidWarden, Count = 4, Interval = 0.9 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBGuardian,
					AdditionalHealthMultiplier = -0.5,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNormal,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 20
				}
			}
		},
		{
			CashBonus = 3000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 4,
					Interval = 6
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 6, Interval = 12 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cyst, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 45,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SpeedyBoss1,
					Count = 6,
					Interval = 4,
					AdditionalHealthMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.AscendedSpeedy,
					AdditionalHealthMultiplier = 9,
					Count = 9,
					Interval = 8
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.AscendedSlow,
					AdditionalHealthMultiplier = 19,
					AdditionalShieldMultiplier = 19,
					Count = 14,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 5000,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.VoidTank, Count = 4, Interval = 6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidGolem, Count = 3, Interval = 12 },
				{
					StartDelay = 6.5,
					EnemyType = Enums.Enemies.VoidBerserker,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 2,
					Count = 12,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 5000,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidGuard, Count = 3, Interval = 10 },
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.VoidGuard,
					AdditionalHealthMultiplier = -0.1,
					AdditionalShieldMultiplier = -0.1,
					Count = 1,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 5000,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidFloater,
					AdditionalHealthMultiplier = -0.5,
					Count = 6,
					Interval = 4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidWarden, Count = 4, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VoidWarden, Count = 8, Interval = 6 }
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 240,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidPrime,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 0.5
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBSpawn1,
					AdditionalShieldMultiplier = 1,
					Count = 24,
					Interval = 3
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBSpawn2,
					AdditionalShieldMultiplier = 1,
					Count = 14,
					Interval = 0.85
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBSpawn3,
					AdditionalShieldMultiplier = 1,
					Count = 8,
					Interval = 8
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBSpawn4,
					AdditionalShieldMultiplier = 1,
					Count = 10,
					Interval = 12
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Neuron,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 12
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.VoidWarden,
					Count = 4,
					Interval = 0.25
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.VoidGuard,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 4,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 40,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidBerserker,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 8
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Malice, Count = 1, Interval = 1 },
				{ StartDelay = 18, EnemyType = Enums.Enemies.VoidSlime, Count = 4, Interval = 0.65 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 185,
			CashMultiplierOverride = 0.75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 7,
					Count = 3,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 180,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidLich,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 14
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidJuggernaut1,
					AdditionalHealthMultiplier = -0.15,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.VoidJuggernaut2,
					AdditionalHealthMultiplier = -0.35,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.TBSpawn1, Count = 12, Interval = 0.65 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.TBSpawn2, Count = 8, Interval = 2 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.TBSpawn4, Count = 4, Interval = 5 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidFloater,
					AdditionalHealthMultiplier = -0.45,
					Count = 6,
					Interval = 4
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 7,
					Count = 12,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 145,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidEmpress,
					AdditionalHealthMultiplier = 9,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidBerserker,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = -5,
					Count = 4,
					Interval = 8
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.VoidDozer, Count = 1, Interval = 1 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 2
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.VoidRunner, Count = 5, Interval = 10 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 245,
			CashMultiplierOverride = 0.22,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ExoVoid,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = -2.4,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.VoidWarden, Count = 4, Interval = 1 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.VoidFloater,
					AdditionalHealthMultiplier = -0.75,
					AdditionalShieldMultiplier = 0.25,
					Count = 6,
					Interval = 10
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Umbrix, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 85,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.VoidRunner,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 6,
					Interval = 4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Giant2, Count = 12, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.VoidGuard, Count = 3, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 9,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 85,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Giant2, Count = 12, Interval = 6 },
				{ StartDelay = 1.25, EnemyType = Enums.Enemies.VoidRunner, Count = 4, Interval = 5 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 165,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					Count = 4,
					Interval = 12
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautA,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 4,
					Interval = 12
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautB,
					Count = 4,
					Interval = 12
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidDozer,
					AdditionalSpeedBoostMultiplier = -0.15,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidRunner,
					AdditionalHealthMultiplier = -0.35,
					Count = 3,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					Count = 4,
					Interval = 12.25
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					Count = 4,
					Interval = 12.5
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 75,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidCrystalizer,
					Count = 1,
					Interval = 1,
					AdditionalSpeedBoostMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperSlow,
					AdditionalSpeedBoostMultiplier = 2,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 9,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidDozer,
					AdditionalHealthMultiplier = -0.5,
					AdditionalShieldMultiplier = -1,
					Count = 3,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 120,
			CashMultiplierOverride = 0.45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidWarden,
					Count = 6,
					Interval = 1,
					AdditionalHealthMultiplier = 9,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidFloater,
					AdditionalHealthMultiplier = 1,
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidDozer,
					AdditionalHealthMultiplier = 4,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.VoidGuard,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = -0.1,
					Count = 3,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 45,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidTank,
					AdditionalShieldMultiplier = 2,
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 49,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidRunner,
					AdditionalShieldMultiplier = 3,
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Giant2,
					AdditionalShieldMultiplier = 3,
					Count = 12,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 45,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MegaHiddenBoss,
					AdditionalHealthMultiplier = 5,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Noscoper,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RadicalSpooky,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 2,
					Stealth = true,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Shady,
					AdditionalHealthMultiplier = 9,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 4,
					Interval = 2
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.TBFireSpirit,
					AdditionalHealthMultiplier = 9,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 6,
					Interval = 0.45
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.TBHidden,
					AdditionalHealthMultiplier = 9,
					Count = 4,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Shade,
					AdditionalHealthMultiplier = 4,
					Count = 8,
					Interval = 1
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ShadyBoss,
					AdditionalSpeedBoostMultiplier = 0.1,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 9,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 260,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperTBMysteryBoss,
					AdditionalHealthMultiplier = 1.35,
					AdditionalShieldMultiplier = 0.15,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.VoidBerserker,
					AdditionalHealthMultiplier = 3,
					Count = 6,
					Interval = 8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.VoidRunner,
					AdditionalHealthMultiplier = 0.75,
					Count = 2,
					Interval = 40
				},
				{
					StartDelay = 5.25,
					EnemyType = Enums.Enemies.VoidRunner,
					Count = 2,
					Interval = 40.25
				},
				{
					StartDelay = 5.5,
					EnemyType = Enums.Enemies.VoidRunner,
					Count = 2,
					Interval = 40.5
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					AdditionalShieldMultiplier = 1.5,
					Count = 3,
					Interval = 18
				},
				{
					StartDelay = 57,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					AdditionalShieldMultiplier = 1.5,
					Count = 3,
					Interval = 18
				},
				{
					StartDelay = 59,
					EnemyType = Enums.Enemies.CorruptedGoldenCommando,
					AdditionalShieldMultiplier = 1.5,
					Count = 3,
					Interval = 18
				},
				{
					StartDelay = 31,
					EnemyType = Enums.Enemies.Giant2,
					AdditionalShieldMultiplier = 3,
					Count = 5,
					Interval = 8
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.VoidGuard,
					AdditionalHealthMultiplier = -0.2,
					AdditionalShieldMultiplier = -0.2,
					Count = 2,
					Interval = 24
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.AscendedSlow,
					AdditionalHealthMultiplier = 19,
					AdditionalSpeedBoostMultiplier = 0.15,
					AdditionalShieldMultiplier = 19,
					Count = 20,
					Interval = 3
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.AscendedSlow,
					AdditionalHealthMultiplier = 19,
					AdditionalSpeedBoostMultiplier = 0.15,
					AdditionalShieldMultiplier = 19,
					Count = 20,
					Interval = 3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.AscendedSlow,
					AdditionalHealthMultiplier = 19,
					AdditionalSpeedBoostMultiplier = 0.15,
					AdditionalShieldMultiplier = 19,
					Count = 20,
					Interval = 3
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Malice,
					AdditionalHealthMultiplier = 9,
					Count = 4,
					Interval = 30
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.VoidFragment,
					AdditionalShieldMultiplier = 9,
					AdditionalSpeedBoostMultiplier = 0.1,
					Stealth = true,
					AdditionalHealthMultiplier = 9,
					Count = 40,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.5,
			SkipWaveDisabled = true,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidDevastator,
					AdditionalHealthMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = -0.2,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					AdditionalHealthMultiplier = -0.1,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 4000000,
			LockSpeedMultiplierTo1 = true,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VoidGod,
					AdditionalHealthMultiplier = 1.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 16.5,
					EnemyType = Enums.Enemies.VoidPrime,
					AdditionalHealthMultiplier = 2.1,
					AdditionalSpeedBoostMultiplier = -0.2,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 177.5,
					EnemyType = Enums.Enemies.ExoVoid,
					AdditionalHealthMultiplier = 1.2,
					AdditionalShieldMultiplier = -5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 273.5,
					EnemyType = Enums.Enemies.VoidJuggernaut1,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = -0.15,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 261.5,
					EnemyType = Enums.Enemies.VoidJuggernaut2,
					AdditionalHealthMultiplier = 1.5,
					AdditionalSpeedBoostMultiplier = -0.15,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 560,
					EnemyType = Enums.Enemies.Umbrix,
					AdditionalHealthMultiplier = 5,
					AdditionalSpeedBoostMultiplier = -0.2,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 16.5,
					EnemyType = Enums.Enemies.TBNormal,
					AdditionalHealthMultiplier = 99,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 2,
					Stealth = true,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 218.5,
					EnemyType = Enums.Enemies.VoidSlime,
					AdditionalHealthMultiplier = 0.5,
					Count = 8,
					Interval = 35
				},
				{
					StartDelay = 131.5,
					EnemyType = Enums.Enemies.VoidGuard,
					Count = 4,
					Interval = 45
				},
				{
					StartDelay = 136.5,
					EnemyType = Enums.Enemies.VoidRunner,
					Count = 5,
					Interval = 30
				},
				{
					StartDelay = 145.5,
					EnemyType = Enums.Enemies.VoidGolem,
					Count = 4,
					Interval = 55
				},
				{
					StartDelay = 150.5,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					AdditionalHealthMultiplier = 3,
					Count = 3,
					Interval = 60
				},
				{
					StartDelay = 165.5,
					EnemyType = Enums.Enemies.Cyst,
					AdditionalHealthMultiplier = 9,
					Count = 10,
					Interval = 6
				},
				{
					StartDelay = 135.5,
					EnemyType = Enums.Enemies.VoidEmpress,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 166,
					EnemyType = Enums.Enemies.VoidBerserker,
					AdditionalHealthMultiplier = 1,
					Count = 2,
					Interval = 30
				},
				{
					StartDelay = 24.5,
					EnemyType = Enums.Enemies.Giant2,
					AdditionalShieldMultiplier = 1,
					Count = 50,
					Interval = 6
				},
				{
					StartDelay = 433,
					EnemyType = Enums.Enemies.VoidEmpress,
					AdditionalHealthMultiplier = 3,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 465,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					AdditionalHealthMultiplier = 3.5,
					AdditionalSpeedBoostMultiplier = 0.15,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 370, EnemyType = Enums.Enemies.VoidGuard, Count = 2, Interval = 1.5 },
				{ StartDelay = 370, EnemyType = Enums.Enemies.VoidGolem, Count = 4, Interval = 30 },
				{ StartDelay = 370, EnemyType = Enums.Enemies.Giant2, Count = 12, Interval = 10 },
				{
					StartDelay = 430,
					EnemyType = Enums.Enemies.ShadyBoss,
					AdditionalHealthMultiplier = 3,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 430,
					EnemyType = Enums.Enemies.MegaHiddenBoss,
					AdditionalHealthMultiplier = 1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 21.5,
					EnemyType = Enums.Enemies.VoidFragment,
					AdditionalHealthMultiplier = 1,
					Count = 70,
					Interval = 8
				},
				{
					StartDelay = 21.5,
					EnemyType = Enums.Enemies.VoidFragment,
					AdditionalHealthMultiplier = 1,
					Count = 70,
					Interval = 9.65
				},
				{
					StartDelay = 21.5,
					EnemyType = Enums.Enemies.VoidFragment,
					AdditionalHealthMultiplier = 1,
					Count = 70,
					Interval = 6.95
				},
				{
					StartDelay = 410,
					EnemyType = Enums.Enemies.SuperSlow,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 4,
					Interval = 10
				},
				{
					StartDelay = 16.5,
					EnemyType = Enums.Enemies.AscendedSlow,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 200,
					Interval = 3
				}
			},
			CustomWaveTime = 999,
			CashMultiplierOverride = 1.025
		}
	}
}