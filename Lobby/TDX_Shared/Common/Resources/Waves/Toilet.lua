local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Toilet",
	VictoryMusicName = "ToiletVictoryMusic",
	StartingCash = 5000,
	CashPerDamageData = {
		{ CashPerDamage = 1.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.3 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 3, GoldReward = 10 },
		{ WaveNumber = 5, GoldReward = 35 },
		{ WaveNumber = 8, GoldReward = 60 },
		{ WaveNumber = 16, GoldReward = 150 },
		{ WaveNumber = 18, GoldReward = 175 },
		{ WaveNumber = 20, GoldReward = 225 },
		{ WaveNumber = 24, GoldReward = 300 },
		{ WaveNumber = 27, GoldReward = 350 },
		{ WaveNumber = 29, GoldReward = 425 },
		{ WaveNumber = 30, GoldReward = 700 },
		{ WaveNumber = 31, GoldReward = 1200 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 4,
			CostGold = 75,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1000,
			GainHP = 200
		},
		{
			WaveNumber = 8,
			CostGold = 300,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 2000,
			GainHP = 500
		},
		{
			WaveNumber = 16,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 15000,
			GainHP = 1000
		},
		{
			WaveNumber = 20,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 25000,
			GainHP = 2000
		},
		{
			WaveNumber = 25,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 50000,
			GainHP = 4000
		},
		{
			WaveNumber = 30,
			CostGold = 900,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 200000,
			GainHP = 8000
		}
	},
	DefaultXPPerWavePassed = 100,
	VictoryBadgeIds = { 2732593581303222 },
	StartingLives = 1111,
	SetUpTime = 15,
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ToiletNoob, Count = 4, Interval = 0.75 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ToiletNoob, Count = 7, Interval = 0.6 }
			}
		},
		{
			CashBonus = 3250,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Crewmate, Count = 3, Interval = 1.5 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletZombie,
					Count = 50,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletNoob,
					Count = 75,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 1300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletNoob,
					Count = 125,
					Interval = 0.15
				}
			}
		},
		{
			CashBonus = 1400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Crewmate, Count = 3, Interval = 1.5 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Crewmate, Count = 16, Interval = 0.2 }
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GrenadierToiletZombie,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletNoob,
					Count = 50,
					Interval = 0.15
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletBoss1,
					Count = 10,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Crewmate, Count = 16, Interval = 0.2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.ToiletBoss1, Count = 5, Interval = 2 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GrenadierToiletZombie,
					Count = 4,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastToiletZombie,
					Count = 30,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.JetpackToilet, Count = 7, Interval = 1 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyToiletZombie,
					Count = 10,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastToiletZombie,
					Count = 30,
					Interval = 0.5
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ToiletNoob,
					Count = 100,
					Interval = 0.15
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Crewmate, Count = 60, Interval = 0.2 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ToiletBoss1,
					Count = 5,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.GrenadierToiletZombie,
					Count = 8,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyToiletZombie,
					Count = 20,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.EvilGasToilet,
					Count = 2,
					Interval = 10
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JetpackToilet,
					Count = 20,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearToilet,
					Count = 14,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Crewmate, Count = 300, Interval = 0.1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 5 }
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BiggerCheeseToiletZombieMKII,
					Count = 1,
					Interval = 8
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.EvilGasToilet, Count = 2, Interval = 4 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.GrenadierToiletZombie,
					Count = 5,
					Interval = 0.2
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.GrenadierToiletZombie,
					Count = 5,
					Interval = 0.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyToiletZombie,
					Count = 45,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RobotToilet, Count = 5, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.FartToilet, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RobotToilet,
					Count = 10,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JetpackToilet,
					Count = 30,
					Interval = 0.5
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.Cheese, Count = 6, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cheese, Count = 13, Interval = 1 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.BiggerCheeseToiletZombieMKII,
					Count = 6,
					Interval = 4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cheese, Count = 10, Interval = 1 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ChainedToiletZombie,
					Count = 5,
					Interval = 3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.EvilGasToilet, Count = 3, Interval = 4 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GunToilet, Count = 25, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearToilet,
					Count = 20,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.EliteGrenadierToiletZombie,
					Count = 5,
					Interval = 0.5
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 5,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ChainedToiletZombie,
					Count = 15,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 400,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.EvilGasToilet, Count = 3, Interval = 4 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.JammerToilet, Count = 2, Interval = 8 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BiggerCheeseToiletZombieMKII,
					Count = 8,
					Interval = 3.5
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.JohnToilet, Count = 8, Interval = 2 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.AtrazineToilet,
					Count = 8,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletJohnBoss,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.EliteGrenadierToiletZombie,
					Count = 5,
					Interval = 0.5
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Eradicator, Count = 2, Interval = 9 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Commander, Count = 50, Interval = 0.5 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TankToilet, Count = 4, Interval = 2 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.TankToilet, Count = 4, Interval = 2 },
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.JetpackToilet,
					Count = 20,
					Interval = 0.6
				},
				{ StartDelay = 45, EnemyType = Enums.Enemies.TankToilet, Count = 4, Interval = 2 },
				{ StartDelay = 17, EnemyType = Enums.Enemies.GunToilet, Count = 10, Interval = 1 }
			}
		}
	}
}