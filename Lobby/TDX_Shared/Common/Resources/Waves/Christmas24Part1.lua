local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Christmas,
	NoSkip = true,
	SkipPenaltyPercentage = 0.3,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Assault,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.John,
				Enums.Towers.Grenadier,
				Enums.Towers.Juggernaut,
				Enums.Towers.Operator,
				Enums.Towers.MissileTrooper,
				Enums.Towers.Sniper
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Support,
			IconId = "rbxassetid://112662075132649",
			VIPOnly = false,
			Towers = {
				Enums.Towers.EDJ,
				Enums.Towers.Barracks,
				Enums.Towers.ArmoredFactory,
				Enums.Towers.Toxicnator,
				Enums.Towers.Operator,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.HeavyWeapons,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Artillery,
				Enums.Towers.Juggernaut,
				Enums.Towers.MineLayer,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Toxicnator
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.SpecialForces,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.SpecialForces,
			IconId = "rbxassetid://76800397073968",
			VIPOnly = true,
			Towers = {
				Enums.Towers.FlameTrooper,
				Enums.Towers.GoldenRanger,
				Enums.Towers.XWMTurret,
				Enums.Towers.Mobster,
				Enums.Towers.Medic,
				Enums.Towers.Commander
			}
		}
	}
}
return {
	DisplayName = "Christmas I",
	DefeatScreenRenderName = "Christmas 1",
	OverrideAdvisorName = "Christmas24Part1_Advisor",
	PlayerCountToStartingCashMap = { 1700, 1200, 1000, 950 },
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.25 }
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
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 2 },
		{ WaveNumber = 3, GoldReward = 27, TokensReward = 5 },
		{ WaveNumber = 5, GoldReward = 55, TokensReward = 10 },
		{ WaveNumber = 8, GoldReward = 85, TokensReward = 15 },
		{ WaveNumber = 10, GoldReward = 165, TokensReward = 20 },
		{ WaveNumber = 12, GoldReward = 250, TokensReward = 30 },
		{ WaveNumber = 15, GoldReward = 325, TokensReward = 40 },
		{ WaveNumber = 17, GoldReward = 425, TokensReward = 60 },
		{ WaveNumber = 20, GoldReward = 625, TokensReward = 150, CrystalsReward = 50 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 500,
			GainHP = 100
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 300,
			GainHP = 150
		},
		{
			WaveNumber = 9,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 250
		},
		{
			WaveNumber = 12,
			CostGold = 525,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 6000,
			GainHP = 400
		},
		{
			WaveNumber = 14,
			CostGold = 700,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 15000,
			GainHP = 500
		},
		{
			WaveNumber = 18,
			CostGold = 850,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 50000,
			GainHP = 2000
		}
	},
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 3749048375931659 },
	StartingLives = 750,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
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
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 12,
					Interval = 1
				},
				{ StartDelay = 9, EnemyType = Enums.Enemies.Frostbite, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerbreadMan,
					Count = 12,
					Interval = 1.4
				},
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Snowman, Count = 10, Interval = 0.75 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.Frostbite, Count = 1, Interval = 1 }
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
					Count = 15,
					Interval = 0.52
				}
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Frostbite, Count = 12, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SnowRunner,
					Count = 20,
					Interval = 0.55
				}
			}
		},
		{
			CashBonus = 725,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowRunner, Count = 30, Interval = 0.2 },
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
				{ StartDelay = 1, EnemyType = Enums.Enemies.Frostbite, Count = 6, Interval = 1.4 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Snowman,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 20,
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
					Count = 60,
					Interval = 0.3
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Frostbite, Count = 6, Interval = 3 }
			}
		},
		{
			CashBonus = 1075,
			SpawnSequences = {
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Ungifted, Count = 13, Interval = 2 },
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
				{ StartDelay = 10, EnemyType = Enums.Enemies.GiftBox, Count = 2, Interval = 14 }
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
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.ResurrectedCryoRanger,
					Count = 1,
					Interval = 8
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Frostbite, Count = 12, Interval = 2 }
			}
		},
		{
			CashBonus = 1225,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 1,
					Interval = 1,
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
					StartDelay = 28,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{ StartDelay = 10, EnemyType = Enums.Enemies.IceCapwn, Count = 1, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowMob, Count = 10, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Ungifted, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 1900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Lumberjack,
					Count = 4,
					Interval = 2.5,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.ResurrectedCryoRanger,
					Count = 6,
					Interval = 2
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Ungifted, Count = 12, Interval = 1 },
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.ResurrectedCryoBlaster,
					Count = 8,
					Interval = 2
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.CoalMan,
					Count = 4,
					Interval = 3,
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
					AdditionalHealthMultiplier = 1.5
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 6
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Chimney, Count = 10, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.SnowMob, Count = 25, Interval = 1 }
			}
		},
		{
			CashBonus = 2350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowGangsta, Count = 4, Interval = 5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 3.2
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
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{ StartDelay = 7.3, EnemyType = Enums.Enemies.IceCapwn, Count = 5, Interval = 1.3 },
				{ StartDelay = 0.2, EnemyType = Enums.Enemies.Ungifted, Count = 20, Interval = 1.5 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.CoalMan, Count = 12, Interval = 1 }
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
				{ StartDelay = 4, EnemyType = Enums.Enemies.SnowZombie, Count = 6, Interval = 2 },
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					Interval = 1.2
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.CoalMan, Count = 10, Interval = 0.45 }
			}
		},
		{
			CashBonus = 3150,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 7,
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
					StartDelay = 25,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 2,
					AdditionalHealthMultiplier = 1,
					SpawnOnAllPaths = true,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 4250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.XmasWall,
					Count = 20,
					SpawnOnAllPaths = true,
					AdditionalHealthMultiplier = 5,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 8250,
			OverrideXP = 750,
			SpawnSequences = {
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 3.3
				},
				{ StartDelay = 16, EnemyType = Enums.Enemies.GingerDrone, Count = 60, Interval = 1 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 10,
					Interval = 1.25
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.SuperNaughty,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.SnowGangsta, Count = 5, Interval = 2.5 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.IceCapwn,
					Count = 5,
					SpawnOnAllPaths = true,
					Interval = 2
				}
			}
		}
	}
}