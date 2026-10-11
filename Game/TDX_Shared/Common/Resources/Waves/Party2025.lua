local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Party!",
	PlayerCountToStartingCashMap = { 12000000, 6000000, 4000000, 3000000, 2400000 },
	CashPerDamageData = {
		{ CashPerDamage = 0.95, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.9, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.25 },
		{ CashPerDamage = 0.75, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5, TokensReward = 0 },
		{ WaveNumber = 3, GoldReward = 350, TokensReward = 100 },
		{ WaveNumber = 4, GoldReward = 750, TokensReward = 200 },
		{ WaveNumber = 6, GoldReward = 1000, TokensReward = 300 },
		{ WaveNumber = 7, GoldReward = 1500, CrystalsReward = 90, TokensReward = 550 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 1,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_15,
			GainCash = 125000,
			GainHP = 50000
		},
		{
			WaveNumber = 3,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_35,
			GainCash = 1000000,
			GainHP = 100000
		},
		{
			WaveNumber = 5,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_45,
			GainCash = 2000000,
			GainHP = 200000
		},
		{
			WaveNumber = 6,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_55,
			GainCash = 3500000,
			GainHP = 500000
		}
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 2,
			ChanceTable = { [Enums.PowerUps.AirStrike] = 1 }
		}
	},
	DefaultXPPerWavePassed = 500,
	StartingLives = 484244,
	SetUpTime = 110,
	PowerUpsDisabled = true,
	PreloadEnemyNames = { Enums.Enemies.ZombieDropPod16, Enums.Enemies.PartyEradicatorMK2Rework },
	TowerCostMultiplierMap = {},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 600,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBVoid,
					AdditionalHealthMultiplier = 2.3,
					AdditionalShieldMultiplier = 0.1,
					AdditionalSpeedBoostMultiplier = 0.95,
					Count = 1,
					Interval = 0.8
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.PartyGeneralCelgar,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 25,
					EnemyType = Enums.Enemies.ZombieDropPod16,
					AdditionalShieldMultiplier = 2,
					Count = 3,
					Interval = 0.8
				},
				{
					StartDelay = 80,
					EnemyType = Enums.Enemies.ZombieDropPod16,
					AdditionalShieldMultiplier = 2.5,
					Count = 6,
					Interval = 1
				},
				{
					StartDelay = 240,
					EnemyType = Enums.Enemies.TBSlimeBoss,
					AdditionalShieldMultiplier = 0.5,
					AdditionalHealthMultiplier = 100,
					Count = 7,
					Interval = 0.7
				},
				{
					StartDelay = 250,
					EnemyType = Enums.Enemies.SlimeKing,
					AdditionalShieldMultiplier = 0.25,
					AdditionalHealthMultiplier = 6.5,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 1,
					Interval = 1.4
				},
				{
					StartDelay = 255,
					EnemyType = Enums.Enemies.PartyEradicatorMK2Rework,
					Count = 1,
					Interval = 1.4
				},
				{
					StartDelay = 255,
					EnemyType = Enums.Enemies.NuclearToilet,
					Count = 3,
					AdditionalShieldMultiplier = 10,
					Interval = 8
				},
				{
					StartDelay = 245,
					EnemyType = Enums.Enemies.NuclearToilet,
					Count = 7,
					Interval = 4
				},
				{
					StartDelay = 325,
					EnemyType = Enums.Enemies.MegaSlime,
					AdditionalShieldMultiplier = 3,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					Count = 1,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 1,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.PartyApexPredator,
					Count = 1,
					Interval = 0.7
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.Jager,
					AdditionalShieldMultiplier = 0.3,
					Count = 2,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 1,
			CashMultiplierOverride = 0.6,
			CustomWaveTime = 500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TheIlluminati,
					AdditionalHealthMultiplier = 0.7,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TrollPhysics,
					Count = 25,
					AdditionalShieldMultiplier = 5,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1,
			CustomWaveTime = 600,
			CashMultiplierOverride = 0.4,
			SpawnSequences = {
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradicatorMK4Gold,
					AdditionalHealthMultiplier = 4,
					Count = 1,
					Interval = 0.4
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Eradicator,
					Count = 1,
					AdditionalHealthMultiplier = 25,
					Interval = 0.4
				},
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.EradicatorMK2,
					Count = 1,
					AdditionalHealthMultiplier = 18,
					Interval = 0.4
				},
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					Count = 10,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1,
			CustomWaveTime = 500,
			CashMultiplierOverride = 0.15,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					AdditionalHealthMultiplier = 125,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 1,
			CustomWaveTime = 700,
			CashMultiplierOverride = 0.25,
			SpawnSequences = {
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SuperTBMysteryBoss,
					Count = 8,
					Interval = 2.5
				},
				{
					StartDelay = 95,
					EnemyType = Enums.Enemies.NightmareCyberSanta,
					AdditionalHealthMultiplier = 8,
					Count = 1,
					Interval = 2.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMysteryBoss, Count = 2, Interval = 4 }
			}
		},
		{
			CashBonus = 1,
			CustomWaveTime = 500,
			OverrideXP = 4500,
			CashMultiplierOverride = 500,
			SpawnSequences = {
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.Zombie,
					Count = 1,
					AdditionalHealthMultiplier = 10000,
					Stealth = true,
					Interval = 0.3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EradB,
					Count = 1,
					AdditionalHealthMultiplier = 75,
					Interval = 0.3
				}
			}
		}
	}
}