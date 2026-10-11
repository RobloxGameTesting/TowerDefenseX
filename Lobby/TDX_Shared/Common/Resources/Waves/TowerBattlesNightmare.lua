local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Tower Battles Nightmare",
	VictoryScreenRenderName = "Tower Battles",
	DefeatScreenRenderName = "Tower Battles",
	OverrideAdvisorName = "Void",
	PlayerCountToStartingCashMap = { 700, 600, 500, 450 },
	CashPerDamageData = {
		{ CashPerDamage = 1.4, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 5, GoldReward = 5, TokensReward = 2 },
		{ WaveNumber = 12, GoldReward = 45, TokensReward = 3 },
		{ WaveNumber = 17, GoldReward = 100, TokensReward = 15 },
		{ WaveNumber = 21, GoldReward = 150, TokensReward = 22 },
		{ WaveNumber = 25, GoldReward = 225, TokensReward = 30 },
		{ WaveNumber = 28, GoldReward = 350, TokensReward = 50 },
		{ WaveNumber = 35, GoldReward = 800, TokensReward = 70 },
		{ WaveNumber = 38, GoldReward = 1500, TokensReward = 100 },
		{ WaveNumber = 40, GoldReward = 2500, TokensReward = 180 }
	},
	PowerUpsRewardIntervalMap = {
		{
			OnWin = true,
			RollCount = 1,
			ChanceTable = {
				[Enums.PowerUps.A10Strike] = 28,
				[Enums.PowerUps.AC130Support] = 20,
				[Enums.PowerUps.DropPod] = 20,
				[Enums.PowerUps.GoldenZed] = 7
			}
		}
	},
	DefaultXPPerWavePassed = 70,
	VictoryBadgeIds = {},
	StartingLives = 100,
	SetUpTime = 15,
	PowerUpsDisabled = true,
	TowerCostMultiplierMap = { [Enums.Towers.CombatDrone] = 2.5 },
	Waves = {
		{
			CashBonus = 0,
			SpeedBoostMultiplierIncrease = 0.1,
			ShieldMultiplierIncrease = 0.1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBNormal, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 300,
			OverridePlayerCountToCashBonusMap = { 500 },
			ShieldMultiplierIncrease = 0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBNormal, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 325,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSpeedy, Count = 14, Interval = 1 }
			}
		},
		{
			CashBonus = 350,
			CashMultiplierOverride = 1,
			ShieldMultiplierIncrease = 0.3,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBNormal, Count = 12, Interval = 1.2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 8, Interval = 1 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 12, Interval = 1 }
			}
		},
		{
			CashBonus = 375,
			SpawnSequences = {
				{ StartDelay = 4, EnemyType = Enums.Enemies.TBSpeedy, Count = 20, Interval = 0.7 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 14, Interval = 1 }
			}
		},
		{
			CashBonus = 400,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 30, Interval = 1.4 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 1, Interval = 1.5 }
			}
		},
		{
			CashBonus = 425,
			SpeedBoostMultiplierIncrease = 0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 1, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 14, Interval = 1.5 }
			}
		},
		{
			CashBonus = 450,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 2, Interval = 1.5 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBSpeedy, Count = 25, Interval = 1 },
				{
					StartDelay = 5.2,
					EnemyType = Enums.Enemies.TBNormal,
					Count = 8,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 475,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 2, Interval = 3 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 1,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLava, Count = 5, Interval = 1.8 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSpeedy, Count = 20, Interval = 1 }
			}
		},
		{
			CashBonus = 525,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLava, Count = 8, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBSpeedy, Count = 15, Interval = 1.7 },
				{
					StartDelay = 5.5,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 2,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 550,
			SpeedBoostMultiplierOverride = 1.5,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery, Count = 20, Interval = 0.4 }
			}
		},
		{
			CashBonus = 575,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlow, Count = 40, Interval = 1 },
				{ StartDelay = 3, EnemyType = Enums.Enemies.TBMystery, Count = 30, Interval = 0.4 }
			}
		},
		{
			CashBonus = 600,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery, Count = 50, Interval = 0.5 }
			}
		},
		{
			CashBonus = 625,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 1, Interval = 1 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBHidden, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 650,
			ShieldMultiplierOverride = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBHidden, Count = 12, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					Count = 1,
					Interval = 2.7
				}
			}
		},
		{
			CashBonus = 675,
			CashMultiplierOverride = 0.4,
			ShieldMultiplierIncrease = 0.2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLava, Count = 35, Interval = 1.2 }
			}
		},
		{
			CashBonus = 700,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss1, Count = 25, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery, Count = 10, Interval = 0.7 }
			}
		},
		{
			CashBonus = 725,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					Count = 3,
					Interval = 1.5
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBLava, Count = 12, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 4, Interval = 5 }
			}
		},
		{
			CashBonus = 750,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 4, Interval = 4 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 775,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBToxic, Count = 12, Interval = 1.3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBLightning, Count = 8, Interval = 1 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 12,
					Interval = 0.9
				}
			}
		},
		{
			CashBonus = 800,
			CashMultiplierOverride = 0.3,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 10, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TBToxic,
					Count = 15,
					Interval = 1,
					Stealth = true
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.TBLightning, Count = 10, Interval = 2 },
				{ StartDelay = 22, EnemyType = Enums.Enemies.TBMystery, Count = 20, Interval = 0.6 }
			}
		},
		{
			CashBonus = 1000,
			CashMultiplierOverride = 1,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSlimeBoss,
					Count = 10,
					Interval = 2.5
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLava, Count = 15, Interval = 2 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 5, Interval = 1 }
			}
		},
		{
			CashBonus = 1200,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 10, Interval = 2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLava, Count = 20, Interval = 2 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery, Count = 15, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBToxic, Count = 20, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBLightning, Count = 15, Interval = 1 }
			}
		},
		{
			CashBonus = 1400,
			SpeedBoostMultiplierIncrease = 1.3,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 35,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 1800,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 14, Interval = 1 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 3,
					Interval = 4,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 2450,
			SpeedBoostMultiplierOverride = 1.1,
			ShieldMultiplierOverride = 0,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 1,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 2800,
			ShieldMultiplierIncrease = 0.2,
			SpeedBoostMultiplierIncrease = 0.1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss3, Count = 15, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss2, Count = 9, Interval = 3 }
			}
		},
		{
			CashBonus = 3200,
			SpawnSequences = {
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBBoss3, Count = 6, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery2, Count = 30, Interval = 0.7 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.Multiplier3, Count = 2, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 7,
					Interval = 0.35
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 7,
					Interval = 0.45
				}
			}
		},
		{
			CashBonus = 3500,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 8, Interval = 2.5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss2, Count = 9, Interval = 2 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.TBBoss3, Count = 5, Interval = 7 },
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBLightning, Count = 20, Interval = 1 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 5, Interval = 3 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBToxic, Count = 30, Interval = 1 }
			}
		},
		{
			CashBonus = 3750,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss3, Count = 22, Interval = 1.5 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss2, Count = 20, Interval = 1 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.TBNecromancer,
					Count = 5,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 4500,
			ShieldMultiplierOverride = 2,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBMystery2, Count = 10, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss3, Count = 10, Interval = 2.5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.Multiplier3, Count = 2, Interval = 6 }
			}
		},
		{
			CashBonus = 6000,
			ShieldMultiplierOverride = 0.1,
			SpawnSequences = {
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 3,
					Interval = 5
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 3, Interval = 1.5 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.TBNecromancer, Count = 5, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 45,
					Interval = 0.85
				}
			}
		},
		{
			CashBonus = 8000,
			SpeedBoostMultiplierOverride = 4,
			ShieldMultiplierOverride = 5,
			HealthMultiplierOverride = 1.5,
			CashMultiplierOverride = 0.5,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBToxic, Count = 20, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBLava, Count = 40, Interval = 0.5 }
			}
		},
		{
			CashBonus = 9000,
			SpeedBoostMultiplierOverride = 8,
			ShieldMultiplierOverride = 3,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBBoss2,
					Count = 30,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.EliteGrenadier,
					Count = 1,
					Interval = 1,
					Stealth = true
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 120,
			SpeedBoostMultiplierOverride = 1.25,
			ShieldMultiplierOverride = 0.7,
			HealthMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 8, Interval = 5 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBMystery2, Count = 25, Interval = 1 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss3, Count = 5, Interval = 5 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 15, Interval = 2 },
				{ StartDelay = 5, EnemyType = Enums.Enemies.TBLightning, Count = 14, Interval = 1 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.TBBoss2,
					Count = 15,
					AdditionalShieldMultiplier = 2,
					Interval = 5
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.TBHiddenBoss, Count = 9, Interval = 1 }
			}
		},
		{
			CashBonus = 11000,
			ShieldMultiplierOverride = 0.7,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 2 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBBoss2, Count = 5, Interval = 5 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.MultiplierT, Count = 1, Interval = 1 },
				{ StartDelay = 9.9, EnemyType = Enums.Enemies.TBBoss4, Count = 1, Interval = 2 }
			}
		},
		{
			CashBonus = 12000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 16, Interval = 1 },
				{ StartDelay = 2, EnemyType = Enums.Enemies.TBSlimeBoss, Count = 15, Interval = 1 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.TBLightning,
					Count = 25,
					AdditionalShieldMultiplier = 5,
					Interval = 0.5
				},
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.TBBoss2,
					Count = 15,
					AdditionalShieldMultiplier = 1,
					Interval = 1
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.TBHiddenBoss,
					Count = 9,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 25000,
			ShieldMultiplierOverride = 0,
			SpeedBoostMultiplierOverride = 1,
			CashMultiplierOverride = 0.8,
			HealthMultiplierOverride = 62500,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.Zombie, Count = 1, Interval = 1 }
			}
		},
		{
			CashBonus = 200000,
			ShieldMultiplierOverride = 0.1,
			SpeedBoostMultiplierOverride = 1.1,
			CashMultiplierOverride = 0.8,
			HealthMultiplierOverride = 1,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.TBBoss4, Count = 22, Interval = 1 },
				{ StartDelay = 0.5, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 1 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.TBNecromancerBoss,
					Count = 3,
					Interval = 10
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss3, Count = 30, Interval = 0.7 },
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.TBMysteryBoss,
					Count = 2,
					Interval = 3
				},
				{ StartDelay = 70, EnemyType = Enums.Enemies.TBEndbringer, Count = 2, Interval = 6 },
				{ StartDelay = 90, EnemyType = Enums.Enemies.TBGuardian, Count = 3, Interval = 4 },
				{
					StartDelay = 100,
					EnemyType = Enums.Enemies.TBNightmareVoid,
					Count = 1,
					Interval = 2.5
				},
				{ StartDelay = 150, EnemyType = Enums.Enemies.TBBoss4, Count = 5, Interval = 1 },
				{ StartDelay = 140, EnemyType = Enums.Enemies.TBGuardian, Count = 2, Interval = 4 }
			}
		}
	}
}