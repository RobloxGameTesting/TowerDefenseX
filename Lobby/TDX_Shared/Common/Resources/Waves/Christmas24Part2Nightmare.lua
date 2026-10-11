local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Christmas II (Nightmare)",
	DefeatScreenRenderName = "Christmas 2",
	DefeatMusicName = "Christmas24DefeatMusicNightmare",
	OverrideAdvisorName = "Christmas24Part2Nightmare_Xenon",
	PlayerCountToStartingCashMap = { 6000, 4200, 3750, 2900 },
	CashPerDamageData = {
		{ CashPerDamage = 2.35, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.9, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1.5, CashPerDamageShared = 0.4 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 100, TokensReward = 25 },
		{ WaveNumber = 2, GoldReward = 150, TokensReward = 55 },
		{ WaveNumber = 3, GoldReward = 250, TokensReward = 80 },
		{ WaveNumber = 5, GoldReward = 350, CrystalsReward = 20, TokensReward = 100 },
		{ WaveNumber = 6, GoldReward = 500, CrystalsReward = 40, TokensReward = 125 },
		{ WaveNumber = 8, GoldReward = 725, CrystalsReward = 100, TokensReward = 175 },
		{ WaveNumber = 10, GoldReward = 900, CrystalsReward = 140, TokensReward = 225 },
		{ WaveNumber = 12, GoldReward = 1500, CrystalsReward = 265, TokensReward = 400 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 10,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 100000,
			GainHP = 1000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 7,
				[Enums.PowerUps.DropPod] = 15,
				[Enums.PowerUps.CashCrate] = 5,
				[Enums.PowerUps.CryoBlast] = 15
			}
		}
	},
	DefaultXPPerWavePassed = 250,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "Arctic HQ Gate" },
	SetUpTime = 30,
	RandomizePathIndex = true,
	PowerUpsDisabled = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 3,
	VictoryBadgeIds = { 1214787263253282 },
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
			ShieldMultiplierIncrease = 0.2,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ArcticScout, Count = 30, Interval = 1 },
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 12,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 2000,
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
					Interval = 1
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
			CashBonus = 2800,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.6,
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
				{ StartDelay = 5, EnemyType = Enums.Enemies.WendigoHunter, Count = 8, Interval = 1 }
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerDroneWithAttack,
					Count = 50,
					Interval = 0.25
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.LumberjackWithAttack,
					Count = 1,
					ForcePathIndices = { 7 },
					Interval = 4.6
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.ToyWithAttack,
					AdditionalSpeedBoostMultiplier = 0.7,
					SpawnOnAllPaths = true,
					Count = 2,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 7000,
			CashMultiplierOverride = 0.75,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 7,
					Interval = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedCryoRangerWithAttack,
					Count = 4,
					Interval = 5
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 7 }
				}
			}
		},
		{
			CashBonus = 75000,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 24,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.GingerDroneWithAttack,
					Count = 60,
					Interval = 1
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
					Count = 30,
					Interval = 1
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 7,
					Interval = 5
				},
				{
					StartDelay = 0.5,
					EnemyType = Enums.Enemies.ResurrectedCryoRangerWithAttack,
					Count = 7,
					Interval = 5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 7,
					Interval = 8
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.CoalManWithAttack,
					Count = 20,
					Interval = 1
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 2,
					AdditionalShieldMultiplier = 1,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 25000,
			CashMultiplierOverride = 0.45,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0.2, EnemyType = Enums.Enemies.Deathwalker, Count = 7, Interval = 4 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 7,
					Interval = 12
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.ResurrectedCryoBlasterWithAttack,
					Count = 12,
					AdditionalShieldMultiplier = 1,
					Interval = 5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.EvergrimSummoner,
					Count = 4,
					AdditionalShieldMultiplier = 1,
					Interval = 3
				},
				{
					StartDelay = 34,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 5,
					AdditionalShieldMultiplier = 1,
					Interval = 8
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 4,
					AdditionalShieldMultiplier = 1,
					Interval = 20
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 2,
					AdditionalShieldMultiplier = 2,
					SpawnOnAllPaths = true,
					Interval = 3
				},
				{ StartDelay = 80, EnemyType = Enums.Enemies.Deathwalker, Count = 6, Interval = 7 },
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 14,
					Interval = 11
				},
				{
					StartDelay = 67,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					AdditionalHealthMultiplier = 1,
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
				{ StartDelay = 155, EnemyType = Enums.Enemies.WraithRider, Count = 3, Interval = 5 },
				{ StartDelay = 160, EnemyType = Enums.Enemies.Deathwalker, Count = 8, Interval = 3 },
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.ElderWendigo,
					Count = 1,
					ForcePathIndices = { 7 },
					Interval = 5
				},
				{
					StartDelay = 212.5,
					EnemyType = Enums.Enemies.WraithRider,
					Count = 2,
					Interval = 5
				},
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.FrozenGladiator,
					AdditionalShieldMultiplier = 2,
					Count = 18,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 175000,
			CashMultiplierOverride = 0.55,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 100,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CoalManWithAttack,
					AdditionalShieldMultiplier = 7,
					Count = 50,
					Interval = 2
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.EvergrimSummoner,
					Count = 6,
					AdditionalShieldMultiplier = 2,
					Interval = 8
				},
				{
					StartDelay = 18,
					EnemyType = Enums.Enemies.SnowGangstaWithAttack,
					Count = 10,
					AdditionalShieldMultiplier = 1.2,
					Interval = 20
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Deathwalker, Count = 3, Interval = 17 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.Belsnickel,
					Count = 11,
					AdditionalShieldMultiplier = 1,
					Interval = 8
				},
				{
					StartDelay = 28,
					EnemyType = Enums.Enemies.Phantom,
					Count = 8,
					AdditionalShieldMultiplier = 0.5,
					Interval = 4
				},
				{
					StartDelay = 88,
					EnemyType = Enums.Enemies.Phantom,
					Count = 3,
					AdditionalShieldMultiplier = 3,
					Interval = 12
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 2,
					AdditionalShieldMultiplier = 4,
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
					Count = 10,
					AdditionalShieldMultiplier = 2,
					Interval = 2
				},
				{
					StartDelay = 135,
					EnemyType = Enums.Enemies.IceCapwnWithAttack,
					Count = 14,
					AdditionalShieldMultiplier = 4,
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
					AdditionalShieldMultiplier = 4.5,
					Interval = 4
				},
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.SnowPredator,
					Count = 13,
					Interval = 2.2,
					AdditionalHealthMultiplier = 0.3,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 215,
					EnemyType = Enums.Enemies.WraithRider,
					Count = 2,
					Interval = 2.2
				},
				{
					StartDelay = 248,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 15 }
				},
				{
					StartDelay = 248.6,
					EnemyType = Enums.Enemies.GingerDread,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 16 }
				}
			}
		},
		{
			CashBonus = 525000,
			CashMultiplierOverride = 1,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 50,
					AdditionalSpeedBoostMultiplier = 0.3,
					Interval = 0.5
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Phantom,
					SpawnOnAllPaths = true,
					Count = 3,
					Interval = 2
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Shadow,
					Stealth = true,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 2,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 500,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalHealthMultiplier = 4,
					Interval = 0.1
				}
			}
		},
		{
			CashBonus = 200000,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Predator,
					SpawnOnAllPaths = true,
					Count = 3,
					Interval = 6,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.ApexPredatorChristmas24,
					Count = 1,
					AdditionalHealthMultiplier = 0.4,
					ForcePathIndices = { 14 },
					Interval = 2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Predator,
					Count = 7,
					Interval = 5,
					EnableDisabledAttacks = true
				}
			}
		},
		{
			CashBonus = 150000,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.WraithRider, Count = 20, Interval = 4 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ToyWithAttack,
					Count = 500,
					AdditionalHealthMultiplier = 10,
					Interval = 0.05
				}
			}
		},
		{
			CashBonus = 1000000,
			OverrideXP = 900,
			CashMultiplierOverride = 0.7,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SnowWendigo,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 1.7
				},
				{
					StartDelay = 0.1,
					EnemyType = Enums.Enemies.FrozenGladiator,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 3,
					Count = 4,
					Interval = 1.7
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.AncientFrost,
					SpawnOnAllPaths = true,
					Count = 1,
					Interval = 1.7
				},
				{
					StartDelay = 7.5,
					EnemyType = Enums.Enemies.GeneralCelgar,
					Count = 1,
					ForcePathIndices = { 13 },
					Interval = 0.1
				},
				{ StartDelay = 6, EnemyType = Enums.Enemies.WraithRider, Count = 3, Interval = 3 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.WendigoHunter,
					Count = 3,
					SpawnOnAllPaths = true,
					AdditionalShieldMultiplier = 4,
					Interval = 3
				},
				{
					StartDelay = 21,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 3,
					SpawnOnAllPaths = true,
					Interval = 5
				},
				{
					StartDelay = 54,
					EnemyType = Enums.Enemies.ElderWendigo,
					Count = 2,
					Interval = 1.7
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.WraithRider, Count = 5, Interval = 5 },
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.FrozenGladiator,
					Count = 15,
					SpawnOnAllPaths = true,
					Interval = 5
				}
			}
		}
	}
}