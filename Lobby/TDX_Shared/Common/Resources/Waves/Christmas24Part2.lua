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
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Assault2,
			IconId = "rbxassetid://77242869433652",
			VIPOnly = false,
			Towers = {
				Enums.Towers.John,
				Enums.Towers.Medic,
				Enums.Towers.Juggernaut,
				Enums.Towers.LaserGunner,
				Enums.Towers.MissileTrooper,
				Enums.Towers.Barracks
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Support,
			IconId = "rbxassetid://112662075132649",
			VIPOnly = false,
			Towers = {
				Enums.Towers.EDJ,
				Enums.Towers.Barracks,
				Enums.Towers.ArmoredFactory,
				Enums.Towers.Toxicnator,
				Enums.Towers.Ghost,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.HeavyWeapons2,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.Artillery,
				Enums.Towers.Juggernaut,
				Enums.Towers.Barracks,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.SpecialForces,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.SpecialForces,
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
	DisplayName = "Christmas II",
	DefeatScreenRenderName = "Christmas 2",
	OverrideAdvisorName = "Christmas24Part2_Advisor",
	PlayerCountToStartingCashMap = { 4500, 3400, 2875, 2700 },
	CashPerDamageData = {
		{ CashPerDamage = 2.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 2.2, CashPerDamageShared = 0.7 },
		{ CashPerDamage = 1.9, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.8, CashPerDamageShared = 0.5 }
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
		{ WaveNumber = 1, GoldReward = 75, TokensReward = 20 },
		{ WaveNumber = 2, GoldReward = 120, TokensReward = 50 },
		{ WaveNumber = 3, GoldReward = 250, TokensReward = 70 },
		{ WaveNumber = 4, GoldReward = 350, CrystalsReward = 10, TokensReward = 90 },
		{ WaveNumber = 5, GoldReward = 500, CrystalsReward = 20, TokensReward = 100 },
		{ WaveNumber = 7, GoldReward = 625, CrystalsReward = 40, TokensReward = 130 },
		{ WaveNumber = 9, GoldReward = 800, CrystalsReward = 70, TokensReward = 175 },
		{ WaveNumber = 10, GoldReward = 920, CrystalsReward = 145, TokensReward = 325 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_20,
			GainCash = 10000,
			GainHP = 2000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 70000,
			GainHP = 4000
		},
		{
			WaveNumber = 7,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 100000,
			GainHP = 7000
		},
		{
			WaveNumber = 9,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 250000,
			GainHP = 10000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 0,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 2,
				[Enums.PowerUps.AirStrike] = 5,
				[Enums.PowerUps.RaptorStorm] = 0,
				[Enums.PowerUps.ReconDrone] = 20,
				[Enums.PowerUps.CashCrate] = 15,
				[Enums.PowerUps.HealingField] = 25
			}
		}
	},
	DefaultXPPerWavePassed = 235,
	StartingLives = 20000,
	StartingLivesOverriddenBy = { "Arctic HQ Gate" },
	SetUpTime = 30,
	PowerUpsDisabled = true,
	RandomizePathIndex = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 3,
	VictoryBadgeIds = { 1352022743522465 },
	LoadoutSelectionData = loadoutSelectionData,
	IntroCutsceneSequence = Enums.CutsceneSequences.Christmas24Part2Intro,
	VictoryCutsceneSeqeuence = Enums.CutsceneSequences.Christmas24Part2Victory,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"ChristmasPart2_1",
		"ChristmasPart2_2",
		"ChristmasPart2_3",
		"ChristmasPart2_4",
		"ChristmasPart2_5",
		"ChristmasPart2_6",
		"ChristmasPart2_7"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ArcticScout, Count = 30, Interval = 1 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 5,
					Interval = 4.5
				}
			}
		},
		{
			CashBonus = 2400,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArcticScout,
					Count = 50,
					Interval = 0.9
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ArcticScout,
					Count = 10,
					Interval = 0.4
				},
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 25,
					Interval = 1.5
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 2,
					Interval = 2.5
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 2,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.75,
			SpawnSequences = {
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ArcticScout,
					AdditionalHealthMultiplier = 0.3,
					Count = 50,
					Interval = 0.4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToyWithAttack,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 25,
					Interval = 0.3
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.WendigoHunter, Count = 5, Interval = 2 },
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.LumberjackWithAttack,
					Count = 1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 4750,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToyWithAttack,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 200,
					Interval = 0.07
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.LumberjackWithAttack,
					Count = 1,
					Interval = 4.6
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.ToyWithAttack,
					AdditionalSpeedBoostMultiplier = 0.7,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 0.07
				}
			}
		},
		{
			CashBonus = 5750,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 12,
					Interval = 3.6
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 6,
					Interval = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedCryoRangerWithAttack,
					Count = 2,
					Interval = 5
				},
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 1,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 16000,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 18,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToyWithAttack,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 60,
					Interval = 2
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 6,
					Interval = 1.5
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 6,
					Interval = 1.5
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SnowMobWithAttack,
					Count = 27,
					Interval = 1.6
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.ResurrectedCryoRangerWithAttack,
					Count = 2,
					Interval = 22
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 1,
					Interval = 8
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.CoalManWithAttack,
					Count = 20,
					Interval = 1
				},
				{ StartDelay = 55, EnemyType = Enums.Enemies.Belsnickel, Count = 2, Interval = 3 }
			}
		},
		{
			CashBonus = 18500,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0.2, EnemyType = Enums.Enemies.Deathwalker, Count = 1, Interval = 5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 7,
					Interval = 20
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 12,
					Interval = 5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.EvergrimSummoner,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 34,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 3,
					Interval = 8
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.Belsnickel, Count = 3, Interval = 20 },
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{ StartDelay = 80, EnemyType = Enums.Enemies.Deathwalker, Count = 1, Interval = 17 },
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 10,
					Interval = 18
				},
				{
					StartDelay = 67,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 1,
					Interval = 1.7
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.LumberjackWithAttack,
					Count = 10,
					Interval = 3
				},
				{ StartDelay = 94, EnemyType = Enums.Enemies.Belsnickel, Count = 4, Interval = 12 },
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.SnowPredator,
					Count = 2,
					Interval = 18,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 222.5,
					EnemyType = Enums.Enemies.WraithRider,
					Count = 1,
					Interval = 5
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 12,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 25000,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 100,
					Interval = 3
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.EvergrimSummoner,
					Count = 6,
					Interval = 12
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 10,
					Interval = 27
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Deathwalker, Count = 3, Interval = 17 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Belsnickel, Count = 11, Interval = 8 },
				{ StartDelay = 28, EnemyType = Enums.Enemies.Phantom, Count = 3, Interval = 12 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.WraithRider, Count = 2, Interval = 24 },
				{
					StartDelay = 88,
					EnemyType = Enums.Enemies.Phantom,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 12
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 2,
					AdditionalShieldMultiplier = 3,
					SpawnOnAllPaths = true,
					Interval = 2.6
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.EvergrimSummoner,
					Count = 4,
					AdditionalShieldMultiplier = 2,
					Interval = 4
				},
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 3,
					AdditionalShieldMultiplier = 2,
					Interval = 3
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 4
				},
				{
					StartDelay = 135,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 14,
					AdditionalShieldMultiplier = 2,
					Interval = 1.7
				},
				{
					StartDelay = 154,
					EnemyType = Enums.Enemies.Phantom,
					Count = 7,
					AdditionalShieldMultiplier = 2,
					Interval = 6
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 4
				},
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.WraithRider,
					Count = 3,
					Interval = 10
				},
				{
					StartDelay = 248,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 15 }
				},
				{
					StartDelay = 260.6,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 16 }
				}
			}
		},
		{
			CashBonus = 500000,
			CashMultiplierOverride = 1.1,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 100,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 0.5
				},
				{
					StartDelay = 63,
					EnemyType = Enums.Enemies.Phantom,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 17,
					Interval = 0.8
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 500,
					AdditionalSpeedBoostMultiplier = 0.6,
					AdditionalHealthMultiplier = 3,
					Interval = 0.1
				}
			}
		},
		{
			CashBonus = 200000,
			OverrideXP = 800,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.WraithRider, Count = 3, Interval = 2 },
				{ StartDelay = 1.2, EnemyType = Enums.Enemies.Deathwalker, Count = 6, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.SnowWendigo, Count = 17, Interval = 2 },
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.FrozenGladiator,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 2,
					Count = 4,
					Interval = 1.7
				},
				{
					StartDelay = 47.2,
					EnemyType = Enums.Enemies.GeneralCelgar,
					Count = 1,
					ForcePathIndices = { 13 },
					Interval = 0.1
				},
				{
					StartDelay = 49,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 1,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 4,
					Interval = 0.1
				},
				{
					StartDelay = 51,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 1.7
				},
				{
					StartDelay = 78,
					EnemyType = Enums.Enemies.ElderWendigo,
					Count = 1,
					Interval = 1.7
				}
			}
		}
	}
}