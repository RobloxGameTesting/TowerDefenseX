local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Intermediate",
	DefeatScreenRenderName = "Intermediate",
	StartingCash = 725,
	CashPerDamageData = {
		{ CashPerDamage = 1.35, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.35 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 15, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 30, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 45, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 100, TokensReward = 0 },
		{ WaveNumber = 24, GoldReward = 195, TokensReward = 0 },
		{ WaveNumber = 28, GoldReward = 250, TokensReward = 0 },
		{ WaveNumber = 29, GoldReward = 320, TokensReward = 0 },
		{ WaveNumber = 31, GoldReward = 375, TokensReward = 0 },
		{ WaveNumber = 32, GoldReward = 700, TokensReward = 85 }
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
			GainCash = 1000,
			GainHP = 200
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 10,
			CostGold = 125,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			CostGold = 150,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2000,
			GainHP = 400
		},
		{
			WaveNumber = 18,
			CostGold = 175,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 4000,
			GainHP = 650
		},
		{
			WaveNumber = 25,
			CostGold = 250,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 10000,
			GainHP = 850
		},
		{
			WaveNumber = 29,
			CostGold = 375,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 15000,
			GainHP = 1250
		},
		{
			WaveNumber = 34,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 40000,
			GainHP = 2500
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 2,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 6,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.ReconDrone] = 18,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 20,
				[Enums.PowerUps.HealingField] = 4
			}
		}
	},
	DefaultXPPerWavePassed = 100,
	StartingLives = 300,
	SetUpTime = 15,
	TowerCostMultiplierMap = { [Enums.Towers.Ranger] = 0.85 },
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZombiePlus, Count = 6, Interval = 0.75 }
			}
		},
		{
			CashBonus = 325,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZombiePlus, Count = 9, Interval = 0.8 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 8,
					Interval = 1.4
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.ZombiePlus, Count = 5, Interval = 0.75 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 12,
					Interval = 1.3
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.ZombiePlus, Count = 5, Interval = 0.75 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 12,
					Interval = 1.2
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ZombiePlus,
					Count = 10,
					Interval = 0.75
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 4,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 7,
					Interval = 1
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.ZombiePlus, Count = 8, Interval = 0.75 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 9,
					Interval = 0.9
				}
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 13,
					Interval = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 8,
					Interval = 0.65
				}
			}
		},
		{
			CashBonus = 475,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss1, Count = 1, Interval = 1 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 5,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 2,
					Interval = 1.7
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.ZombiePlus, Count = 5, Interval = 0.75 }
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 25,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 15,
					Interval = 1.2,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss1, Count = 2, Interval = 7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Multiplier1, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss1, Count = 2, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Grenadier, Count = 1, Interval = 0.4 }
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 30,
					Interval = 0.8
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Multiplier1, Count = 2, Interval = 8 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombiePlus,
					Count = 5,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 6,
					Interval = 1.7
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Grenadier, Count = 1, Interval = 1.8 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.Grenadier, Count = 2, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 1,
					Interval = 0.65
				}
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.NuclearZombie, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedTitan, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearZombie,
					Count = 10,
					Interval = 1
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Multiplier1, Count = 1, Interval = 6 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 10,
					Interval = 1.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 2,
					Interval = 0.5,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 825,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedTitan, Count = 2, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Grenadier, Count = 2, Interval = 3.5 }
			}
		},
		{
			CashBonus = 850,
			SpawnSequences = {
				{ StartDelay = 6, EnemyType = Enums.Enemies.Monster, Count = 1, Interval = 2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 2,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedTitan, Count = 1, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.NuclearZombie,
					Count = 15,
					Interval = 1,
					Stealth = true
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Infiltrator, Count = 2, Interval = 1 }
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ChargerBoss, Count = 1, Interval = 1 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 3,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 925,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monster, Count = 2, Interval = 4 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.NuclearZombie,
					Count = 6,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 6,
					Interval = 0.75,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 950,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Smasher, Count = 1, Interval = 1.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Shocker, Count = 2, Interval = 4.5 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 30,
					Interval = 0.35,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 975,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monster, Count = 3, Interval = 3.5 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Multiplier1,
					Count = 1,
					Interval = 0.65
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.NuclearZombie, Count = 8, Interval = 2 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 9,
					Interval = 0.8
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.NuclearZombie, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 16000,
			OverrideXP = 600,
			CustomWaveTime = 450,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Predator, Count = 1, Interval = 1.6 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Monster, Count = 6, Interval = 15 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 115,
					Interval = 0.7
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.ChargerBoss, Count = 3, Interval = 5 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Monster, Count = 6, Interval = 2.5 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Smasher, Count = 1, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Infiltrator,
					Count = 15,
					Interval = 0.85
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 2,
					Interval = 6
				}
			}
		},
		{
			CashBonus = 90000,
			OverrideXP = 1700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Eradicator, Count = 1, Interval = 0.75 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 2,
					Interval = 4
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Grenadier, Count = 5, Interval = 0.75 },
				{ StartDelay = 19, EnemyType = Enums.Enemies.ChargerBoss, Count = 2, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 6
				},
				{ StartDelay = 14, EnemyType = Enums.Enemies.Infiltrator, Count = 7, Interval = 1 }
			}
		}
	}
}