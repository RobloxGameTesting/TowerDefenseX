local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Easy",
	StartingCash = 975,
	CashPerDamageData = {
		{ CashPerDamage = 1.55, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.2, CashPerDamageShared = 0.8 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.45 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 10, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 50, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 100, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 125, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 150, TokensReward = 0 },
		{ WaveNumber = 20, GoldReward = 200, TokensReward = 0 },
		{ WaveNumber = 23, GoldReward = 275, TokensReward = 0 },
		{ WaveNumber = 24, GoldReward = 400, TokensReward = 40 }
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
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 1000,
			GainHP = 150
		},
		{
			WaveNumber = 8,
			CostGold = 45,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 250
		},
		{
			WaveNumber = 16,
			CostGold = 70,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 4000,
			GainHP = 400
		},
		{
			WaveNumber = 20,
			CostGold = 85,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7500,
			GainHP = 500
		},
		{
			WaveNumber = 24,
			CostGold = 100,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 32000,
			GainHP = 1000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 2,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 5,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 35,
				[Enums.PowerUps.HealingField] = 0
			}
		}
	},
	DefaultXPPerWavePassed = 90,
	StartingLives = 500,
	SetUpTime = 15,
	NoTowerDamageAllowed = true,
	AmbientPlaylist = { "Easy1", "Easy2", "Easy4", "Easy5", "Easy6" },
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZombieRework, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 14,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 8,
					Interval = 1
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.ZombieRework, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 14,
					Interval = 0.6
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 10,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 14,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 4,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 12,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 15,
					Interval = 1
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 15,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 20,
					Interval = 1
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 12,
					Interval = 1
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.ZombieRework, Count = 14, Interval = 1 }
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 5,
					Interval = 1.2
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 15,
					Interval = 1
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 16,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 32,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 1,
					Interval = 1.3
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 8,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 25,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 1050,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ChainedRework, Count = 2, Interval = 6 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 24,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 3,
					Interval = 1
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.ChainedRework, Count = 3, Interval = 7 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 18,
					Interval = 1.6
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 25,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1150,
			SpawnSequences = {
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 21,
					Interval = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 9,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 2,
					Interval = 1.6
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 25,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombieRework,
					AdditionalShieldMultiplier = 1,
					Count = 15,
					Interval = 0.2,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1250,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 45,
					Interval = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 7,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 14,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 3,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 4,
					Interval = 1.2,
					Stealth = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 5,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 1450,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 3,
					Stealth = true,
					Interval = 3
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 5,
					Stealth = true,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 19,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 5,
					Interval = 1.2
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 6,
					Interval = 2.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 7,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 2300,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 8,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 6,
					Interval = 0.7
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 15,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 11,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 3200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 4250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 2,
					Interval = 8
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 4,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 2,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 3,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 8000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 4,
					Interval = 1.5
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.FastZombieRework,
					Count = 35,
					AdditionalShieldMultiplier = 2,
					Interval = 0.2,
					Stealth = true
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.RadioactiveZombieRework,
					Count = 4,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 20000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 4,
					Interval = 9
				},
				{
					StartDelay = 33,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 2,
					Interval = 8,
					Stealth = true
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ArmoredHeavyZombieRework,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 8,
					Interval = 1.4
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 8,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieRework,
					Count = 40,
					Interval = 0.8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.HeavyZombieRework,
					Count = 25,
					Interval = 1
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.ArmoredZombieRework,
					Count = 6,
					Interval = 0.5
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ChainedRework,
					Count = 12,
					Interval = 0.8
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.HazmatZombieRework,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 27,
					EnemyType = Enums.Enemies.MutatedZombieRework,
					Count = 8,
					Interval = 1.3
				}
			}
		},
		{
			CashBonus = 50000,
			CashMultiplierOverride = 1.7,
			OverrideXP = 1000,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.PlagueDoctor,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AbominationRework,
					Count = 3,
					Interval = 2.5,
					Stealth = true
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.RadioactiveZombieRework,
					Count = 5,
					AdditionalHealthMultiplier = 1,
					Interval = 1
				}
			}
		}
	}
}