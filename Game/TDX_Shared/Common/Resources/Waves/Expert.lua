local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Expert",
	DefeatScreenRenderName = "Expert",
	PlayerCountToStartingCashMap = { 1200, 925, 900, 850 },
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.4 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.25, CashPerDamageShared = 0 },
		{ MaxLevel = 30, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.15, CashPerDamageShared = 0 },
		{ MaxLevel = 60, CashPerDamage = 0.1, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.05, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 0 },
		{ WaveNumber = 5, GoldReward = 20, TokensReward = 0 },
		{ WaveNumber = 8, GoldReward = 80, TokensReward = 0 },
		{ WaveNumber = 14, GoldReward = 140, TokensReward = 0 },
		{ WaveNumber = 16, GoldReward = 195, TokensReward = 0 },
		{ WaveNumber = 20, GoldReward = 220, TokensReward = 0 },
		{ WaveNumber = 24, GoldReward = 300, TokensReward = 0 },
		{ WaveNumber = 27, GoldReward = 350, TokensReward = 0 },
		{ WaveNumber = 29, GoldReward = 625, TokensReward = 0 },
		{ WaveNumber = 30, GoldReward = 925, TokensReward = 0 },
		{ WaveNumber = 33, GoldReward = 1000, TokensReward = 0 },
		{ WaveNumber = 35, GoldReward = 1200, TokensReward = 0 },
		{ WaveNumber = 38, GoldReward = 1300, TokensReward = 0 },
		{ WaveNumber = 40, GoldReward = 1775, TokensReward = 225 },
		{ WaveNumber = 42, GoldReward = 2800, CrystalsReward = 85, TokensReward = 225 }
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
			WaveNumber = 18,
			CostGold = 700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7000,
			GainHP = 500
		},
		{
			WaveNumber = 24,
			CostGold = 925,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 9000,
			GainHP = 1000
		},
		{
			WaveNumber = 29,
			CostGold = 1400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 40000,
			GainHP = 2000
		},
		{
			WaveNumber = 33,
			CostGold = 1700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 45000,
			GainHP = 2500
		},
		{
			WaveNumber = 37,
			CostGold = 1925,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 50000,
			GainHP = 4500
		},
		{
			WaveNumber = 39,
			CostGold = 2400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 80000,
			GainHP = 7000
		},
		{
			WaveNumber = 41,
			CostGold = 3350,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 250000,
			GainHP = 12000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 3,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 8,
				[Enums.PowerUps.AC130Support] = 5,
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
	DefaultXPPerWavePassed = 150,
	StartingLives = 250,
	SetUpTime = 20,
	HasDialogueSequenceData = true,
	TowerCostMultiplierMap = { [Enums.Towers.Ranger] = 0.8 },
	AmbientPlaylist = {
		"Expert1",
		"Expert2",
		"Expert3",
		"Expert4",
		"Expert5",
		"Expert6",
		"Expert7",
		"Expert8",
		"Expert9",
		"Expert10",
		"Expert11",
		"Expert12",
		"Expert13",
		"Expert14"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Normal, Count = 11, Interval = 1 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Normal, Count = 14, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Quick, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Normal, Count = 11, Interval = 0.9 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Quick, Count = 4, Interval = 1 }
			}
		},
		{
			CashBonus = 575,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Quick, Count = 8, Interval = 1.2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Slow, Count = 7, Interval = 1.75 }
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Normal, Count = 20, Interval = 0.85 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Quick, Count = 3, Interval = 0.25 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Quick, Count = 3, Interval = 0.25 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.Quick, Count = 3, Interval = 0.25 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.Quick, Count = 3, Interval = 0.25 }
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slow, Count = 15, Interval = 1.25 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Quick, Count = 5, Interval = 0.25 }
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.XSoldier, Count = 1, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Quick, Count = 7, Interval = 0.3 }
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Quick, Count = 17, Interval = 0.7 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.XSoldier, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ExosuitZombie, Count = 2, Interval = 4 },
				{ StartDelay = 4.5, EnemyType = Enums.Enemies.Quick, Count = 2, Interval = 0.3 },
				{ StartDelay = 9, EnemyType = Enums.Enemies.XSoldier, Count = 1, Interval = 4 }
			}
		},
		{
			CashBonus = 1100,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Quick, Count = 40, Interval = 0.23 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.HeavyTitan, Count = 1, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1250,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{ StartDelay = 10, EnemyType = Enums.Enemies.Skulldrone, Count = 3, Interval = 3.4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.ExosuitZombie, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 1300,
			CustomWaveTime = 90,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyTitan, Count = 2, Interval = 10 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Quick,
					Count = 3,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Quick,
					Count = 4,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Quick,
					Count = 5,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.Quick,
					Count = 6,
					Interval = 0.15,
					Stealth = true
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.Quick,
					Count = 7,
					Interval = 0.15,
					Stealth = true
				},
				{ StartDelay = 17, EnemyType = Enums.Enemies.Quick, Count = 8, Interval = 0.15 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.Quick, Count = 9, Interval = 0.15 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.Skulldrone, Count = 3, Interval = 1.5 },
				{ StartDelay = 22, EnemyType = Enums.Enemies.Skulldrone, Count = 7, Interval = 1.5 }
			}
		},
		{
			CashBonus = 1400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Buzzard, Count = 7, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.XSoldier, Count = 1, Interval = 0.7 },
				{ StartDelay = 8.5, EnemyType = Enums.Enemies.Quick, Count = 12, Interval = 0.2 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.HeavyTitan, Count = 1, Interval = 5 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ExosuitZombie,
					Count = 8,
					Interval = 1.7
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Grenadier, Count = 2, Interval = 5 },
				{ StartDelay = 8, EnemyType = Enums.Enemies.Buzzard, Count = 3, Interval = 3 }
			}
		},
		{
			CashBonus = 1550,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Buzzard, Count = 15, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1600,
			CustomWaveTime = 90,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyTitan, Count = 3, Interval = 1.7 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 2,
					Interval = 1.7
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.ExosuitZombie,
					Count = 6,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 1650,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Jumper, Count = 1, Interval = 5 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Jumper,
					Stealth = true,
					Count = 1,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 130,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Quick,
					AdditionalShieldMultiplier = 4.5,
					Count = 20,
					Interval = 0.1
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.Quick,
					AdditionalShieldMultiplier = 3.5,
					Count = 20,
					Interval = 0.1
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 2,
					AdditionalSpeedBoostMultiplier = 1,
					Interval = 4
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.Jumper, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 1750,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ExosuitZombie,
					Stealth = true,
					Count = 3,
					Interval = 1.7
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Buzzard,
					Stealth = true,
					Count = 3,
					Interval = 0.8
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.HeavyTitan,
					Stealth = true,
					Count = 1,
					Interval = 1.7
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Grenadier,
					Stealth = true,
					Count = 3,
					Interval = 1.7
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Jumper,
					Count = 1,
					Stealth = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1800,
			CustomWaveTime = 90,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 2,
					Interval = 7
				},
				{
					StartDelay = 3.5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.XSoldier,
					AdditionalShieldMultiplier = 1,
					Count = 2,
					Interval = 6
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Jumper, Count = 3, Interval = 6 }
			}
		},
		{
			CashBonus = 2150,
			CustomWaveTime = 90,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slow,
					Count = 30,
					AdditionalHealthMultiplier = 1.5,
					Interval = 0.6
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Skulldrone,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Skulldrone,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.Skulldrone,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.XSoldier,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 6
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Skulldrone,
					Count = 6,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 2450,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{ StartDelay = 3.2, EnemyType = Enums.Enemies.Purgatory, Count = 1, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Quick,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 1,
					Count = 30,
					Interval = 0.25
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.Jumper, Count = 1, Interval = 5 }
			}
		},
		{
			CashBonus = 3000,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					Count = 8,
					AdditionalShieldMultiplier = 1,
					Interval = 2.6
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Jumper,
					Count = 3,
					Stealth = true,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 3375,
			CustomWaveTime = 90,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 9, EnemyType = Enums.Enemies.SpeedDeployer, Count = 1, Interval = 7 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 2,
					Interval = 3,
					AdditionalShieldMultiplier = 0.4
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.RevivedBoss1, Count = 5, Interval = 1 },
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.XSoldier,
					Count = 3,
					Interval = 1,
					Stealth = true,
					AdditionalShieldMultiplier = 1.5
				}
			}
		},
		{
			CashBonus = 3650,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.Bounded, Count = 1, Interval = 0.85 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ExosuitZombie,
					Count = 2,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 140,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 6,
					Interval = 2.5
				},
				{
					StartDelay = 8.5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					Interval = 2.5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Jumper,
					Count = 5,
					Interval = 3.5,
					Stealth = true
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.RevivedBoss1,
					Count = 8,
					Interval = 0.75,
					Stealth = true
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Buzzard, Count = 3, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ExosuitZombie,
					Count = 6,
					Interval = 1,
					AdditionalHealthMultiplier = 1,
					Stealth = true
				},
				{
					StartDelay = 34,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					AdditionalShieldMultiplier = 0.3,
					Interval = 0.75
				},
				{
					StartDelay = 36,
					EnemyType = Enums.Enemies.XSoldier,
					Count = 4,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 2
				},
				{ StartDelay = 40, EnemyType = Enums.Enemies.Buzzard, Count = 7, Interval = 1 },
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.Jumper,
					Count = 2,
					Stealth = true,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 5250,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 2,
					Interval = 6
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.Quick,
					Count = 150,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.6,
					Interval = 0.4
				},
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 1,
					AdditionalShieldMultiplier = 0.45,
					Interval = 6
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 8,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 7250,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 1,
					AdditionalHealthMultiplier = 0.2,
					Interval = 6
				},
				{ StartDelay = 1.2, EnemyType = Enums.Enemies.Multiplier1, Count = 1, Interval = 2 },
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.Bounded,
					Count = 1,
					Stealth = true,
					Interval = 0.85
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Buzzard,
					AdditionalSpeedBoostMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.5,
					Count = 12,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 19000,
			CustomWaveTime = 220,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{ StartDelay = 1.5, EnemyType = Enums.Enemies.Pilot, Count = 4, Interval = 18 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedAbomination,
					AdditionalHealthMultiplier = 0.1,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RevivedMonster,
					AdditionalShieldMultiplier = 0.35,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Predator,
					AdditionalShieldMultiplier = 0.5,
					Count = 2,
					Interval = 7
				},
				{
					StartDelay = 9.5,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 1,
					Stealth = true,
					AdditionalShieldMultiplier = 0.45,
					Interval = 6
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalShieldMultiplier = 1,
					Count = 10,
					Interval = 3
				},
				{
					StartDelay = 23,
					EnemyType = Enums.Enemies.XSoldier,
					AdditionalShieldMultiplier = 2,
					Count = 5,
					Interval = 2
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 1,
					Stealth = true,
					AdditionalShieldMultiplier = 0.45,
					Interval = 6
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 3,
					Interval = 0.3
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 1,
					Stealth = true,
					AdditionalShieldMultiplier = 0.45,
					Interval = 6
				},
				{
					StartDelay = 33,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 7,
					AdditionalHealthMultiplier = 1,
					Interval = 2
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 1,
					Interval = 0.85
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 1,
					Interval = 0.85
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Bounded,
					Count = 1,
					Stealth = true,
					Interval = 0.85
				},
				{
					StartDelay = 62,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					Stealth = true,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 35000,
			CashMultiplierOverride = 0.8,
			OverrideXP = 750,
			CustomWaveTime = 320,
			OverrideAmbientPlaylist = { "ExpertWave30Music" },
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Phobeus, Count = 1, Interval = 0.5 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Zeus, Count = 1, Interval = 2.4 },
				{ StartDelay = 13, EnemyType = Enums.Enemies.Artemis, Count = 1, Interval = 2.4 },
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.XSoldier,
					Count = 5,
					AdditionalHealthMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 1,
					AdditionalHealthMultiplier = 0.5,
					Interval = 0.85
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 1,
					AdditionalShieldMultiplier = 0.3,
					Interval = 8
				},
				{
					StartDelay = 56,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 3,
					AdditionalHealthMultiplier = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 7250,
			CustomWaveTime = 90,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 0.4,
					Interval = 0.4
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					AdditionalShieldMultiplier = 1.5,
					Interval = 5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Bounded, Count = 5, Interval = 5 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ArmoredRunner,
					Count = 10,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 1
				},
				{
					StartDelay = 15.5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 1,
					AdditionalShieldMultiplier = 1.5,
					Interval = 5
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.Jumper,
					Count = 7,
					AdditionalHealthMultiplier = 2.5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 7500,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 4,
					Interval = 3.5
				},
				{ StartDelay = 18, EnemyType = Enums.Enemies.Pilot, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 7750,
			CustomWaveTime = 180,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 1,
					Interval = 3.5
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 16,
					AdditionalHealthMultiplier = 0.5,
					Interval = 2
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Purgatory, Count = 2, Interval = 5 },
				{
					StartDelay = 34,
					EnemyType = Enums.Enemies.Bounded,
					Count = 1,
					AdditionalHealthMultiplier = 0.5,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8000,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					Count = 24,
					Stealth = true,
					AdditionalHealthMultiplier = 2.5,
					AdditionalShieldMultiplier = 3,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 8250,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 300,
			OverrideXP = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Pilot, Count = 10, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 0.7 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 50,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 1,
					Interval = 0.7
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Skulldrone,
					Count = 20,
					AdditionalShieldMultiplier = 7,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 8500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Pilot,
					Count = 42,
					AdditionalSpeedBoostMultiplier = 0.1,
					AdditionalShieldMultiplier = 1,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 8750,
			CustomWaveTime = 140,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.XJuggernaut, Count = 2, Interval = 5.5 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Purgatory,
					Count = 4,
					AdditionalShieldMultiplier = 1.5,
					Interval = 3
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.DamageDeployer,
					Count = 1,
					Interval = 3
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.TitanCharger, Count = 1, Interval = 1 },
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 23,
					EnemyType = Enums.Enemies.RevivedMonster,
					Count = 1,
					AdditionalHealthMultiplier = 1.2,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 9000,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedAbomination,
					Count = 80,
					Interval = 0.3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SpeedDeployer,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 15000,
			CashMultiplierOverride = 0.45,
			CustomWaveTime = 190,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.XJuggernaut, Count = 3, Interval = 3 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.XOrdinal, Count = 5, Interval = 4 },
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.XSoldier,
					Count = 12,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 5,
					Interval = 1.3
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.XJuggernaut,
					AdditionalShieldMultiplier = 1.5,
					Count = 3,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 75000,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 360,
			OverrideXP = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 5,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Destructor, Count = 1, Interval = 2.5 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalShieldMultiplier = 1,
					Count = 6,
					Interval = 2.5
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.DamageDeployer,
					Count = 1,
					Interval = 2.5
				},
				{ StartDelay = 29, EnemyType = Enums.Enemies.XJuggernaut, Count = 2, Interval = 3 },
				{ StartDelay = 48, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 2 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.XOrdinal, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 120000,
			CashMultiplierOverride = 1.1,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 23,
					Stealth = true,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 200000,
			OverrideXP = 2150,
			CashMultiplierOverride = 0.85,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMK2Rework,
					Count = 1,
					Interval = 0.9
				}
			}
		}
	}
}