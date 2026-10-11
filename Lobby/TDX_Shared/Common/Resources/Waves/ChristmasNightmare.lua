local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Christmas Nightmare",
	DefeatScreenRenderName = "Christmas",
	OverrideAdvisorName = "Xenon",
	StartingCash = 2000,
	CashPerDamageData = {
		{ CashPerDamage = 1.3, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 5, GoldReward = 35 },
		{ WaveNumber = 10, GoldReward = 70 },
		{ WaveNumber = 14, GoldReward = 125 },
		{ WaveNumber = 17, GoldReward = 185 },
		{ WaveNumber = 18, GoldReward = 300 },
		{ WaveNumber = 19, GoldReward = 875 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 500,
			GainHP = 100
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1250,
			GainHP = 400
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2500,
			GainHP = 500
		},
		{
			WaveNumber = 10,
			CostGold = 300,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2500,
			GainHP = 500
		},
		{
			WaveNumber = 15,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 8000,
			GainHP = 1500
		},
		{
			WaveNumber = 18,
			CostGold = 700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 40000,
			GainHP = 3500
		}
	},
	DefaultXPPerWavePassed = 75,
	VictoryBadgeIds = { 4362308968475610 },
	StartingLives = 150,
	SetUpTime = 15,
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowRunner, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 30,
					Interval = 0.35
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrozenZombie,
					Count = 14,
					Interval = 0.75
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 10,
					Interval = 0.75,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowZombie, Count = 14, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 2,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CoalMan, Count = 2, Interval = 6 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.Toy, Count = 5, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SummonedRanger,
					Count = 16,
					Interval = 2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 3,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowZombie,
					Count = 7,
					Interval = 1,
					Stealth = true
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.GiftBox, Count = 1, Interval = 0.25 },
				{
					StartDelay = 7.2,
					EnemyType = Enums.Enemies.XmasWall,
					Count = 10,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 1150,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiftBox, Count = 11, Interval = 0.8 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 20,
					Interval = 1.25
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 50, Interval = 0.85 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 500,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 1800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 1, Interval = 4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Chimney, Count = 25, Interval = 1.25 }
			}
		},
		{
			CashBonus = 2400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 1, Interval = 2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Wendigo, Count = 1, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Grenadier, Count = 5, Interval = 0.25 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowPal, Count = 10, Interval = 2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.SnowRunner, Count = 3, Interval = 0.25 }
			}
		},
		{
			CashBonus = 4000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CoalMan, Count = 20, Interval = 0.35 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.CoalMan, Count = 20, Interval = 0.35 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					Interval = 0.15
				}
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					Interval = 3,
					Stealth = true
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.SuperNaughty, Count = 1, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Wendigo, Count = 2, Interval = 0.15 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.Wendigo, Count = 2, Interval = 0.15 }
			}
		},
		{
			CashBonus = 2250,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Wendigo, Count = 12, Interval = 2.5 }
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.GiftBox, Count = 10, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 2, Interval = 7 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.85,
					Stealth = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 40, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 14,
					Interval = 2
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.CoalMan, Count = 8, Interval = 3 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.85,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 2800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 12, Interval = 3 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 2,
					Interval = 8,
					Stealth = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Tree,
					Count = 18,
					Interval = 1.1,
					Stealth = true
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 150,
					Interval = 0.85,
					Stealth = true
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Wendigo,
					Count = 3,
					Interval = 1.1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiftBox, Count = 80, Interval = 0.5 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.SuperNaughty, Count = 6, Interval = 2 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 150,
					Interval = 0.85
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 8 }
			}
		},
		{
			CashBonus = 7000,
			SpawnSequences = {
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.SnowPredator,
					Count = 1,
					Interval = 0.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 14, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.CoalMan, Count = 14, Interval = 0.45 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Wendigo, Count = 20, Interval = 0.85 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.Toy, Count = 100, Interval = 0.35 }
			}
		},
		{
			CashBonus = 20000,
			OverrideXP = 4000,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.NightmareCyberSanta,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Wendigo, Count = 10, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.SnowPredator, Count = 2, Interval = 4 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 100,
					Interval = 1
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.ElfGuardian, Count = 2, Interval = 6 },
				{ StartDelay = 85, EnemyType = Enums.Enemies.SnowPredator, Count = 2, Interval = 4 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.MultiplierX, Count = 1, Interval = 6 }
			}
		}
	}
}