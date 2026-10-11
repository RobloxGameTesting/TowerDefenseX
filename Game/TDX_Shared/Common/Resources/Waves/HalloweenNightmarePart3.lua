local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Halloween III (Nightmare)",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 3",
	OverrideAdvisorName = "OilHalloweenPart3Nightmare",
	PlayerCountToStartingCashMap = { 8000, 6500, 5500, 4000 },
	CashPerDamageData = {
		{ CashPerDamage = 2.35, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.3, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1.3, CashPerDamageShared = 0.35 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 200, TokensReward = 40 },
		{ WaveNumber = 2, GoldReward = 350, TokensReward = 80 },
		{ WaveNumber = 3, GoldReward = 600, TokensReward = 110 },
		{ WaveNumber = 4, GoldReward = 800, TokensReward = 175 },
		{ WaveNumber = 5, GoldReward = 1250, TokensReward = 250 },
		{ WaveNumber = 6, GoldReward = 2500, TokensReward = 500 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 10000,
			GainHP = 1000
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 20000,
			GainHP = 2000
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 40000,
			GainHP = 3000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 75000,
			GainHP = 5000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 125000,
			GainHP = 7000
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_75,
			GainCash = 250000,
			GainHP = 10000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.CashCrate] = 15 }
		}
	},
	DefaultXPPerWavePassed = 500,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "Hellspire Artillery" },
	SetUpTime = 30,
	RandomizePathIndex = true,
	PowerUpsDisabled = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 12,
	VictoryBadgeIds = { 1879526283421555 },
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
					Count = 15,
					Interval = 1.4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 25,
					Interval = 2.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 32,
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
					Count = 6,
					Interval = 4
				},
				{
					StartDelay = 257,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 6,
					Interval = 1
				},
				{
					StartDelay = 265,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 6,
					Interval = 1.2
				}
			}
		},
		{
			CashBonus = 6000,
			CashMultiplierOverride = 0.9,
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
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 14,
					Interval = 8
				},
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
					Count = 10,
					Interval = 1.2
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 7,
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
					Count = 25,
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
					Count = 5,
					Interval = 6
				},
				{ StartDelay = 90, EnemyType = Enums.Enemies.DreadKnight, Count = 2, Interval = 5 },
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.Wraith,
					Count = 25,
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
					Interval = 8
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
					Count = 21,
					Interval = 4
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
					Count = 3,
					Interval = 8
				},
				{
					StartDelay = 220,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 100,
					Interval = 1.4,
					AdditionalHealthMultiplier = 1
				},
				{ StartDelay = 240, EnemyType = Enums.Enemies.DreadKnight, Count = 4, Interval = 7 },
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
					Count = 25,
					Stealth = true,
					Interval = 3
				},
				{
					StartDelay = 270,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 15,
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
					Interval = 3
				},
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 5,
					Interval = 5
				},
				{ StartDelay = 350, EnemyType = Enums.Enemies.Banshee, Count = 12, Interval = 2 },
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 6,
					Interval = 4,
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
					Count = 20,
					Interval = 2
				},
				{
					StartDelay = 310,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 15,
					Interval = 5
				},
				{
					StartDelay = 380,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 40,
					Interval = 0.7,
					AdditionalHealthMultiplier = 3
				}
			}
		},
		{
			CashBonus = 7000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.8,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerAWithAttack,
					Count = 155,
					Interval = 1.4,
					AdditionalHealthMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerBWithAttack,
					Count = 166,
					Interval = 1.5,
					AdditionalHealthMultiplier = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.VillagerCWithAttack,
					Count = 186,
					Interval = 1.6,
					AdditionalHealthMultiplier = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CultistAssassin,
					Count = 20,
					Stealth = true,
					Interval = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 7,
					Interval = 30
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 15,
					Interval = 7
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 25,
					AdditionalHealthMultiplier = 3,
					Interval = 7
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 25,
					AdditionalHealthMultiplier = 3,
					Interval = 14
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 17,
					Interval = 2,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.Banshee,
					Count = 17,
					Interval = 4,
					AdditionalHealthMultiplier = 3
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.Diabolist, Count = 20, Interval = 5 },
				{
					StartDelay = 32,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 15,
					Interval = 7.4
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.DreadKnight, Count = 20, Interval = 5 },
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.Wraith,
					Count = 34,
					Stealth = true,
					AdditionalHealthMultiplier = 3,
					Interval = 2
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 8,
					Interval = 5,
					AdditionalHealthMultiplier = 1
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.Diabolist, Count = 12, Interval = 7 },
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
					Count = 8,
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
					AdditionalShieldMultiplier = 1,
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
					Count = 25,
					Interval = 2
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 2,
					Interval = 4.5,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 25,
					AdditionalHealthMultiplier = 4,
					Interval = 3.2
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
					Count = 2,
					Interval = 3,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 20,
					AdditionalHealthMultiplier = 1,
					Interval = 3
				},
				{
					StartDelay = 280,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 14,
					Interval = 1.5
				},
				{
					StartDelay = 290,
					EnemyType = Enums.Enemies.Diabolist,
					Count = 11,
					Interval = 1,
					AdditionalShieldMultiplier = 1
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.6,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 7,
					Interval = 3,
					AdditionalShieldMultiplier = 0.25
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.DreadKnight, Count = 4, Interval = 4.6 },
				{ StartDelay = 25, EnemyType = Enums.Enemies.Diabolist, Count = 14, Interval = 10 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TankPathfinder,
					Count = 2,
					Stealth = true,
					Interval = 1.7,
					AdditionalShieldMultiplier = 0.5
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 4,
					AdditionalHealthMultiplier = 1,
					Interval = 3
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 7,
					Interval = 5,
					AdditionalShieldMultiplier = 0.25
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 5,
					Interval = 10,
					AdditionalShieldMultiplier = 0.25
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 30,
					Interval = 3,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 40,
					Interval = 7,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 10,
					AdditionalHealthMultiplier = 1,
					Interval = 3
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 8,
					Interval = 5,
					AdditionalShieldMultiplier = 0.25
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 4,
					AdditionalHealthMultiplier = 1,
					Interval = 3
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.TankPathfinder,
					Count = 5,
					Stealth = true,
					Interval = 1.7,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 8,
					Interval = 5,
					AdditionalShieldMultiplier = 0.25
				},
				{
					StartDelay = 260,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 5,
					Interval = 7,
					AdditionalShieldMultiplier = 0.25
				},
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 15,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 25000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 14,
					AdditionalShieldMultiplier = 0.5,
					Interval = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 50,
					Interval = 1.7,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 72,
					EnemyType = Enums.Enemies.DreadnoughtContemptor,
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 2
				},
				{
					StartDelay = 68,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 6,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 45,
					EnemyType = Enums.Enemies.DreadnoughtRavager,
					Count = 2,
					Interval = 40
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 2,
					AdditionalShieldMultiplier = 0.5,
					Interval = 9
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 15,
					Interval = 4,
					AdditionalShieldMultiplier = 0.2
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 3,
					Interval = 1,
					AdditionalShieldMultiplier = 0.2
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 6,
					Interval = 2,
					AdditionalShieldMultiplier = 0.2
				},
				{
					StartDelay = 175,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 8,
					AdditionalHealthMultiplier = 1,
					Interval = 4.5,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 40,
					Interval = 1.4,
					AdditionalShieldMultiplier = 3
				},
				{
					StartDelay = 225,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 10,
					Interval = 4,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 1.2
				},
				{
					StartDelay = 230,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 20,
					Interval = 3,
					Stealth = true,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 12,
					Interval = 6,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.Diabolist,
					Count = 20,
					Interval = 3,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 141,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 40,
					Interval = 0.8,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 40,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1,
					Interval = 1.4
				}
			}
		},
		{
			CashBonus = 200000,
			CustomWaveTime = 1e999,
			OverrideXP = 7000,
			CashMultiplierOverride = 0.15,
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
					Count = 9,
					Interval = 0.2
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 0.2
				},
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.DreadnoughtRavager,
					Count = 1,
					Interval = 0.2,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 7,
					Interval = 0.2,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 20,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				}
			}
		}
	}
}