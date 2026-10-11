local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Elite",
	StartingCash = 650,
	CashPerDamageData = {
		{ CashPerDamage = 1.3, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 0.95, CashPerDamageShared = 0.475 },
		{ CashPerDamage = 0.725, CashPerDamageShared = 0.375 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 20, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 45, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 140, TokensReward = 0 },
		{ WaveNumber = 20, GoldReward = 200, TokensReward = 0 },
		{ WaveNumber = 24, GoldReward = 275, TokensReward = 0 },
		{ WaveNumber = 27, GoldReward = 500, TokensReward = 0 },
		{ WaveNumber = 28, GoldReward = 700, TokensReward = 115 }
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
			GainCash = 850,
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
			CostGold = 150,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			CostGold = 175,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 2500,
			GainHP = 400
		},
		{
			WaveNumber = 18,
			CostGold = 250,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 5000,
			GainHP = 600
		},
		{
			WaveNumber = 22,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 8000,
			GainHP = 750
		},
		{
			WaveNumber = 26,
			CostGold = 450,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 30000,
			GainHP = 1200
		},
		{
			WaveNumber = 27,
			CostGold = 500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 50000,
			GainHP = 3000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 2,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 3,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.ReconDrone] = 30,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 30,
				[Enums.PowerUps.HealingField] = 0
			}
		}
	},
	DefaultXPPerWavePassed = 100,
	StartingLives = 250,
	SetUpTime = 15,
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Zombie, Count = 9, Interval = 0.8 }
			}
		},
		{
			CashBonus = 275,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Zombie, Count = 12, Interval = 0.7 }
			}
		},
		{
			CashBonus = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Zombie, Count = 22, Interval = 0.5 }
			}
		},
		{
			CashBonus = 325,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.FastZombie, Count = 11, Interval = 0.3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Zombie, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.FastZombie, Count = 14, Interval = 0.2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Zombie, Count = 8, Interval = 0.8 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 25,
					Interval = 0.7
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyZombie, Count = 8, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.ArmoredZombie, Count = 1, Interval = 4 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chained, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyZombie, Count = 20, Interval = 1 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 25,
					Interval = 0.3,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chained, Count = 8, Interval = 2.2 }
			}
		},
		{
			CashBonus = 475,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.ArmoredZombie, Count = 3, Interval = 1 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedRanger1,
					Count = 1,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chained, Count = 7, Interval = 1.3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ArmoredZombie,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombie,
					Count = 25,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 20,
					Interval = 0.2,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedRanger1,
					Count = 2,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 4,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombie,
					Count = 3,
					Interval = 1
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.Chained, Count = 7, Interval = 1.3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Zombie, Count = 18, Interval = 1.6 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.HeavyZombie,
					Count = 25,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 21,
					Interval = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Knight, Count = 1, Interval = 1 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Chained, Count = 3, Interval = 1.6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Zombie,
					Count = 38,
					Interval = 0.4,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 7,
					Interval = 0.4
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 20,
					Interval = 0.6
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.HeavyZombie, Count = 25, Interval = 1 },
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 3,
					Interval = 1
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.ArmoredZombie, Count = 3, Interval = 8 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Chained, Count = 5, Interval = 1.6 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Chained,
					Count = 6,
					Interval = 1.6,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 650,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 10,
					Interval = 0.8
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ResurrectedRanger2,
					Count = 5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 20,
					Interval = 1.2
				},
				{ StartDelay = 0.2, EnemyType = Enums.Enemies.Multiplier2, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss2,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.ResurrectedRanger2,
					Count = 2,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HazmatZombie,
					Count = 12,
					Interval = 0.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 6,
					Interval = 0.7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.FastZombie,
					Count = 15,
					Interval = 0.3,
					Stealth = true
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.HeavyZombie, Count = 15, Interval = 1 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Abomination,
					Count = 2,
					Interval = 3.5
				}
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Abomination, Count = 6, Interval = 3 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HazmatZombie,
					Count = 18,
					Interval = 1.8
				}
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Abomination, Count = 4, Interval = 4.2 },
				{
					StartDelay = 2.1,
					EnemyType = Enums.Enemies.Abomination,
					Count = 6,
					Interval = 4.2,
					Stealth = false
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.ArmoredHeavyZombie,
					Count = 10,
					Interval = 1,
					Stealth = true
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.RevivedBoss2, Count = 1, Interval = 5 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.HazmatZombie,
					Count = 8,
					Interval = 2,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Abomination, Count = 7, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Multiplier2, Count = 2, Interval = 4 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RadioactiveZombie,
					Count = 10,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 825,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Abomination, Count = 5, Interval = 2 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Abomination,
					Count = 3,
					Interval = 2.5,
					Stealth = true
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.ToxicWaste, Count = 30, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.HazmatZombie,
					Count = 12,
					Interval = 0.5
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ArmoredHeavyZombie,
					Count = 14,
					Interval = 1.9,
					Stealth = true
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 8,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombie,
					Count = 25,
					Interval = 0.5
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.RevivedBoss2, Count = 3, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.RadioactiveZombie,
					Count = 7,
					Interval = 0.8
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.HazmatZombie,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 8,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 8, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Abomination, Count = 9, Interval = 2.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.ToxicWaste, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 1400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Abomination,
					Count = 20,
					Interval = 1.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 4,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Abomination, Count = 24, Interval = 1 },
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 2,
					Interval = 18,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss2,
					Count = 6,
					Interval = 8,
					Stealth = true
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.ToxicWaste, Count = 12, Interval = 8 }
			}
		},
		{
			CashBonus = 10000,
			OverrideXP = 1000,
			SpawnSequences = {
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.RevivedPlagueDoctor,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Abomination,
					Count = 5,
					Interval = 2.5,
					Stealth = true
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.RadioactiveZombie,
					Count = 40,
					Interval = 1.2,
					Stealth = true
				}
			}
		}
	}
}