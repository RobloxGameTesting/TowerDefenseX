local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Expert",
	DefeatScreenRenderName = "Intermediate",
	StartingCash = 800,
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.42 },
		{ CashPerDamage = 0.85, CashPerDamageShared = 0.36 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 20, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 80, TokensReward = 0 },
		{ WaveNumber = 14, GoldReward = 140, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 195, TokensReward = 0 },
		{ WaveNumber = 24, GoldReward = 260, TokensReward = 0 },
		{ WaveNumber = 30, GoldReward = 425, TokensReward = 0 },
		{ WaveNumber = 35, GoldReward = 500, TokensReward = 0 },
		{ WaveNumber = 39, GoldReward = 825, TokensReward = 0 },
		{ WaveNumber = 40, GoldReward = 1500, TokensReward = 225 }
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
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 200,
			GainHP = 400
		},
		{
			WaveNumber = 18,
			CostGold = 500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7000,
			GainHP = 500
		},
		{
			WaveNumber = 24,
			CostGold = 750,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 9000,
			GainHP = 1000
		},
		{
			WaveNumber = 29,
			CostGold = 925,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 40000,
			GainHP = 2000
		},
		{
			WaveNumber = 33,
			CostGold = 975,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 45000,
			GainHP = 2500
		},
		{
			WaveNumber = 37,
			CostGold = 1000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 50000,
			GainHP = 4500
		},
		{
			WaveNumber = 39,
			CostGold = 1200,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 80000,
			GainHP = 6750
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 12,
				[Enums.PowerUps.AC130Support] = 8,
				[Enums.PowerUps.AirStrike] = 32,
				[Enums.PowerUps.RaptorStorm] = 2,
				[Enums.PowerUps.Punkbuster] = 1,
				[Enums.PowerUps.ReconDrone] = 50,
				[Enums.PowerUps.CashCrate] = 14,
				[Enums.PowerUps.HealthCrate] = 30,
				[Enums.PowerUps.HealingField] = 90
			}
		}
	},
	DefaultXPPerWavePassed = 125,
	StartingLives = 175,
	SetUpTime = 15,
	Waves = {
		{
			CashBonus = 0,
			OverrideXP = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZombiePlus, Count = 8, Interval = 0.75 }
			}
		},
		{
			CashBonus = 300,
			OverrideXP = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZombiePlus, Count = 12, Interval = 0.8 }
			}
		},
		{
			CashBonus = 325,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 12,
					Interval = 1.4
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.ZombiePlus, Count = 8, Interval = 0.75 }
			}
		},
		{
			CashBonus = 350,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 15,
					Interval = 1.3
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.ZombiePlus,
					Count = 10,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 375,
			OverrideXP = 50,
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
					Count = 7,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 400,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 7,
					Interval = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.MutatedOffspring,
					Count = 5,
					Interval = 0.75
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 15,
					Interval = 0.9
				}
			}
		},
		{
			CashBonus = 425,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombiePlus,
					Count = 10,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 450,
			OverrideXP = 50,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss1, Count = 1, Interval = 1 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.MutatedZombie, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 475,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 2,
					Interval = 1.7
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 1,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 500,
			OverrideXP = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HeavyZombiePlus,
					Count = 35,
					Interval = 0.5
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Grenadier, Count = 1, Interval = 0.5 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.Knight, Count = 1, Interval = 0.5 }
			}
		},
		{
			CashBonus = 525,
			OverrideXP = 75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FastZombiePlus,
					Count = 10,
					Interval = 0.3
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.MutatedZombie, Count = 5, Interval = 2 }
			}
		},
		{
			CashBonus = 550,
			OverrideXP = 75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.Grenadier, Count = 2, Interval = 4 }
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss1, Count = 2, Interval = 3 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Grenadier, Count = 3, Interval = 0.7 }
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredHeavyZombiePlus,
					Count = 30,
					Interval = 0.3
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.Multiplier2, Count = 3, Interval = 5 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.MutatedOffspring,
					Count = 40,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 1,
					Interval = 1.4
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Grenadier, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Grenadier,
					Count = 2,
					Interval = 2,
					Stealth = true
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 2,
					Interval = 3,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedTitan,
					Count = 1,
					Interval = 0.65,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Knight, Count = 3, Interval = 4 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ResurrectedRanger2,
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.ResurrectedRanger1,
					Count = 3,
					Interval = 2
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 2,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 650,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedTitan, Count = 2, Interval = 5 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 2,
					Interval = 5,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearZombie,
					Count = 10,
					Interval = 1
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Multiplier1, Count = 3, Interval = 4 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyZombie,
					Count = 5,
					Interval = 0.8
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Multiplier2, Count = 2, Interval = 2 }
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monster, Count = 2, Interval = 5 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 2,
					Stealth = true
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.ChargerBoss, Count = 1, Interval = 5 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss2, Count = 2, Interval = 5 },
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 8,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedTitan, Count = 5, Interval = 7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Shocker, Count = 5, Interval = 4 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.RevivedBoss2, Count = 1, Interval = 5 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 2,
					Interval = 0.5,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 3,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 825,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Monster,
					Count = 3,
					Interval = 4,
					Stealth = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 2,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 8,
					Interval = 0.75,
					Stealth = true
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Grenadier,
					Count = 1,
					Interval = 0.75,
					Stealth = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Smasher,
					Count = 1,
					Interval = 0.75,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 825,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Smasher, Count = 2, Interval = 5 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Shocker, Count = 3, Interval = 4.5 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.Monster, Count = 1, Interval = 4 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ToxicWaste,
					Count = 2,
					Interval = 0.35,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 850,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monster, Count = 3, Interval = 3.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Multiplier1, Count = 2, Interval = 5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.NuclearZombie, Count = 8, Interval = 2 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.RevivedBoss2,
					Count = 3,
					Interval = 1.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.NuclearZombie,
					Count = 8,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 875,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ChargerBoss, Count = 6, Interval = 1.6 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RevivedTitan,
					Count = 2,
					Interval = 8,
					Stealth = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ArmoredHeavyZombiePlus,
					Count = 30,
					Interval = 0.75,
					Stealth = true
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 2,
					Interval = 8,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 3000,
			OverrideXP = 300,
			CustomWaveTime = 250,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Predator,
					Count = 3,
					Interval = 5,
					Stealth = true
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 2,
					Interval = 0.5,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ChargerBoss,
					Count = 12,
					Interval = 2.4
				},
				{
					StartDelay = 1.2,
					EnemyType = Enums.Enemies.ChargerBoss,
					Count = 12,
					Interval = 2.4,
					Stealth = true
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 2,
					Interval = 0.85
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 30,
					Interval = 1.6
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss2, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 1050,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Smasher, Count = 1, Interval = 4 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ToxicWaste,
					Count = 35,
					Interval = 0.85
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut,
					Count = 25,
					Interval = 1
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 3,
					Interval = 3.5
				}
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Monster,
					Count = 3,
					Interval = 5,
					Stealth = true
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 3,
					Interval = 0.8,
					Stealth = true
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Multiplier1,
					Count = 2,
					Interval = 2,
					Stealth = true
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Jammer,
					Count = 4,
					Interval = 5,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1150,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 12,
					Interval = 0.75
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Infiltrator,
					Count = 16,
					Interval = 0.85
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Monster, Count = 7, Interval = 3.5 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Jammer,
					Count = 5,
					Interval = 4,
					STealth = true
				}
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ChargerBoss, Count = 16, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 1,
					Interval = 0.85
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RevivedTitan,
					Count = 4,
					Interval = 1.5
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 12,
					Interval = 1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier2, Count = 2, Interval = 6 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.ToxicWaste,
					Count = 20,
					Interval = 0.85
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 8,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 1300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 7,
					Interval = 0.7
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Infiltrator,
					Count = 20,
					Interval = 0.85
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.RevivedBoss2, Count = 7, Interval = 4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 2, Interval = 7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Smasher, Count = 3, Interval = 9 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 3,
					Interval = 4,
					Stealth = true
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.ToxicWaste, Count = 15, Interval = 1 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Jammer,
					Count = 10,
					Interval = 4,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 30,
					Interval = 0.8,
					Stealth = true
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 3,
					Interval = 6,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jammer,
					Count = 4,
					Interval = 4,
					Stealth = true
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.Smasher, Count = 1, Interval = 2 },
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 1,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.ToxicWaste, Count = 15, Interval = 1.2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 3 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 2,
					Interval = 0.25,
					Stealth = true
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.Multiplier2, Count = 2, Interval = 1 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 2,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1800,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 40,
					Interval = 0.9,
					Stealth = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 3,
					Interval = 6,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToxicWaste,
					Count = 145,
					Interval = 0.3
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Multiplier2, Count = 5, Interval = 8 },
				{
					StartDelay = 58,
					EnemyType = Enums.Enemies.Zombie,
					Count = 1,
					Interval = 0,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 10000,
			OverrideXP = 5000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMK2,
					Count = 1,
					Interval = 0.75
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 8,
					Interval = 2.5
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.RevivedBoss2,
					Count = 10,
					Interval = 3,
					Stealth = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.ToxicWaste, Count = 30, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Infiltrator,
					Count = 40,
					Interval = 0.4
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 10,
					Interval = 1.4,
					Stealth = true
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 10,
					Interval = 1.4
				}
			}
		}
	}
}