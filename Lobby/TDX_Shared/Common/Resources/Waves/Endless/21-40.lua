local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	[21] = {
		CashBonus = 800,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.75,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 5,
				Interval = 3
			},
			{ StartDelay = 1, EnemyType = Enums.Enemies.Prisoner, Count = 25, Interval = 0.75 }
		}
	},
	[22] = {
		CashBonus = 800,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 6,
				Interval = 3
			},
			{ StartDelay = 2, EnemyType = Enums.Enemies.ShockHead, Count = 25, Interval = 0.65 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.Prisoner, Count = 50, Interval = 0.75 }
		}
	},
	[23] = {
		CashBonus = 1000,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0.5, EnemyType = Enums.Enemies.Brute, Count = 7, Interval = 2.5 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 5,
				Interval = 4
			}
		}
	},
	[24] = {
		CashBonus = 1200,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 3, Interval = 5 },
			{ StartDelay = 12, EnemyType = Enums.Enemies.Brute, Count = 2, Interval = 5 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Xcientist, Count = 15, Interval = 2.5 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.ShockHead, Count = 25, Interval = 0.65 }
		}
	},
	[25] = {
		CashBonus = 20000,
		CustomWaveTime = 300,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 2.5, EnemyType = Enums.Enemies.PlagueDoctor, Count = 1, Interval = 1.2 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 3,
				Interval = 1
			},
			{ StartDelay = 1, EnemyType = Enums.Enemies.PlagueGuardian, Count = 2, Interval = 5 },
			{
				StartDelay = 4,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 30,
				Interval = 2.65
			},
			{ StartDelay = 4, EnemyType = Enums.Enemies.Disposalist, Count = 2, Interval = 0.5 },
			{ StartDelay = 12, EnemyType = Enums.Enemies.Disposalist, Count = 2, Interval = 0.5 },
			{ StartDelay = 20, EnemyType = Enums.Enemies.Disposalist, Count = 2, Interval = 0.5 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Xcientist, Count = 40, Interval = 1.25 },
			{
				StartDelay = 30,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 3,
				Interval = 1.5
			}
		}
	},
	[26] = {
		CashBonus = 900,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.ArmoredTank, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 1, Interval = 1.2 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 10,
				Interval = 1.2
			},
			{ StartDelay = 3, EnemyType = Enums.Enemies.Xcientist, Count = 10, Interval = 0.35 },
			{ StartDelay = 8, EnemyType = Enums.Enemies.Disposalist, Count = 2, Interval = 1.2 }
		}
	},
	[27] = {
		CashBonus = 925,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 3, Interval = 4 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.Brute, Count = 8, Interval = 3.75 },
			{ StartDelay = 20, EnemyType = Enums.Enemies.Specter, Count = 1, Interval = 4 }
		}
	},
	[28] = {
		CashBonus = 950,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 12,
				Interval = 1.2
			},
			{ StartDelay = 1, EnemyType = Enums.Enemies.ArmoredRunner, Count = 12, Interval = 1.2 }
		}
	},
	[29] = {
		CashBonus = 975,
		CustomWaveTime = 60,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 7, Interval = 1.2 },
			{ StartDelay = 7, EnemyType = Enums.Enemies.Specter, Count = 2, Interval = 1 },
			{
				StartDelay = 10,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 5,
				Interval = 1
			}
		}
	},
	[30] = {
		CashBonus = 42000,
		CustomWaveTime = 300,
		HealthMultiplierOverride = 0.8,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1.15,
		SpawnSequences = {
			{
				StartDelay = 2.5,
				EnemyType = Enums.Enemies.RevivedPlagueDoctor,
				Count = 1,
				Interval = 1.2
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.PlagueGuardian, Count = 1, Interval = 2 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.ArmoredRunner, Count = 3, Interval = 2 },
			{ StartDelay = 8, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 3, Interval = 12 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Xcientist, Count = 100, Interval = 0.65 }
		}
	},
	[31] = {
		CashBonus = 1025,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 1.5,
		CashMultiplierOverride = 0.6,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 3, Interval = 4 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Xcientist, Count = 30, Interval = 0.65 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Brute, Count = 20, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Specter, Count = 1, Interval = 4 }
		}
	},
	[32] = {
		CashBonus = 1050,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 1.5,
		CashMultiplierOverride = 0.35,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 7, Interval = 4 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Specter, Count = 1, Interval = 1 }
		}
	},
	[33] = {
		CashBonus = 1075,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 40,
				Interval = 0.65
			},
			{ StartDelay = 2, EnemyType = Enums.Enemies.ArmoredTank, Count = 3, Interval = 3.75 }
		}
	},
	[34] = {
		CashBonus = 1100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 12,
				Interval = 0.65
			},
			{ StartDelay = 3, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 3 }
		}
	},
	[35] = {
		CashBonus = 40000,
		CustomWaveTime = 300,
		HealthMultiplierOverride = 1.1,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 0.7,
		CashMultiplierOverride = 0.6,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradicator, Count = 1, Interval = 8 },
			{ StartDelay = 7, EnemyType = Enums.Enemies.Guardian, Count = 1, Interval = 2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 2, Interval = 2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Predator, Count = 3, Interval = 3 }
		}
	},
	[36] = {
		CashBonus = 5000,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.35,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Breacher, Count = 17, Interval = 1.2 }
		}
	},
	[37] = {
		CashBonus = 1175,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Breacher, Count = 12, Interval = 1 },
			{ StartDelay = 1.5, EnemyType = Enums.Enemies.ArmoredRunner, Count = 12, Interval = 1 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 12,
				Interval = 1
			}
		}
	},
	[38] = {
		CashBonus = 1200,
		CustomWaveTime = 60,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0.4,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.ArmoredTank, Count = 12, Interval = 1.2 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Guardian,
				Count = 5,
				Interval = 1.5,
				Stealth = true
			},
			{ StartDelay = 10, EnemyType = Enums.Enemies.Specter, Count = 3, Interval = 4 }
		}
	},
	[39] = {
		CashBonus = 1225,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.Specter, Count = 3, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 2, Interval = 1.2 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Breacher, Count = 11, Interval = 0.5 }
		}
	},
	[40] = {
		CashBonus = 12000,
		CustomWaveTime = 300,
		HealthMultiplierOverride = 1.1,
		SpeedBoostMultiplierOverride = 1.1,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMK2, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 4, Interval = 1.2 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Guardian, Count = 1, Interval = 1.2 },
			{ StartDelay = 20, EnemyType = Enums.Enemies.ArmoredTank, Count = 10, Interval = 1.2 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Eradicator, Count = 1, Interval = 1.2 },
			{ StartDelay = 45, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 },
			{ StartDelay = 45, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 },
			{ StartDelay = 45, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 }
		}
	}
}