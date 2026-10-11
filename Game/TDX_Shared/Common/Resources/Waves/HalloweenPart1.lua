local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Halloween,
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
	DisplayName = "Halloween I",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 1",
	PlayerCountToStartingCashMap = { 900, 800, 700, 600 },
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.2, CashPerDamageShared = 0.65 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 }
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
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 1 },
		{ WaveNumber = 3, GoldReward = 10, TokensReward = 3 },
		{ WaveNumber = 5, GoldReward = 20, TokensReward = 7 },
		{ WaveNumber = 8, GoldReward = 50, TokensReward = 12 },
		{ WaveNumber = 10, GoldReward = 90, TokensReward = 15 },
		{ WaveNumber = 12, GoldReward = 100, TokensReward = 20 },
		{ WaveNumber = 15, GoldReward = 115, TokensReward = 35 },
		{ WaveNumber = 16, GoldReward = 125, TokensReward = 45 },
		{ WaveNumber = 17, GoldReward = 235, TokensReward = 105 }
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
			CostGold = 45,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1500,
			GainHP = 250
		},
		{
			WaveNumber = 12,
			CostGold = 70,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 4000,
			GainHP = 400
		},
		{
			WaveNumber = 14,
			CostGold = 85,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 7500,
			GainHP = 500
		},
		{
			WaveNumber = 18,
			CostGold = 100,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 32000,
			GainHP = 1000
		}
	},
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 2064028770867384 },
	StartingLives = 472,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = { "HalloweenNight1_1", "HalloweenNight1_2", "HalloweenNight1_3" },
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 2, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerB, Count = 2, Interval = 3 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 5, Interval = 1.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerB, Count = 4, Interval = 2 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 3, Interval = 2 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 8, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 6, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Psycho, Count = 1, Interval = 0.6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 4, Interval = 1.7 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 4, Interval = 1.3 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 15, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 13, Interval = 0.8 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 17, Interval = 1.2 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Psycho, Count = 2, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 1, Interval = 2.4 }
			}
		},
		{
			CashBonus = 650,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 3, Interval = 8.7 }
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 1, Interval = 2.4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerA, Count = 15, Interval = 0.9 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 13, Interval = 0.7 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 17, Interval = 1.1 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Prowler, Count = 3, Interval = 4 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 4, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 3, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 2, Interval = 1.1 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 5, Interval = 3.6 }
			}
		},
		{
			CashBonus = 800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Prowler, Count = 5, Interval = 3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Psycho, Count = 3, Interval = 4.2 }
			}
		},
		{
			CashBonus = 850,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Psycop, Count = 7, Interval = 1.2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.MrSaw, Count = 2, Interval = 1.6 }
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 0.3 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 12, Interval = 0.9 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.MrSaw, Count = 1, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 7, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 6, Interval = 1.1 }
			}
		},
		{
			CashBonus = 950,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 0.3 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Psycop,
					Count = 10,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 8, Interval = 0.7 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Executioner, Count = 1, Interval = 0.6 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Prowler, Count = 3, Interval = 1 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 14, Interval = 0.7 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 0.3 }
			}
		},
		{
			CashBonus = 1450,
			SpawnSequences = {
				{ StartDelay = 20, EnemyType = Enums.Enemies.Heretic, Count = 1, Interval = 1.2 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.MrSaw, Count = 5, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Judge, Count = 2, Interval = 15 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Executioner, Count = 2, Interval = 3 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Psycop, Count = 18, Interval = 0.7 }
			}
		}
	}
}