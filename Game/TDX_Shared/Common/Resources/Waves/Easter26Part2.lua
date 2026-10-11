local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Easter,
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
				Enums.Towers.Medic
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
				Enums.Towers.MissileTrooper,
				Enums.Towers.ScoutHelicopter,
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
				Enums.Towers.Medic,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.ArmoredFactory
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
				Enums.Towers.Ghost,
				Enums.Towers.Medic,
				Enums.Towers.EDJ,
				Enums.Towers.John
			}
		}
	}
}
return {
	DisplayName = "Easter Night (Normal)",
	DefeatScreenRenderName = "Easter26",
	PlayerCountToStartingCashMap = { 82000, 46000, 32000, 24750 },
	CashPerDamageData = {
		{ CashPerDamage = 1.35, CashPerDamageShared = 0 },
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
		{ WaveNumber = 1, GoldReward = 75, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 175, TokensReward = 75 },
		{ WaveNumber = 4, GoldReward = 200, TokensReward = 100 },
		{ WaveNumber = 7, GoldReward = 275, TokensReward = 150 },
		{ WaveNumber = 10, GoldReward = 375, TokensReward = 195 },
		{ WaveNumber = 12, GoldReward = 500, TokensReward = 250 },
		{ WaveNumber = 15, GoldReward = 700, TokensReward = 350 },
		{ WaveNumber = 18, GoldReward = 925, TokensReward = 425 },
		{ WaveNumber = 19, GoldReward = 1400, TokensReward = 675 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 8000,
			GainHP = 2500
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 10000,
			GainHP = 4000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 20000,
			GainHP = 8000
		},
		{
			WaveNumber = 8,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 40000,
			GainHP = 12000
		},
		{
			WaveNumber = 12,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 80000,
			GainHP = 18000
		},
		{
			WaveNumber = 16,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 100000,
			GainHP = 22000
		},
		{
			WaveNumber = 18,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 150000,
			GainHP = 30000
		}
	},
	DefaultXPPerWavePassed = 400,
	VictoryBadgeIds = { 171886072661730 },
	StartingLives = 15000,
	SetUpTime = 25,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	WaveSkippingDisabled = true,
	HasDialogueSequenceData = true,
	PreloadEnemyNames = { Enums.Enemies.RavagedPredator, Enums.Enemies.EasterEngineer },
	TowerCostMultiplierMap = { [Enums.Towers.MissileTrooper] = 0.9 },
	AmbientPlaylist = {
		"Easter26_1",
		"Easter26_2",
		"Easter26_3",
		"Easter26_4",
		"Easter26_5",
		"Easter26_6",
		"Easter26_7",
		"Easter26_8",
		"HalloweenNight2_1",
		"HalloweenNight2_2",
		"HalloweenNight2_3",
		"HalloweenNight2_4"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobNormal,
					Count = 30,
					Interval = 1.5
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 5,
					SpawnOnAllPaths = true,
					Interval = 8
				}
			}
		},
		{
			CashBonus = 500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.PsychomobNormal,
					Count = 40,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 50,
					Interval = 0.8
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 8
				}
			}
		},
		{
			CashBonus = 600,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 20,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 38,
					Interval = 0.25
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Judge, Count = 2, Interval = 12 },
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 5,
					Interval = 0.25
				},
				{ StartDelay = 14, EnemyType = Enums.Enemies.DuckHunter, Count = 5, Interval = 9 }
			}
		},
		{
			CashBonus = 700,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TerryTheBunny,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 90,
					Interval = 0.2
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.DuckHunter,
					Count = 10,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 800,
			CashMultiplierOverride = 2,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerA,
					Count = 150,
					Interval = 0.35
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Zealot,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.25,
					Count = 30,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 6,
					SpawnOnAllPaths = true,
					Interval = 2
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.NailHead,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 12
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerB,
					Count = 150,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerC,
					Count = 136,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 900,
			CashMultiplierOverride = 1,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Diabolist, Count = 25, Interval = 1.2 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 90,
					AdditionalShieldMultiplier = 1,
					Interval = 0.3
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.PsychomobRunner,
					Count = 90,
					AdditionalShieldMultiplier = 1,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 28000,
			CustomWaveTime = 250,
			SpawnSequences = {
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.RavagedPredator,
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedPredator,
					AdditionalHealthMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1100,
			CashMultiplierOverride = 1.5,
			CustomWaveTime = 160,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.PapaDuck, Count = 14, Interval = 5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.NailHead,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 12
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.DuckHunter,
					AdditionalSpeedBoostMultiplier = 1,
					SpawnOnAllPaths = true,
					Count = 25,
					Interval = 2
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TwitchingVile,
					Count = 4,
					SpawnOnAllPaths = true,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 24000,
			CashMultiplierOverride = 1.2,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RavagedPredator,
					Count = 6,
					ForcePathIndices = { 3, 4 },
					AdditionalSpeedBoostMultiplier = 0.15,
					Interval = 3.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Jumper,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 50,
					Interval = 1
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.NailHead,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 1300,
			CashMultiplierOverride = 1,
			CustomWaveTime = 240,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 45,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.2,
					Count = 85,
					Interval = 0.2
				},
				{
					StartDelay = 4.2,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 10,
					SpawnOnAllPaths = true,
					Interval = 4
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.NailHead,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 19
				}
			}
		},
		{
			CashBonus = 1400,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Hatchling3,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1500,
			CustomWaveTime = 140,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 2,
					AdditionalHealthMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.7,
					AdditionalSpeedBoostMultiplier = 0.25,
					SpawnOnAllPaths = true,
					Interval = 6
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Hatchling3, Count = 1, Interval = 0.5 }
			}
		},
		{
			CashBonus = 1600,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Hatchling3,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 0.5
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 3,
					Interval = 2.3
				}
			}
		},
		{
			CashBonus = 1700,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Shady,
					Stealth = true,
					Count = 15,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PapaDuck,
					Count = 14,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalHealthMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobSlow,
					Count = 85,
					AdditionalShieldMultiplier = 1.5,
					AdditionalSpeedBoostMultiplier = 0.4,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychomobRunner,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					AdditionalShieldMultiplier = 0.2,
					Count = 120,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 40000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier3,
					SpawnOnAllPaths = true,
					Count = 4,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.DuckHunter,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 6,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.MultiplierT,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 1800,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Shady,
					Stealth = true,
					Count = 50,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 1900,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.WallPusher,
					AdditionalShieldMultiplier = 1,
					Count = 15,
					Interval = 2.9
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SpeedDeployer,
					AdditionalShieldMultiplier = 5,
					SpawnOnAllPaths = true,
					Count = 2,
					Interval = 8
				}
			}
		},
		{
			CashBonus = 30000,
			CashMultiplierOverride = 0.45,
			CustomWaveTime = 550,
			OverrideXP = 3000,
			OverrideAmbientPlaylist = { "BunnyZillaWaveMusic" },
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyZilla,
					Count = 1,
					ForcePathIndices = { 3, 4 },
					Interval = 0.5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.BunnyTank900,
					Count = 1,
					ForcePathIndices = { 3 },
					Interval = 3
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.BunnyTank900,
					Count = 1,
					ForcePathIndices = { 4 },
					Interval = 3
				}
			}
		},
		{
			CashBonus = 75000,
			OverrideXP = 6200,
			CashMultiplierOverride = 0.65,
			CustomWaveTime = 550,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.EasterEngineer,
					Count = 1,
					Interval = 0.5,
					ForcePathIndices = { 5 }
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.RavagedPredator,
					AdditionalHealthMultiplier = 0.5,
					Count = 5,
					Interval = 1.5
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.RavagedPredator,
					AdditionalHealthMultiplier = 0.5,
					Count = 5,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyGuardian,
					Count = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				}
			}
		}
	}
}