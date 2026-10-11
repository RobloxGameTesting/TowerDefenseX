local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Elite",
	StartingCash = 650,
	CashPerDamageData = {
		{ CashPerDamage = 1.32, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.35 },
		{ CashPerDamage = 0.95, CashPerDamageShared = 0.475 },
		{ CashPerDamage = 0.725, CashPerDamageShared = 0.375 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 25, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 85, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 350, TokensReward = 0 },
		{ WaveNumber = 20, GoldReward = 575, TokensReward = 0 },
		{ WaveNumber = 23, GoldReward = 725, TokensReward = 0 },
		{ WaveNumber = 26, GoldReward = 825, TokensReward = 0 },
		{ WaveNumber = 28, GoldReward = 975, TokensReward = 0 },
		{ WaveNumber = 31, GoldReward = 1275, TokensReward = 0 },
		{ WaveNumber = 34, GoldReward = 1975, TokensReward = 115 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 750,
			GainHP = 150
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1250,
			GainHP = 225
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2500,
			GainHP = 300
		},
		{
			WaveNumber = 10,
			CostGold = 450,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 2750,
			GainHP = 350
		},
		{
			WaveNumber = 12,
			CostGold = 500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 3250,
			GainHP = 400
		},
		{
			WaveNumber = 18,
			CostGold = 700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 5750,
			GainHP = 650
		},
		{
			WaveNumber = 22,
			CostGold = 850,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 9000,
			GainHP = 1000
		},
		{
			WaveNumber = 26,
			CostGold = 1100,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 25000,
			GainHP = 2000
		},
		{
			WaveNumber = 31,
			CostGold = 1500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 75000,
			GainHP = 3000
		},
		{
			WaveNumber = 34,
			CostGold = 1700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 125000,
			GainHP = 8000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 3,
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
	DefaultXPPerWavePassed = 120,
	StartingLives = 350,
	SetUpTime = 15,
	TowerCostMultiplierMap = { [Enums.Towers.Ranger] = 0.7 },
	AmbientPlaylist = {
		"Elite1",
		"Elite2",
		"Elite3",
		"Elite4",
		"Elite5",
		"Elite6",
		"Elite7",
		"Elite8",
		"Elite9",
		"Elite10"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 11, Interval = 0.8 }
			}
		},
		{
			CashBonus = 325,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 18, Interval = 0.7 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 30, Interval = 0.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Slaw, Count = 4, Interval = 3.5 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 42, Interval = 0.45 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Slaw, Count = 7, Interval = 2.5 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 70, Interval = 0.4 },
				{ StartDelay = 3.5, EnemyType = Enums.Enemies.Skeleton, Count = 4, Interval = 5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Slaw, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Skeleton, Count = 10, Interval = 2.5 },
				{ StartDelay = 1.5, EnemyType = Enums.Enemies.Infected, Count = 25, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Slaw, Count = 4, Interval = 4 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Infected,
					Count = 60,
					Stealth = true,
					Interval = 0.3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Multiplier1,
					Count = 3,
					Stealth = true,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Skeleton, Count = 14, Interval = 1.5 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Slaw,
					Count = 25,
					Interval = 0.3,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiantSkeleton, Count = 3, Interval = 4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Skeleton, Count = 9, Interval = 1.5 }
			}
		},
		{
			CashBonus = 475,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Infected, Count = 80, Interval = 0.25 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Skeleton, Count = 4, Interval = 1 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedRanger1,
					Count = 5,
					Interval = 3
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.GiantSkeleton,
					Stealth = true,
					Count = 2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Mage, Count = 1, Interval = 1.3 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantSkeleton,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Knyght, Count = 10, Interval = 1 }
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.ResurrectedRanger1,
					Count = 13,
					Interval = 1.2,
					Stealth = true
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Infected,
					Count = 80,
					Interval = 0.5,
					Stealth = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Knyght, Count = 3, Interval = 0.5 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Slaw,
					Count = 25,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 575,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Amalgam, Count = 5, Interval = 1 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Skeleton, Count = 40, Interval = 0.5 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Knyght, Count = 3, Interval = 4.5 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.GiantSkeleton,
					Count = 3,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantSkeleton,
					Count = 8,
					Stealth = true,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 1000,
			CustomWaveTime = 130,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Mage,
					Count = 1,
					AdditionalShieldMultiplier = 0.7,
					Interval = 14
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Amalgam,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Infected,
					AdditionalShieldMultiplier = 0.1,
					AdditionalHealthMultiplier = 5,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 140,
					Interval = 0.3
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Knyght,
					Count = 15,
					AdditionalShieldMultiplier = 0.2,
					Interval = 2.3
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Slaw,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 25,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 650,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Berserker, Count = 3, Interval = 4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Javelin, Count = 7, Interval = 1.2 },
				{ StartDelay = 1.5, EnemyType = Enums.Enemies.Knyght, Count = 9, Interval = 2.3 }
			}
		},
		{
			CashBonus = 675,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Amalgam, Count = 15, Interval = 0.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Javelin, Count = 6, Interval = 3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Berserker, Count = 2, Interval = 7 }
			}
		},
		{
			CashBonus = 1200,
			CashMultiplierOverride = 0.4,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Knyght, Count = 70, Interval = 0.4 },
				{ StartDelay = 1.4, EnemyType = Enums.Enemies.Multiplier2, Count = 5, Interval = 5 }
			}
		},
		{
			CashBonus = 1300,
			CustomWaveTime = 120,
			CashMultiplierOverride = 0.65,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.MechaMutant, Count = 5, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 40,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 1350,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.LavaGolem, Count = 3, Interval = 12 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.MechaMutant, Count = 3, Interval = 7 },
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 3,
					Interval = 0.75
				},
				{
					StartDelay = 23,
					EnemyType = Enums.Enemies.MutatedZombie,
					Count = 3,
					Interval = 0.75
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Infected,
					AdditionalHealthMultiplier = 3,
					Count = 180,
					Interval = 0.35
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Javelin,
					Count = 6,
					AdditionalHealthMultiplier = 0.3,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.Mage,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 0.5,
					Count = 4,
					Interval = 4.2
				},
				{
					StartDelay = 0.3,
					EnemyType = Enums.Enemies.Infected,
					Count = 300,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.35,
					Interval = 0.3,
					Stealth = false
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.Slaw,
					Count = 50,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.35,
					Interval = 0.75,
					Stealth = false
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.LavaGolem,
					Count = 3,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.3,
					AdditionalSpeedBoostMultiplier = 0.05,
					Interval = 15
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Berserker,
					Count = 8,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 2450,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.IronBastion, Count = 1, Interval = 5 },
				{ StartDelay = 24, EnemyType = Enums.Enemies.MechaMutant, Count = 1, Interval = 2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Berserker, Count = 10, Interval = 2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Javelin, Count = 3, Interval = 0.4 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Javelin, Count = 3, Interval = 0.4 }
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedMutatedZombie,
					Count = 4,
					AdditionalShieldMultiplier = 2.2,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 260,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.LavaGolem, Count = 24, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Amalgam, Count = 60, Interval = 1 }
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedBoss2,
					Count = 30,
					AdditionalShieldMultiplier = 0.75,
					Interval = 1
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.RevivedBoss1,
					AdditionalShieldMultiplier = 5,
					Count = 30,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 400,
			OverrideXP = 1200,
			CashMultiplierOverride = 0.65,
			OverrideAmbientPlaylist = { "EliteWave27Music" },
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.King, Count = 1, Interval = 1 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Queen, Count = 1, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GoldenKnight,
					Count = 80,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 2500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TankKnyght, Count = 1, Interval = 0.5 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.PlagueBird,
					Count = 20,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 2750,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankKnyght,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 0.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Specter,
					AdditionalShieldMultiplier = 0.4,
					Count = 1,
					Interval = 2.5
				},
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 6,
					AdditionalShieldMultiplier = 2,
					Interval = 3.5
				}
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CyberDragon, Count = 1, Interval = 0.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.IronBastion,
					Count = 1,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 1.2,
					Interval = 2.5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Specter,
					Count = 1,
					AdditionalShieldMultiplier = 1.3,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.MechaMutant,
					Count = 15,
					AdditionalShieldMultiplier = 2.5,
					Interval = 1.2,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 4750,
			CashMultiplierOverride = 0.35,
			CustomWaveTime = 160,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedRailgunner,
					Count = 14,
					Interval = 1
				},
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.ResurrectedSlammer,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.ResurrectedJohn,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 1
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut,
					Count = 17,
					AdditionalShieldMultiplier = 2.5,
					Interval = 0.75
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.ResurrectedCryoRanger,
					Count = 2,
					AdditionalShieldMultiplier = 4,
					AdditionalHealthMultiplier = 4,
					Interval = 7
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
					Count = 1,
					Interval = 3
				},
				{ StartDelay = 30, EnemyType = Enums.Enemies.Pestilent, Count = 1, Interval = 3 },
				{
					StartDelay = 1.2,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					AdditionalShieldMultiplier = 3,
					Count = 5,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 8500,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankKnyght,
					Count = 2,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2.5
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.BatteringRam,
					Count = 1,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 15000,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 20,
					AdditionalShieldMultiplier = 1,
					Stealth = true,
					Interval = 1
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.LavaGolem,
					Count = 3,
					AdditionalShieldMultiplier = 2,
					Stealth = true,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 75000,
			OverrideXP = 2500,
			SpawnSequences = {
				{
					StartDelay = 48,
					EnemyType = Enums.Enemies.RevivedPlagueDoctorRework,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.PlagueGuardian,
					Count = 1,
					AdditionalShieldMultiplier = 2.5,
					Interval = 0.8
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.PlagueGuardian,
					Count = 2,
					AdditionalShieldMultiplier = 2.5,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankKnyght,
					AdditionalShieldMultiplier = 0.25,
					Count = 3,
					Interval = 2.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Specter,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Javelin,
					AdditionalShieldMultiplier = 0.5,
					Count = 40,
					Interval = 0.8
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Mage,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 1.5,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.GoldenKnight,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CyborgBird,
					Count = 15,
					Interval = 0.8
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.PlagueGuardian,
					Count = 1,
					AdditionalShieldMultiplier = 2,
					Interval = 0.8
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.ResurrectedJohn,
					AdditionalShieldMultiplier = 0.3,
					Count = 1,
					Interval = 0.8
				},
				{
					StartDelay = 23,
					EnemyType = Enums.Enemies.Specter,
					AdditionalHealthMultiplier = 2,
					Count = 1,
					Interval = 0.8
				}
			}
		}
	}
}