local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Ultra Nightmare",
	VictoryScreenRenderName = "Nightmare",
	DefeatScreenRenderName = "Nightmare",
	NoVictoryMusic = true,
	PlayerCountToStartingCashMap = { 32000, 16500, 12850, 10000 },
	CashPerDamageData = {
		{ CashPerDamage = 1.1, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.52 },
		{ CashPerDamage = 0.7, CashPerDamageShared = 0.47 },
		{ CashPerDamage = 0.5, CashPerDamageShared = 0.32 }
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
		{ WaveNumber = 3, CrystalsReward = 15, TokensReward = 0 },
		{ WaveNumber = 5, CrystalsReward = 20, TokensReward = 0 },
		{ WaveNumber = 8, CrystalsReward = 30, TokensReward = 0 },
		{ WaveNumber = 11, CrystalsReward = 55, TokensReward = 0 },
		{ WaveNumber = 14, CrystalsReward = 70, TokensReward = 0 },
		{ WaveNumber = 16, CrystalsReward = 85, TokensReward = 0 },
		{ WaveNumber = 20, CrystalsReward = 135, TokensReward = 0 },
		{ WaveNumber = 24, CrystalsReward = 150, TokensReward = 0 },
		{ WaveNumber = 26, CrystalsReward = 175, TokensReward = 0 },
		{ WaveNumber = 28, CrystalsReward = 190, TokensReward = 0 },
		{ WaveNumber = 30, CrystalsReward = 215, TokensReward = 0 },
		{ WaveNumber = 33, CrystalsReward = 250, TokensReward = 0 },
		{ WaveNumber = 35, CrystalsReward = 285, TokensReward = 0 },
		{ WaveNumber = 37, CrystalsReward = 325, TokensReward = 0 },
		{ WaveNumber = 40, CrystalsReward = 400, TokensReward = 0 },
		{ WaveNumber = 42, CrystalsReward = 500, TokensReward = 0 },
		{ WaveNumber = 44, CrystalsReward = 700, TokensReward = 0 },
		{ WaveNumber = 46, CrystalsReward = 1500, GoldReward = 6250, TokensReward = 700 }
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 5,
			ChanceTable = {
				[Enums.PowerUps.DamageField] = 12,
				[Enums.PowerUps.RangeField] = 12,
				[Enums.PowerUps.SR71Strike] = 8,
				[Enums.PowerUps.UberField] = 2,
				[Enums.PowerUps.EmergencySupplyCrate] = 5
			}
		}
	},
	DefaultXPPerWavePassed = 400,
	StartingLives = 5500,
	StartingLivesOverriddenBy = {
		"CastellanReachBase",
		"SupremacyPrimeBase",
		"PacificaRuinsBase",
		"GUNFacilityBase",
		"FinalityBase"
	},
	SetUpTime = 35,
	PowerUpsDisabled = true,
	IntroCutsceneSequence = Enums.CutsceneSequences.NightmareIntro,
	PreloadEnemyNames = {
		Enums.Enemies.EradicatorMK2ReworkWithLanding,
		Enums.Enemies.Avatar,
		Enums.Enemies.Hunter,
		Enums.Enemies.ZombieDropPod1
	},
	TowerCostMultiplierMap = {
		[Enums.Towers.CombatDrone] = 0.85,
		[Enums.Towers.GoldenMobster] = 1.1
	},
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
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Walker,
					Count = 12,
					AdditionalHealthMultiplier = 0.2,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Stealth = true,
					Count = 2,
					Interval = 2
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Haste, Count = 9, Interval = 4 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Walker,
					Count = 18,
					AdditionalShieldMultiplier = 0.1,
					AdditionalSpeedMultiplier = 0.1,
					Interval = 0.7
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Jumper,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					AdditionalHealthMultiplier = 0.75,
					Stealth = true,
					Interval = 7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 4,
					Stealth = true,
					AdditionalShieldMultiplier = 0.5,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Stealth = true,
					Count = 7,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					AdditionalHealthMultiplier = 0.2,
					Stealth = true,
					Count = 2,
					Interval = 12
				}
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Lurch2,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 5,
					Stealth = true,
					Interval = 2.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Stealth = true,
					Count = 2,
					Interval = 0.2
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Lurch3,
					AdditionalShieldMultiplier = 0.7,
					AdditionalHealthMultiplier = 0.7,
					Count = 1,
					Stealth = true,
					Interval = 2.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 5,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalHealthMultiplier = 0.2,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.HeavyTitan,
					Count = 2,
					AdditionalHealthMultiplier = 0.25,
					Interval = 6
				}
			}
		},
		{
			CashBonus = 2250,
			CustomWaveTime = 120,
			CashMultiplierOverride = 1.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Walker,
					Count = 30,
					AdditionalSpeedBoostMultiplier = 0.5,
					Interval = 0.8
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.XNader,
					AdditionalHealthMultiplier = -0.6,
					Count = 1,
					Interval = 0.8
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 5,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 1,
					Interval = 0.8
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Haste,
					Count = 4,
					AdditionalHealthMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Jumper,
					Count = 1,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 2750,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Chariot,
					AdditionalHealthMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Lurch1,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 7,
					Stealth = true,
					Interval = 2.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Haste,
					Count = 30,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.8,
					Interval = 0.7
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.Jumper,
					Count = 3,
					AdditionalHealthMultiplier = 2,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 4250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 5,
					AdditionalSpeedBoostMultiplier = 2,
					AdditionalHealthMultiplier = 5,
					Interval = 0.5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Chariot,
					Count = 3,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.25,
					Interval = 4
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Count = 4,
					AdditionalHealthMultiplier = 1,
					Interval = 0.25
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Buzzard,
					Count = 15,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Pilot,
					Stealth = true,
					Count = 1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 4500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Breacher,
					Count = 1,
					AdditionalHealthMultiplier = -0.25,
					Interval = 3
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Lurch3,
					Stealth = true,
					Count = 7,
					Interval = 1.5
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.Chariot,
					Count = 2,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.25,
					Interval = 4
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.Jumper, Count = 12, Interval = 0.4 },
				{
					StartDelay = 28,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Count = 2,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Count = 12,
					AdditionalSpeedBoostMultiplier = 0.15,
					AdditionalHealthMultiplier = 2,
					Interval = 0.15
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Breacher, Count = 1, Interval = 15 }
			}
		},
		{
			CashBonus = 5000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lurch3,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 11,
					Interval = 4.5
				},
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Buzzard,
					AdditionalHealthMultiplier = 2,
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
					StartDelay = 7,
					EnemyType = Enums.Enemies.Jumper,
					Count = 19,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalHealthMultiplier = 0.15,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Stealth = true,
					Count = 1,
					Interval = 2.5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.ZombieDropPod1,
					Stealth = true,
					Count = 2,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 6500,
			CustomWaveTime = 75,
			SpawnSequences = {
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.Chariot,
					Count = 10,
					AdditionalShieldMultiplier = 0.85,
					AdditionalHealthMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.3,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 5,
					AdditionalShieldMultiplier = 2,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 8500,
			CustomWaveTime = 75,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 5,
					AdditionalShieldMultiplier = 0.85,
					AdditionalHealthMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.35,
					Interval = 4.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 1,
					Interval = 0.3
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 1,
					Interval = 0.3
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 1,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 9000,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 5,
					Interval = 2.5
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.XNader, Count = 4, Interval = 3 }
			}
		},
		{
			CashBonus = 9750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Breacher, Count = 2, Interval = 6.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.XNader, Count = 1, Interval = 4 }
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 85,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					Count = 2,
					AdditionalShieldMultiplier = 1,
					Interval = 17
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Bounded,
					AdditionalHealthMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 0.75
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.Pilot, Count = 3, Interval = 0.75 }
			}
		},
		{
			CashBonus = 10500,
			CustomWaveTime = 110,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 8,
					AdditionalSpeedBoostMultiplier = 2,
					AdditionalShieldMultiplier = 11,
					Interval = 0.2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.RevivedSmasher,
					Count = 19,
					AdditionalShieldMultiplier = 1,
					Interval = 2.5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Pilot, Count = 2, Interval = 0.6 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.DamageDeployer,
					Count = 4,
					Stealth = true,
					AdditionalShieldMultiplier = 4,
					AdditionalHealthMultiplier = 3,
					Interval = 6
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.SuperHeavyTitan,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 0.5,
					Interval = 7
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					Count = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 17
				}
			}
		},
		{
			CashBonus = 11000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MultiplierT,
					AdditionalShieldMultiplier = 0.5,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 4,
					Interval = 0.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					Count = 5,
					AdditionalShieldMultiplier = 1,
					Interval = 2.5
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Jammer,
					Count = 7,
					AdditionalHealthMultiplier = 10,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 2.5
				},
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.ZombieDropPod6,
					Count = 30,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 150000,
			OverrideXP = 2150,
			CustomWaveTime = 400,
			OverrideAmbientPlaylist = { "ExpertWave30Music" },
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Phobeus,
					AdditionalSpeedMultiplier = 0.25,
					Count = 1,
					Interval = 5
				},
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Zeus, Count = 1, Interval = 2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Artemis, Count = 1, Interval = 0.75 },
				{
					StartDelay = 57,
					EnemyType = Enums.Enemies.BatteringRam,
					AdditionalSpeedMultiplier = 0.1,
					Count = 1,
					Interval = 5
				},
				{ StartDelay = 64, EnemyType = Enums.Enemies.Artemis, Count = 1, Interval = 0.75 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.King,
					AdditionalSpeedMultiplier = 0.35,
					AdditionalShieldMultiplier = 0.7,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.ZombieDropPod8,
					Count = 3,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.HunterNightmare,
					Count = 3,
					Interval = 2
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.XenonTank, Count = 2, Interval = 10 },
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.HunterNightmare,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 11000,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Maniac,
					Count = 12,
					AdditionalShieldMultiplier = 0.4,
					Interval = 1.5
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.XenonTank, Count = 1, Interval = 10 }
			}
		},
		{
			CashBonus = 12000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.XenonTank, Count = 2, Interval = 15 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ZombieDropPod2,
					AdditionalShieldMultiplier = 0.5,
					Count = 9,
					Interval = 0.75
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Haste,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedMultiplier = 0.7,
					Count = 200,
					Interval = 0.2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Pilot,
					AdditionalHealthMultiplier = 1,
					Count = 6,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 35000,
			CashMultiplierOverride = 1.1,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 2
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 1.8
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Maniac, Count = 4, Interval = 1.5 },
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
					EnemyType = Enums.Enemies.Bounded,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 0.5,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 3.5,
					Count = 3,
					Interval = 1.3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.DamageDeployer,
					AdditionalShieldMultiplier = 5.5,
					Count = 3,
					Interval = 1.3
				},
				{ StartDelay = 72, EnemyType = Enums.Enemies.AntiGolem, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 75000,
			CashMultiplierOverride = 0.9,
			CustomWaveTime = 80,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TitanCharger, Count = 6, Interval = 5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1.5,
					Count = 5,
					Interval = 1.8
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Tracker,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1.5,
					Count = 1,
					Interval = 1.8
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 5,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 25000,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 9,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 10000,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Cybercubus, Count = 2, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 7,
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
					EnemyType = Enums.Enemies.ZombieDropPod7,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 12000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.NuclearTank,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 4,
					AdditionalShieldMultiplier = 1,
					Interval = 2.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 5,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 15000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MultiplierX,
					AdditionalSpeedBoostMultiplier = 0.15,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 100000,
			CashMultiplierOverride = 0.65,
			CustomWaveTime = 240,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerDread,
					AdditionalHealthMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.75,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 3,
					Interval = 6
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.Eradidog, Count = 2, Interval = 2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 2,
					Interval = 0.2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.HunterNightmare,
					Count = 4,
					AdditionalShieldMultiplier = 0.6,
					Interval = 0.4
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.AvatarR,
					AdditionalShieldMultiplier = 0.4,
					Count = 6,
					Interval = 0.4
				}
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
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.AvatarR,
					Count = 10,
					AdditionalShieldMultiplier = 1,
					Interval = 1.5
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 1,
					Interval = 0.2
				}
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
					AdditionalSpeedBoostMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.2,
					Interval = 5
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					AdditionalShieldMultiplier = 1,
					Count = 3,
					Interval = 0.15
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Thumper,
					AdditionalShieldMultiplier = 8.5,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 40,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 19000,
			CustomWaveTime = 85,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 3,
					Interval = 0.7
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					AdditionalShieldMultiplier = 1.5,
					Count = 4,
					Interval = 0.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.XJuggernaut,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 3,
					Interval = 1.4
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Thumper,
					Count = 7,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 3,
					Interval = 0.7
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					AdditionalShieldMultiplier = 1.5,
					Count = 4,
					Interval = 0.7
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Bounded,
					AdditionalShieldMultiplier = 10,
					AdditionalHealthMultiplier = 1.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 1,
					Interval = 2.25
				}
			}
		},
		{
			CashBonus = 21000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TitanCharger, Count = 7, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Dispenser, Count = 2, Interval = 5 },
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.ZombieDropPod7,
					AdditionalShieldMultiplier = 0.8,
					Count = 25,
					Interval = 0.4
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
					EnemyType = Enums.Enemies.Destructor,
					AdditionalHealthMultiplier = 0.75,
					AdditionalShieldMultiplier = 1,
					Count = 2,
					Interval = 6
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.Dreadcubus, Count = 4, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.AerialJuggernaut,
					Count = 4,
					AdditionalShieldMultiplier = 1,
					Interval = 0.9
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.AvatarR,
					AdditionalShieldMultiplier = 2.5,
					Count = 11,
					Interval = 0.75
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Jager,
					Count = 2,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.25,
					Interval = 1.5
				}
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
					StartDelay = 10,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 1,
					Interval = 0.7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Jammer,
					Stealth = true,
					AdditionalShieldMultiplier = 10,
					AdditionalHealthMultiplier = 10,
					Count = 9,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 50000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JX,
					Count = 15,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.25,
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
				}
			}
		},
		{
			CashBonus = 27000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier3,
					AdditionalShieldMultiplier = 100,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.MultiplierX,
					AdditionalShieldMultiplier = 3.5,
					AdditionalSpeedBoostMultiplier = 0.35,
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
					StartDelay = 2,
					EnemyType = Enums.Enemies.Smasher9x,
					Count = 1,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 10,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 10,
					AdditionalHealthMultiplier = 0.7,
					Interval = 0.7
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.ZombieDropPod10,
					Count = 5,
					AdditionalShieldMultiplier = 1.5,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 37500,
			OverrideXP = 2150,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.X2Trooper,
					Count = 1,
					AdditionalHealthMultiplier = 0.25,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TitanCharger,
					Count = 5,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 0.5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.X2Fighter,
					AdditionalHealthMultiplier = 0.6,
					Count = 2,
					Interval = 4
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Jager,
					AdditionalShieldMultiplier = 1.2,
					AdditionalHealthMultiplier = 1,
					Count = 3,
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
					AdditionalHealthMultiplier = 0.75,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 20,
					Interval = 2
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Bombardier, Count = 2, Interval = 15 },
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
					AdditionalHealthMultiplier = 2.5,
					AdditionalSpeedMultiplier = 0.2,
					Count = 7,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 42000,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ApexPredatorUltra,
					Count = 3,
					Interval = 7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.HunterNightmare,
					AdditionalShieldMultiplier = 0.6,
					Count = 7,
					Interval = 3
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.AlphaPredator,
					AdditionalHealthMultiplier = 0.15,
					AdditionalShieldMultiplier = 0.2,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 145,
					EnemyType = Enums.Enemies.ApexPredatorUltra,
					AdditionalHealthMultiplier = 0.15,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.6,
					Count = 1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 45000,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 170,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.XenonTank,
					Count = 10,
					AdditionalShieldMultiplier = 3.5,
					AdditionalHealthMultiplier = 3,
					Interval = 8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.E02,
					Count = 20,
					AdditionalShieldMultiplier = 2.5,
					Interval = 0.7
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.ZombieDropPod2,
					Count = 2,
					AdditionalShieldMultiplier = 2,
					Interval = 0.7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Tracker,
					AdditionalShieldMultiplier = 2,
					Count = 6,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 500000,
			CashMultiplierOverride = 0.65,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMK2ReworkWithLanding,
					Count = 3,
					Interval = 1.7
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.EradicatorMK4Nightmare,
					AdditionalShieldMultiplier = 0.8,
					Count = 1,
					Interval = 5
				},
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.X2Fighter,
					AdditionalHealthMultiplier = 0.6,
					AdditionalShieldMultiplier = 0.25,
					Count = 2,
					Interval = 10
				}
			}
		},
		{
			CashBonus = 250000,
			OverrideXP = 4000,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					AdditionalHealthMultiplier = 7,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 2
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.Multiplier3,
					Count = 1,
					AdditionalHealthMultiplier = 10,
					AdditionalShieldMultiplier = 10,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MultiplierX,
					Count = 1,
					AdditionalHealthMultiplier = 3,
					AdditionalSpeedBoostMultiplier = 0.7,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1500000,
			CustomWaveTime = 1e999,
			SkipWaveDisabled = true,
			OverrideXP = 10000,
			LockSpeedMultiplierTo1 = true,
			CashMultiplierOverride = 0.6,
			OverrideAmbientPlaylist = { "EmperorDeathAmbient" },
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.EmperorUltra, Count = 1, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.E02, Count = 20, Interval = 0.8 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Destructor,
					AdditionalHealthMultiplier = 1,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.X2Fighter,
					AdditionalHealthMultiplier = 0.7,
					Count = 2,
					Interval = 2
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.EradicatorMK2ReworkWithLanding,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.ZombieDropPod5,
					Count = 5,
					Interval = 30
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.XenonTank,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 0.5,
					Count = 3,
					Interval = 60
				}
			}
		}
	}
}