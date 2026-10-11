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
				Enums.Towers.EDJ,
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
				Enums.Towers.AATurret,
				Enums.Towers.Mobster,
				Enums.Towers.Railgunner,
				Enums.Towers.Medic
			}
		},
		{
			Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
			Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
			IconId = "rbxassetid://107079411064021",
			VIPOnly = false,
			Towers = {
				Enums.Towers.EDJ,
				Enums.Towers.Juggernaut,
				Enums.Towers.MachineGunner,
				Enums.Towers.John,
				Enums.Towers.Railgunner,
				Enums.Towers.Medic
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
				Enums.Towers.EDJ,
				Enums.Towers.Mobster,
				Enums.Towers.Medic,
				Enums.Towers.Commander
			}
		}
	}
}
return {
	DisplayName = "Halloween IV",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 4",
	OverrideAdvisorName = "AdvisorHalloweenPart4",
	PlayerCountToStartingCashMap = { 20000, 17000, 14000, 11000 },
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
		{ WaveNumber = 1, GoldReward = 150, TokensReward = 50 },
		{ WaveNumber = 2, GoldReward = 300, TokensReward = 90 },
		{ WaveNumber = 3, GoldReward = 725, TokensReward = 170 },
		{ WaveNumber = 4, GoldReward = 1500, TokensReward = 350 },
		{ WaveNumber = 5, GoldReward = 3000, TokensReward = 650 }
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
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 125000,
			GainHP = 17500
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 0,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 3,
				[Enums.PowerUps.AC130Support] = 5,
				[Enums.PowerUps.AirStrike] = 10,
				[Enums.PowerUps.RaptorStorm] = 2,
				[Enums.PowerUps.CashCrate] = 15
			}
		}
	},
	DefaultXPPerWavePassed = 600,
	StartingLives = 49972,
	StartingLivesOverriddenBy = { "GDA Base" },
	SetUpTime = 30,
	PowerUpsDisabled = true,
	LoadoutSelectionData = loadoutSelectionData,
	RandomizePathIndex = true,
	WaveSkippingDisabled = true,
	HideWaveTimerIfInfiniteTime = true,
	VictoryDelay = 12,
	VictoryBadgeIds = { 3990860343140135 },
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
				{
					StartDelay = 130,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 3,
					Interval = 4
				},
				{ StartDelay = 200, EnemyType = Enums.Enemies.Zealot, Count = 18, Interval = 2 },
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.ExecutionerWithAttack,
					Count = 2,
					Interval = 4
				},
				{ StartDelay = 220, EnemyType = Enums.Enemies.Wraith, Count = 8, Interval = 2 },
				{ StartDelay = 245, EnemyType = Enums.Enemies.Diabolist, Count = 2, Interval = 7 },
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 5,
					Interval = 1
				},
				{ StartDelay = 260, EnemyType = Enums.Enemies.Zealot, Count = 20, Interval = 2 },
				{ StartDelay = 285, EnemyType = Enums.Enemies.DreadKnight, Count = 1, Interval = 1 },
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
				{ StartDelay = 350, EnemyType = Enums.Enemies.DreadKnight, Count = 2, Interval = 7 },
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
					Count = 24,
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
					Interval = 1.2
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 300,
					Interval = 0.8
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 400,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.CultistAmbusher,
					Count = 50,
					AdditionalHealthMultiplier = 1,
					Interval = 7
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.DreadKnight, Count = 2, Interval = 6 },
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.PsychoWithAttack,
					Count = 36,
					Interval = 3,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 30,
					Interval = 1.2
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.AirDiabolist, Count = 4, Interval = 7 },
				{
					StartDelay = 82,
					EnemyType = Enums.Enemies.Banshee,
					Count = 12,
					Stealth = true,
					Interval = 2
				},
				{ StartDelay = 90, EnemyType = Enums.Enemies.DreadKnight, Count = 4, Interval = 7 },
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
					Count = 20,
					Interval = 3
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.ProwlerWithAttack,
					Count = 15,
					Interval = 0.8,
					AdditionalHealthMultiplier = 1
				},
				{ StartDelay = 230, EnemyType = Enums.Enemies.VileSeraph, Count = 2, Interval = 1 },
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.Zealot,
					Count = 80,
					Interval = 0.3,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.2
				},
				{ StartDelay = 270, EnemyType = Enums.Enemies.VileSeraph, Count = 3, Interval = 1 },
				{ StartDelay = 290, EnemyType = Enums.Enemies.Husk, Count = 9, Interval = 2 },
				{
					StartDelay = 350,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 18 }
				},
				{
					StartDelay = 355,
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
					StartDelay = 365,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 1,
					Interval = 5,
					ForcePathIndices = { 2 }
				},
				{
					StartDelay = 340,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 40,
					Interval = 1.5,
					AdditionalShieldMultiplier = 0.2
				},
				{
					StartDelay = 390,
					EnemyType = Enums.Enemies.AirDiabolist,
					Count = 14,
					Interval = 3
				},
				{
					StartDelay = 420,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 440,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 5,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 30000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.4,
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
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerBWithAttack,
					Count = 30,
					Interval = 4,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.FrenziedVillagerCWithAttack,
					Count = 40,
					Interval = 3,
					AdditionalHealthMultiplier = 1
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
					Count = 140,
					Interval = 1,
					AdditionalHealthMultiplier = 1.5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 15,
					Interval = 4
				},
				{ StartDelay = 25, EnemyType = Enums.Enemies.TankEnforcer, Count = 3, Interval = 9 },
				{
					StartDelay = 110,
					EnemyType = Enums.Enemies.CursedDevourer,
					Count = 7,
					Interval = 2
				},
				{
					StartDelay = 150,
					EnemyType = Enums.Enemies.DreadnoughtRavager,
					Count = 1,
					Interval = 0.2,
					ForcePathIndices = { 4 }
				},
				{
					StartDelay = 170,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 22 }
				},
				{
					StartDelay = 210,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 4 }
				},
				{ StartDelay = 260, EnemyType = Enums.Enemies.VileSeraph, Count = 7, Interval = 1 },
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 90,
					Interval = 0.8,
					AdditionalShieldMultiplier = 0.6
				},
				{
					StartDelay = 267,
					EnemyType = Enums.Enemies.TarnishedClergyman,
					Count = 4,
					Interval = 8
				},
				{
					StartDelay = 310,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 2,
					AdditionalShieldMultiplier = 0.8,
					Interval = 10
				},
				{
					StartDelay = 325,
					EnemyType = Enums.Enemies.TankEnforcer,
					Count = 2,
					Interval = 1
				},
				{
					StartDelay = 335,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 2,
					AdditionalShieldMultiplier = 0.8,
					Interval = 10
				},
				{
					StartDelay = 360,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 5,
					Interval = 2
				},
				{ StartDelay = 390, EnemyType = Enums.Enemies.Husk, Count = 57, Interval = 0.8 },
				{
					StartDelay = 410,
					EnemyType = Enums.Enemies.TankBattlemaster,
					Count = 25,
					AdditionalShieldMultiplier = 0.5,
					Interval = 4
				},
				{
					StartDelay = 480,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 4 }
				},
				{
					StartDelay = 480,
					EnemyType = Enums.Enemies.Grumble,
					Count = 1,
					Interval = 1,
					ForcePathIndices = { 18 }
				},
				{
					StartDelay = 490,
					EnemyType = Enums.Enemies.DreadKnight,
					Count = 1,
					Interval = 3,
					AdditionalShieldMultiplier = 0.5,
					SpawnOnAllPaths = true
				},
				{
					StartDelay = 515,
					EnemyType = Enums.Enemies.Cultist,
					Count = 7,
					Interval = 3,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 515,
					EnemyType = Enums.Enemies.CursedWendigo,
					Count = 7,
					Interval = 4
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
			CashBonus = 80000,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.7,
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
					AdditionalShieldMultiplier = 0.7,
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
					AdditionalShieldMultiplier = 0.7,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 4,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 14 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.7,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Predator,
					Count = 1,
					Interval = 2,
					ForcePathIndices = { 22 },
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.7,
					EnableDisabledAttacks = true
				},
				{
					StartDelay = 35,
					EnemyType = Enums.Enemies.CorruptedPredator,
					Count = 1,
					Interval = 1.7,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 2,
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
					Count = 10,
					Interval = 20,
					AdditionalHealthMultiplier = 1.5,
					AdditionalShieldMultiplier = 0.3,
					EnableDisabledAttacks = true
				}
			}
		},
		{
			CashBonus = 300000,
			OverrideXP = 6250,
			CustomWaveTime = 1e999,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 9,
					Interval = 6,
					AdditionalShieldMultiplier = 2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Cultist,
					Count = 50,
					Interval = 2,
					AdditionalShieldMultiplier = 2
				},
				{ StartDelay = 1, EnemyType = Enums.Enemies.Husk, Count = 85, Interval = 0.8 },
				{ StartDelay = 30, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 6 },
				{ StartDelay = 80, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 6 },
				{
					StartDelay = 92,
					EnemyType = Enums.Enemies.VileSeraph,
					Count = 15,
					Interval = 5,
					AdditionalShieldMultiplier = 1
				},
				{
					StartDelay = 160,
					EnemyType = Enums.Enemies.Zealot,
					Count = 50,
					Interval = 1,
					AdditionalShieldMultiplier = 2.5,
					AdditionalSpeedBoostMultiplier = 0.4
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.MazeGuardian,
					Count = 7,
					Interval = 10
				},
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.WallPusher,
					Count = 7,
					Interval = 2.5,
					AdditionalSpeedBoostMultiplier = 0.3,
					AdditionalShieldMultiplier = 0.4
				},
				{
					StartDelay = 205,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautA,
					Count = 3,
					Interval = 4
				},
				{
					StartDelay = 207,
					EnemyType = Enums.Enemies.CorruptedGoldenJuggernautB,
					Count = 6,
					Interval = 4
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.TheWretched,
					Count = 1,
					Interval = 4,
					ForcePathIndices = { 26 }
				},
				{ StartDelay = 250, EnemyType = Enums.Enemies.WallPusher, Count = 30, Interval = 7 }
			}
		}
	}
}