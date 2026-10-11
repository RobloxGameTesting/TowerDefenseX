local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Christmas I (Nightmare)",
	DefeatScreenRenderName = "Christmas 1",
	OverrideAdvisorName = "Christmas24Part1Nightmare_Xenon",
	DefeatMusicName = "Christmas24DefeatMusicNightmare",
	PlayerCountToStartingCashMap = { 2400, 2000, 1850, 1400 },
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.2, CashPerDamageShared = 0.65 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.45 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 1 },
		{ WaveNumber = 3, GoldReward = 30, TokensReward = 1 },
		{ WaveNumber = 5, GoldReward = 100, TokensReward = 2 },
		{ WaveNumber = 8, GoldReward = 145, TokensReward = 5 },
		{ WaveNumber = 12, GoldReward = 175, TokensReward = 10 },
		{ WaveNumber = 16, GoldReward = 225, TokensReward = 15 },
		{ WaveNumber = 18, GoldReward = 375, TokensReward = 25 },
		{ WaveNumber = 19, GoldReward = 450, TokensReward = 35 },
		{ WaveNumber = 21, GoldReward = 500, TokensReward = 65 },
		{ WaveNumber = 24, GoldReward = 700, TokensReward = 90 },
		{ WaveNumber = 25, GoldReward = 900, TokensReward = 200, CrystalsReward = 75 }
	},
	DefaultXPPerWavePassed = 70,
	VictoryBadgeIds = { 4480231979205698 },
	StartingLives = 300,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	IntroCutsceneSequence = Enums.CutsceneSequences.Christmas24Part1Intro,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"ChristmasPart1_1",
		"ChristmasPart1_2",
		"ChristmasPart1_3",
		"ChristmasPart1_4",
		"ChristmasPart1_5",
		"HalloweenNight1_1",
		"HalloweenNight1_2",
		"HalloweenNight1_3"
	},
	Waves = {
		{
			CashBonus = 0,
			ShieldMultiplierIncrease = 0.1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 15,
					Interval = 1
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.Frostbite, Count = 3, Interval = 1 }
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 18,
					Interval = 1.4
				},
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Snowman, Count = 10, Interval = 0.75 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.Frostbite, Count = 4, Interval = 1 }
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Frostbite, Count = 8, Interval = 1.2 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Snowman,
					SpeedBoostMultiplierOverride = 0.2,
					Count = 28,
					Interval = 0.52
				}
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Frostbite, Count = 14, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.GingerDrone, Count = 1, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 30,
					Interval = 0.55
				}
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowRunner, Count = 50, Interval = 0.1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 15,
					Interval = 1.4
				}
			}
		},
		{
			CashBonus = 825,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
					Count = 3,
					Interval = 2
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Frostbite, Count = 8, Interval = 1.4 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Snowman,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 30,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 950,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 32,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 1,
					Interval = 0.3
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Frostbite, Count = 10, Interval = 3 }
			}
		},
		{
			CashBonus = 1075,
			SpawnSequences = {
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Ungifted, Count = 16, Interval = 2 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SnowRunner,
					AdditionalHealthMultiplier = 1,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					AdditionalHealthMultiplier = 1,
					Count = 24,
					Interval = 0.75
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.GiftBox, Count = 3, Interval = 6 }
			}
		},
		{
			CashBonus = 1125,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
					Count = 11,
					Interval = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SummonedRanger,
					Count = 9,
					Interval = 1
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.ResurrectedCryoRanger,
					Count = 3,
					Interval = 5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Frostbite, Count = 14, Interval = 1 }
			}
		},
		{
			CashBonus = 1225,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 2,
					Interval = 4,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SnowZombie,
					Count = 20,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 0.3,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 4,
					SpawnOnAllPaths = true,
					Interval = 1.5
				}
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowMob,
					SpeedBoostMultiplierOverride = 0.5,
					Count = 16,
					Interval = 1
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Ungifted, Count = 16, Interval = 1 }
			}
		},
		{
			CashBonus = 1900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 6,
					Interval = 2.5,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.ResurrectedCryoRanger,
					Count = 9,
					Interval = 2
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Ungifted, Count = 12, Interval = 1 },
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 6,
					Interval = 2,
					SpawnOnAllPaths = true
				}
			}
		},
		{
			CashBonus = 2150,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 100,
					Interval = 0.15,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 1.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 6
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Chimney,
					Count = 10,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowMob, Count = 25, Interval = 1 }
			}
		},
		{
			CashBonus = 2350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowGangsta, Count = 6, Interval = 5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 3.2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Tree,
					Count = 1,
					SpawnOnAllPaths = true,
					Stealth = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 2650,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 10,
					Interval = 2,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 26,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 7.3,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 6,
					AdditionalShieldMultiplier = 0.3,
					Interval = 1.3
				},
				{ StartDelay = 0.2, EnemyType = Enums.Enemies.Ungifted, Count = 20, Interval = 1.5 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 12,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 2900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiftBox,
					AdditionalHealthMultiplier = 2,
					Count = 14,
					Interval = 1
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Chimney, Count = 24, Interval = 0.75 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.SnowZombie,
					Count = 12,
					AdditionalShieldMultiplier = 2,
					Interval = 1
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1.2
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 10,
					AdditionalShieldMultiplier = 1,
					Interval = 0.45
				}
			}
		},
		{
			CashBonus = 3150,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.SuperNaughty, Count = 7, Interval = 2 },
				{
					StartDelay = 4.5,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 1,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 4250,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 4,
					AdditionalShieldMultiplier = 0.3,
					Interval = 0.8
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.Chimney, Count = 19, Interval = 0.8 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.SnowPredator,
					Count = 2,
					Interval = 15
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 2,
					AdditionalHealthMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8250,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.GingerDrone,
					Count = 60,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 10,
					AdditionalShieldMultiplier = 2,
					Interval = 1.25
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 3,
					AdditionalShieldMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Avatar,
					Count = 1,
					AdditionalShieldMultiplier = 0.25,
					SpawnOnAllPaths = true,
					Interval = 2.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Tree,
					Count = 1,
					SpawnOnAllPaths = true,
					Stealth = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 8250,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.SnowGangsta, Count = 5, Interval = 2.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 5,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 0.6,
					Interval = 2.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 5,
					SpawnOnAllPaths = true,
					AdditionalHealthMultiplier = 2,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8250,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.GingerDrone,
					Count = 60,
					AdditionalShieldMultiplier = 15,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					AdditionalShieldMultiplier = 0.5,
					Count = 10,
					Interval = 1.25
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 3,
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.SnowGangsta, Count = 5, Interval = 2.5 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 5,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 10,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8250,
			CustomWaveTime = 100,
			CashMultiplierOverride = 0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 3.3 },
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					SpawnOnAllPaths = true,
					Interval = 2.5
				},
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.MultiplierX,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8250,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 1, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.NightmareCyberSanta,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3.3
				}
			}
		},
		{
			CashBonus = 8250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Tree,
					AdditionalShieldMultiplier = 10,
					Count = 50,
					Stealth = true,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eradidog,
					SpawnOnAllPaths = true,
					Count = 1,
					AdditionalHealthMultiplier = -0.5,
					Stealth = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 8250,
			SpawnSequences = {
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 3.3
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.GingerDrone,
					Count = 60,
					AdditionalShieldMultiplier = 24,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 10,
					AdditionalShieldMultiplier = 2,
					Interval = 1.25
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SnowGangsta,
					Count = 5,
					AdditionalShieldMultiplier = 2,
					Interval = 2.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 5,
					AdditionalShieldMultiplier = 4,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 3,
					AdditionalShieldMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		}
	}
}