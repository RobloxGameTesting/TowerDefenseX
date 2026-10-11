local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.TowerBattles,
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
				Enums.Towers.Sentry,
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
				Enums.Towers.Slammer,
				Enums.Towers.GoldenRanger,
				Enums.Towers.Ghost,
				Enums.Towers.Mobster,
				Enums.Towers.Medic,
				Enums.Towers.Commander
			}
		}
	}
}
return {
	DisplayName = "Tower Battles",
	VictoryScreenRenderName = "Tower Battles",
	DefeatScreenRenderName = "Tower Battles",
	OverrideAdvisorName = "Commander",
	PlayerCountToStartingCashMap = { 700, 650, 600, 500 },
	CashPerDamageData = {
		{ CashPerDamage = 1, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.2 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.15, CashPerDamageShared = 0 },
		{ MaxLevel = 30, CashPerDamage = 0.12, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.1, CashPerDamageShared = 0 },
		{ MaxLevel = 60, CashPerDamage = 0.07, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.035, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 7, TokensReward = 5 },
		{ WaveNumber = 5, GoldReward = 60, TokensReward = 20 },
		{ WaveNumber = 10, GoldReward = 100, TokensReward = 25 },
		{ WaveNumber = 15, GoldReward = 300, TokensReward = 35 },
		{ WaveNumber = 23, GoldReward = 700, TokensReward = 45 },
		{ WaveNumber = 28, GoldReward = 850, TokensReward = 65 },
		{ WaveNumber = 34, GoldReward = 1150, TokensReward = 90 },
		{ WaveNumber = 35, GoldReward = 1650, TokensReward = 145 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 3,
			CostGold = 125,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_05,
			GainCash = 1000,
			GainHP = 100
		},
		{
			WaveNumber = 6,
			CostGold = 400,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1250,
			GainHP = 150
		},
		{
			WaveNumber = 10,
			CostGold = 850,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 1750,
			GainHP = 325
		},
		{
			WaveNumber = 18,
			CostGold = 1500,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 3000,
			GainHP = 750
		},
		{
			WaveNumber = 25,
			CostGold = 2000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 10000,
			GainHP = 1000
		},
		{
			WaveNumber = 30,
			CostGold = 2750,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 17500,
			GainHP = 3000
		},
		{
			WaveNumber = 34,
			CostGold = 4000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 75000,
			GainHP = 10000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 0,
			ChanceTable = {
				[Enums.PowerUps.ReconDrone] = 10,
				[Enums.PowerUps.HealthCrate] = 3,
				[Enums.PowerUps.AirStrike] = 5,
				[Enums.PowerUps.StrykerRush] = 15,
				[Enums.PowerUps.GoldenZed] = 1,
				[Enums.PowerUps.HealingField] = 20,
				[Enums.PowerUps.HealingField] = 20
			}
		}
	},
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 479924240104642 },
	StartingLives = 300,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBNormal, Count = 7, Interval = 1 }
			}
		},
		{
			CashBonus = 300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBNormal, Count = 13, Interval = 1 }
			}
		},
		{
			CashBonus = 325,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSpeedy, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 350,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBNormal, Count = 6, Interval = 1.2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 8, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.TBSpeedy, Count = 14, Interval = 0.7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 7, Interval = 1 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 15, Interval = 1.4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 1, Interval = 1.5 }
			}
		},
		{
			CashBonus = 425,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 2, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 12, Interval = 1.5 }
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 3, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 15, Interval = 1 },
				{ StartDelay = 5.2, EnemyType = Enums.Enemies.TBNormal, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 475,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 2, Interval = 3 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.TBNecromancer, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBHidden, Count = 8, Interval = 1.8 }
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBHidden, Count = 4, Interval = 3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBSpeedy, Count = 15, Interval = 1.7 },
				{
					StartDelay = 5.5,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 550,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery, Count = 20, Interval = 0.7 }
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 20, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBMystery, Count = 15, Interval = 1 }
			}
		},
		{
			CashBonus = 600,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery, Count = 35, Interval = 0.5 }
			}
		},
		{
			CashBonus = 625,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 7, Interval = 3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBHidden, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 650,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 2, Interval = 12 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 3,
					Interval = 2.7
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBSpeedy, Count = 15, Interval = 2 }
			}
		},
		{
			CashBonus = 675,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLava, Count = 20, Interval = 1.2 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 14, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery, Count = 10, Interval = 0.7 }
			}
		},
		{
			CashBonus = 725,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					Count = 1,
					Interval = 1.5
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBLava, Count = 5, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 1, Interval = 1.5 }
			}
		},
		{
			CashBonus = 750,
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 3, Interval = 4 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 2, Interval = 7 }
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBToxic, Count = 12, Interval = 1.3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLightning, Count = 4, Interval = 4 }
			}
		},
		{
			CashBonus = 800,
			CashMultiplierOverride = 0.3,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 5, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 3,
					Interval = 1
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBToxic, Count = 7, Interval = 1 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.TBLightning, Count = 3, Interval = 8 },
				{ StartDelay = 22, EnemyType = Enums.Enemies.TBMystery, Count = 15, Interval = 0.6 }
			}
		},
		{
			CashBonus = 1000,
			CustomWaveTime = 120,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 4, Interval = 2.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLava, Count = 10, Interval = 2 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 2, Interval = 5 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 5, Interval = 2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLava, Count = 10, Interval = 2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery, Count = 15, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBToxic, Count = 10, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBLightning, Count = 4, Interval = 4 }
			}
		},
		{
			CashBonus = 1400,
			SpawnSequences = {
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBLightning, Count = 10, Interval = 2 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLava, Count = 25, Interval = 1 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 1800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery, Count = 50, Interval = 0.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLightning, Count = 25, Interval = 1 }
			}
		},
		{
			CashBonus = 2000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 2200,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 25, EnemyType = Enums.Enemies.TBBoss3, Count = 1, Interval = 0.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 5, Interval = 6 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBMystery2, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 2400,
			SpawnSequences = {
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBBoss3, Count = 3, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery2, Count = 24, Interval = 0.7 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 3,
					Interval = 0.75
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 3,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 2600,
			CustomWaveTime = 160,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 1, Interval = 0.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss2, Count = 7, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBBoss3, Count = 3, Interval = 7 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBLightning, Count = 15, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 5, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBToxic, Count = 20, Interval = 2 }
			}
		},
		{
			CashBonus = 3000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss3, Count = 12, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 2, Interval = 7 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 5,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 4500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery2, Count = 10, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss3, Count = 6, Interval = 2.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Multiplier2, Count = 3, Interval = 3 }
			}
		},
		{
			CashBonus = 6000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 1,
					Interval = 5
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.TBNecromancer, Count = 5, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBMystery2, Count = 20, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLightning, Count = 20, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBMystery, Count = 35, Interval = 1 }
			}
		},
		{
			CashBonus = 8000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 4, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery2, Count = 25, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 5, Interval = 5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLightning, Count = 7, Interval = 2 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.TBBoss2, Count = 2, Interval = 5 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 7, Interval = 1 }
			}
		},
		{
			CashBonus = 50000,
			OverrideXP = 3750,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 5, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss3, Count = 5, Interval = 2 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TBToxic, Count = 50, Interval = 0.8 },
				{ StartDelay = 0.3, EnemyType = Enums.Enemies.TBLava, Count = 50, Interval = 0.8 },
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 1,
					Interval = 1.5
				},
				{ StartDelay = 37, EnemyType = Enums.Enemies.TBBoss3, Count = 8, Interval = 4 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.TBGuardian, Count = 1, Interval = 5 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.TBVoid, Count = 1, Interval = 2.5 }
			}
		}
	}
}