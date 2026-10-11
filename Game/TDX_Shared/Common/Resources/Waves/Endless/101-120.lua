local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	[101] = {
		CashBonus = 20000,
		CustomWaveTime = 600,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 20,
		CashMultiplierOverride = 10,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[102] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 5, Interval = 5 }
		}
	},
	[103] = {
		CashBonus = 2000,
		CustomWaveTime = 777,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedPlagueDoctor,
				Count = 1,
				Interval = 5,
				AdditionalHealthMultiplier = 4
			},
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.PlagueGuardian,
				Count = 2,
				Interval = 5,
				AdditionalHealthMultiplier = 2
			},
			{ StartDelay = 8, EnemyType = Enums.Enemies.EradicatorMK4, Count = 1, Interval = 5 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.PlagueDoctor, Count = 1, Interval = 5 }
		}
	},
	[104] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.75,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 5 }
		}
	},
	[105] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 5, Interval = 5 }
		}
	},
	[106] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 2.25,
		ShieldMultiplierOverride = 3,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedAbomination,
				Count = 12,
				Interval = 2,
				Stealth = true
			}
		}
	},
	[107] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 6,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 1, Interval = 5 }
		}
	},
	[108] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 15,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[109] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[110] = {
		CashBonus = 2000,
		CustomWaveTime = 400,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMK4, Count = 1, Interval = 5 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Eradicator, Count = 1, Interval = 5 },
			{ StartDelay = 15, EnemyType = Enums.Enemies.Eradicator, Count = 1, Interval = 5 }
		}
	},
	[111] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 500,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier1, Count = 1, Interval = 5 }
		}
	},
	[112] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 18, Interval = 2 }
		}
	},
	[113] = {
		CashBonus = 2000,
		CustomWaveTime = 300,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 15, Interval = 3 }
		}
	},
	[114] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 4.5,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 5 }
		}
	},
	[115] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 2.25,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Hunter, Count = 5, Interval = 5 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 5 }
		}
	},
	[116] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 10,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Specter, Count = 1, Interval = 5 }
		}
	},
	[117] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[118] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[119] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[120] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 30,
				Interval = 0.75
			},
			{
				StartDelay = 0.5,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 30,
				Interval = 0.5
			}
		}
	},
	[121] = {
		CashBonus = 2000,
		CustomWaveTime = 200,
		HealthMultiplierOverride = 1.3,
		SpeedBoostMultiplierOverride = 4,
		ShieldMultiplierOverride = 0.2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMK4, Count = 1, Interval = 5 }
		}
	},
	[122] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 20,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Infiltrator, Count = 10, Interval = 1.2 }
		}
	},
	[123] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 5,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Hunter, Count = 2, Interval = 5 }
		}
	},
	[124] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradidog, Count = 5, Interval = 1.5 }
		}
	},
	[125] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.MultiplierX,
				Count = 1,
				Interval = 10,
				Stealth = true
			}
		}
	},
	[126] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 5,
				EnemyType = Enums.Enemies.RevivedAbomination,
				Count = 20,
				Interval = 1,
				Stealth = true
			}
		}
	},
	[127] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 20, Interval = 1 }
		}
	},
	[128] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 7,
		SpeedBoostMultiplierOverride = 4,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Hunter, Count = 1, Interval = 5 }
		}
	},
	[129] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 30, Interval = 0.5 }
		}
	},
	[130] = {
		CashBonus = 2000,
		CustomWaveTime = 999999,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 0.65,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ApexPredator,
				Count = 1,
				Interval = 5,
				AdditionalHealthMultiplier = 0.5
			},
			{ StartDelay = 5, EnemyType = Enums.Enemies.EradicatorMK4, Count = 2, Interval = 5 },
			{ StartDelay = 60, EnemyType = Enums.Enemies.Assailant, Count = 1, Interval = 5 }
		}
	},
	[131] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 15, Interval = 0.8 }
		}
	},
	[132] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 10,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 0.85 }
		}
	},
	[133] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Assailant, Count = 1, Interval = 5 }
		}
	},
	[134] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 25,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 40,
				Interval = 0.75
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.PlagueGuardian, Count = 5, Interval = 1 }
		}
	},
	[135] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Jammer, Count = 20, Interval = 1 }
		}
	},
	[136] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 25,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 7,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EliteGrenadier, Count = 8, Interval = 1 }
		}
	},
	[137] = {
		CashBonus = 2000,
		CustomWaveTime = 777,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 0.2,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ToiletJohnBoss,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 1.5
			},
			{ StartDelay = 15, EnemyType = Enums.Enemies.EradicatorMK4, Count = 2, Interval = 4 },
			{ StartDelay = 16, EnemyType = Enums.Enemies.TankToilet, Count = 20, Interval = 1 }
		}
	},
	[138] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.JohnToilet, Count = 1, Interval = 1 }
		}
	},
	[139] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 5, Interval = 1 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.Grumble,
				Count = 1,
				Interval = 7,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[140] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 8,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0.3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.NightmareCyberSanta,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 1
			},
			{ StartDelay = 4, EnemyType = Enums.Enemies.EradicatorMK2, Count = 1, Interval = 7 }
		}
	},
	[141] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 30,
		SpeedBoostMultiplierOverride = 1.4,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.SuperNaughty, Count = 20, Interval = 1 },
			{ StartDelay = 15, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 1 }
		}
	},
	[142] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 1.15,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 40, Interval = 1 }
		}
	},
	[143] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 10, Interval = 1 }
		}
	},
	[144] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 200,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.MutantXcientist, Count = 50, Interval = 1 }
		}
	},
	[145] = {
		CashBonus = 2000,
		CustomWaveTime = 160,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 20, Interval = 1 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.Suppressor, Count = 10, Interval = 1 },
			{
				StartDelay = 4,
				EnemyType = Enums.Enemies.Grumble,
				Count = 2,
				Interval = 7,
				AdditionalHealthMultiplier = 1
			},
			{ StartDelay = 15, EnemyType = Enums.Enemies.Ravage, Count = 5, Interval = 1 }
		}
	},
	[146] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 1, Interval = 1 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.Specter,
				Count = 2,
				Interval = 7,
				AdditionalHealthMultiplier = 8
			}
		}
	},
	[147] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0.4,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 20, Interval = 0.7 }
		}
	},
	[148] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Brute, Count = 40, Interval = 0.4 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.ArmoredTank,
				Count = 20,
				Interval = 1,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[149] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 20,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 1 }
		}
	},
	[150] = {
		CashBonus = 100000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.2,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.EradicatorMK4Gold,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 0.5
			}
		}
	},
	[151] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Assailant, Count = 5, Interval = 1.5 }
		}
	},
	[152] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 10, Interval = 2.25 }
		}
	},
	[153] = {
		CashBonus = 2000,
		CustomWaveTime = 222,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1.2,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Grumble,
				Count = 1,
				Interval = 7,
				AdditionalHealthMultiplier = 1,
				Stealth = true
			}
		}
	},
	[154] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 60,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Xcientist, Count = 30, Interval = 1 }
		}
	},
	[155] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 20, Interval = 1 }
		}
	},
	[156] = {
		CashBonus = 2000,
		CustomWaveTime = 160,
		HealthMultiplierOverride = 7,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 20,
				Interval = 1
			},
			{ StartDelay = 7, EnemyType = Enums.Enemies.AntiGolem, Count = 1, Interval = 1 },
			{
				StartDelay = 0.5,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 20,
				Interval = 1
			}
		}
	},
	[157] = {
		CashBonus = 2000,
		CustomWaveTime = 666,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Goliath,
				Count = 1,
				Interval = 7,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[158] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 10, Interval = 1 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.Grumble,
				Count = 1,
				Interval = 7,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[159] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Assailant, Count = 20, Interval = 1 }
		}
	},
	[160] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradidog, Count = 10, Interval = 1.5 }
		}
	},
	[161] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 400,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.EliteGrenadier,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 8
			}
		}
	},
	[162] = {
		CashBonus = 2000,
		CustomWaveTime = 222,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 20, Interval = 1 }
		}
	},
	[163] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradidog, Count = 11, Interval = 1 }
		}
	},
	[164] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 30,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Grumble,
				Count = 1,
				Interval = 7,
				AdditionalHealthMultiplier = 4
			}
		}
	},
	[165] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 20,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Redacted, Count = 1, Interval = 1 }
		}
	},
	[166] = {
		CashBonus = 2000,
		CustomWaveTime = 66666,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Calamity,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 0.2
			}
		}
	},
	[167] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 20, Interval = 1 }
		}
	},
	[168] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 5,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.01,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Assailant, Count = 20, Interval = 1 }
		}
	},
	[169] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 100000,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyZombiePlus, Count = 1, Interval = 1 }
		}
	},
	[170] = {
		CashBonus = 2000,
		CustomWaveTime = 8788,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.EradicatorMKICGold,
				Count = 1,
				Interval = 1
			}
		}
	},
	[171] = {
		CashBonus = 2000,
		CustomWaveTime = 667,
		HealthMultiplierOverride = 10,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 20, Interval = 1 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.Grumble,
				Count = 2,
				Interval = 7,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[172] = {
		CashBonus = 2000,
		CustomWaveTime = 1000,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBNightmareVoid,
				Count = 1,
				Interval = 1,
				AdditionalHealthMultiplier = 0.5
			},
			{ StartDelay = 2, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1 }
		}
	},
	[173] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 4,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss3, Count = 40, Interval = 0.5 }
		}
	},
	[174] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ToiletJohnBoss,
				Count = 1,
				Interval = 6,
				AdditionalHealthMultiplier = 4
			}
		}
	},
	[175] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.TBMysteryBoss, Count = 10, Interval = 2 }
		}
	},
	[176] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Assailant, Count = 15, Interval = 1 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.Hunter, Count = 6, Interval = 3 }
		}
	},
	[177] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 2 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.MultiplierT, Count = 1, Interval = 1 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.Assailant, Count = 1, Interval = 1 }
		}
	},
	[178] = {
		CashBonus = 2000,
		CustomWaveTime = 500,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 3.5,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMKIC, Count = 1, Interval = 1 }
		}
	},
	[179] = {
		CashBonus = 2000,
		CustomWaveTime = 400,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Goliath,
				Count = 4,
				Interval = 2,
				AdditionalHealthMultiplier = 10
			}
		}
	},
	[180] = {
		CashBonus = 2000,
		CustomWaveTime = 777,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 0.2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Calamity, Count = 1, Interval = 6 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.TBVoid, Count = 1, Interval = 6 }
		}
	},
	[181] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0.01,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 10,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[182] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 9,
		SpeedBoostMultiplierOverride = 1.3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBNormal,
				Count = 1,
				Interval = 6,
				AdditionalHealthMultiplier = 999999
			}
		}
	},
	[183] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.MultiplierX, Count = 1, Interval = 6 }
		}
	},
	[184] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.01,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 10,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[185] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.1,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 12,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[186] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.1,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 14,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[187] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.1,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 16,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[188] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.1,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 18,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[189] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		ShieldMultiplierOverride = 0.1,
		SpeedBoostMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Assailant,
				Count = 18,
				Interval = 3,
				AdditionalHealthMultiplier = 1
			}
		}
	},
	[190] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1.3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.TBVoid, Count = 1, Interval = 6 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.MultiplierX, Count = 1, Interval = 6 }
		}
	},
	[191] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Calamity, Count = 2, Interval = 7 }
		}
	},
	[192] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.4,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedPlagueDoctor,
				Count = 15,
				Interval = 2.5
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 15, Interval = 2 },
			{
				StartDelay = 35,
				EnemyType = Enums.Enemies.Grumble,
				Count = 1,
				Interval = 5,
				AdditionalHealthMultiplier = 8
			}
		}
	},
	[193] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.TBBoss4, Count = 80, Interval = 0.25 }
		}
	},
	[194] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBLava,
				Count = 30,
				Interval = 1,
				AdditionalHealthMultiplier = 110
			}
		}
	},
	[195] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedJohn,
				Count = 100,
				Interval = 0.25,
				AdditionalHealthMultiplier = 7
			}
		}
	},
	[196] = {
		CashBonus = 2000,
		CustomWaveTime = 333,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBHiddenBoss,
				Count = 175,
				Interval = 0.2,
				AdditionalHealthMultiplier = 50
			}
		}
	},
	[197] = {
		CashBonus = 2000,
		CustomWaveTime = 555,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBMystery2,
				Count = 250,
				Interval = 0.25,
				AdditionalHealthMultiplier = 20
			}
		}
	},
	[198] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.TBNormal, Count = 1, Interval = 6 }
		}
	},
	[199] = {
		CashBonus = 2000,
		CustomWaveTime = 666,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.JohnToilet,
				Count = 1,
				Interval = 6,
				AdditionalHealthMultiplier = 20
			}
		}
	},
	[200] = {
		CashBonus = 9999999,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.VoidApexPredator,
				Count = 1,
				Interval = 6,
				AdditionalHealthMultiplier = 1
			},
			{
				StartDelay = 10,
				EnemyType = Enums.Enemies.TBVoid,
				Count = 1,
				AdditionalHealthMultiplier = 1,
				Interval = 6
			}
		}
	},
	[201] = {
		CashBonus = 2000,
		CustomWaveTime = 999,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.TBEndbringer,
				Count = 999,
				Interval = 2,
				AdditionalHealthMultiplier = 100
			}
		}
	}
}