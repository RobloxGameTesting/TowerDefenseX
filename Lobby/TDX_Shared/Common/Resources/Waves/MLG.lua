local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.MLG,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.MLGScarecrow,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.MLGScarecrow,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.GoldenRanger,
				Enums.Towers.GoldenJuggernaut,
				Enums.Towers.GoldenMineLayer,
				Enums.Towers.GoldenMobster,
				Enums.Towers.GoldenWarship,
				Enums.Towers.Juggernaut
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.MLGSupport,
			IconId = "rbxassetid://112662075132649",
			VIPOnly = false,
			Towers = {
				Enums.Towers.EDJ,
				Enums.Towers.Zed,
				Enums.Towers.ArmoredFactory,
				Enums.Towers.LaserGunner,
				Enums.Towers.Ghost,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.MLGHeavyWeapons,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Artillery,
				Enums.Towers.Juggernaut,
				Enums.Towers.MineLayer,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Slammer
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.SpecialForces,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.MLGSpecialForces,
			IconId = "rbxassetid://76800397073968",
			VIPOnly = true,
			Towers = {
				Enums.Towers.FlameTrooper,
				Enums.Towers.GoldenRanger,
				Enums.Towers.Railgunner,
				Enums.Towers.Slammer,
				Enums.Towers.EDJ,
				Enums.Towers.Commander
			}
		}
	}
}
return {
	DisplayName = "MLG",
	OverrideAdvisorName = "MLG",
	PlayerCountToStartingCashMap = { 250000, 175000, 120000, 100000 },
	CashPerDamageData = {
		{ CashPerDamage = 0.7, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.6, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.4, CashPerDamageShared = 0.2 },
		{ CashPerDamage = 0.25, CashPerDamageShared = 0.15 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.12, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.1, CashPerDamageShared = 0.05 },
		{ MaxLevel = 30, CashPerDamage = 0.08, CashPerDamageShared = 0.04 },
		{ MaxLevel = 40, CashPerDamage = 0.06, CashPerDamageShared = 0.03 },
		{ MaxLevel = 60, CashPerDamage = 0.04, CashPerDamageShared = 0.01 },
		{ MaxLevel = 80, CashPerDamage = 0.02, CashPerDamageShared = 0.01 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 3, GoldReward = 10 },
		{ WaveNumber = 5, GoldReward = 35 },
		{ WaveNumber = 8, GoldReward = 60 },
		{ WaveNumber = 10, GoldReward = 100 },
		{ WaveNumber = 16, GoldReward = 175 },
		{ WaveNumber = 18, GoldReward = 200 },
		{ WaveNumber = 20, GoldReward = 250 },
		{ WaveNumber = 24, GoldReward = 325 },
		{ WaveNumber = 27, GoldReward = 450 },
		{ WaveNumber = 29, GoldReward = 750 },
		{ WaveNumber = 30, GoldReward = 1000 },
		{ WaveNumber = 31, GoldReward = 1200 },
		{ WaveNumber = 35, GoldReward = 1800 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 4,
			CostGold = 75,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 10000,
			GainHP = 3000
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 12000,
			GainHP = 5000
		},
		{
			WaveNumber = 12,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 15000,
			GainHP = 12500
		},
		{
			WaveNumber = 16,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 17500,
			GainHP = 15000
		},
		{
			WaveNumber = 20,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 25000,
			GainHP = 25000
		},
		{
			WaveNumber = 25,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 50000,
			GainHP = 35000
		},
		{
			WaveNumber = 30,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 200000,
			GainHP = 50000
		},
		{
			WaveNumber = 33,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 350000,
			GainHP = 125000
		}
	},
	DefaultXPPerWavePassed = 75,
	StartingLives = 233337,
	SetUpTime = 55,
	LoadoutSelectionData = loadoutSelectionData,
	AmbientPlaylist = { "MLG1", "MLG2", "MLG3", "MLG4", "MLG5" },
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Troll, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 6312,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Troll, Count = 12, Interval = 1 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.EpicTroll, Count = 3, Interval = 3 }
			}
		},
		{
			CashBonus = 6342,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.EpicTroll, Count = 7, Interval = 1.5 },
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.Troll,
					Count = 1,
					AdditionalShieldMultiplier = 10,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 2324,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Troll, Count = 70, Interval = 0.25 }
			}
		},
		{
			CashBonus = 2451,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.EpicTroll, Count = 35, Interval = 0.8 }
			}
		},
		{
			CashBonus = 6352,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Grum, Count = 25, Interval = 1.2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					SpeedBoostMultiplier = 0.15,
					Count = 35,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 2315,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Grum, Count = 25, Interval = 1.2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.Multiplier2, Count = 3, Interval = 3.5 }
			}
		},
		{
			CashBonus = 1634,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Troll,
					AdditionalSpeedBoostMultiplier = 1.5,
					Count = 70,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 4721,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.BuffActivist, Count = 3, Interval = 7 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Grum,
					Count = 25,
					AdditionalSpeedBoostMultiplier = 0.5,
					Interval = 0.15
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.EpicTroll,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 5,
					Count = 2,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 8212,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.DewKid, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 7242,
			CustomWaveTime = 120,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Spooky, Count = 17, Interval = 1 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Troll,
					Count = 25,
					AdditionalSpeedBoostMultiplier = 2,
					AdditionalShieldMultiplier = 3,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 6254,
			CashMultiplierOverride = 0.25,
			CustomWaveTime = 180,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.BuffActivist, Count = 6, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Troll,
					Count = 100,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalHealthMultiplier = 1.2,
					Interval = 0.3
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Grum, Count = 25, Interval = 0.15 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.EpicTroll,
					AdditionalSpeedBoostMultiplier = 4,
					Count = 4,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 3125,
			CustomWaveTime = 120,
			CashMultiplierOverride = 0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TheRotator, Count = 12, Interval = 1.2 }
			}
		},
		{
			CashBonus = 1523,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.DewKid,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 20,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 9314,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.Noscoper, Count = 7, Interval = 1.2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Spooky,
					Count = 12,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 6234,
			CustomWaveTime = 260,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					Count = 100,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalHealthMultiplier = 1.2,
					Interval = 0.3
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.Noscoper, Count = 3, Interval = 8 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Eradicator,
					Count = 1,
					AdditionalHealthMultiplier = 4,
					AdditionalShieldMultiplier = 0.7,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			CashMultiplierOverride = 0.3,
			CustomWaveTime = 180,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Robert, Count = 30, Interval = 1 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TheRotator,
					Count = 12,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 12352,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RadicalSpooky,
					Count = 2,
					Interval = 12
				}
			}
		},
		{
			CashBonus = 15342,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.DewKid, Count = 25, Interval = 0.5 }
			}
		},
		{
			CashBonus = 350000,
			CustomWaveTime = 777,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToiletJohnBoss,
					Count = 1,
					Interval = 8
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.EpicTroll, Count = 250, Interval = 0.4 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Robert,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 60,
					Interval = 0.25
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Cheese, Count = 4, Interval = 7 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Noscoper,
					Count = 25,
					AdditionalShieldMultiplier = 3,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Illuminati, Count = 30, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Cheese, Count = 4, Interval = 2.7 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Sanic, Count = 7, Interval = 2 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Sanic, Count = 9, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Noscoper,
					Count = 5,
					AdditionalShieldMultiplier = 3,
					Interval = 7
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Illuminati, Count = 20, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.DewKid, Count = 25, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Sanic, Count = 9, Interval = 1 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					Count = 1,
					AdditionalHealthMultiplier = 65,
					Interval = 0.5
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.TrollPhysics, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RGBSpooky, Count = 1, Interval = 5 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Cheese,
					Count = 7,
					AdditionalShieldMultiplier = 1,
					Interval = 2.7
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.MLGGeneralCelgar,
					Count = 1,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MegaGulper, Count = 8, Interval = 4.5 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.MachoNacho, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Sanic, Count = 12, Interval = 1.1 }
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JohnToilet,
					Count = 1,
					Interval = 0.5,
					AdditionalShieldMultiplier = 10
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.RGBSpooky, Count = 1, Interval = 0.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Atrazine, Count = 1, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1500,
			CashMultiplierOverride = 0.1,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.MachoNacho, Count = 5, Interval = 15 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.MegaGulper, Count = 2, Interval = 13 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Grumble, Count = 3, Interval = 8 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Grum,
					Count = 90,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 1,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 200000,
			OverrideXP = 4000,
			SpawnSequences = {
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.TheIlluminati,
					Count = 1,
					Interval = 0.5
				},
				{ StartDelay = 0.3, EnemyType = Enums.Enemies.MegaGulper, Count = 5, Interval = 12 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Noscoper,
					Count = 8,
					AdditionalHealthMultiplier = 1,
					Interval = 20
				},
				{ StartDelay = 17, EnemyType = Enums.Enemies.MachoNacho, Count = 2, Interval = 16 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.Cheese, Count = 5, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Sanic, Count = 5, Interval = 15 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Illuminati3, Count = 7, Interval = 1.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					Count = 200,
					AdditionalHealthMultiplier = 1,
					Interval = 0.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TrollPhysics, Count = 18, Interval = 2 }
			}
		}
	}
}