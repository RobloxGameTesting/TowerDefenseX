local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Halloween IV (Nightmare)",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 4",
	OverrideAdvisorName = "WretchedHalloweenPart4Nightmare",
	PlayerCountToStartingCashMap = { 14000, 11000, 9000, 7000 },
	CashPerDamageData = {
		{ CashPerDamage = 2.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 1.6, CashPerDamageShared = 0.45 },
		{ CashPerDamage = 1.4, CashPerDamageShared = 0.4 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 250, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 500, TokensReward = 130 },
		{ WaveNumber = 3, GoldReward = 750, TokensReward = 250 },
		{ WaveNumber = 4, GoldReward = 1500, TokensReward = 400 },
		{ WaveNumber = 5, GoldReward = 3250, TokensReward = 750 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_25,
			GainCash = 30000,
			GainHP = 5000
		},
		{
			WaveNumber = 2,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 50000,
			GainHP = 7500
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 70000,
			GainHP = 8000
		},
		{
			WaveNumber = 4,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 175000,
			GainHP = 10000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_65,
			GainCash = 500000,
			GainHP = 17500
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = { [Enums.PowerUps.A10Strike] = 3, [Enums.PowerUps.AC130Support] = 5 }
		}
	},
	DefaultXPPerWavePassed = 775,
	StartingLives = 1,
	StartingLivesOverriddenBy = { "GDA Base" },
	SetUpTime = 30,
	RandomizePathIndex = true,
	PowerUpsDisabled = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 12,
	VictoryBadgeIds = { 3973995234809925 },
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = {
		"HalloweenNight4_1",
		"HalloweenNight4_2",
		"HalloweenNight4_3",
		"HalloweenNight4_4",
		"HalloweenNight4_5",
		"HalloweenNight4_6"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerAWithAttack,
					Count = 350,
					Interval = 0.9
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 390,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 360,
					Interval = 1
				},
				{ StartDelay = 30, EnemyType = Enums.Enemies.Zealot, Count = 6, Interval = 9 },
				{
					StartDelay = 42,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 1,
					Interval = 5
				},
				{ StartDelay = 50, EnemyType = Enums.Enemies.Zealot, Count = 6, Interval = 7 },
				{ StartDelay = 70, EnemyType = Enums.Enemies.Zealot, Count = 9, Interval = 5 },
				{
					StartDelay = 85,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 1,
					Interval = 5
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 1,
					Interval = 8
				},
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 12,
					Interval = 2
				},
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 2,
					Interval = 4
				},
				{ StartDelay = 140, EnemyType = Enums.Enemies.Zealot, Count = 12, Interval = 3 },
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 1,
					Interval = 7
				},
				{ StartDelay = 180, EnemyType = Enums.Enemies.DreadKnight, Count = 1, Interval = 7 },
				{ StartDelay = 200, EnemyType = Enums.Enemies.Zealot, Count = 18, Interval = 2 },
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 2,
					Interval = 4
				},
				{ StartDelay = 220, EnemyType = Enums.Enemies.Wraith, Count = 2, Interval = 2 },
				{ StartDelay = 235, EnemyType = Enums.Enemies.DreadKnight, Count = 1, Interval = 7 },
				{ StartDelay = 245, EnemyType = Enums.Enemies.Diabolist, Count = 2, Interval = 7 },
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 5,
					Interval = 1
				},
				{ StartDelay = 260, EnemyType = Enums.Enemies.Zealot, Count = 20, Interval = 2 },
				{ StartDelay = 285, EnemyType = Enums.Enemies.DreadKnight, Count = 2, Interval = 1 },
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.Banshee,
					Stealth = true,
					Count = 5,
					Interval = 1
				},
				{ StartDelay = 310, EnemyType = Enums.Enemies.Zealot, Count = 30, Interval = 2 },
				{
					StartDelay = 315,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Stealth = true,
					Count = 3,
					Interval = 7
				},
				{
					StartDelay = 330,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 15,
					Interval = 0.9
				},
				{ StartDelay = 350, EnemyType = Enums.Enemies.DreadKnight, Count = 4, Interval = 7 },
				{
					StartDelay = 345,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 5,
					Interval = 2
				},
				{ StartDelay = 358, EnemyType = Enums.Enemies.Diabolist, Count = 3, Interval = 3 },
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 20,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 25000,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 1e999,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerAWithAttack,
					Count = 200,
					Interval = 1.2,
					AdditionalShieldMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 300,
					Interval = 0.8,
					AdditionalShieldMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 400,
					Interval = 1,
					AdditionalShieldMultiplier = 2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 50,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1,
					Interval = 7
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.DreadKnight, Count = 5, Interval = 8 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 36,
					Interval = 3,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 30,
					Interval = 1.2,
					AdditionalShieldMultiplier = 2
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.AirDiabolist, Count = 4, Interval = 7 },
				{
					StartDelay = 82,
					EnemyType = Enums.Enemies.Banshee,
					Count = 12,
					Stealth = true,
					Interval = 2,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 10,
					Interval = 4.5
				},
				{ StartDelay = 100, EnemyType = Enums.Enemies.Diabolist, Count = 3, Interval = 3 },
				{
					StartDelay = 112,
					EnemyType = Enums.Enemies.Banshee,
					Count = 8,
					Stealth = true,
					AdditionalHealthMultiplier = 1,
					Interval = 2
				},
				{
					StartDelay = 114,
					EnemyType = Enums.Enemies.Zealot,
					Count = 30,
					AdditionalHealthMultiplier = 1,
					Interval = 2
				},
				{ StartDelay = 149, EnemyType = Enums.Enemies.Husk, Count = 1, Interval = 2 },
				{ StartDelay = 158, EnemyType = Enums.Enemies.Diabolist, Count = 6, Interval = 2 },
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 30,
					Interval = 1
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 15,
					Interval = 0.8,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{ StartDelay = 230, EnemyType = Enums.Enemies.VileSeraph, Count = 3, Interval = 1 },
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.Zealot,
					Count = 40,
					Interval = 0.3,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{ StartDelay = 280, EnemyType = Enums.Enemies.VileSeraph, Count = 5, Interval = 1 },
				{ StartDelay = 305, EnemyType = Enums.Enemies.Husk, Count = 6, Interval = 2 },
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 18 }
				},
				{
					StartDelay = 357,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 13 }
				},
				{
					StartDelay = 360,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 6 }
				},
				{
					StartDelay = 362,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 2 }
				},
				{
					StartDelay = 367,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 4 }
				},
				{
					StartDelay = 372,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 1 }
				},
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 80,
					Interval = 1,
					AdditionalShieldMultiplier = 0.55
				},
				{
					StartDelay = 390,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 3,
					Interval = 4
				},
				{
					StartDelay = 430,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 430,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 8,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 30000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.2,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Zealot,
					Count = 80,
					AdditionalHealthMultiplier = 1,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerAWithAttack,
					Count = 50,
					Interval = 2,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 30,
					Interval = 4,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 40,
					Interval = 3,
					AdditionalHealthMultiplier = 1,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Wraith,
					Count = 100,
					Interval = 0.8,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 110,
					Interval = 1,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 120,
					Interval = 1,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 20,
					Interval = 4,
					AdditionalShieldMultiplier = 0.2
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.TankEnforcer, Count = 4, Interval = 5 },
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.DreadnoughtRavager,
					Count = 1,
					Interval = 0.2,
					ForcePathIndices = { 4 }
				},
				{
					StartDelay = 140,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 22 }
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 10 }
				},
				{ StartDelay = 210, EnemyType = Enums.Enemies.VileSeraph, Count = 22, Interval = 2 },
				{
					StartDelay = 235,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 80,
					Interval = 0.8,
					AdditionalShieldMultiplier = 0.6
				},
				{
					StartDelay = 238,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 9,
					Interval = 5
				},
				{
					StartDelay = 305,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 3,
					Interval = 10,
					AdditionalShieldMultiplier = 0.8
				},
				{
					StartDelay = 315,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 2,
					Interval = 6
				},
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 2,
					Interval = 5,
					AdditionalShieldMultiplier = 0.8
				},
				{
					StartDelay = 360,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 390,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 18,
					Interval = 2
				},
				{ StartDelay = 387, EnemyType = Enums.Enemies.Husk, Count = 34, Interval = 0.8 },
				{
					StartDelay = 410,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 4
				},
				{
					StartDelay = 470,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 4 }
				},
				{
					StartDelay = 470,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 18 }
				},
				{
					StartDelay = 490,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 3,
					Interval = 3,
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 515,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 7,
					Interval = 3
				},
				{
					StartDelay = 540,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 1,
					SpawnOnAllPaths = true,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 100000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 1.5,
					ForcePathIndices = { 18 },
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 5 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 1.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 1 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.7,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 9 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.4,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 14 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.2,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 22 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.3,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.CorruptedPredator,
					Count = 1,
					Interval = 1.7,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 21 }
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.CorruptedPredator,
					Count = 1,
					Interval = 1,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 2 }
				},
				{
					StartDelay = 65,
					EnemyType = Enums.Enemies.CorruptedApexPredator,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 25 }
				},
				{
					StartDelay = 90,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					ForcePathIndices = { 18 },
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 92,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 5 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 94,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 1 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 96,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 9 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 98,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 14 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 22 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.5,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 125,
					EnemyType = Enums.Enemies.Predator,
					Count = 15,
					Interval = 10,
					AdditionalHealthMultiplier = 1,
					EnableDisabledAttacks = true
				}
			}
		},
		{
			CashBonus = 600000,
			CustomWaveTime = 1e999,
			OverrideXP = 9250,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Zealot,
					Count = 80,
					AdditionalHealthMultiplier = 20,
					AdditionalSpeedBoostMultiplier = 0.3,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerAWithAttack,
					Count = 120,
					Interval = 0.6,
					AdditionalHealthMultiplier = 60,
					AdditionalSpeedBoostMultiplier = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 65,
					Interval = 1,
					AdditionalHealthMultiplier = 60,
					AdditionalSpeedBoostMultiplier = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 120,
					Interval = 0.7,
					AdditionalHealthMultiplier = 60,
					AdditionalSpeedBoostMultiplier = 0.3
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 9,
					Interval = 6,
					AdditionalShieldMultiplier = 0.6
				},
				{
					StartDelay = 62,
					EnemyType = Enums.Enemies.Cultist,
					Count = 50,
					Interval = 2,
					AdditionalHealthMultiplier = 4
				},
				{
					StartDelay = 64,
					EnemyType = Enums.Enemies.Husk,
					Count = 85,
					Interval = 0.8,
					AdditionalShieldMultiplier = 0.6
				},
				{ StartDelay = 90, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 5 },
				{ StartDelay = 100, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 5 },
				{
					StartDelay = 115,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 15,
					Interval = 5,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.Zealot,
					Count = 50,
					Interval = 1,
					AdditionalShieldMultiplier = 2.5,
					AdditionalSpeedBoostMultiplier = 0.4
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.MazeGuardian,
					Count = 7,
					Interval = 10
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 20,
					Interval = 2.5,
					AdditionalSpeedBoostMultiplier = 0.6,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 270,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautA,
					Count = 8,
					Interval = 3
				},
				{
					StartDelay = 274,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautB,
					Count = 21,
					Interval = 2
				},
				{
					StartDelay = 326,
					EnemyType = Enums.Enemies.TheWretched,
					Count = 1,
					ForcePathIndices = { 26 },
					Interval = 4
				},
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 50,
					Interval = 6,
					AdditionalShieldMultiplier = 0.6
				},
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 24,
					Interval = 7
				},
				{
					StartDelay = 70,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 30,
					Interval = 8
				}
			}
		}
	}
}