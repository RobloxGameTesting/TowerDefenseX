local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local RewindProducts = require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "MLG (Nightmare)",
	OverrideAdvisorName = "MLG",
	PlayerCountToStartingCashMap = { 1000000, 500000, 333333, 250000 },
	CashPerDamageData = {
		{ CashPerDamage = 1.2, CashPerDamageShared = 0 },
		{ CashPerDamage = 1.1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.4 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.3 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, CrystalsReward = 5 },
		{ WaveNumber = 2, CrystalsReward = 275 }
	},
	RewindProductIntervalMap = {
		{
			WaveNumber = 0,
			CostGold = 10000,
			RobuxProductId = RewindProducts.RobuxProducts.REWIND_ROBUX_95,
			GainCash = 200000,
			GainHP = 150000
		}
	},
	DefaultXPPerWavePassed = 1000,
	StartingLives = 133337,
	SetUpTime = 60,
	PowerUpsDisabled = true,
	UpgradeShopEnabled = true,
	PlayerCountToUpgradeShopStartingCredits = { 8250, 4700, 3000, 2700 },
	AmbientPlaylist = { "MLG1", "MLG2", "MLG3", "MLG4", "MLG5" },
	Waves = {
		{
			CashBonus = 0,
			PlayerCountToUpgradeShopCreditPool = { 8000, 5000, 4000, 3000 },
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					Count = 1,
					Interval = 0.75
				}
			}
		},
		{
			CashBonus = 1333337,
			OverrideXP = 9000,
			CashMultiplierOverride = 0.75,
			PlayerCountToUpgradeShopCreditPool = { 14000, 8000, 6000, 4000 },
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 0.3, EnemyType = Enums.Enemies.MegaGulper, Count = 5, Interval = 12 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Noscoper,
					Count = 8,
					AdditionalHealthMultiplier = 1,
					Interval = 20
				},
				{ StartDelay = 17, EnemyType = Enums.Enemies.MachoNacho, Count = 2, Interval = 16 },
				{ StartDelay = 40, EnemyType = Enums.Enemies.Cheese, Count = 5, Interval = 1 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.AlphaPredator,
					Count = 1,
					Interval = 1
				},
				{ StartDelay = 35, EnemyType = Enums.Enemies.Jager, Count = 2, Interval = 3 },
				{
					StartDelay = 37,
					EnemyType = Enums.Enemies.EngineerNightmare,
					AdditionalShieldMultiplier = 2,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.WendigoHunter,
					AdditionalShieldMultiplier = 800,
					Count = 15,
					Interval = 3
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Artemis,
					AdditionalShieldMultiplier = 3,
					Count = 2,
					Interval = 8
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.Sanic, Count = 15, Interval = 15 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Illuminati3, Count = 7, Interval = 1.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.EpicTroll,
					Count = 200,
					AdditionalHealthMultiplier = 1,
					Interval = 0.5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TrollPhysics, Count = 18, Interval = 2 },
				{ StartDelay = 50, EnemyType = Enums.Enemies.Fragment, Count = 9, Interval = 4 },
				{ StartDelay = 160, EnemyType = Enums.Enemies.MachoNacho, Count = 8, Interval = 4 },
				{
					StartDelay = 180,
					EnemyType = Enums.Enemies.CorruptedApexPredator,
					Count = 1,
					AdditionalHealthMultiplier = 0.5,
					Interval = 4
				},
				{
					StartDelay = 190,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					AdditionalShieldMultiplier = 3,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 200,
					EnemyType = Enums.Enemies.DreadnoughtStriker,
					AdditionalShieldMultiplier = 3,
					Count = 1,
					Interval = 4
				},
				{
					StartDelay = 300,
					EnemyType = Enums.Enemies.Jager,
					AdditionalShieldMultiplier = 1,
					Count = 25,
					Interval = 3
				},
				{
					StartDelay = 315,
					EnemyType = Enums.Enemies.Infiltrator,
					AdditionalShieldMultiplier = 100,
					Count = 60,
					Interval = 1
				},
				{
					StartDelay = 320,
					EnemyType = Enums.Enemies.SpawnDeployer,
					AdditionalShieldMultiplier = 1,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 320,
					EnemyType = Enums.Enemies.SpawnDeployer,
					AdditionalShieldMultiplier = 1,
					Count = 2,
					Interval = 12
				},
				{
					StartDelay = 120,
					EnemyType = Enums.Enemies.WendigoHunter,
					AdditionalShieldMultiplier = 1000,
					Count = 15,
					Interval = 3
				},
				{
					StartDelay = 400,
					EnemyType = Enums.Enemies.X2Trooper,
					AdditionalHealthMultiplier = 3,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 405,
					EnemyType = Enums.Enemies.Purgatory,
					AdditionalHealthMultiplier = 30,
					AdditionalShieldMultiplier = 1,
					Count = 8,
					Interval = 5
				},
				{
					StartDelay = 395,
					EnemyType = Enums.Enemies.TrollPhysics,
					Count = 18,
					Interval = 1
				},
				{
					StartDelay = 405,
					EnemyType = Enums.Enemies.ZombieDropPod15,
					Count = 6,
					Interval = 0.7
				},
				{
					StartDelay = 460,
					EnemyType = Enums.Enemies.BatteringRam,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 5,
					AdditionalSpeedBoostMultiplier = 2,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 463,
					EnemyType = Enums.Enemies.King,
					AdditionalHealthMultiplier = 30,
					AdditionalSpeedBoostMultiplier = 1.5,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 465,
					EnemyType = Enums.Enemies.Troll,
					Count = 30,
					AdditionalSpeedBoostMultiplier = 5,
					Interval = 1
				},
				{
					StartDelay = 465,
					EnemyType = Enums.Enemies.WendigoHunter,
					AdditionalShieldMultiplier = 1000,
					Count = 35,
					Interval = 2
				},
				{
					StartDelay = 468,
					EnemyType = Enums.Enemies.Queen,
					AdditionalHealthMultiplier = 25,
					AdditionalSpeedBoostMultiplier = 1.5,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 530,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					AdditionalHealthMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 5,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 532,
					EnemyType = Enums.Enemies.MLGGoldZombie,
					Count = 60,
					Interval = 1
				},
				{
					StartDelay = 610,
					EnemyType = Enums.Enemies.ToiletJohnBoss,
					AdditionalHealthMultiplier = 4,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 1,
					Interval = 12
				},
				{
					StartDelay = 625,
					EnemyType = Enums.Enemies.Assailant,
					AdditionalShieldMultiplier = 10,
					AdditionalSpeedBoostMultiplier = 1,
					Count = 4,
					Interval = 12
				},
				{
					StartDelay = 800,
					EnemyType = Enums.Enemies.TheIlluminati,
					Count = 3,
					Interval = 60
				},
				{
					StartDelay = 780,
					EnemyType = Enums.Enemies.TBVoid,
					AdditionalSpeedBoostMultiplier = 3,
					AdditionalHealthMultiplier = 5,
					Count = 1,
					Interval = 0.5
				},
				{
					StartDelay = 770,
					EnemyType = Enums.Enemies.EradicatorMK2ReworkWithLanding,
					AdditionalSpeedBoostMultiplier = 2,
					AdditionalShieldMultiplier = 6,
					Count = 2,
					Interval = 0.5
				},
				{
					StartDelay = 800,
					EnemyType = Enums.Enemies.Jager,
					AdditionalSpeedBoostMultiplier = 2,
					AdditionalShieldMultiplier = 11,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 730,
					EnemyType = Enums.Enemies.EmperorUltra,
					AdditionalHealthMultiplier = 2,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.67,
					Count = 1,
					Interval = 0.5
				}
			}
		}
	}
}