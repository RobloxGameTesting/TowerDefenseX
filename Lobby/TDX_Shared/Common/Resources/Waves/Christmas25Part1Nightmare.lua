local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local RewindProducts = require(Common:WaitForChild("RewindProducts"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Robot Invasion (Nightmare)",
	DefeatScreenRenderName = "Christmas25 1",
	PlayerCountToStartingCashMap = { 10000, 7000, 5750, 4000 },
	OverrideMaxmimumTowerCountTable = { 60, 32, 25, 20, 16 },
	CashPerDamageData = {
		{ CashPerDamage = 1.8, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.5, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, CrystalsReward = 15, TokensReward = 35 },
		{ WaveNumber = 2, CrystalsReward = 40, TokensReward = 125 },
		{ WaveNumber = 3, CrystalsReward = 65, TokensReward = 225 },
		{ WaveNumber = 4, CrystalsReward = 95, TokensReward = 350 },
		{ WaveNumber = 5, CrystalsReward = 125, TokensReward = 450 },
		{ WaveNumber = 6, CrystalsReward = 235, TokensReward = 625 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 15000,
			GainHP = 5000
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 45000,
			GainHP = 7500
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 60000,
			GainHP = 10000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 125000,
			GainHP = 15000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 250000,
			GainHP = 25000
		}
	},
	DefaultXPPerWavePassed = 750,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "WinterContingencyBase" },
	SetUpTime = 30,
	OverrideDelayOnceWaveCleared = 30,
	PowerUpsDisabled = true,
	RandomizePathIndex = true,
	HasDialogueSequenceData = true,
	WaveSkippingDisabled = true,
	VictoryCutsceneSeqeuence = Enums.CutsceneSequences.Christmas25Part1Victory,
	VictoryDelay = 3,
	VictoryBadgeIds = { 1026766070318278 },
	UpgradeShopEnabled = true,
	PlayerCountToUpgradeShopStartingCredits = { 1500, 1000, 800, 600 },
	TowerCostMultiplierMap = { [Enums.Towers.EDJ] = 7.5, [Enums.Towers.Commander] = 15 },
	PreloadEnemyNames = { Enums.Enemies.GiantMGBot },
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
			PlayerCountToUpgradeShopCreditPool = { 1600, 1200, 875, 675 },
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RangerBot1,
					AdditionalShieldMultiplier = 0.2,
					Count = 70,
					Interval = 2.5
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.RangerBot2,
					AdditionalShieldMultiplier = 0.2,
					Count = 25,
					Interval = 9
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.TargetBot, Count = 4, Interval = 1 },
				{ StartDelay = 20, EnemyType = Enums.Enemies.MissileBot, Count = 5, Interval = 2.3 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.MissileBot, Count = 5, Interval = 2.7 },
				{ StartDelay = 92, EnemyType = Enums.Enemies.MissileBot, Count = 5, Interval = 2.2 },
				{
					StartDelay = 105,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 8,
					Interval = 0.7
				},
				{ StartDelay = 125, EnemyType = Enums.Enemies.FlameBot, Count = 6, Interval = 9 },
				{ StartDelay = 140, EnemyType = Enums.Enemies.TargetBot, Count = 25, Interval = 1 },
				{ StartDelay = 155, EnemyType = Enums.Enemies.MissileBot, Count = 16, Interval = 3 },
				{ StartDelay = 175, EnemyType = Enums.Enemies.TBScoutBot, Count = 4, Interval = 15 },
				{ StartDelay = 177, EnemyType = Enums.Enemies.TBScoutBot, Count = 9, Interval = 9 },
				{ StartDelay = 210, EnemyType = Enums.Enemies.FlameBot, Count = 3, Interval = 5 },
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 7,
					Interval = 1.5
				},
				{ StartDelay = 200, EnemyType = Enums.Enemies.KritzBot, Count = 4, Interval = 1.5 }
			}
		},
		{
			CashBonus = 10000,
			PlayerCountToUpgradeShopCreditPool = { 1900, 1450, 975, 750 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 12,
					Interval = 2
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Boterator, Count = 30, Interval = 5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.TargetBot,
					AdditionalShieldMultiplier = 0.5,
					Count = 40,
					Interval = 0.7
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.TBScoutBot,
					AdditionalShieldMultiplier = 0.5,
					Count = 30,
					Interval = 1
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalShieldMultiplier = 0.5,
					Count = 15,
					Interval = 3
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.RangerBot2, Count = 36, Interval = 7 },
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 8,
					Interval = 2
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.DJRobot, Count = 2, Interval = 7 },
				{
					StartDelay = 58,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 40,
					Interval = 0.7
				},
				{ StartDelay = 55, EnemyType = Enums.Enemies.FlameBot, Count = 8, Interval = 5 },
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 10,
					Interval = 2
				},
				{ StartDelay = 68, EnemyType = Enums.Enemies.KritzBot, Count = 4, Interval = 4 },
				{ StartDelay = 65, EnemyType = Enums.Enemies.RangerBot1, Count = 30, Interval = 5 },
				{ StartDelay = 95, EnemyType = Enums.Enemies.DJRobot, Count = 1, Interval = 7 },
				{
					StartDelay = 92,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalShieldMultiplier = 0.5,
					Count = 12,
					Interval = 3
				},
				{
					StartDelay = 102,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 8,
					Interval = 1.5
				},
				{ StartDelay = 107, EnemyType = Enums.Enemies.MediBot, Count = 3, Interval = 5 },
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
				{ StartDelay = 137, EnemyType = Enums.Enemies.MissileBot, Count = 30, Interval = 1 },
				{ StartDelay = 135, EnemyType = Enums.Enemies.DJRobot, Count = 5, Interval = 4 },
				{ StartDelay = 139, EnemyType = Enums.Enemies.MediBot, Count = 5, Interval = 13 },
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
					Count = 32,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 0.7
				},
				{ StartDelay = 184, EnemyType = Enums.Enemies.MediBot, Count = 3, Interval = 4 },
				{
					StartDelay = 181,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 205,
					EnemyType = Enums.Enemies.CommanderBot,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 5,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 30000,
			PlayerCountToUpgradeShopCreditPool = { 2100, 1550, 1075, 875 },
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.RangerBot2,
					AdditionalHealthMultiplier = 0.6,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 140,
					Interval = 2
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.GiantLaserBot, Count = 2, Interval = 4 },
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 7,
					Interval = 3
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ScoutBot,
					Count = 40,
					AdditionalShieldMultiplier = 0.7,
					Interval = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 3,
					Interval = 4
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					Count = 4,
					Interval = 17
				},
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.JuggernautBot,
					Count = 15,
					Interval = 4.5
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 4,
					Interval = 4.5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 1.2,
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
					Count = 14,
					Interval = 7
				},
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.GiantKritzBot,
					Count = 2,
					Interval = 7
				},
				{ StartDelay = 70, EnemyType = Enums.Enemies.GiantMediBot, Count = 1, Interval = 6 },
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.ScoutBot,
					Count = 50,
					AdditionalShieldMultiplier = 1,
					Interval = 0.7
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 2,
					Interval = 1.2
				},
				{ StartDelay = 155, EnemyType = Enums.Enemies.DJRobot, Count = 4, Interval = 9 },
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.TBScoutBot,
					Count = 15,
					Interval = 0.7
				},
				{
					StartDelay = 155,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 3,
					Interval = 12
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.GoldenRangerRobot,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.5,
					Count = 50,
					Interval = 1.2
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.MissileBot,
					AdditionalHealthMultiplier = 0.25,
					AdditionalShieldMultiplier = 2.5,
					Count = 100,
					Interval = 1.2
				},
				{
					StartDelay = 202,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 7,
					Interval = 9
				},
				{
					StartDelay = 207,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 2,
					Interval = 10
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 3,
					AdditionalShieldMultiplier = 0.5,
					Interval = 7
				},
				{
					StartDelay = 252,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 2,
					Interval = 10
				},
				{
					StartDelay = 235,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 2,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 45000,
			PlayerCountToUpgradeShopCreditPool = { 2300, 1750, 1275, 1075 },
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ScoutBot,
					AdditionalShieldMultiplier = 1.2,
					Count = 600,
					Interval = 0.1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.DJRobot, Count = 10, Interval = 4 },
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.GiantLaserBot,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.RailtrooperBot,
					Count = 20,
					Interval = 6
				},
				{
					StartDelay = 57,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					Count = 1,
					ForcePathIndices = { 4 },
					Interval = 7
				},
				{
					StartDelay = 67,
					EnemyType = Enums.Enemies.GiantKritzBot,
					Count = 1,
					ForcePathIndices = { 4 },
					Interval = 7
				},
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.GiantRailgunnerBot,
					ForcePathIndices = { 9 },
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantKritzBot,
					Count = 1,
					ForcePathIndices = { 9 },
					Interval = 7
				},
				{ StartDelay = 160, EnemyType = Enums.Enemies.GiantMGBot, Count = 1, Interval = 5 },
				{ StartDelay = 95, EnemyType = Enums.Enemies.MediBot, Count = 5, Interval = 4 },
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 4,
					Interval = 5
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
					AdditionalShieldMultiplier = 0.5,
					Count = 5,
					Interval = 7
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.ScoutBot,
					AdditionalShieldMultiplier = 1.2,
					Count = 50,
					Interval = 0.7
				},
				{
					StartDelay = 175,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					Count = 1,
					Interval = 5
				},
				{
					StartDelay = 132,
					EnemyType = Enums.Enemies.GiantGrenadierBot,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 3,
					Interval = 7
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					ForcePathIndices = { 4 },
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.GiantShotgunnerRobot,
					ForcePathIndices = { 9 },
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.ScoutBot,
					AdditionalShieldMultiplier = 1.2,
					Count = 500,
					Interval = 0.07
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					AdditionalShieldMultiplier = 0.5,
					Count = 2,
					Interval = 5
				},
				{ StartDelay = 210, EnemyType = Enums.Enemies.DJRobot, Count = 5, Interval = 6 },
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					Count = 1,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 60000,
			PlayerCountToUpgradeShopCreditPool = { 3000, 2000, 1500, 1275 },
			CustomWaveTime = 700,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GiantSlammerBot,
					Count = 3,
					Interval = 4
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.GiantLaserBot, Count = 4, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.CommanderBot, Count = 6, Interval = 10 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 3,
					Interval = 12
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.GiantRangerRobot,
					Count = 14,
					Interval = 5
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
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true,
					Count = 8,
					Interval = 11
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
					AdditionalShieldMultiplier = 7,
					SpawnOnAllPaths = true,
					Interval = 4.5
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.DJRobot,
					AdditionalShieldMultiplier = 3,
					Count = 10,
					Interval = 2.5
				},
				{
					StartDelay = 205,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					AdditionalHealthMultiplier = 0.2,
					ForcePathIndices = { 11 },
					Interval = 20
				},
				{
					StartDelay = 225,
					EnemyType = Enums.Enemies.GiantKritzBot,
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
			PlayerCountToUpgradeShopCreditPool = { 3500, 3000, 2750, 2400 },
			CashMultiplierOverride = 0.5,
			CustomWaveTime = 700,
			OverrideXP = 5000,
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
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 5,
					Interval = 7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GiantLaserBot,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 15,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GoldenRangerRobot,
					Count = 20,
					Interval = 2
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
					AdditionalShieldMultiplier = 3,
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
				{ StartDelay = 19, EnemyType = Enums.Enemies.GiantMediBot, Count = 3, Interval = 8 },
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					Interval = 40
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.GiantJuggernautBot,
					Count = 1,
					ForcePathIndices = { 6 },
					Interval = 40
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.GiantMediBot,
					Count = 1,
					ForcePathIndices = { 6 },
					Interval = 40
				},
				{ StartDelay = 65, EnemyType = Enums.Enemies.GiantMRLBot, Count = 4, Interval = 8 },
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.GiantKritzBot,
					Count = 4,
					Interval = 7
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 7 }
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 1 }
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 2 }
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.GiantFlameBot,
					Count = 1,
					Interval = 40,
					ForcePathIndices = { 9 }
				},
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.FlameBot,
					AdditionalShieldMultiplier = 4,
					AdditionalHealthMultiplier = 2,
					Count = 50,
					Interval = 0.3
				}
			}
		}
	}
}