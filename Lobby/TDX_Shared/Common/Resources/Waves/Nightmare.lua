local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Nightmare",
	VictoryScreenRenderName = "Nightmare",
	DefeatScreenRenderName = "Nightmare",
	NoVictoryMusic = true,
	PlayerCountToStartingCashMap = { 12000, 8000, 7000, 6500 },
	CashPerDamageData = {
		{ CashPerDamage = 1.1, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.95, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 0.7, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.5, CashPerDamageShared = 0.3 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 20, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.25, CashPerDamageShared = 0 },
		{ MaxLevel = 50, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 70, CashPerDamage = 0.15, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.1, CashPerDamageShared = 0 },
		{ MaxLevel = 100, CashPerDamage = 0.1, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, CrystalsReward = 4, TokensReward = 0 },
		{ WaveNumber = 3, CrystalsReward = 12, TokensReward = 0 },
		{ WaveNumber = 5, CrystalsReward = 15, TokensReward = 0 },
		{ WaveNumber = 8, CrystalsReward = 28, TokensReward = 0 },
		{ WaveNumber = 11, CrystalsReward = 45, TokensReward = 0 },
		{ WaveNumber = 14, CrystalsReward = 60, TokensReward = 0 },
		{ WaveNumber = 16, CrystalsReward = 70, TokensReward = 0 },
		{ WaveNumber = 20, CrystalsReward = 125, TokensReward = 0 },
		{ WaveNumber = 24, CrystalsReward = 145, TokensReward = 0 },
		{ WaveNumber = 26, CrystalsReward = 170, TokensReward = 0 },
		{ WaveNumber = 28, CrystalsReward = 180, TokensReward = 0 },
		{ WaveNumber = 30, CrystalsReward = 200, TokensReward = 0 },
		{ WaveNumber = 33, CrystalsReward = 220, TokensReward = 0 },
		{ WaveNumber = 35, CrystalsReward = 265, TokensReward = 0 },
		{ WaveNumber = 37, CrystalsReward = 300, TokensReward = 0 },
		{ WaveNumber = 40, CrystalsReward = 375, TokensReward = 0 },
		{ WaveNumber = 43, CrystalsReward = 430, TokensReward = 0 },
		{ WaveNumber = 45, CrystalsReward = 570, TokensReward = 0 },
		{ WaveNumber = 47, CrystalsReward = 650, TokensReward = 0 },
		{ WaveNumber = 50, CrystalsReward = 925, TokensReward = 500 },
		{ WaveNumber = 51, CrystalsReward = 1320, TokensReward = 500 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 4000,
			GainHP = 100
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 8000,
			GainHP = 200
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 16500,
			GainHP = 300
		},
		{
			WaveNumber = 12,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 35000,
			GainHP = 300
		},
		{
			WaveNumber = 18,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 65000,
			GainHP = 500
		},
		{
			WaveNumber = 24,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 90000,
			GainHP = 1000
		},
		{
			WaveNumber = 29,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 115000,
			GainHP = 2000
		},
		{
			WaveNumber = 33,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 150000,
			GainHP = 2500
		},
		{
			WaveNumber = 37,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 175000,
			GainHP = 4500
		},
		{
			WaveNumber = 39,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 200000,
			GainHP = 7000
		},
		{
			WaveNumber = 43,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_105,
			GainCash = 250000,
			GainHP = 12000
		},
		{
			WaveNumber = 46,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_125,
			GainCash = 375000,
			GainHP = 14000
		},
		{
			WaveNumber = 48,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_125,
			GainCash = 500000,
			GainHP = 20000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 2,
			ChanceTable = {
				[Enums.PowerUps.DamageField] = 12,
				[Enums.PowerUps.RangeField] = 12,
				[Enums.PowerUps.SR71Strike] = 8,
				[Enums.PowerUps.UberField] = 2,
				[Enums.PowerUps.EmergencySupplyCrate] = 5
			}
		}
	},
	DefaultXPPerWavePassed = 200,
	StartingLives = 5500,
	StartingLivesOverriddenBy = {
		"CastellanReachBase",
		"SupremacyPrimeBase",
		"PacificaRuinsBase",
		"GUNFacilityBase",
		"FinalityBase"
	},
	SetUpTime = 35,
	HasDialogueSequenceData = true,
	IntroCutsceneSequence = Enums.CutsceneSequences.NightmareIntro,
	VictoryCutsceneSeqeuence = Enums.CutsceneSequences.NightmareSecretWaveVictory,
	VictoryCutsceneOnlyIfSecretWaveTriggered = true,
	PreloadEnemyNames = {
		Enums.Enemies.EradicatorMK2ReworkWithLanding,
		Enums.Enemies.Avatar,
		Enums.Enemies.Hunter,
		Enums.Enemies.ZombieDropPod1,
		Enums.Enemies.HellStar,
		Enums.Enemies.Nemesis
	},
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 1.2 },
	AmbientPlaylist = {
		"Nightmare1",
		"Nightmare2",
		"Nightmare3",
		"Nightmare4",
		"Nightmare5",
		"Nightmare6",
		"Nightmare7",
		"Nightmare8",
		"Nightmare9",
		"Nightmare10",
		"Nightmare11",
		"Nightmare12",
		"Nightmare13",
		"Nightmare14",
		"Expert2",
		"Expert6",
		"Expert8",
		"Expert4",
		"Expert13",
		"Expert1"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Walker, Count = 9, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Haste, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Walker, Count = 12, Interval = 0.7 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Haste, Count = 4, Interval = 7 }
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Lurch1,
					Count = 1,
					Stealth = true,
					Interval = 1.3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Walker, Count = 20, Interval = 0.7 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Haste, Count = 10, Interval = 1.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Buzzard, Count = 3, Interval = 4 }
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.Lurch2,
					Count = 2,
					Stealth = true,
					Interval = 2.5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Buzzard, Count = 5, Interval = 2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalHealthMultiplier = -0.2,
					Count = 1,
					Interval = 3
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.HeavyTitan, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 2250,
			CustomWaveTime = 120,
			CashMultiplierOverride = 1.25,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Walker, Count = 30, Interval = 0.8 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Buzzard, Count = 5, Interval = 0.8 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.Haste, Count = 4, Interval = 2 },
				{ StartDelay = 9, EnemyType = Enums.Enemies.HeavyTitan, Count = 2, Interval = 5 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Jumper, Count = 1, Interval = 7 }
			}
		},
		{
			CashBonus = 2750,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Chariot, Count = 1, Interval = 4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Haste, Count = 30, Interval = 1.8 },
				{ StartDelay = 9, EnemyType = Enums.Enemies.HeavyTitan, Count = 3, Interval = 8 }
			}
		},
		{
			CashBonus = 4250,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 1,
					Interval = 5.3
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Chariot, Count = 1, Interval = 4 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Buzzard, Count = 15, Interval = 1.5 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.Pilot, Count = 1, Interval = 4 }
			}
		},
		{
			CashBonus = 4500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Lurch2,
					Stealth = true,
					Count = 7,
					Interval = 1.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Lurch1,
					Stealth = true,
					Count = 6,
					Interval = 1.5
				},
				{ StartDelay = 16, EnemyType = Enums.Enemies.Chariot, Count = 1, Interval = 4 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Jumper, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Lurch3, Count = 2, Interval = 2.5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Buzzard,
					AdditionalShieldMultiplier = 0.5,
					Count = 12,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lurch3,
					Stealth = true,
					Count = 11,
					Interval = 4.5
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Buzzard,
					AdditionalShieldMultiplier = 0.5,
					Stealth = true,
					Count = 12,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 5500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					Count = 19,
					Stealth = true,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 6500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Thumper, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 8500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 5,
					Interval = 4.5
				},
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Haste, Count = 30, Interval = 0.3 },
				{ StartDelay = 16, EnemyType = Enums.Enemies.Haste, Count = 30, Interval = 0.3 },
				{ StartDelay = 30, EnemyType = Enums.Enemies.Haste, Count = 30, Interval = 0.3 }
			}
		},
		{
			CashBonus = 9000,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 20, EnemyType = Enums.Enemies.Rusher, Count = 2, Interval = 8 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Pilot, Count = 3, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Buzzard,
					AdditionalShieldMultiplier = 0.5,
					Count = 30,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 9750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Breacher, Count = 2, Interval = 6.5 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Rusher, Count = 7, Interval = 4 }
			}
		},
		{
			CashBonus = 10000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Pilot, Count = 3, Interval = 0.75 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Pilot, Count = 3, Interval = 0.75 },
				{ StartDelay = 19, EnemyType = Enums.Enemies.Pilot, Count = 3, Interval = 0.75 }
			}
		},
		{
			CashBonus = 10500,
			CustomWaveTime = 110,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Chariot, Count = 7, Interval = 3 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 19,
					Interval = 4
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Rusher, Count = 3, Interval = 12 }
			}
		},
		{
			CashBonus = 11000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Thumper, Count = 2, Interval = 2 }
			}
		},
		{
			CashBonus = 15000,
			OverrideXP = 2150,
			CustomWaveTime = 400,
			OverrideAmbientPlaylist = { "ExpertWave30Music" },
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Eradicator,
					AdditionalShieldMultiplier = 0.15,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Phobeus, Count = 1, Interval = 2 },
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Zeus, Count = 1, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Pilot, Count = 4, Interval = 0.75 },
				{
					StartDelay = 71,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 3,
					Interval = 0.75
				},
				{
					StartDelay = 0.9,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 3,
					Interval = 0.75
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Rusher, Count = 2, Interval = 3.5 },
				{ StartDelay = 42, EnemyType = Enums.Enemies.Rusher, Count = 2, Interval = 2 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.XNader, Count = 2, Interval = 3.5 },
				{ StartDelay = 95, EnemyType = Enums.Enemies.AvatarM, Count = 2, Interval = 2.5 }
			}
		},
		{
			CashBonus = 10000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Thumper, Count = 8, Interval = 2 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Rusher,
					AdditionalHealthMultiplier = 0.2,
					AdditionalShieldMultiplier = 0.1,
					Count = 16,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 11000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Maniac,
					Count = 12,
					AdditionalShieldMultiplier = 0.2,
					Interval = 1.5
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.XNader,
					AdditionalShieldMultiplier = 0.25,
					Count = 7,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 12000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.XenonTank, Count = 1, Interval = 15 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					AdditionalShieldMultiplier = 0.5,
					Count = 9,
					Interval = 0.75
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Haste,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 200,
					Interval = 0.2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Pilot,
					AdditionalHealthMultiplier = 0.5,
					Count = 6,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 35000,
			CashMultiplierOverride = 1.1,
			CustomWaveTime = 250,
			SpawnSequences = {
				{ StartDelay = 8, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 2 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 5,
					Interval = 1.8
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Maniac, Count = 8, Interval = 1.5 },
				{ StartDelay = 49, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 2 },
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 5,
					Interval = 1.8
				},
				{
					StartDelay = 52,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 3.5,
					Count = 3,
					Interval = 0.75
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.Thumper, Count = 5, Interval = 3.5 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalHealthMultiplier = 1.5,
					Count = 16,
					Interval = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 3.5,
					Count = 3,
					Interval = 1.3
				},
				{ StartDelay = 72, EnemyType = Enums.Enemies.AntiGolem, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 75000,
			CashMultiplierOverride = 0.9,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 9, Interval = 8.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TitanCharger, Count = 4, Interval = 12 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 2,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 150000,
			CashMultiplierOverride = 0.8,
			OverrideXP = 2800,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.EradicatorMK4Nightmare,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 30, EnemyType = Enums.Enemies.XenonTank, Count = 1, Interval = 2 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Rusher,
					AdditionalHealthMultiplier = 0.25,
					Count = 10,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 2,
					Interval = 0.7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ZombieDropPod2,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 3,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 10000,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.Dreadcubus, Count = 5, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 4,
					Interval = 0.85
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.ZombieDropPod2,
					AdditionalShieldMultiplier = 0.25,
					Count = 3,
					Interval = 1.5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 4,
					Interval = 0.85
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 15,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 12000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.NuclearTank, Count = 1, Interval = 2 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 4,
					Interval = 9
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.Ravage, Count = 5, Interval = 4 }
			}
		},
		{
			CashBonus = 15000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Breacher,
					AdditionalShieldMultiplier = 0.7,
					Count = 20,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 100000,
			CustomWaveTime = 500,
			OverrideXP = 3250,
			CashMultiplierOverride = 0.65,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Destructor, Count = 2, Interval = 64 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 4,
					Interval = 0.5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Cybercubus, Count = 1, Interval = 12 },
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.RevivedMonsterPlus,
					Count = 1,
					Interval = 3.5
				},
				{ StartDelay = 30, EnemyType = Enums.Enemies.Bounded, Count = 2, Interval = 4 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 7,
					Interval = 3
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 10 },
				{ StartDelay = 80, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 10 }
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cybercubus, Count = 3, Interval = 8 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieDropPod2,
					Count = 3,
					Interval = 1.5
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.AvatarR, Count = 3, Interval = 1.5 }
			}
		},
		{
			CashBonus = 17000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RevivedMonsterPlus,
					Count = 5,
					Interval = 5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Thumper,
					AdditionalShieldMultiplier = 2.5,
					Count = 40,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 19000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieDropPod3,
					AdditionalShieldMultiplier = 0.35,
					Count = 7,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 7,
					Interval = 1.4
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Thumper, Count = 15, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Bounded,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 2.25
				}
			}
		},
		{
			CashBonus = 21000,
			CustomWaveTime = 160,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TitanCharger, Count = 7, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Dispenser, Count = 2, Interval = 5 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RevivedMonsterPlus,
					Count = 6,
					Interval = 5
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ZombieDropPod3,
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 0.7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Chariot,
					AdditionalShieldMultiplier = 2,
					AdditionalHealthMultiplier = 3,
					Count = 10,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 200000,
			CustomWaveTime = 600,
			OverrideXP = 3750,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMKIC,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 4,
					Interval = 0.9
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.AvatarM,
					AdditionalShieldMultiplier = 0.5,
					Count = 2,
					Interval = 1.5
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.Rusher,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 0.7,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.RocketDrone,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 1.4
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.HealingDrone,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 1.4
				},
				{ StartDelay = 40, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 3.5 }
			}
		},
		{
			CashBonus = 25000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JX,
					Stealth = true,
					Count = 10,
					Interval = 0.9
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Dispenser,
					AdditionalShieldMultiplier = 0.25,
					Stealth = true,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Lurch2,
					AdditionalShieldMultiplier = 10,
					AdditionalHealthMultiplier = 15,
					Stealth = true,
					Count = 10,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Rusher,
					Stealth = true,
					AdditionalShieldMultiplier = 1,
					Count = 9,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 100000,
			CustomWaveTime = 550,
			OverrideAmbientPlaylist = { "NightmareWave37" },
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JX,
					Count = 5,
					Stealth = true,
					Interval = 0.75
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SpawnDeployer,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Ravage,
					Count = 9,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 1.5
				},
				{ StartDelay = 17, EnemyType = Enums.Enemies.Cybercubus, Count = 2, Interval = 3.5 },
				{ StartDelay = 30, EnemyType = Enums.Enemies.XenonTank, Count = 1, Interval = 3.5 },
				{
					StartDelay = 48,
					EnemyType = Enums.Enemies.SpawnDeployer,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 33,
					EnemyType = Enums.Enemies.JX,
					Count = 5,
					Stealth = true,
					Interval = 0.75
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Rusher,
					Count = 9,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.HunterNightmare,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.Thumper,
					Count = 12,
					AdditionalShieldMultiplier = 1.5,
					Interval = 1
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.SpawnDeployer,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.Ravage,
					Count = 8,
					AdditionalShieldMultiplier = 0.6,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 1
				},
				{ StartDelay = 125, EnemyType = Enums.Enemies.XenonTank, Count = 3, Interval = 20 },
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 4,
					Count = 3,
					Interval = 2
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.RevivedMonsterPlus,
					AdditionalShieldMultiplier = 0.2,
					Count = 3,
					Interval = 8
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.Chariot,
					Count = 15,
					AdditionalHealthMultiplier = 6.5,
					AdditionalShieldMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.5,
					Interval = 1.5
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.SpawnDeployer,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.Jager,
					AdditionalShieldMultiplier = 0.85,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.Cybercubus,
					Count = 2,
					Interval = 3.5
				},
				{
					StartDelay = 270,
					EnemyType = Enums.Enemies.Cybercubus,
					Count = 5,
					Interval = 3.5
				},
				{
					StartDelay = 185,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 20,
					Interval = 7.5
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.AvatarM,
					Count = 5,
					AdditionalHealthMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.25,
					Interval = 3
				},
				{
					StartDelay = 285,
					EnemyType = Enums.Enemies.XenonTank,
					AdditionalShieldMultiplier = 0.7,
					Count = 2,
					Interval = 9
				},
				{
					StartDelay = 230,
					EnemyType = Enums.Enemies.JX,
					Count = 9,
					Stealth = true,
					Interval = 0.75
				},
				{
					StartDelay = 270,
					EnemyType = Enums.Enemies.ZombieDropPod3,
					AdditionalShieldMultiplier = 0.7,
					Count = 6,
					Interval = 0.25
				},
				{
					StartDelay = 310,
					EnemyType = Enums.Enemies.HunterNightmare,
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.TitanCharger,
					AdditionalHealthMultiplier = 0.25,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 303,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 4,
					Count = 5,
					Interval = 2
				},
				{
					StartDelay = 330,
					EnemyType = Enums.Enemies.SpawnDeployer,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.Grumble,
					AdditionalShieldMultiplier = 1.2,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 315,
					EnemyType = Enums.Enemies.Rusher,
					AdditionalHealthMultiplier = 3,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 310,
					EnemyType = Enums.Enemies.NuclearTank,
					AdditionalShieldMultiplier = 2.5,
					AdditionalSpeedMultiplier = 0.25,
					Count = 7,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 27000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.MultiplierX,
					AdditionalShieldMultiplier = 3.5,
					Count = 1,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 29000,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Rusher,
					Count = 25,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 1 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Artemis,
					AdditionalHealthMultiplier = 0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.XNader,
					Count = 10,
					AdditionalShieldMultiplier = 1,
					Interval = 2.5
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.RocketDrone,
					Count = 10,
					Interval = 2.5
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Pilot,
					AdditionalShieldMultiplier = 1,
					Count = 14,
					Interval = 0.45
				},
				{ StartDelay = 45, EnemyType = Enums.Enemies.VXDrone, Count = 1, Interval = 1 },
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 10,
					Interval = 4.5
				},
				{
					StartDelay = 42,
					EnemyType = Enums.Enemies.Rusher,
					Count = 25,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Pilot,
					AdditionalShieldMultiplier = 1,
					Count = 14,
					Interval = 0.45
				},
				{ StartDelay = 50, EnemyType = Enums.Enemies.RocketDrone, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 37500,
			OverrideXP = 2150,
			CustomWaveTime = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.X2Trooper, Count = 1, Interval = 2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.X2Fighter, Count = 2, Interval = 4 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Jager,
					AdditionalShieldMultiplier = 0.5,
					AdditionalHealthMultiplier = 0.75,
					Count = 2,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 40000,
			CashMultiplierOverride = 0.25,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearTank,
					AdditionalHealthMultiplier = 0.5,
					Count = 20,
					Interval = 2
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 2.75
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Dispenser,
					AdditionalHealthMultiplier = 1.5,
					AdditionalSpeedMultiplier = 0.2,
					Count = 3,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 42000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JX,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedMultiplier = 0.25,
					Count = 35,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Dispenser,
					AdditionalHealthMultiplier = 2.5,
					AdditionalSpeedMultiplier = 0.2,
					Count = 3,
					Interval = 2.5
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 4.5,
					Count = 7,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 45000,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Thumper,
					Count = 60,
					AdditionalShieldMultiplier = 2,
					AdditionalHealthMultiplier = 1,
					Interval = 0.7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ZombieDropPod3,
					AdditionalShieldMultiplier = 2,
					Count = 14,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 47500,
			CustomWaveTime = 180,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 18, Interval = 2 }
			}
		},
		{
			CashBonus = 250000,
			OverrideXP = 4000,
			CashMultiplierOverride = 0.65,
			CustomWaveTime = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.AlphaPredator, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 27000,
			CashMultiplierOverride = 0.15,
			CustomWaveTime = 150,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AntiGolem,
					Count = 1,
					AdditionalHealthMultiplier = 3.5,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 300000,
			CashMultiplierOverride = 0.65,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMK2ReworkWithLanding,
					Count = 2,
					Interval = 1.7
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.EradicatorMK2,
					AdditionalShieldMultiplier = 2,
					Count = 2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 27000,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ZombieDropPod4,
					Count = 7,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Cybercubus,
					AdditionalHealthMultiplier = 1,
					Count = 2,
					Interval = 4
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Dreadcubus,
					AdditionalHealthMultiplier = 1.5,
					Count = 10,
					Interval = 4.2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.HunterNightmare,
					AdditionalHealthMultiplier = 1.5,
					Count = 3,
					Interval = 4.2
				}
			}
		},
		{
			CashBonus = 27000,
			CustomWaveTime = 200,
			CashMultiplierOverride = 0.1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					AdditionalHealthMultiplier = 7,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1000000,
			CustomWaveTime = 1e999,
			SkipWaveDisabled = true,
			OverrideXP = 5000,
			LockSpeedMultiplierTo1 = true,
			CashMultiplierOverride = 0.6,
			OverrideAmbientPlaylist = { "EmperorDeathAmbient" },
			TimeUntilNextWaveIfSecretWaveTriggered = 42,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Emperor, Count = 1, Interval = 2 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ZombieDropPod5,
					Count = 7,
					Interval = 36
				}
			}
		},
		{
			CashBonus = 0,
			OverrideXP = 15000,
			LockSpeedMultiplierTo1 = true,
			CashMultiplierOverride = 0.39,
			OverrideAmbientPlaylist = { "NightmareSpecialWaveAmbient" },
			IsSecretWave = true,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Redacted, Count = 1, Interval = 2 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.NightmareCalamity1,
					Count = 1,
					Interval = 2
				},
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Gargoyle, Count = 25, Interval = 3 },
				{ StartDelay = 42, EnemyType = Enums.Enemies.DarkPresence, Count = 1, Interval = 3 },
				{ StartDelay = 30, EnemyType = Enums.Enemies.Forsaken, Count = 3, Interval = 3 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.Fragment, Count = 10, Interval = 7 },
				{ StartDelay = 130, EnemyType = Enums.Enemies.Brimstone, Count = 7, Interval = 5 },
				{
					StartDelay = 185,
					EnemyType = Enums.Enemies.NightmareEndbringer,
					Count = 5,
					Interval = 7
				},
				{ StartDelay = 260, EnemyType = Enums.Enemies.IronMaiden, Count = 5, Interval = 5 },
				{ StartDelay = 290, EnemyType = Enums.Enemies.Fragment, Count = 4, Interval = 2.5 },
				{ StartDelay = 300, EnemyType = Enums.Enemies.Nemesis, Count = 1, Interval = 2 },
				{ StartDelay = 315, EnemyType = Enums.Enemies.Penance, Count = 20, Interval = 3 },
				{
					StartDelay = 310,
					EnemyType = Enums.Enemies.NightmareEndbringer,
					Count = 10,
					Interval = 12
				},
				{ StartDelay = 330, EnemyType = Enums.Enemies.Fragment, Count = 2, Interval = 6 }
			}
		}
	}
}