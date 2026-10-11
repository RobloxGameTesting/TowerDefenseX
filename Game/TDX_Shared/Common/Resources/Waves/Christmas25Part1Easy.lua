local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local loadoutSelectionData = {
	SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.Christmas,
	SkipPenaltyPercentage = 0.3,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Operator,
				Enums.Towers.Medic,
				Enums.Towers.Juggernaut,
				Enums.Towers.John,
				"",
				""
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Juggernaut,
				Enums.Towers.Refractor,
				Enums.Towers.Medic,
				"",
				"",
				""
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
				Enums.Towers.Juggernaut,
				Enums.Towers.Mobster,
				Enums.Towers.Medic,
				Enums.Towers.Commander
			}
		}
	}
}
return {
	DisplayName = "Robot Invasion (Easy)",
	DefeatScreenRenderName = "Christmas25 1",
	PlayerCountToStartingCashMap = { 19000, 15000, 12000, 11000 },
	OverrideMaxmimumTowerCountTable = { 60, 32, 25, 20, 16 },
	CashPerDamageData = {
		{ CashPerDamage = 1.4, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.45 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.35 },
		{ CashPerDamage = 0.85, CashPerDamageShared = 0.3 }
	},
	CumulativeLevelToExtraCashPerDamageDataMap = {
		{ MaxLevel = 10, CashPerDamage = 0.6, CashPerDamageShared = 0 },
		{ MaxLevel = 20, CashPerDamage = 0.5, CashPerDamageShared = 0 },
		{ MaxLevel = 30, CashPerDamage = 0.4, CashPerDamageShared = 0 },
		{ MaxLevel = 40, CashPerDamage = 0.3, CashPerDamageShared = 0 },
		{ MaxLevel = 60, CashPerDamage = 0.2, CashPerDamageShared = 0 },
		{ MaxLevel = 80, CashPerDamage = 0.1, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 125, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 350, TokensReward = 100 },
		{ WaveNumber = 3, GoldReward = 400, TokensReward = 150 },
		{ WaveNumber = 4, GoldReward = 500, TokensReward = 250 },
		{ WaveNumber = 5, GoldReward = 600, TokensReward = 285 },
		{ WaveNumber = 6, GoldReward = 800, TokensReward = 350 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 15000,
			GainHP = 2000
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 25000,
			GainHP = 4000
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 50000,
			GainHP = 7000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 100000,
			GainHP = 15000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 200000,
			GainHP = 25000
		}
	},
	DefaultXPPerWavePassed = 325,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "WinterContingencyBase" },
	SetUpTime = 30,
	OverrideDelayOnceWaveCleared = 30,
	RandomizePathIndex = true,
	HasDialogueSequenceData = true,
	WaveSkippingDisabled = true,
	VictoryCutsceneSeqeuence = Enums.CutsceneSequences.Christmas25Part1Victory,
	VictoryDelay = 3,
	VictoryBadgeIds = { 1505801717054137 },
	LoadoutSelectionData = loadoutSelectionData,
	UpgradeShopEnabled = true,
	PlayerCountToUpgradeShopStartingCredits = { 1500, 1100, 1000, 925 },
	TowerCostMultiplierMap = {
		[Enums.Towers.EDJ] = 4,
		[Enums.Towers.Commander] = 8,
		[Enums.Towers.Medic] = 0.4
	},
	AmbientPlaylist = {
		"Christmas25_1",
		"Christmas25_2",
		"Christmas25_3",
		"Christmas25_5",
		"Christmas25_6",
		"Christmas25_7",
		"Christmas25_8",
		"Christmas25_9",
		"Christmas25_10",
		"Christmas25_11",
		"Christmas25_12",
		"Christmas25_13",
		"Christmas25_14"
	},
	Waves = {
		{
			CashBonus = 0,
			PlayerCountToUpgradeShopCreditPool = { 1200, 975, 850, 750 },
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.RangerBot1, Count = 50, Interval = 4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.RangerBot2, Count = 25, Interval = 9 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.TargetBot, Count = 14, Interval = 1 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.MissileBot, Count = 2, Interval = 6 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.MissileBot, Count = 2, Interval = 6 },
				{
					StartDelay = 105,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 7,
					Interval = 0.7
				},
				{ StartDelay = 125, EnemyType = Enums.Enemies.FlameBot, Count = 3, Interval = 14 },
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.TargetBot,
					Count = 35,
					Interval = 1.3
				},
				{ StartDelay = 155, EnemyType = Enums.Enemies.MissileBot, Count = 3, Interval = 11 },
				{ StartDelay = 175, EnemyType = Enums.Enemies.TBScoutBot, Count = 4, Interval = 15 },
				{ StartDelay = 177, EnemyType = Enums.Enemies.TBScoutBot, Count = 9, Interval = 4 },
				{
					StartDelay = 186,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 3,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 10000,
			PlayerCountToUpgradeShopCreditPool = { 1600, 1200, 1000, 950 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.JuggernautBot, Count = 3, Interval = 8 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boterator, Count = 8, Interval = 17 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TargetBot, Count = 65, Interval = 0.7 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.TBScoutBot, Count = 30, Interval = 1 },
				{ StartDelay = 17, EnemyType = Enums.Enemies.MissileBot, Count = 15, Interval = 7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.RangerBot2, Count = 36, Interval = 7 },
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 3,
					Interval = 12
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.DJRobot, Count = 1, Interval = 7 },
				{
					StartDelay = 58,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 20,
					Interval = 0.7
				},
				{ StartDelay = 55, EnemyType = Enums.Enemies.TargetBot, Count = 50, Interval = 2 },
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 3,
					Interval = 7
				},
				{ StartDelay = 65, EnemyType = Enums.Enemies.RangerBot1, Count = 30, Interval = 5 },
				{ StartDelay = 95, EnemyType = Enums.Enemies.DJRobot, Count = 1, Interval = 7 },
				{ StartDelay = 92, EnemyType = Enums.Enemies.MissileBot, Count = 9, Interval = 7 },
				{
					StartDelay = 102,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 3,
					Interval = 9
				},
				{ StartDelay = 107, EnemyType = Enums.Enemies.MediBot, Count = 2, Interval = 5 },
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 20,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					Interval = 0.5
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 1,
					Interval = 0.5
				},
				{ StartDelay = 137, EnemyType = Enums.Enemies.TargetBot, Count = 35, Interval = 1 },
				{ StartDelay = 139, EnemyType = Enums.Enemies.MediBot, Count = 5, Interval = 8 },
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.TargetBot,
					AdditionalHealthMultiplier = 0.2,
					Count = 50,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 0.7
				},
				{ StartDelay = 184, EnemyType = Enums.Enemies.MediBot, Count = 3, Interval = 4 },
				{
					StartDelay = 187,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 195,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 100,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 15000,
			PlayerCountToUpgradeShopCreditPool = { 1700, 1400, 1200, 1000 },
			CashMultiplierOverride = 0.85,
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 2,
					Interval = 10
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.MediBot, Count = 4, Interval = 2.8 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Boterator, Count = 25, Interval = 8 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 2,
					Interval = 4
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.SniperBot,
					Count = 18,
					Stealth = true,
					Interval = 5
				},
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 10,
					Interval = 4.5
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 3,
					Interval = 4.5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalHealthMultiplier = 0.35,
					AdditionalShieldMultiplier = 0.15,
					Count = 35,
					Interval = 1.5
				},
				{
					StartDelay = 65,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 2,
					Interval = 10
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.SGrenadierBot,
					Count = 8,
					Interval = 7
				},
				{ StartDelay = 70, EnemyType = Enums.Enemies.MediBot, Count = 3, Interval = 10 },
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalHealthMultiplier = 0.35,
					AdditionalShieldMultiplier = 0.1,
					Count = 35,
					Interval = 1.5
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 30,
					Interval = 1.2
				},
				{ StartDelay = 155, EnemyType = Enums.Enemies.DJRobot, Count = 3, Interval = 9 },
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 15,
					Interval = 0.7
				},
				{ StartDelay = 155, EnemyType = Enums.Enemies.MediBot, Count = 17, Interval = 2.8 },
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.RangerBot1,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.1,
					Count = 50,
					Interval = 1.2
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalHealthMultiplier = 0.4,
					AdditionalShieldMultiplier = 0.2,
					Count = 10,
					Interval = 5
				},
				{
					StartDelay = 202,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 5,
					Interval = 11
				},
				{
					StartDelay = 207,
					EnemyType = Enums.Enemies.MediBot,
					Count = 6,
					AdditionalShieldMultiplier = 0.4,
					Interval = 8
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 3,
					Interval = 7
				},
				{
					StartDelay = 225,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 15,
					Interval = 2.6
				}
			}
		},
		{
			CashBonus = 25000,
			PlayerCountToUpgradeShopCreditPool = { 2000, 1700, 1500, 1275 },
			CashMultiplierOverride = 0.35,
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 30,
					Interval = 3
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 1,
					ForcePathIndices = { 11 },
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TargetBot,
					AdditionalHealthMultiplier = 3,
					AdditionalShieldMultiplier = 0.1,
					Count = 800,
					Interval = 0.1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.DJRobot, Count = 10, Interval = 4 },
				{ StartDelay = 52, EnemyType = Enums.Enemies.ScoutBot, Count = 3, Interval = 1.2 },
				{ StartDelay = 45, EnemyType = Enums.Enemies.ScoutBot, Count = 150, Interval = 1 },
				{
					StartDelay = 57,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					ForcePathIndices = { 4 },
					Interval = 7
				},
				{ StartDelay = 95, EnemyType = Enums.Enemies.MediBot, Count = 5, Interval = 4 },
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 4,
					Interval = 9
				},
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.JuggernautBot,
					AdditionalShieldMultiplier = 1,
					Count = 20,
					Interval = 4
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 3,
					Interval = 15
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.ScoutBot,
					Count = 100,
					Interval = 0.3
				},
				{
					StartDelay = 175,
					EnemyType = Enums.Enemies.CommanderBot,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 132,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 4,
					Interval = 7
				},
				{
					StartDelay = 205,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					ForcePathIndices = { 9 },
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.Boterator,
					AdditionalShieldMultiplier = 0.5,
					Count = 50,
					Interval = 1.2
				},
				{ StartDelay = 220, EnemyType = Enums.Enemies.MediBot, Count = 4, Interval = 7 },
				{ StartDelay = 210, EnemyType = Enums.Enemies.DJRobot, Count = 5, Interval = 6 },
				{
					StartDelay = 235,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 35000,
			PlayerCountToUpgradeShopCreditPool = { 2400, 1900, 1700, 1500 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 7,
					Interval = 4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiantLaserBot, Count = 4, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.CommanderBot, Count = 6, Interval = 10 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.MediBot, Count = 3, Interval = 30 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 7,
					Interval = 10
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 5,
					Interval = 20
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 3,
					Interval = 22
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.LaserBot,
					SpawnOnAllPaths = true,
					Count = 6,
					Interval = 19
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 20,
					Interval = 5
				},
				{
					StartDelay = 87,
					EnemyType = Enums.Enemies.SGrenadierBot,
					Count = 20,
					Interval = 4
				},
				{
					StartDelay = 165,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 6,
					AdditionalShieldMultiplier = 1,
					SpawnOnAllPaths = true,
					Interval = 4.5
				},
				{ StartDelay = 170, EnemyType = Enums.Enemies.DJRobot, Count = 10, Interval = 2.5 },
				{
					StartDelay = 205,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					ForcePathIndices = { 11 },
					Interval = 20
				},
				{
					StartDelay = 230,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 1,
					ForcePathIndices = { 11 },
					Interval = 20
				}
			}
		},
		{
			CashBonus = 100000,
			OverrideAmbientPlaylist = { "Christmas25_4" },
			PlayerCountToUpgradeShopCreditPool = { 2275, 1475, 1200, 1175 },
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 700,
			OverrideXP = 2000,
			SpawnSequences = {
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					AdditionalShieldMultiplier = 0.15,
					Count = 10,
					Interval = 6
				},
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					AdditionalShieldMultiplier = 0.15,
					Count = 4,
					Interval = 12
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GoldenRangerRobot,
					Count = 20,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TargetBot,
					Count = 50,
					AdditionalShieldMultiplier = 2,
					Interval = 0.5
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.GoldenBotster,
					Count = 20,
					Interval = 2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalShieldMultiplier = 1.5,
					AdditionalHealthMultiplier = 1,
					Count = 75,
					Interval = 0.7
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 5,
					Interval = 6
				},
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 3,
					Interval = 11
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					Interval = 40
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 1,
					ForcePathIndices = { 6 },
					Interval = 40
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.GiantKritzBot,
					Count = 1,
					ForcePathIndices = { 6 },
					Interval = 40
				},
				{ StartDelay = 70, EnemyType = Enums.Enemies.GiantMRLBot, Count = 1, Interval = 8 },
				{
					StartDelay = 106,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 7 }
				},
				{
					StartDelay = 115,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 1 }
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.FlameBot,
					AdditionalShieldMultiplier = 1,
					AdditionalHealthMultiplier = 2,
					Count = 50,
					Interval = 0.3
				}
			}
		}
	}
}