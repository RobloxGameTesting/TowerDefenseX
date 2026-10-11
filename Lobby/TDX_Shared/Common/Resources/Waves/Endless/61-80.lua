local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	[61] = {
		CashBonus = 1775,
		CustomWaveTime = 140,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 1.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 10, Interval = 2.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 7, Interval = 2.2 }
		}
	},
	[62] = {
		CashBonus = 1800,
		CustomWaveTime = 140,
		HealthMultiplierOverride = 30,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 2,
		CashMultiplierOverride = 0.25,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 2, Interval = 7 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 15,
				Interval = 1.2
			},
			{ StartDelay = 2, EnemyType = Enums.Enemies.Xcientist, Count = 2, Interval = 7 }
		}
	},
	[63] = {
		CashBonus = 1825,
		CustomWaveTime = 60,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0.4,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.AntiGolem,
				Count = 7,
				Interval = 2.2,
				Stelath = true
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 3, Interval = 2 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Eradidog, Count = 2, Interval = 12 }
		}
	},
	[64] = {
		CashBonus = 1850,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 0.4,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 12,
				Interval = 1.2
			},
			{ StartDelay = 1, EnemyType = Enums.Enemies.Guardian, Count = 2, Interval = 4 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 1.2 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 2, Interval = 3 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 12,
				Interval = 1.2
			}
		}
	},
	[65] = {
		CashBonus = 1875,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 8, Interval = 1 }
		}
	},
	[66] = {
		CashBonus = 1900,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 12, Interval = 1.2 },
			{ StartDelay = 7, EnemyType = Enums.Enemies.Eradidog, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 3 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 3 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 3 }
		}
	},
	[67] = {
		CashBonus = 1925,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 12, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 3, Interval = 4 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 3, Interval = 7 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Multiplier2, Count = 1, Interval = 9 }
		}
	},
	[68] = {
		CashBonus = 1950,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.7,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 16,
				Interval = 0.65
			}
		}
	},
	[69] = {
		CashBonus = 1975,
		HealthMultiplierOverride = 84000,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier1, Count = 1, Interval = 1.2 }
		}
	},
	[70] = {
		CashBonus = 10000,
		CustomWaveTime = 666,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.8,
		CashMultiplierOverride = 0.7,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ApexPredator, Count = 1, Interval = 1.2 }
		}
	},
	[71] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 0.7,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 13, Interval = 1 }
		}
	},
	[72] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 6,
		SpeedBoostMultiplierOverride = 1.4,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 5, Interval = 3 },
			{ StartDelay = 14, EnemyType = Enums.Enemies.Specter, Count = 1, Interval = 2 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Guardian, Count = 10, Interval = 1.2 }
		}
	},
	[73] = {
		CashBonus = 2000,
		CustomWaveTime = 120,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 7, Interval = 1.7 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 12, Interval = 3 }
		}
	},
	[74] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 1.2,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 15, Interval = 1 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Guardian, Count = 3, Interval = 7 }
		}
	},
	[75] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 3, EnemyType = Enums.Enemies.Eradidog, Count = 6, Interval = 4 }
		}
	},
	[76] = {
		CashBonus = 2000,
		CustomWaveTime = 40,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.4,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Suppressor, Count = 12, Interval = 1 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.AntiGolem, Count = 3, Interval = 4 }
		}
	},
	[77] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 9,
		SpeedBoostMultiplierOverride = 1.8,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.2,
		SpawnSequences = {
			{ StartDelay = 3, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 3, Interval = 1 }
		}
	},
	[78] = {
		CashBonus = 2000,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 2.5,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 3, EnemyType = Enums.Enemies.Specter, Count = 7, Interval = 1 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 6, Interval = 3 }
		}
	},
	[79] = {
		CashBonus = 2000,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Ravage,
				Stealth = true,
				Count = 2,
				Interval = 7
			},
			{
				StartDelay = 5,
				EnemyType = Enums.Enemies.Suppressor,
				Count = 20,
				Interval = 1,
				Stealth = true
			}
		}
	},
	[80] = {
		CashBonus = 40000,
		CustomWaveTime = 99999999999,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Calamity, Count = 1, Interval = 1.2 }
		}
	}
}