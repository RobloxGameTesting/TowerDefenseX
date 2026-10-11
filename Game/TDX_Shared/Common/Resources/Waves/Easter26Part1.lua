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
				Enums.Towers.NoobTuber,
				Enums.Towers.Operator,
				Enums.Towers.Stinger
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
				Enums.Towers.Stinger,
				Enums.Towers.Operator,
				Enums.Towers.Medic
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
	DisplayName = "Easter Day (Normal)",
	DefeatScreenRenderName = "Easter26",
	PlayerCountToStartingCashMap = { 25000, 19000, 17000, 14000 },
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
		{ WaveNumber = 1, GoldReward = 100, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 175, TokensReward = 100 },
		{ WaveNumber = 3, GoldReward = 275, TokensReward = 185 },
		{ WaveNumber = 4, GoldReward = 375, TokensReward = 285 },
		{ WaveNumber = 5, GoldReward = 700, TokensReward = 400 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 5000,
			GainHP = 250
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 10000,
			GainHP = 450
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 20000,
			GainHP = 750
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 40000,
			GainHP = 1250
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 80000,
			GainHP = 2500
		}
	},
	DefaultXPPerWavePassed = 700,
	VictoryBadgeIds = { 2124354625057396 },
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "EasterCastrumBase" },
	SetUpTime = 30,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	WaveSkippingDisabled = true,
	HasDialogueSequenceData = true,
	PreloadEnemyNames = {},
	AmbientPlaylist = {
		"Easter26_1",
		"Easter26_2",
		"Easter26_3",
		"Easter26_4",
		"Easter26_5",
		"Easter26_6",
		"Easter26_7",
		"Easter26_8"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 360,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling3,
					Count = 2600,
					Interval = 0.08
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Terry, Count = 200, Interval = 0.8 },
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.BunnyGangNormal,
					Count = 12,
					Interval = 8.5
				},
				{ StartDelay = 145, EnemyType = Enums.Enemies.Berry, Count = 2, Interval = 5 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 550,
			SpawnSequences = {
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.Eggling2,
					Count = 500,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling3,
					Count = 300,
					AdditionalShieldMultiplier = 5,
					Interval = 0.04
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 230,
					AdditionalSpeedBoostMultiplier = 0.55,
					Interval = 1
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.Berry, Count = 25, Interval = 8.5 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.BunnyGangNormal,
					Count = 60,
					Interval = 4
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.Eggling1, Count = 18, Interval = 13 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Eggling4, Count = 200, Interval = 0.5 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 300,
					AdditionalSpeedBoostMultiplier = 0.75,
					AdditionalShieldMultiplier = 0.7,
					Interval = 0.8
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.BabyDuck, Count = 70, Interval = 3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Eggling1, Count = 27, Interval = 6 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.LilEntling, Count = 5, Interval = 3 },
				{ StartDelay = 75, EnemyType = Enums.Enemies.LilEntling, Count = 7, Interval = 3 },
				{ StartDelay = 110, EnemyType = Enums.Enemies.LilEntling, Count = 9, Interval = 3 },
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.Berry,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 45,
					Interval = 4.5
				},
				{ StartDelay = 150, EnemyType = Enums.Enemies.LilEntling, Count = 12, Interval = 3 },
				{ StartDelay = 200, EnemyType = Enums.Enemies.BigEntling, Count = 2, Interval = 8 },
				{ StartDelay = 230, EnemyType = Enums.Enemies.LilEntling, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Terry,
					Count = 225,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 1.2,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Berry,
					Count = 60,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalShieldMultiplier = 0.4,
					Interval = 4.2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.BabyDuck,
					Count = 70,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.3,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Eggling1,
					Count = 22,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.1,
					Interval = 6
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.LilEntling, Count = 25, Interval = 3 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.MamaDuck, Count = 4, Interval = 12 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.BigEntling, Count = 5, Interval = 9 },
				{ StartDelay = 72, EnemyType = Enums.Enemies.MamaDuck, Count = 4, Interval = 12 },
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.LilEntling,
					AdditionalSpeedBoostMultiplier = 0.4,
					SpawnOnAllPaths = true,
					Count = 9,
					Interval = 1.25
				}
			}
		},
		{
			CashBonus = 150000,
			CashMultiplierOverride = 2.8,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.BunnyOTron,
					Count = 1,
					ForcePathIndices = { 1 },
					Interval = 1.2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Eggling4,
					AdditionalHealthMultiplier = 0.7,
					Count = 50,
					Interval = 1
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.DuckStrike,
					Count = 7,
					SpawnOnAllPaths = true,
					Interval = 9
				}
			}
		}
	}
}