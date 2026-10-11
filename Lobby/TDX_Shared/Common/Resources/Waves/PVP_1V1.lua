local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "PVP - 1V1",
	StartingCash = 725,
	OverrideMaxmimumTowerCountTable = { 60, 60, 30, 30 },
	CashPerDamageData = {
		{ CashPerDamage = 0.7, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.05, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.85, CashPerDamageShared = 0.2 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.15 }
	},
	PVPVictoryIntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 0, TokensReward = 0 },
		{ WaveNumber = 3, TokensReward = 2, GoldReward = 5 },
		{ WaveNumber = 6, TokensReward = 2, GoldReward = 35 },
		{ WaveNumber = 8, TokensReward = 15, GoldReward = 250 },
		{ WaveNumber = 10, TokensReward = 30, GoldReward = 400 },
		{ WaveNumber = 12, TokensReward = 50, GoldReward = 700 },
		{ WaveNumber = 13, TokensReward = 165, GoldReward = 1025 },
		{ WaveNumber = 16, TokensReward = 190, GoldReward = 1125 },
		{ WaveNumber = 19, TokensReward = 225, GoldReward = 1300 },
		{ WaveNumber = 22, TokensReward = 240, GoldReward = 1500 },
		{ WaveNumber = 25, TokensReward = 265, GoldReward = 1675 },
		{ WaveNumber = 28, TokensReward = 285, GoldReward = 2100 },
		{ WaveNumber = 30, TokensReward = 300, GoldReward = 2625 },
		{ WaveNumber = 32, TokensReward = 310, GoldReward = 3225 },
		{ WaveNumber = 34, TokensReward = 335, GoldReward = 3400 },
		{ WaveNumber = 36, TokensReward = 350, GoldReward = 3625 },
		{ WaveNumber = 38, TokensReward = 380, GoldReward = 3850 },
		{ WaveNumber = 40, TokensReward = 400, GoldReward = 4125 },
		{ WaveNumber = 41, TokensReward = 420, GoldReward = 4350 },
		{ WaveNumber = 43, TokensReward = 425, GoldReward = 4575 },
		{ WaveNumber = 45, TokensReward = 450, GoldReward = 4800 },
		{ WaveNumber = 47, TokensReward = 475, GoldReward = 4900 },
		{ WaveNumber = 50, TokensReward = 500, GoldReward = 5025 },
		{ WaveNumber = 55, TokensReward = 500, GoldReward = 5500 },
		{ WaveNumber = 58, TokensReward = 500, GoldReward = 5800 },
		{ WaveNumber = 60, TokensReward = 500, GoldReward = 6800 },
		{ WaveNumber = 61, TokensReward = 500, GoldReward = 18000 }
	},
	PVPDefeatIntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 0, TokensReward = 0 },
		{ WaveNumber = 3, TokensReward = 2, GoldReward = 5 },
		{ WaveNumber = 6, TokensReward = 2, GoldReward = 20 },
		{ WaveNumber = 8, TokensReward = 15, GoldReward = 35 },
		{ WaveNumber = 10, TokensReward = 30, GoldReward = 55 },
		{ WaveNumber = 12, TokensReward = 50, GoldReward = 85 },
		{ WaveNumber = 13, TokensReward = 65, GoldReward = 110 },
		{ WaveNumber = 16, TokensReward = 90, GoldReward = 135 },
		{ WaveNumber = 19, TokensReward = 125, GoldReward = 180 },
		{ WaveNumber = 22, TokensReward = 140, GoldReward = 225 },
		{ WaveNumber = 25, TokensReward = 165, GoldReward = 300 },
		{ WaveNumber = 28, TokensReward = 185, GoldReward = 385 },
		{ WaveNumber = 30, TokensReward = 200, GoldReward = 450 },
		{ WaveNumber = 32, TokensReward = 210, GoldReward = 525 },
		{ WaveNumber = 34, TokensReward = 235, GoldReward = 575 },
		{ WaveNumber = 36, TokensReward = 250, GoldReward = 625 },
		{ WaveNumber = 38, TokensReward = 280, GoldReward = 650 },
		{ WaveNumber = 40, TokensReward = 300, GoldReward = 725 },
		{ WaveNumber = 41, TokensReward = 320, GoldReward = 800 },
		{ WaveNumber = 43, TokensReward = 325, GoldReward = 875 },
		{ WaveNumber = 45, TokensReward = 350, GoldReward = 950 },
		{ WaveNumber = 47, TokensReward = 375, GoldReward = 1000 },
		{ WaveNumber = 50, TokensReward = 400, GoldReward = 1100 },
		{ WaveNumber = 55, TokensReward = 500, GoldReward = 1200 },
		{ WaveNumber = 61, TokensReward = 500, GoldReward = 2000 }
	},
	DefaultXPPerWavePassed = 180,
	StartingLives = 240,
	SetUpTime = 15,
	WaveSkippingDisabled = true,
	SpeedControlDisabled = true,
	CustomGameInfoHandlerName = Enums.GameModes.PVP,
	HideDefaultGameInfo = true,
	TowerCostMultiplierMap = {
		[Enums.Towers.WarMachineFactory] = 1.2,
		[Enums.Towers.Farm] = 1.35,
		[Enums.Towers.Refractor] = 1.1,
		[Enums.Towers.Ranger] = 0.9
	},
	PreloadEnemyNames = {
		Enums.Enemies.Arachnina,
		Enums.Enemies.Boss1,
		Enums.Enemies.Boss2,
		Enums.Enemies.Cloaker,
		Enums.Enemies.Crusher,
		Enums.Enemies.Disruptor,
		Enums.Enemies.EMP,
		Enums.Enemies.Fallout,
		Enums.Enemies.FastDroid,
		Enums.Enemies.Flesh,
		Enums.Enemies.Gestalt,
		Enums.Enemies.HeavyDroid,
		Enums.Enemies.HeavyMetal,
		Enums.Enemies.IonGuard,
		Enums.Enemies.Malfunction,
		Enums.Enemies.NightKnight,
		Enums.Enemies.NormalDroid,
		Enums.Enemies.OverCharge,
		Enums.Enemies.Sturmtruppler,
		Enums.Enemies.ToxicWaste2,
		Enums.Enemies.Monstrosity
	},
	AmbientPlaylist = {
		"PVP1",
		"PVP2",
		"PVP3",
		"PVP4",
		"PVP5",
		"PVP6",
		"PVP7",
		"PVP8",
		"PVP9",
		"PVP10",
		"PVP11",
		"PVP12",
		"PVP13",
		"PVP14",
		"PVP15",
		"PVP16",
		"Christmas25_1",
		"Christmas25_2",
		"Christmas25_3",
		"Christmas25_5",
		"Christmas25_6",
		"Christmas25_7",
		"Christmas25_8",
		"Christmas25_9",
		"Christmas25_10",
		"Christmas25_11",
		"Christmas25_12",
		"Christmas25_13",
		"Christmas25_14",
		"Easter26_1",
		"Easter26_2",
		"Easter26_3",
		"Easter26_4",
		"Easter26_5",
		"Easter26_6",
		"Easter26_7",
		"Easter26_8",
		"HalloweenNight3_1",
		"HalloweenNight3_2",
		"HalloweenNight3_3",
		"HalloweenNight3_4"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 20,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.NormalDroid, Count = 5, Interval = 1.5 }
			}
		},
		{
			CashBonus = 400,
			CustomWaveTime = 20,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.FastDroid, Count = 3, Interval = 2 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.NormalDroid,
					Count = 4,
					Interval = 1.35
				}
			}
		},
		{
			CashBonus = 450,
			CustomWaveTime = 25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NormalDroid,
					Count = 12,
					Interval = 0.9
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.FastDroid, Count = 2, Interval = 1 }
			}
		},
		{
			CashBonus = 700,
			CustomWaveTime = 30,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.HeavyDroid, Count = 8, Interval = 1.2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.FastDroid, Count = 5, Interval = 0.8 }
			}
		},
		{
			CashBonus = 650,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.NormalDroid, Count = 8, Interval = 1.2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.FastDroid, Count = 2, Interval = 1 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.HeavyDroid, Count = 6, Interval = 1.2 }
			}
		},
		{
			CashBonus = 800,
			CustomWaveTime = 37,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NormalDroid,
					Count = 25,
					Interval = 0.95
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.FastDroid, Count = 5, Interval = 1.2 }
			}
		},
		{
			CashBonus = 950,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 40,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyDroid, Count = 22, Interval = 1.2 }
			}
		},
		{
			CashBonus = 1000,
			CustomWaveTime = 32,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boss1, Count = 1, Interval = 1.2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.FastDroid, Count = 8, Interval = 0.75 }
			}
		},
		{
			CashBonus = 950,
			CustomWaveTime = 48,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyDroid, Count = 22, Interval = 0.6 },
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalHealthMultiplier = -0.5,
					Count = 1,
					Interval = 0.7
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Boss1, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 800,
			CustomWaveTime = 30,
			SpawnSequences = {
				{
					StartDelay = 0.75,
					EnemyType = Enums.Enemies.FastDroid,
					Count = 20,
					AdditionalShieldMultiplier = 0.75,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastDroid,
					Count = 15,
					Interval = 1,
					AdditionalShieldMultiplier = 0.75,
					Stealth = true
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.XSoldier, Count = 1, Interval = 4.5 }
			}
		},
		{
			CashBonus = 850,
			CustomWaveTime = 42,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Fallout, Count = 7, Interval = 3 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.FastDroid, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 900,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boss1, Count = 4, Interval = 4.5 }
			}
		},
		{
			CashBonus = 950,
			CustomWaveTime = 57,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyDroid,
					Count = 40,
					AdditionalShieldMultiplier = 0.2,
					Interval = 0.8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalHealthMultiplier = -0.65,
					Count = 2,
					Interval = 15
				}
			}
		},
		{
			CashBonus = 1000,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ToxicWaste2, Count = 10, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Boss1, Count = 3, Interval = 2.5 }
			}
		},
		{
			CashBonus = 1050,
			CustomWaveTime = 65,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boss1, Count = 8, Interval = 1.75 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.FastDroid,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3,
					Stealth = true
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.FastDroid,
					AdditionalShieldMultiplier = 0.5,
					Count = 7,
					Interval = 0.3
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.FastDroid,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.FastDroid,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3
				},
				{ StartDelay = 11, EnemyType = Enums.Enemies.Boss1, Count = 6, Interval = 1.75 }
			}
		},
		{
			CashBonus = 1100,
			CustomWaveTime = 20,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cloaker,
					Count = 4,
					Stealth = true,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1200,
			CustomWaveTime = 70,
			SpawnSequences = {
				{ StartDelay = 19, EnemyType = Enums.Enemies.Boss2, Count = 1, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Fallout, Count = 7, Interval = 3 }
			}
		},
		{
			CashBonus = 1250,
			CustomWaveTime = 95,
			SpawnSequences = {
				{ StartDelay = 10, EnemyType = Enums.Enemies.Boss2, Count = 2, Interval = 5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boss1, Count = 16, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					AdditionalHealthMultiplier = -0.5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1300,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cloaker,
					Count = 7,
					Stealth = true,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 5000,
			OverrideXP = 1000,
			CustomWaveTime = 115,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.EradB,
					Count = 1,
					Interval = 2,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Fallout, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 1400,
			CustomWaveTime = 65,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Boss2,
					Count = 5,
					Interval = 6,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 2,
					Interval = 10,
					AdditionalSpeedBoostMultiplier = 0.1
				}
			}
		},
		{
			CashBonus = 1450,
			CustomWaveTime = 60,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBMystery,
					Count = 30,
					Interval = 1.2,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 5.5,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Boss2,
					Count = 1,
					Interval = 1.2,
					AdditionalSpeedBoostMultiplier = 0.2
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 45,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBMystery2,
					Count = 22,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 1.3,
					Interval = 1.3
				}
			}
		},
		{
			CashBonus = 1550,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Malfunction,
					Count = 9,
					Interval = 2,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.EMP,
					Count = 5,
					Interval = 2,
					AdditionalSpeedBoostMultiplier = 0.2
				}
			}
		},
		{
			CashBonus = 25000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eradicator,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = -0.2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.TBMystery2,
					Count = 10,
					Interval = 1,
					AdditionalShieldMultiplier = 1.8,
					AdditionalSpeedBoostMultiplier = 0.25
				}
			}
		},
		{
			CashBonus = 1659,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.IonGuard, Count = 2, Interval = 8 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.FastDroid,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 5,
					Count = 60,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 40,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.NightKnight,
					Count = 5,
					Stealth = true,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cloaker,
					Count = 6,
					Stealth = true,
					Interval = 2.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					Stealth = true,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 1750,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EMP,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.NightKnight,
					Stealth = true,
					Count = 2,
					Interval = 8
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.SpeedDeployer, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 1800,
			CustomWaveTime = 40,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.IonGuard, Count = 3, Interval = 5 }
			}
		},
		{
			CashBonus = 10000,
			OverrideXP = 2000,
			CashMultiplierOverride = 0.4,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 3,
					Interval = 14,
					AdditionalShieldMultiplier = 0.75
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CrushOTron9000,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 6,
					AdditionalShieldMultiplier = 0.4,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Crusher,
					Count = 1,
					Interval = 2,
					AdditionalSpeedBoostMultiplier = 0.25
				}
			}
		},
		{
			CashBonus = 1900,
			CashMultiplierOverride = 0.85,
			CustomWaveTime = 20,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 17,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 1950,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 65,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Dreadcubus,
					AdditionalShieldMultiplier = -0.7,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBLightning,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 0.5,
					Count = 3,
					Interval = 0.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monstrosity, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 40,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 0.4,
					Count = 35,
					Interval = 0.8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 2,
					Count = 2,
					Interval = 8
				}
			}
		},
		{
			CashBonus = 2050,
			CustomWaveTime = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monstrosity, Count = 3, Interval = 7 }
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 90,
			CashMultiplierOverride = 0.4,
			OverrideAmbientPlaylist = { "EliteWave27Music" },
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.King, Count = 1, Interval = 2 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.DamageDeployer,
					Count = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 9
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.GoldenKnight,
					Count = 5,
					AdditionalShieldMultiplier = 1,
					Interval = 9
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Queen, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 2150,
			CustomWaveTime = 55,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.IonGuard, Count = 14, Interval = 2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Fallout,
					AdditionalShieldMultiplier = 10,
					Count = 14,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 2200,
			CustomWaveTime = 30,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Disruptor, Count = 8, Interval = 2 }
			}
		},
		{
			CashBonus = 2250,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cloaker,
					Count = 10,
					Interval = 1.2,
					Stealth = true,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Sturmtruppler,
					Count = 3,
					Interval = 1.4,
					Stealth = true,
					AdditionalHealthMultiplier = -0.1,
					AdditionalShieldMultiplier = -0.2,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.NightKnight,
					Count = 5,
					Interval = 1,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.3
				}
			}
		},
		{
			CashBonus = 2300,
			CustomWaveTime = 85,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.OverCharge,
					Count = 4,
					Interval = 5,
					AdditionalShieldMultiplier = 0
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Gestalt,
					Count = 3,
					Interval = 7,
					AdditionalSpeedBoostMultiplier = 0.25
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Sturmtruppler,
					Count = 10,
					Interval = 3,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.1
				}
			}
		},
		{
			CashBonus = 30000,
			OverrideXP = 3250,
			CustomWaveTime = 110,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.X2Trooper,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = -0.5,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalShieldMultiplier = -0.75
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.OverCharge, Count = 3, Interval = 12 }
			}
		},
		{
			CashBonus = 2400,
			CustomWaveTime = 85,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Sturmtruppler,
					Count = 16,
					Interval = 2.5,
					Stealth = true,
					AdditionalHealthMultiplier = -0.2,
					AdditionalShieldMultiplier = -0.2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Arachnina,
					Count = 6,
					Interval = 3,
					AdditionalHealthMultiplier = 0.05,
					AdditionalShieldMultiplier = -0.6,
					AdditionalSpeedBoostMultiplier = 0.1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Arachnina,
					Count = 3,
					Interval = 3,
					Stealth = true,
					AdditionalHealthMultiplier = 0.05,
					AdditionalShieldMultiplier = -0.6,
					AdditionalSpeedBoostMultiplier = 0.1
				}
			}
		},
		{
			CashBonus = 2500,
			CustomWaveTime = 85,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Smasher9x,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = -0.2,
					AdditionalShieldMultiplier = -0.3,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 4,
					Interval = 3,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 0.4,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Smasher,
					Count = 2,
					Interval = 3,
					Stealth = true,
					AdditionalHealthMultiplier = 2.5,
					AdditionalShieldMultiplier = 0.6,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.PSmasher,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 220,
					AdditionalShieldMultiplier = 1
				}
			}
		},
		{
			CashBonus = 2600,
			OverrideXP = 1000,
			CustomWaveTime = 70,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Monstrosity,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 0,
					AdditionalSpeedBoostMultiplier = 0.1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.E02,
					Count = 2,
					Interval = 2.5,
					AdditionalHealthMultiplier = 1.25,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.2
				}
			}
		},
		{
			CashBonus = 2700,
			OverrideXP = 1000,
			CustomWaveTime = 95,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Executioner,
					Count = 6,
					Interval = 3,
					AdditionalHealthMultiplier = 11,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.6
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 20,
					Interval = 3,
					AdditionalHealthMultiplier = 15,
					AdditionalShieldMultiplier = -0.75
				}
			}
		},
		{
			CashBonus = 100000,
			OverrideXP = 3000,
			CustomWaveTime = 110,
			CashMultiplierOverride = 0.8,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TombRaider,
					Count = 10,
					Interval = 4,
					AdditionalHealthMultiplier = 50,
					AdditionalShieldMultiplier = -1,
					AdditionalSpeedBoostMultiplier = 0.25
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 10,
					Interval = 3,
					AdditionalHealthMultiplier = 14,
					AdditionalShieldMultiplier = -0.75,
					AdditionalSpeedBoostMultiplier = 0.1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.CoffinHead,
					Count = 1,
					Interval = 3,
					AdditionalHealthMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.25
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.VineGolem,
					Count = 3,
					Interval = 13,
					AdditionalHealthMultiplier = 8,
					AdditionalShieldMultiplier = 0.5
				}
			}
		},
		{
			CashBonus = 2700,
			CustomWaveTime = 70,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 2,
					Interval = 9,
					AdditionalHealthMultiplier = 5,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Zeus,
					Count = 1,
					Interval = 1,
					Stealth = true,
					AdditionalHealthMultiplier = 3.9,
					AdditionalShieldMultiplier = -0.75
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 12,
					Interval = 8,
					AdditionalHealthMultiplier = 0.55,
					AdditionalShieldMultiplier = -1
				}
			}
		},
		{
			CashBonus = 2800,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Arachnina,
					Count = 12,
					Interval = 2,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = -1,
					AdditionalSpeedBoostMultiplier = 0.1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.EMP,
					Count = 20,
					Interval = 5,
					AdditionalHealthMultiplier = 9,
					AdditionalShieldMultiplier = 0.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Sturmtruppler,
					Count = 6,
					Interval = 4,
					Stealth = true,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = -1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Fallout,
					Count = 16,
					Interval = 6,
					AdditionalHealthMultiplier = 20
				}
			}
		},
		{
			CashBonus = 2900,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 6.5
				}
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Berserker,
					Count = 8,
					Interval = 3,
					AdditionalHealthMultiplier = 21,
					AdditionalShieldMultiplier = 0,
					AdditionalSpeedBoostMultiplier = 0.15
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Wrecker,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 19,
					AdditionalSpeedBoostMultiplier = 0.15
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.KnightRework,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 49,
					AdditionalShieldMultiplier = 0
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.IronBastion,
					Count = 2,
					Interval = 8,
					AdditionalHealthMultiplier = 9,
					AdditionalSpeedBoostMultiplier = 0.2
				}
			}
		},
		{
			CashBonus = 50000,
			OverrideXP = 1000,
			CustomWaveTime = 70,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBEndbringer,
					Count = 4,
					Interval = 4,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.TBBoss4,
					Count = 2,
					Interval = 6,
					AdditionalHealthMultiplier = 7
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 65,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 2,
					Interval = 6,
					AdditionalHealthMultiplier = 8
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.TBGuardian,
					Count = 2,
					Interval = 4,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.55
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TBEndbringer,
					Count = 1,
					Interval = 5,
					AdditionalShieldMultiplier = 1
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 70,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Herculean,
					Count = 5,
					Interval = 9,
					AdditionalHealthMultiplier = -0.25,
					AdditionalShieldMultiplier = -1,
					AdditionalSpeedBoostMultiplier = 0.1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Suppressor,
					Count = 3,
					Interval = 6,
					AdditionalHealthMultiplier = -0.25,
					AdditionalShieldMultiplier = -1,
					AdditionalSpeedBoostMultiplier = 0.15
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ArmoredTank,
					Count = 5,
					Interval = 5,
					AdditionalHealthMultiplier = 7,
					AdditionalShieldMultiplier = -1,
					AdditionalSpeedBoostMultiplier = 0.15
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.Breacher,
					Count = 20,
					Interval = 3,
					AdditionalHealthMultiplier = 4,
					AdditionalShieldMultiplier = -1
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 140,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Crewmate,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 350,
					AdditionalSpeedBoostMultiplier = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.AvatarM,
					Count = 3,
					Interval = 2,
					AdditionalHealthMultiplier = 3.5,
					AdditionalSpeedBoostMultiplier = 0.3
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.AvatarR,
					Count = 3,
					Interval = 2,
					AdditionalHealthMultiplier = 3.5,
					AdditionalSpeedBoostMultiplier = 0.3
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Crewmate,
					Count = 7,
					Interval = 2,
					AdditionalHealthMultiplier = 350,
					AdditionalSpeedBoostMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 7,
					Interval = 3,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 1
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Breacher,
					Count = 80,
					Interval = 2.5,
					AdditionalHealthMultiplier = 4,
					AdditionalShieldMultiplier = 0.5
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.SlimeCaptain1,
					Count = 1,
					Interval = 2.5,
					AdditionalHealthMultiplier = 10,
					AdditionalShieldMultiplier = 0.7,
					AddtiionalSpeedMultiplier = 0.2
				}
			}
		},
		{
			CashBonus = 100000,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EasterEngineer,
					Count = 1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					Count = 1,
					Interval = 4,
					AdditionalShieldMultiplier = 4
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBEndbringer,
					Count = 15,
					Interval = 4,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 21,
					Interval = 3,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeKing,
					Count = 1,
					Interval = 4,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.GeneralCelgar,
					Count = 1,
					Interval = 4,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.TBBoss3,
					Count = 40,
					Interval = 3,
					AdditionalHealthMultiplier = 10,
					AdditionalShieldMultiplier = 2
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBEndbringer,
					Count = 30,
					Interval = 4,
					AdditionalShieldMultiplier = 2
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBEndbringer,
					Count = 66,
					Interval = 4,
					AdditionalShieldMultiplier = 9
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Nemesis,
					Count = 1,
					Interval = 4,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.AlphaPredator,
					Count = 1,
					Interval = 4,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					Count = 1,
					Interval = 4,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.X2Trooper,
					Count = 1,
					Interval = 4,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Dispenser,
					Count = 33,
					Interval = 3,
					AdditionalHealthMultiplier = 5,
					AdditionalShieldMultiplier = 5
				}
			}
		}
	}
}