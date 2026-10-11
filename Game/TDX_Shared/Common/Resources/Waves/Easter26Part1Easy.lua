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
	SkipPenaltyPercentage = 0.7,
	LoadoutSelectionConfigs = {
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.MissileTrooper,
				Enums.Towers.John,
				Enums.Towers.Operator,
				Enums.Towers.NoobTuber,
				Enums.Towers.Stinger,
				Enums.Towers.EDJ
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
				Enums.Towers.Grenadier,
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
				Enums.Towers.NoobTuber,
				Enums.Towers.Juggernaut,
				Enums.Towers.Operator,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Stinger
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
				Enums.Towers.Stinger,
				Enums.Towers.EDJ,
				Enums.Towers.John
			}
		}
	}
}
return {
	DisplayName = "Easter Day (Easy)",
	DefeatScreenRenderName = "Easter26",
	PlayerCountToStartingCashMap = { 28000, 21000, 20000, 18000 },
	CashPerDamageData = {
		{ CashPerDamage = 1.35, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.7 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.5 }
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
		{ WaveNumber = 1, GoldReward = 50, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 125, TokensReward = 90 },
		{ WaveNumber = 3, GoldReward = 325, TokensReward = 150 },
		{ WaveNumber = 4, GoldReward = 350, TokensReward = 225 },
		{ WaveNumber = 5, GoldReward = 500, TokensReward = 325 }
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
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 15000,
			GainHP = 750
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 25000,
			GainHP = 1250
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_30,
			GainCash = 50000,
			GainHP = 2500
		}
	},
	DefaultXPPerWavePassed = 650,
	StartingLives = 676767,
	StartingLivesOverriddenBy = { "EasterCastrumBase" },
	SetUpTime = 25,
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
					Count = 1400,
					Interval = 0.12
				},
				{ StartDelay = 3, EnemyType = Enums.Enemies.Terry, Count = 160, Interval = 1.2 },
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.BunnyGangNormal,
					Count = 8,
					Interval = 7
				},
				{ StartDelay = 145, EnemyType = Enums.Enemies.Berry, Count = 2, Interval = 5 }
			}
		},
		{
			CashBonus = 8000,
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
			CashBonus = 14000,
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
				{ StartDelay = 5, EnemyType = Enums.Enemies.BabyDuck, Count = 30, Interval = 6 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Eggling1, Count = 27, Interval = 6 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.LilEntling, Count = 3, Interval = 3 },
				{ StartDelay = 75, EnemyType = Enums.Enemies.LilEntling, Count = 5, Interval = 3 },
				{ StartDelay = 110, EnemyType = Enums.Enemies.LilEntling, Count = 7, Interval = 3 },
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.Berry,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 45,
					Interval = 4.5
				},
				{ StartDelay = 150, EnemyType = Enums.Enemies.LilEntling, Count = 9, Interval = 3 },
				{ StartDelay = 200, EnemyType = Enums.Enemies.BigEntling, Count = 2, Interval = 8 },
				{ StartDelay = 230, EnemyType = Enums.Enemies.LilEntling, Count = 10, Interval = 2 }
			}
		},
		{
			CashBonus = 20000,
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
					Count = 60,
					AdditionalShieldMultiplier = 0.2,
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
				{ StartDelay = 15, EnemyType = Enums.Enemies.LilEntling, Count = 15, Interval = 5 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.MamaDuck, Count = 6, Interval = 12 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.BigEntling, Count = 4, Interval = 15 },
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.LilEntling,
					AdditionalSpeedBoostMultiplier = 0.2,
					SpawnOnAllPaths = true,
					Count = 9,
					Interval = 4.5
				}
			}
		},
		{
			CashBonus = 200000,
			CashMultiplierOverride = 3,
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
					Count = 100,
					Interval = 1
				}
			}
		}
	}
}