local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Halloween II (Nightmare)",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 2",
	OverrideAdvisorName = "Engineer",
	PlayerCountToStartingCashMap = { 2100, 1600, 1300, 1100 },
	CashPerDamageData = {
		{ CashPerDamage = 2.7, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.8, CashPerDamageShared = 1 },
		{ CashPerDamage = 1.5, CashPerDamageShared = 0.75 },
		{ CashPerDamage = 1.3, CashPerDamageShared = 0.75 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 1 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 6 },
		{ WaveNumber = 5, GoldReward = 24, TokensReward = 15 },
		{ WaveNumber = 8, GoldReward = 53, TokensReward = 32 },
		{ WaveNumber = 16, GoldReward = 100, TokensReward = 65 },
		{ WaveNumber = 20, GoldReward = 165, TokensReward = 100 },
		{ WaveNumber = 23, GoldReward = 300, TokensReward = 150 },
		{ WaveNumber = 24, GoldReward = 1450, TokensReward = 285 }
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.AirStrike] = 5,
				[Enums.PowerUps.RaptorStorm] = 1,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.HealthCrate] = 35,
				[Enums.PowerUps.HealingField] = 7
			}
		}
	},
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 2692871438244068 },
	StartingLives = 500,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"HalloweenNight2_1",
		"HalloweenNight2_2",
		"HalloweenNight2_3",
		"HalloweenNight2_4"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 7,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 8,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 9,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 11,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 12,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 13,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 15,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 17,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 19,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 5, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 10,
					Interval = 1.2
				},
				{
					StartDelay = 4.6,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 10,
					Interval = 1.2
				},
				{
					StartDelay = 5.3,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 10,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Worker, Count = 10, Interval = 2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 7, Interval = 0.8 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 5,
					Interval = 1.2
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 8, Interval = 1.2 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 12, Interval = 1 },
				{ StartDelay = 3.2, EnemyType = Enums.Enemies.Worker, Count = 7, Interval = 2.4 }
			}
		},
		{
			CashBonus = 650,
			SpeedBoostMultiplierIncrease = 0.25,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Worker, Count = 18, Interval = 0.8 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Psycho, Count = 5, Interval = 3 }
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Prowler,
					Count = 5,
					AdditionalSpeedBoostMultiplier = 1.5,
					Interval = 1
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerA, Count = 14, Interval = 0.9 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Skulltist, Count = 10, Interval = 0.9 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.VillagerB, Count = 12, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 12, Interval = 1.1 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Skulltist, Count = 10, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 10,
					Interval = 1.2
				},
				{
					StartDelay = 4.6,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 10,
					Interval = 1.2
				},
				{
					StartDelay = 5.3,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 10,
					Interval = 1.2
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 9, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 6, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 5, Interval = 1.1 }
			}
		},
		{
			CashBonus = 750,
			CashMultiplierOverride = 0.75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 14,
					Interval = 1,
					AdditionalHealthMultiplier = 2
				},
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Executioner, Count = 3, Interval = 7 },
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.Psycop,
					Count = 20,
					Interval = 1,
					AdditionalSpeedBoostMultiplier = 0.5
				}
			}
		},
		{
			CashBonus = 850,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Prowler,
					AdditionalSpeedBoostMultiplier = 4,
					Count = 14,
					Slteath = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Worker,
					Count = 20,
					Slteath = true,
					Interval = 1,
					AdditionalSpeedBoostMultiplier = 1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Psycho,
					Count = 14,
					Slteath = true,
					Interval = 1,
					AdditionalHealthMultiplier = 5,
					AdditionalSpeedBoostMultiplier = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Judge,
					Count = 2,
					Slteath = true,
					Interval = 6,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalHealthMultiplier = 2
				}
			}
		},
		{
			CashBonus = 950,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.NailHead,
					Count = 5,
					Interval = 1,
					AdditionalHealthMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 30,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 4,
					Interval = 1.5,
					AdditionalSpeedBoostMultiplier = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Psycho,
					Count = 15,
					Interval = 0.5,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 3
				}
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Skulltist,
					Count = 10,
					Interval = 0.7,
					Stealth = true
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.NailHead,
					Count = 10,
					Interval = 1.4,
					AdditionalHealthMultiplier = 2
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Judge, Count = 4, Interval = 1 }
			}
		},
		{
			CashBonus = 8000,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.NailHead,
					Count = 8,
					Interval = 4,
					AdditionalHealthMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Skulltist,
					Count = 100,
					Interval = 0.5,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 32,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 25,
					Interval = 0.2
				},
				{
					StartDelay = 1.3,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 32,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.CorruptedPredatorNightmare,
					Count = 1,
					Interval = 0,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 0,
					SpawnOnAllPaths = true,
					Stealth = true
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 0,
					SpawnOnAllPaths = true,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 50,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 2,
					Interval = 1.7,
					AdditionalSpeedBoostMultiplier = 0.1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 50,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 50,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 220,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Judge,
					Count = 16,
					AdditionalShieldMultiplier = 1,
					Interval = 1.2
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 100,
					Interval = 0.7,
					AdditionalShieldMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.5
				}
			}
		},
		{
			CashBonus = 2500,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 1.2,
					SpawnOnAllPaths = true
				}
			}
		},
		{
			CashBonus = 3000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 20,
					AdditionalShieldMultiplier = 0.7,
					Interval = 0.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Judge,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 2,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Psycho,
					Count = 20,
					AdditionalShieldMultiplier = 5,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 3500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Redacted,
					Count = 3,
					Interval = 1.5,
					SpawnOnAllPaths = true
				}
			}
		},
		{
			CashBonus = 3500,
			CashMultiplierOverride = 0.05,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AntiGolem,
					Count = 2,
					Interval = 1.2,
					SpawnOnAllPaths = true
				}
			}
		},
		{
			CashBonus = 20000,
			OverrideXP = 3000,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.EngineerNightmare,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 28,
					EnemyType = Enums.Enemies.HereticNightmare,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.CorruptedPredator,
					Count = 1,
					Interval = 1.2,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 115,
					EnemyType = Enums.Enemies.AntiGolem,
					Count = 1,
					Interval = 1.2,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.HalloweenAvatar,
					Count = 1,
					Interval = 1.2,
					AdditionalHealthMultiplier = 1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NailGolem,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.NailHead,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.NailGolem,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TwitchingVile, Count = 6, Interval = 1 },
				{ StartDelay = 18, EnemyType = Enums.Enemies.Worker, Count = 100, Interval = 0.25 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Welder,
					Count = 80,
					AdditionalHealthMultiplier = 1,
					Interval = 1
				}
			}
		}
	}
}