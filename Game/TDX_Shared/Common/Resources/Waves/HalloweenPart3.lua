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
				Enums.Towers.Medic,
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
				Enums.Towers.Medic,
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
	DisplayName = "Halloween III",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 3",
	OverrideAdvisorName = "OilHalloweenPart3",
	PlayerCountToStartingCashMap = { 8000, 6500, 5500, 4000 },
	CashPerDamageData = {
		{ CashPerDamage = 2.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.45 },
		{ CashPerDamage = 1.4, CashPerDamageShared = 0.4 }
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
		{ WaveNumber = 1, GoldReward = 150, TokensReward = 60 },
		{ WaveNumber = 2, GoldReward = 275, TokensReward = 90 },
		{ WaveNumber = 3, GoldReward = 450, TokensReward = 140 },
		{ WaveNumber = 4, GoldReward = 650, TokensReward = 180 },
		{ WaveNumber = 5, GoldReward = 900, TokensReward = 250 },
		{ WaveNumber = 6, GoldReward = 1350, TokensReward = 425 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_10,
			GainCash = 10000,
			GainHP = 5000
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 20000,
			GainHP = 7500
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 40000,
			GainHP = 8000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 75000,
			GainHP = 10000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 125000,
			GainHP = 17500
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 250000,
			GainHP = 25000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 0,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 2,
				[Enums.PowerUps.AC130Support] = 1,
				[Enums.PowerUps.AirStrike] = 5,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealthCrate] = 35,
				[Enums.PowerUps.HealingField] = 0
			}
		}
	},
	DefaultXPPerWavePassed = 500,
	StartingLives = 49972,
	StartingLivesOverriddenBy = { "Hellspire Artillery" },
	SetUpTime = 30,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	RandomizePathIndex = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 12,
	VictoryBadgeIds = { 4200913367907900 },
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"HalloweenNight3_1",
		"HalloweenNight3_2",
		"HalloweenNight3_3",
		"HalloweenNight3_4"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 8,
					Interval = 1.4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 11,
					Interval = 2.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 9,
					Interval = 2
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 14,
					Interval = 1.4
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 17,
					Interval = 2.5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 22,
					Interval = 1
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 32,
					Interval = 1.4
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 35,
					Interval = 2.5
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 37,
					Interval = 2
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 5,
					Interval = 2
				},
				{
					StartDelay = 125,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 5,
					Interval = 8
				},
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 5,
					Interval = 1
				},
				{
					StartDelay = 145,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 32,
					Interval = 1.45
				},
				{
					StartDelay = 165,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 35,
					Interval = 2.5
				},
				{
					StartDelay = 157,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 37,
					Interval = 2
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 5,
					Interval = 3
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 5,
					Interval = 12
				},
				{
					StartDelay = 225,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 32,
					Interval = 1.3
				},
				{
					StartDelay = 235,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 35,
					Interval = 1.1
				},
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 37,
					Interval = 1.7
				},
				{
					StartDelay = 260,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 4,
					Interval = 6
				},
				{
					StartDelay = 257,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 3,
					Interval = 3
				},
				{
					StartDelay = 265,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 3,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 6000,
			CashMultiplierOverride = 0.85,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 25,
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 25,
					Interval = 0.7
				},
				{ StartDelay = 12, EnemyType = Enums.Enemies.AirDiabolist, Count = 5, Interval = 7 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 5,
					Interval = 8,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 3,
					Interval = 2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 5,
					Interval = 1.2
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Wraith,
					Count = 8,
					Stealth = true,
					Interval = 4.6
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 90,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 90,
					Interval = 1.2
				},
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 3,
					Interval = 1.2
				},
				{ StartDelay = 100, EnemyType = Enums.Enemies.Banshee, Count = 4, Interval = 6 },
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 3,
					Interval = 8
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.Wraith,
					Count = 5,
					Stealth = true,
					Interval = 9
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 6,
					Interval = 7
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 7,
					Interval = 5
				},
				{ StartDelay = 200, EnemyType = Enums.Enemies.Banshee, Count = 5, Interval = 3 },
				{
					StartDelay = 165,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 20,
					Interval = 1.2
				},
				{
					StartDelay = 145,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 12,
					Interval = 0.7
				},
				{
					StartDelay = 192,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 18,
					Interval = 7
				},
				{
					StartDelay = 175,
					EnemyType = Enums.Enemies.Wraith,
					Count = 5,
					Stealth = true,
					Interval = 4
				},
				{ StartDelay = 190, EnemyType = Enums.Enemies.Banshee, Count = 4, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 25,
					Interval = 1.2
				},
				{
					StartDelay = 195,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 1,
					Interval = 8
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 100,
					Interval = 1.4,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 3,
					Interval = 10
				},
				{
					StartDelay = 260,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 8,
					Interval = 4,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 290,
					EnemyType = Enums.Enemies.Wraith,
					Count = 12,
					Stealth = true,
					Interval = 6
				},
				{
					StartDelay = 270,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 8,
					AdditionalHealthMultiplier = 1,
					Interval = 1.2
				},
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 7,
					AdditionalHealthMultiplier = 1,
					Interval = 1.2
				},
				{
					StartDelay = 320,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 18,
					Interval = 4
				},
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 3,
					Interval = 8
				},
				{ StartDelay = 350, EnemyType = Enums.Enemies.Banshee, Count = 12, Interval = 2 },
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 5,
					Interval = 5,
					AdditionalHealthMultiplier = 3
				},
				{
					StartDelay = 370,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 370,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 7,
					Interval = 2
				},
				{ StartDelay = 310, EnemyType = Enums.Enemies.DreadKnight, Count = 8, Interval = 7 },
				{
					StartDelay = 380,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 20,
					Interval = 1,
					AdditionalHealthMultiplier = 3
				}
			}
		},
		{
			CashBonus = 7000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 90,
					Interval = 1.4,
					AdditionalHealthMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 75,
					Interval = 2.5,
					AdditionalHealthMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 90,
					Interval = 2,
					AdditionalHealthMultiplier = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CultistAssassin,
					Count = 2,
					Stealth = true,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 3,
					Interval = 50
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 2,
					Interval = 7
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 15,
					AdditionalHealthMultiplier = 3,
					Interval = 20
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 15,
					AdditionalHealthMultiplier = 3,
					Interval = 16
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 17,
					Interval = 4,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Banshee,
					Count = 17,
					Interval = 4,
					AdditionalHealthMultiplier = 3
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.Diabolist, Count = 6, Interval = 8 },
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 5,
					Interval = 7.4
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.DreadKnight, Count = 10, Interval = 5 },
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Wraith,
					Count = 16,
					Stealth = true,
					AdditionalHealthMultiplier = 3,
					Interval = 4
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 8,
					Interval = 5,
					AdditionalHealthMultiplier = 1
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.Diabolist, Count = 6, Interval = 7 },
				{
					StartDelay = 75,
					EnemyType = Enums.Enemies.CultistAssassin,
					Count = 4,
					Stealth = true,
					Interval = 4
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 3,
					Interval = 5
				},
				{ StartDelay = 95, EnemyType = Enums.Enemies.DreadKnight, Count = 10, Interval = 5 },
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 90,
					Interval = 1.4,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 75,
					Interval = 2.5,
					AdditionalHealthMultiplier = 5
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 90,
					Interval = 2,
					AdditionalHealthMultiplier = 4
				},
				{ StartDelay = 115, EnemyType = Enums.Enemies.Diabolist, Count = 11, Interval = 5 },
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.Wraith,
					Count = 20,
					Stealth = true,
					AdditionalHealthMultiplier = 3,
					Interval = 3
				},
				{
					StartDelay = 122,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 14,
					AdditionalHealthMultiplier = 1,
					Interval = 4.5
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 13,
					Interval = 4
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 1,
					Interval = 4.5
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 10,
					AdditionalHealthMultiplier = 4,
					Interval = 5.5
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 15,
					AdditionalHealthMultiplier = 3,
					Interval = 4
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 14,
					AdditionalHealthMultiplier = 1,
					Interval = 4.5
				},
				{
					StartDelay = 247,
					EnemyType = Enums.Enemies.Wraith,
					Count = 20,
					Stealth = true,
					AdditionalHealthMultiplier = 3,
					Interval = 3
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 1,
					Interval = 4.5
				},
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 10,
					AdditionalHealthMultiplier = 1,
					Interval = 5
				},
				{
					StartDelay = 280,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 8,
					Interval = 2.5
				},
				{ StartDelay = 290, EnemyType = Enums.Enemies.Diabolist, Count = 11, Interval = 3 }
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 4,
					Interval = 5
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.DreadKnight, Count = 4, Interval = 4.6 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Diabolist, Count = 7, Interval = 10 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TankPathfinder,
					Count = 1,
					Stealth = true,
					Interval = 1.7
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 4,
					Interval = 5
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 4,
					Interval = 15
				},
				{ StartDelay = 40, EnemyType = Enums.Enemies.DreadKnight, Count = 3, Interval = 3 },
				{ StartDelay = 60, EnemyType = Enums.Enemies.DreadKnight, Count = 40, Interval = 7 },
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 6,
					Interval = 5
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 4,
					Interval = 3
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.TankPathfinder,
					Count = 1,
					Stealth = true,
					Interval = 1.7
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 8,
					Interval = 5
				},
				{
					StartDelay = 260,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 2,
					Interval = 10
				},
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 3,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 25000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 20,
					AdditionalShieldMultiplier = 1,
					Interval = 1.7
				},
				{
					StartDelay = 64,
					EnemyType = Enums.Enemies.DreadnoughtContemptor,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.DreadnoughtRavager,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 175,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 8,
					Interval = 4.5
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 40,
					Interval = 1.4
				},
				{
					StartDelay = 225,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 8,
					Interval = 7
				},
				{
					StartDelay = 230,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 20,
					Interval = 2,
					Stealth = true,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 8,
					Interval = 9
				},
				{ StartDelay = 140, EnemyType = Enums.Enemies.Diabolist, Count = 20, Interval = 3 },
				{
					StartDelay = 141,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 20,
					Interval = 2.6
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 20,
					Interval = 2.6
				}
			}
		},
		{
			CashBonus = 100000,
			CustomWaveTime = 1e999,
			LockSpeedMultiplierTo1 = true,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CorruptedEradicatorMK2,
					Count = 1,
					Interval = 1.5,
					ForcePathIndices = { 18 }
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 7,
					Interval = 0.2
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 0.2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 7,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				}
			}
		}
	}
}