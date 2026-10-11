local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Assault Mode (Nightmare)",
	DefeatScreenRenderName = "Christmas25 1",
	PlayerCountToStartingCashMap = { 60000, 41000, 31500, 27500 },
	OverrideMaxmimumTowerCountTable = { 60, 32, 25, 20, 16 },
	CashPerDamageData = {
		{ CashPerDamage = 1.8, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.5, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 125, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 250, TokensReward = 100 },
		{ WaveNumber = 3, GoldReward = 325, TokensReward = 175 },
		{ WaveNumber = 4, GoldReward = 500, TokensReward = 250 },
		{ WaveNumber = 5, GoldReward = 750, TokensReward = 300 },
		{ WaveNumber = 6, GoldReward = 875, TokensReward = 400 },
		{ WaveNumber = 7, GoldReward = 1300, TokensReward = 675 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 15000,
			GainHP = 2500
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 25000,
			GainHP = 4000
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 50000,
			GainHP = 7000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 100000,
			GainHP = 15000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 175000,
			GainHP = 25000
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_85,
			GainCash = 275000,
			GainHP = 42500
		}
	},
	DefaultXPPerWavePassed = 1000,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "NorthforgeMissileSilo" },
	SetUpTime = 30,
	OverrideDelayOnceWaveCleared = 30,
	PowerUpsDisabled = true,
	RandomizePathIndex = true,
	HasDialogueSequenceData = true,
	WaveSkippingDisabled = true,
	IntroCutsceneSequence = Enums.CutsceneSequences.Christmas25Part2Intro,
	VictoryDelay = 12,
	VictoryBadgeIds = { 1518345441440863 },
	UpgradeShopEnabled = true,
	PlayerCountToUpgradeShopStartingCredits = { 2300, 1700, 1500, 1350 },
	CustomGameInfoHandlerName = Enums.GameModes.AssaultMode,
	HideDefaultGameInfo = true,
	TowerCostMultiplierMap = { [Enums.Towers.EDJ] = 12, [Enums.Towers.Commander] = 17 },
	PreloadEnemyNames = { Enums.Enemies.GiantMGBot },
	AmbientPlaylist = {
		"Christmas25_1",
		"Christmas25_2",
		"Christmas25_3",
		"Christmas25_4",
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
			PlayerCountToUpgradeShopCreditPool = { 3250, 1800, 1500, 1400 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 3
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 5,
					Interval = 10
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.RangerBot2,
					Count = 15,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2.7
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 2,
					Interval = 50
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.RangerBot2,
					AdditionalShieldMultiplier = 0.5,
					Count = 30,
					Interval = 1.5
				},
				{
					StartDelay = 65,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 12,
					AdditionalShieldMultiplier = 0.2,
					Interval = 9
				},
				{ StartDelay = 90, EnemyType = Enums.Enemies.MissileBot, Count = 9, Interval = 3.5 },
				{ StartDelay = 85, EnemyType = Enums.Enemies.ScoutBot, Count = 5, Interval = 1 },
				{ StartDelay = 95, EnemyType = Enums.Enemies.ScoutBot, Count = 5, Interval = 1 },
				{ StartDelay = 105, EnemyType = Enums.Enemies.ScoutBot, Count = 5, Interval = 1 },
				{
					StartDelay = 125,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 4,
					Interval = 2.5
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 5,
					Interval = 2.5
				},
				{
					StartDelay = 152,
					EnemyType = Enums.Enemies.DJRobot,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				},
				{
					StartDelay = 165,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 6,
					Interval = 2.5
				},
				{
					StartDelay = 158,
					EnemyType = Enums.Enemies.SGrenadierBot,
					Count = 4,
					AdditionalShieldMultiplier = 0.5,
					Interval = 7
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 11,
					Interval = 7.5
				},
				{ StartDelay = 200, EnemyType = Enums.Enemies.Boterator, Count = 22, Interval = 4 },
				{
					StartDelay = 260,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 10,
					Interval = 2.5
				},
				{
					StartDelay = 305,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 5
				},
				{
					StartDelay = 308,
					EnemyType = Enums.Enemies.KritzBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 2,
					Count = 1,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 4000,
			CashMultiplierOverride = 0.6,
			PlayerCountToUpgradeShopCreditPool = { 3500, 2300, 1900, 1700 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 10,
					AdditionalShieldMultiplier = 0.3,
					Interval = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Boterator,
					Count = 18,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				},
				{
					StartDelay = 1.5,
					EnemyType = Enums.Enemies.MediBot,
					Count = 6,
					AdditionalShieldMultiplier = 1,
					Interval = 5
				},
				{ StartDelay = 30, EnemyType = Enums.Enemies.M202Bot, Count = 3, Interval = 2.5 },
				{ StartDelay = 32, EnemyType = Enums.Enemies.KritzBot, Count = 3, Interval = 2.5 },
				{
					StartDelay = 37,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 1
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.MediBot,
					Count = 5,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.Boterator,
					ForcePathIndices = { 1 },
					Count = 10,
					AdditionalShieldMultiplier = 0.7,
					Interval = 0.7
				},
				{
					StartDelay = 65,
					EnemyType = Enums.Enemies.ScoutBot,
					ForcePathIndices = { 1 },
					Count = 15,
					AdditionalShieldMultiplier = 0.8,
					Interval = 0.5
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.CommanderBot,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 12
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.5,
					Count = 2,
					Interval = 11
				},
				{
					StartDelay = 95,
					EnemyType = Enums.Enemies.M202Bot,
					ForcePathIndices = { 1 },
					Count = 4,
					Interval = 2
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.MissileBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 2,
					Count = 10,
					Interval = 1
				},
				{
					StartDelay = 103,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 7,
					AdditionalShieldMultiplier = 0.2,
					Interval = 4
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 2,
					AdditionalShieldMultiplier = 0.2,
					ForcePathIndices = { 1 },
					Interval = 7
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 3,
					AdditionalShieldMultiplier = 0.3,
					Interval = 4
				},
				{
					StartDelay = 158,
					EnemyType = Enums.Enemies.MissileBot,
					Count = 90,
					AdditionalShieldMultiplier = 1.5,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 20000,
			CashMultiplierOverride = 0.4,
			PlayerCountToUpgradeShopCreditPool = { 2175, 1250, 1000, 900 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 4,
					AdditionalShieldMultiplier = 0.4,
					Interval = 4
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.MediBot,
					AdditionalShieldMultiplier = 2.5,
					Count = 3,
					Interval = 4
				},
				{
					StartDelay = 31,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 2
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.LaserBot,
					Count = 35,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1.5
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 24,
					AdditionalShieldMultiplier = 0.2,
					Interval = 4
				},
				{
					StartDelay = 42,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.35,
					Interval = 4
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Boterator,
					Count = 20,
					AdditionalShieldMultiplier = 0.7,
					Interval = 0.3
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 4,
					AdditionalShieldMultiplier = 0.2,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 82,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 4,
					AdditionalShieldMultiplier = 0.2,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{ StartDelay = 84, EnemyType = Enums.Enemies.M202Bot, Count = 7, Interval = 1 }
			}
		},
		{
			CashBonus = 25000,
			CashMultiplierOverride = 0.4,
			PlayerCountToUpgradeShopCreditPool = { 1850, 1375, 1125, 1000 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Boterator,
					Count = 100,
					AdditionalShieldMultiplier = 3.2,
					Interval = 0.2
				},
				{
					StartDelay = 1.1,
					EnemyType = Enums.Enemies.SGrenadierBot,
					Count = 5,
					AdditionalShieldMultiplier = 0.2,
					Interval = 3
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.DJRobot,
					Count = 11,
					AdditionalShieldMultiplier = 0.6,
					Interval = 5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.KritzBot,
					Count = 30,
					AdditionalShieldMultiplier = 0.7,
					ForcePathIndices = { 1 },
					Interval = 1.5
				},
				{
					StartDelay = 36,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					AdditionalShieldMultiplier = 0.4,
					Count = 3,
					Interval = 3.2
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 3,
					AdditionalShieldMultiplier = 0.4,
					ForcePathIndices = { 1 },
					Interval = 2
				},
				{
					StartDelay = 52,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 4,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 1 },
					Interval = 4
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.ScoutBot,
					AdditionalShieldMultiplier = 2.5,
					Count = 60,
					Interval = 0.2
				}
			}
		},
		{
			CashBonus = 50000,
			CashMultiplierOverride = 0.35,
			PlayerCountToUpgradeShopCreditPool = { 2500, 2000, 1725, 1325 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					AdditionalShieldMultiplier = 0.1,
					Count = 15,
					Interval = 3
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.CommanderBot, Count = 3, Interval = 12 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.GiantLaserBot,
					ForcePathIndices = { 1 },
					Count = 5,
					Interval = 4
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.DJRobot,
					Count = 5,
					AdditionalShieldMultiplier = 2,
					Interval = 5
				},
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.JuggernautBot,
					AdditionalShieldMultiplier = 0.6,
					Count = 25,
					Interval = 1.62
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 5,
					Interval = 1.5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.KritzBot,
					Count = 30,
					AdditionalShieldMultiplier = 2,
					ForcePathIndices = { 1 },
					Interval = 1.5
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.M202Bot,
					Count = 15,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 62,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalShieldMultiplier = 5,
					Count = 50,
					Interval = 0.7
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.GiantKritzBot,
					ForcePathIndices = { 1 },
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					ForcePathIndices = { 1 },
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 72,
					EnemyType = Enums.Enemies.SGrenadierBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.4,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 105,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalShieldMultiplier = 3,
					Count = 50,
					Interval = 0.4
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					ForcePathIndices = { 1 },
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 105,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 25,
					Interval = 0.7
				},
				{
					StartDelay = 117,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 3,
					AdditionalShieldMultiplier = 0.3,
					Interval = 4
				},
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.GoldenRangerRobot,
					Count = 14,
					AdditionalShieldMultiplier = 0.35,
					Interval = 1.5
				},
				{
					StartDelay = 131,
					EnemyType = Enums.Enemies.GoldenBotster,
					Count = 12,
					AdditionalShieldMultiplier = 0.35,
					Interval = 2.5
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.M1BTank,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.2,
					Count = 2,
					Interval = 7
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.GiantFlameBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 0.2,
					Count = 2,
					Interval = 3.5
				},
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.KritzBot,
					ForcePathIndices = { 1 },
					AdditionalShieldMultiplier = 3,
					Count = 5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 125000,
			PlayerCountToUpgradeShopCreditPool = { 2800, 2275, 1925, 1525 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 3,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.M1BTank,
					Count = 3,
					AdditionalShieldMultiplier = 0.2,
					Interval = 7
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.GiantMRLBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					ForcePathIndices = { 1 },
					Interval = 2
				},
				{
					StartDelay = 43,
					EnemyType = Enums.Enemies.BombTank,
					ForcePathIndices = { 1 },
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 26,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 15,
					AdditionalShieldMultiplier = 0.2,
					Interval = 2
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.GiantMGBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 300000,
			CashMultiplierOverride = 0.5,
			PlayerCountToUpgradeShopCreditPool = { 3000, 2500, 2100, 1700 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Ironclad,
					Count = 1,
					AdditionalHealthMultiplier = 0.15,
					ForcePathIndices = { 1 },
					Interval = 4
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.GiantMGBot,
					Count = 4,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 1 },
					Interval = 30
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					Count = 1,
					AdditionalShieldMultiplier = 0.2,
					Interval = 75
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 2,
					AdditionalShieldMultiplier = 0.25,
					Interval = 7
				},
				{
					StartDelay = 156,
					EnemyType = Enums.Enemies.GiantKritzBot,
					ForcePathIndices = { 1 },
					Count = 2,
					AdditionalShieldMultiplier = 0.25,
					Interval = 11
				},
				{ StartDelay = 185, EnemyType = Enums.Enemies.GiantMRLBot, Count = 1, Interval = 7 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.M1BTank,
					Count = 7,
					AdditionalShieldMultiplier = 0.25,
					Interval = 6
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.M1BTank,
					Count = 2,
					AdditionalShieldMultiplier = 0.25,
					Interval = 8
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.MegaTank,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 6
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ShieldBuster,
					Count = 3,
					AdditionalShieldMultiplier = 0.25,
					ForcePathIndices = { 1 },
					Interval = 17
				},
				{
					StartDelay = 52,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 17,
					AdditionalShieldMultiplier = 0.25,
					ForcePathIndices = { 1 },
					Interval = 2.5
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.BombTank,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 3
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 6
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.GiantMediBot,
					ForcePathIndices = { 1 },
					Count = 1,
					Interval = 6
				}
			}
		}
	}
}