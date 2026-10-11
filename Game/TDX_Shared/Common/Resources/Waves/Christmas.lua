local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Christmas Event",
	DefeatScreenRenderName = "Christmas",
	StartingCash = 950,
	CashPerDamageData = {
		{ CashPerDamage = 1.3, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 5, GoldReward = 50 },
		{ WaveNumber = 10, GoldReward = 90 },
		{ WaveNumber = 14, GoldReward = 165 },
		{ WaveNumber = 17, GoldReward = 185 },
		{ WaveNumber = 19, GoldReward = 325 },
		{ WaveNumber = 20, GoldReward = 375 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 600,
			GainHP = 100
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 200
		},
		{
			WaveNumber = 10,
			CostGold = 150,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 3250,
			GainHP = 375
		},
		{
			WaveNumber = 14,
			CostGold = 225,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 5000,
			GainHP = 450
		},
		{
			WaveNumber = 19,
			CostGold = 275,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 30000,
			GainHP = 2000
		}
	},
	DefaultXPPerWavePassed = 75,
	VictoryBadgeIds = { 2854651458739362 },
	StartingLives = 365,
	SetUpTime = 15,
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Snowman, Count = 22, Interval = 1 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Snowman, Count = 35, Interval = 0.85 }
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 30,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.FrozenZombie, Count = 14, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 20,
					Interval = 0.55
				}
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 40,
					Interval = 0.12
				}
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SummonedRanger,
					Count = 6,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SummonedRanger,
					Count = 9,
					Interval = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.FrozenZombie,
					Count = 3,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowPal, Count = 14, Interval = 1.5 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 7,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 9, Interval = 0.85 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chimney, Count = 3, Interval = 2.5 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.SnowZombie, Count = 2, Interval = 2.5 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Tree,
					Count = 1,
					Interval = 3,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 10,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 10, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowPal, Count = 3, Interval = 6 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.SnowRunner, Count = 3, Interval = 0.25 },
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 3,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 1750,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.15,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chimney, Count = 5, Interval = 3 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 50,
					Interval = 0.15
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.CoalMan, Count = 5, Interval = 3 }
			}
		},
		{
			CashBonus = 2250,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CoalMan, Count = 12, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Multiplier1, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiftBox, Count = 10, Interval = 2 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Tree,
					Count = 2,
					Interval = 0.85,
					Stealth = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 10, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowZombie, Count = 3, Interval = 4 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 7,
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
			CashBonus = 2750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiftBox, Count = 11, Interval = 2.5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 14,
					Interval = 0.75
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowZombie, Count = 6, Interval = 2 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.CoalMan, Count = 10, Interval = 0.45 }
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.SuperNaughty, Count = 1, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Wendigo, Count = 2, Interval = 2.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiftBox, Count = 25, Interval = 1 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.Tree,
					Count = 5,
					Interval = 0.4,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 125,
					Interval = 0.35
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowPal, Count = 10, Interval = 1.65 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.CoalMan, Count = 7, Interval = 0.65 }
			}
		},
		{
			CashBonus = 3500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.Wendigo, Count = 6, Interval = 2.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.SuperNaughty, Count = 3, Interval = 4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.XmasWall, Count = 30, Interval = 0.75 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Chimney, Count = 9, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.BlackIce, Count = 10, Interval = 2.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.GiftBox, Count = 9, Interval = 1.5 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.SnowPal, Count = 15, Interval = 1.65 }
			}
		},
		{
			CashBonus = 3500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 8,
					Interval = 3.3
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.Wendigo, Count = 6, Interval = 1.25 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Wendigo, Count = 9, Interval = 2.5 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Tree,
					Count = 5,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 10000,
			OverrideXP = 4250,
			SpawnSequences = {
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ElfGuardian,
					Count = 3,
					Interval = 2.8
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.CyberSanta, Count = 1, Interval = 3.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 7,
					Interval = 2.5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Tree,
					Count = 3,
					Interval = 1.5,
					Stealth = true
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.GiftBox, Count = 3, Interval = 0.75 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.GiftBox, Count = 3, Interval = 0.75 },
				{ StartDelay = 39, EnemyType = Enums.Enemies.GiftBox, Count = 3, Interval = 0.75 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 40,
					Interval = 1.3
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.BlackIce, Count = 7, Interval = 3 }
			}
		}
	}
}