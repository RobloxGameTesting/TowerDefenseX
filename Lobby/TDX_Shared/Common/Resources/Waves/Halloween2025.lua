local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Halloween,
	NoSkip = false,
	SkipPenaltyPercentage = 0.5,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.John,
				Enums.Towers.MissileTrooper,
				Enums.Towers.Juggernaut,
				Enums.Towers.Operator,
				Enums.Towers.EDJ,
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
				Enums.Towers.AATurret,
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
				Enums.Towers.Operator,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.AATurret
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.SpecialForces,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://76800397073968",
			VIPOnly = true,
			Towers = {
				Enums.Towers.CryoRanger,
				Enums.Towers.GoldenRanger,
				Enums.Towers.Ghost,
				Enums.Towers.AATurret,
				Enums.Towers.EDJ,
				Enums.Towers.John
			}
		}
	}
}
return {
	DisplayName = "Halloween 2025",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 1",
	OverrideAdvisorName = "Halloween25_Advisor",
	PlayerCountToStartingCashMap = { 1500, 1000, 950, 900 },
	CashPerDamageData = {
		{ CashPerDamage = 1.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 0.65, CashPerDamageShared = 0.3 }
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
		{ WaveNumber = 1, GoldReward = 4, TokensReward = 3 },
		{ WaveNumber = 5, GoldReward = 150, TokensReward = 45 },
		{ WaveNumber = 9, GoldReward = 325, TokensReward = 80 },
		{ WaveNumber = 13, GoldReward = 400, TokensReward = 100 },
		{ WaveNumber = 17, GoldReward = 500, TokensReward = 150 },
		{ WaveNumber = 21, GoldReward = 700, TokensReward = 180 },
		{ WaveNumber = 23, GoldReward = 850, TokensReward = 200 },
		{ WaveNumber = 25, GoldReward = 850, TokensReward = 250 },
		{ WaveNumber = 26, GoldReward = 1000, CrystalsReward = 50, TokensReward = 435 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 1000,
			GainHP = 250
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 4000,
			GainHP = 450
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 6500,
			GainHP = 750
		},
		{
			WaveNumber = 12,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 9250,
			GainHP = 1250
		},
		{
			WaveNumber = 15,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 15000,
			GainHP = 1750
		},
		{
			WaveNumber = 20,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 27500,
			GainHP = 2500
		},
		{
			WaveNumber = 25,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 100000,
			GainHP = 3500
		}
	},
	DefaultXPPerWavePassed = 100,
	StartingLives = 2500,
	SetUpTime = 25,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	PreloadEnemyNames = {},
	TowerCostMultiplierMap = { [Enums.Towers.AATurret] = 1.3 },
	AmbientPlaylist = {
		"Halloween2025_1",
		"Halloween2025_2",
		"Halloween2025_3",
		"Halloween2025_4",
		"Halloween2025_5",
		"Halloween2025_6",
		"Halloween2025_7",
		"Halloween2025_8",
		"Halloween2025_9"
	},
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Corrupted, Count = 9, Interval = 1.5 }
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Corrupted, Count = 14, Interval = 1.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Corroded, Count = 4, Interval = 4 }
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Corrupted, Count = 25, Interval = 1.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.GhostEnemy, Count = 2, Interval = 2 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Corrupted, Count = 14, Interval = 1.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Corroded, Count = 5, Interval = 4 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.GhostEnemy, Count = 4, Interval = 4 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Corrupted, Count = 50, Interval = 0.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Corroded, Count = 9, Interval = 2 }
			}
		},
		{
			CashBonus = 1300,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TombRaider, Count = 3, Interval = 4 },
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.GhostEnemy,
					Count = 5,
					Interval = 1.6
				}
			}
		},
		{
			CashBonus = 1400,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TombRaider, Count = 5, Interval = 5 },
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.GhostEnemy,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 30,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 1500,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.CurseVine, Count = 1, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TombRaider, Count = 1, Interval = 5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Corrupted,
					AdditionalShieldMultiplier = 1,
					Count = 12,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 1600,
			SpawnSequences = {
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.LostSoul, Count = 8, Interval = 1.5 },
				{
					StartDelay = 8.2,
					EnemyType = Enums.Enemies.GhostEnemy,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 5,
					Interval = 1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TombRaider, Count = 8, Interval = 4 }
			}
		},
		{
			CashBonus = 1700,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CurseVine, Count = 1, Interval = 1.5 },
				{ StartDelay = 0.7, EnemyType = Enums.Enemies.LostSoul, Count = 5, Interval = 0.7 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.TormentedSoul,
					Count = 5,
					Interval = 4.5
				}
			}
		},
		{
			CashBonus = 1900,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TormentedSoul,
					Count = 9,
					Interval = 3.5
				},
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.LostSoul, Count = 16, Interval = 1.7 }
			}
		},
		{
			CashBonus = 24000,
			CustomWaveTime = 160,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VineGolem, Count = 2, Interval = 25 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Corroded, Count = 60, Interval = 1.2 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.CurseVine, Count = 1, Interval = 12 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.GhostEnemy,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 25,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 2100,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SkeletonAirbarrel,
					Count = 2,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 2200,
			CashMultiplierOverride = 0.75,
			CustomWaveTime = 150,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Tormentor, Count = 1, Interval = 1.5 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VineGolem, Count = 1, Interval = 11 }
			}
		},
		{
			CashBonus = 2300,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SkeletonAirbarrel,
					Count = 6,
					Interval = 7
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TormentedSoul,
					Count = 10,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 25000,
			CustomWaveTime = 275,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 0.7,
					EnemyType = Enums.Enemies.TombRaider,
					Count = 60,
					Interval = 1.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Ghoul,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 0.7
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.VineGolem, Count = 11, Interval = 13 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FlyingPumpkin,
					Count = 10,
					Interval = 11
				},
				{
					StartDelay = 138,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 1,
					Interval = 6
				},
				{ StartDelay = 165, EnemyType = Enums.Enemies.Ghoul, Count = 1, Interval = 0.7 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.Tormentor, Count = 2, Interval = 35 }
			}
		},
		{
			CashBonus = 2500,
			CustomWaveTime = 120,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Apostle, Count = 1, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VineGolem, Count = 5, Interval = 7 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 2,
					Interval = 18
				}
			}
		},
		{
			CashBonus = 2600,
			CustomWaveTime = 150,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Ghoul,
					AdditionalShieldMultiplier = 0.5,
					Count = 2,
					Interval = 1.7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.TormentedSoul,
					Count = 27,
					Interval = 1
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.Apostle, Count = 3, Interval = 12 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.Tormentor, Count = 1, Interval = 12 },
				{
					StartDelay = 43,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 1,
					Interval = 12
				}
			}
		},
		{
			CashBonus = 2700,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SkeletonAirbarrel,
					Count = 17,
					Interval = 1.2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Ghoul,
					Count = 2,
					AdditionalShieldMultiplier = 1,
					Interval = 15
				}
			}
		},
		{
			CashBonus = 60000,
			CustomWaveTime = 280,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.CoffinHead, Count = 1, Interval = 1.5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.FlyingPumpkin, Count = 5, Interval = 7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Tormentor, Count = 5, Interval = 15 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TombRaider,
					Count = 25,
					AdditionalShieldMultiplier = 1.5,
					Interval = 1
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 3,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 5000,
			CustomWaveTime = 150,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Apostle, Count = 10, Interval = 3.5 }
			}
		},
		{
			CashBonus = 3500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.GraveGuardian, Count = 3, Interval = 5 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Apostle, Count = 2, Interval = 4 }
			}
		},
		{
			CashBonus = 15000,
			CustomWaveTime = 150,
			SpawnSequences = {
				{ StartDelay = 5, EnemyType = Enums.Enemies.GiantBat, Count = 8, Interval = 7 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 5,
					Interval = 5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.FlyingPumpkin,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.VineGolem,
					Count = 5,
					AdditionalShieldMultiplier = 1.5,
					Interval = 9
				}
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 180,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 20,
					Interval = 5
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.GiantBat, Count = 5, Interval = 20 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Ghoul,
					Count = 4,
					Interval = 20,
					AdditionalShieldMultiplier = 2.5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.FlyingPumpkin,
					Count = 15,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 20000,
			CustomWaveTime = 320,
			SpawnSequences = {
				{
					StartDelay = 7.5,
					EnemyType = Enums.Enemies.HarvestWitch,
					Count = 1,
					Interval = 1.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.CoffinHead, Count = 1, Interval = 2 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Apostle,
					AdditionalShieldMultiplier = 0.5,
					Count = 9,
					Interval = 9
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PumpkinBalloon,
					Count = 7,
					Interval = 11
				}
			}
		},
		{
			CashBonus = 100000,
			OverrideXP = 2000,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ForgottenKnight,
					IsUnstasisSequence = true,
					Count = 1,
					Interval = 1.5
				}
			}
		}
	}
}