local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Halloween,
	NoSkip = true,
	SkipPenaltyPercentage = 0.3,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
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
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
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
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
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
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
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
	DisplayName = "Halloween II",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 2",
	OverrideAdvisorName = "JohnHalloweenPart2",
	PlayerCountToStartingCashMap = { 2200, 1500, 1200, 1075 },
	CashPerDamageData = {
		{ CashPerDamage = 3, CashPerDamageShared = 0 },
		{ CashPerDamage = 2, CashPerDamageShared = 1 },
		{ CashPerDamage = 1.7, CashPerDamageShared = 1 },
		{ CashPerDamage = 1.5, CashPerDamageShared = 1 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.45, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.35, CashPerDamageShared = 0 },
		{ MaxLevel = 30, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.225, CashPerDamageShared = 0 },
		{ MaxLevel = 60, CashPerDamage = 0.15, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.075, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 1 },
		{ WaveNumber = 3, GoldReward = 50, TokensReward = 3 },
		{ WaveNumber = 5, GoldReward = 100, TokensReward = 8 },
		{ WaveNumber = 8, GoldReward = 200, TokensReward = 19 },
		{ WaveNumber = 13, GoldReward = 250, TokensReward = 25 },
		{ WaveNumber = 16, GoldReward = 325, TokensReward = 40 },
		{ WaveNumber = 17, GoldReward = 450, TokensReward = 65 },
		{ WaveNumber = 19, GoldReward = 600, TokensReward = 100 },
		{ WaveNumber = 20, GoldReward = 900, TokensReward = 245 }
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
			GainCash = 1000,
			GainHP = 150
		},
		{
			WaveNumber = 9,
			CostGold = 120,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 250
		},
		{
			WaveNumber = 12,
			CostGold = 140,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 4000,
			GainHP = 400
		},
		{
			WaveNumber = 14,
			CostGold = 200,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7500,
			GainHP = 500
		},
		{
			WaveNumber = 18,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 32000,
			GainHP = 1000
		},
		{
			WaveNumber = 23,
			CostGold = 1000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 45000,
			GainHP = 5000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 0,
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
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 4209797237619675 },
	StartingLives = 500,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"HalloweenNight2_1",
		"HalloweenNight2_2",
		"HalloweenNight2_3",
		"HalloweenNight2_4"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 4,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 5,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 4,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 5,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 6,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 5,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 7,
					Interval = 1.2
				},
				{
					StartDelay = 0.4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 7,
					Interval = 1.2
				},
				{
					StartDelay = 0.8,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 7,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 2, Interval = 0 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 3,
					Interval = 1.2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 4,
					Interval = 1.2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 3,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Worker, Count = 4, Interval = 2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 7, Interval = 0.8 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 5,
					Interval = 1.2
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 8, Interval = 1.2 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 3, Interval = 1 },
				{ StartDelay = 3.2, EnemyType = Enums.Enemies.Worker, Count = 2, Interval = 2.4 }
			}
		},
		{
			CashBonus = 650,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Worker, Count = 10, Interval = 1.2 }
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Prowler, Count = 5, Interval = 1 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 4, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 3, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 2, Interval = 1.1 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Skulltist, Count = 6, Interval = 1 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 9, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 6, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 5, Interval = 1.1 }
			}
		},
		{
			CashBonus = 750,
			CashMultiplierOverride = 0.75,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 8, Interval = 1 },
				{ StartDelay = 2.5, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Executioner, Count = 2, Interval = 7 },
				{ StartDelay = 0.4, EnemyType = Enums.Enemies.Psycop, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 850,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Prowler,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 10,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Worker,
					Count = 20,
					Slteath = true,
					Interval = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Judge,
					Count = 2,
					Slteath = true,
					Interval = 6
				}
			}
		},
		{
			CashBonus = 950,
			CashMultiplierOverride = 0.65,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.NailHead, Count = 1, Interval = 3.2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 10, Interval = 1 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 2,
					Interval = 1.5
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Prowler, Count = 10, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 14, Interval = 0.7 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Judge, Count = 2, Interval = 1 }
			}
		},
		{
			CashBonus = 1450,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.NailHead, Count = 2, Interval = 2 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.Skulltist, Count = 8, Interval = 0.5 },
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 7,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 7,
					Interval = 1.2
				},
				{
					StartDelay = 1.3,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 7,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 400,
			CashMultiplierOverride = 0.8,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.CorruptedPredator,
					Count = 1,
					Interval = 0,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 50,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 1,
					Interval = 1.2,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 50,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 50,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 2000,
			CustomWaveTime = 220,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Judge, Count = 10, Interval = 1.2 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.MrSaw, Count = 15, Interval = 0.7 }
			}
		},
		{
			CashBonus = 15000,
			OverrideXP = 2000,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{ StartDelay = 10, EnemyType = Enums.Enemies.Engineer, Count = 1, Interval = 1.2 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.NailGolem,
					Count = 1,
					Interval = 1,
					SpawnOnAllPaths = true
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TwitchingVile, Count = 6, Interval = 1 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Worker, Count = 100, Interval = 0.25 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Welder, Count = 40, Interval = 1 }
			}
		}
	}
}