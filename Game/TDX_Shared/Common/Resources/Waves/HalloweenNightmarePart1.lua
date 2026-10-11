local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Halloween I (Nightmare)",
	VictoryScreenRenderName = "Halloween",
	DefeatScreenRenderName = "Halloween 1",
	OverrideAdvisorName = "Heretic",
	PlayerCountToStartingCashMap = { 1375, 1150, 950, 750 },
	CashPerDamageData = {
		{ CashPerDamage = 1.5, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.2, CashPerDamageShared = 0.65 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.55 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 1 },
		{ WaveNumber = 5, GoldReward = 10, TokensReward = 5 },
		{ WaveNumber = 8, GoldReward = 20, TokensReward = 12 },
		{ WaveNumber = 10, GoldReward = 50, TokensReward = 18 },
		{ WaveNumber = 13, GoldReward = 90, TokensReward = 20 },
		{ WaveNumber = 16, GoldReward = 120, TokensReward = 40 },
		{ WaveNumber = 17, GoldReward = 175, TokensReward = 60 },
		{ WaveNumber = 18, GoldReward = 375, TokensReward = 135 }
	},
	DefaultXPPerWavePassed = 63,
	VictoryBadgeIds = { 511982484695994 },
	StartingLives = 472,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	AmbientPlaylist = { "HalloweenNight1_1", "HalloweenNight1_2", "HalloweenNight1_3" },
	Waves = {
		{
			CashBonus = 0,
			ShieldMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 5, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerB, Count = 4, Interval = 3 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 4, Interval = 3 }
			}
		},
		{
			CashBonus = 350,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 7, Interval = 1.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerB, Count = 6, Interval = 2 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 10, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 9, Interval = 0.8 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 6, Interval = 2 }
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Psycho, Count = 2, Interval = 0.6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 5, Interval = 1.7 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 6, Interval = 1.3 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 3, Interval = 2 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.VillagerA, Count = 15, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 13, Interval = 0.8 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 17, Interval = 1.2 }
			}
		},
		{
			CashBonus = 600,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Psycho, Count = 2, Interval = 1.5 },
				{ StartDelay = 3.2, EnemyType = Enums.Enemies.MrSaw, Count = 1, Interval = 2.4 }
			}
		},
		{
			CashBonus = 650,
			SpeedBoostMultiplierIncrease = 0.12,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 3, Interval = 8.7 }
			}
		},
		{
			CashBonus = 675,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 1, Interval = 2.4 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.VillagerA, Count = 15, Interval = 0.9 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.VillagerB, Count = 13, Interval = 0.7 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.VillagerC, Count = 17, Interval = 1.1 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Prowler, Count = 3, Interval = 4 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 4, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 3, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 2, Interval = 1.1 }
			}
		},
		{
			CashBonus = 750,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 5, Interval = 3.6 }
			}
		},
		{
			CashBonus = 800,
			SpeedBoostMultiplierIncrease = 0.25,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Prowler, Count = 7, Interval = 3 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.Psycho, Count = 3, Interval = 4.2 }
			}
		},
		{
			CashBonus = 850,
			SpeedBoostMultiplierIncrease = -0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Psycop, Count = 10, Interval = 1.2 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.MrSaw, Count = 3, Interval = 1.6 }
			}
		},
		{
			CashBonus = 900,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Judge,
					Count = 1,
					AdditionalHealthMultiplier = -0.4,
					Interval = 0.3
				},
				{ StartDelay = 7, EnemyType = Enums.Enemies.VillagerA, Count = 12, Interval = 0.9 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.MrSaw, Count = 4, Interval = 0.9 },
				{ StartDelay = 6, EnemyType = Enums.Enemies.VillagerB, Count = 4, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.VillagerC, Count = 6, Interval = 1.1 }
			}
		},
		{
			CashBonus = 950,
			SpawnSequences = {
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.Judge,
					Count = 1,
					AdditionalHealthMultiplier = -0.6,
					Interval = 0.3,
					Stealth = true
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Psycop,
					Count = 16,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 1000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MrSaw, Count = 8, Interval = 0.7 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.Executioner, Count = 2, Interval = 0.6 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.Prowler, Count = 3, Interval = 1 }
			}
		},
		{
			CashBonus = 1100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 14,
					Interval = 0.7,
					Stealth = true
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 0.3 }
			}
		},
		{
			CashBonus = 1450,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Judge,
					Count = 1,
					Interval = 1.2,
					AdditionalHealthMultiplier = 1
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.Prowler,
					Count = 10,
					Interval = 0.5,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 3500,
			SpeedBoostMultiplierIncrease = -0.1,
			ShieldMultiplierOverride = 0.3,
			SpawnSequences = {
				{
					StartDelay = 40,
					EnemyType = Enums.Enemies.HereticNightmare,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 60,
					EnemyType = Enums.Enemies.Executioner,
					Count = 4,
					Interval = 1.2
				},
				{ StartDelay = 60, EnemyType = Enums.Enemies.Fanatic, Count = 10, Interval = 1 },
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 5,
					Interval = 1,
					Stealth = true
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.MrSaw,
					Count = 5,
					Interval = 1,
					Stealth = true
				},
				{ StartDelay = 45, EnemyType = Enums.Enemies.Judge, Count = 1, Interval = 10 },
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut2,
					Count = 1,
					Interval = 1.2
				},
				{
					StartDelay = 55,
					EnemyType = Enums.Enemies.ResurrectedJuggernaut,
					Count = 2,
					Interval = 3
				},
				{
					StartDelay = 52,
					EnemyType = Enums.Enemies.ResurrectedArmoredRanger,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 50,
					EnemyType = Enums.Enemies.ResurrectedRanger2,
					Count = 5,
					Interval = 0.7
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Psycho, Count = 3, Interval = 2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.Judge, Count = 2, Interval = 10 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Executioner, Count = 3, Interval = 2 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.Psycop, Count = 21, Interval = 0.7 }
			}
		}
	}
}