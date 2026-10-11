local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	[41] = {
		CashBonus = 1275,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1.3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Breacher, Count = 30, Interval = 1 }
		}
	},
	[42] = {
		CashBonus = 1300,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.3,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 7, Interval = 3 }
		}
	},
	[43] = {
		CashBonus = 1325,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 8, Interval = 1.2 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Specter, Count = 2, Interval = 1.2 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.Breacher, Count = 3, Interval = 1 }
		}
	},
	[44] = {
		CashBonus = 1350,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 3, EnemyType = Enums.Enemies.Specter, Count = 5, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Ravage, Count = 3, Interval = 1 }
		}
	},
	[45] = {
		CashBonus = 1375,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 1.2 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.Ravage,
				Count = 2,
				Interval = 6,
				Stealth = true
			}
		}
	},
	[46] = {
		CashBonus = 1400,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.28,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.Grumble, Count = 3, Interval = 5 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.RevivedMutatedZombie,
				Count = 60,
				Interval = 0.5
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 2, Interval = 2 }
		}
	},
	[47] = {
		CashBonus = 1425,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 7, Interval = 4 },
			{ StartDelay = 4, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 4 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Specter, Count = 2, Interval = 1 }
		}
	},
	[48] = {
		CashBonus = 1450,
		CustomWaveTime = 120,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 1, EnemyType = Enums.Enemies.Herculean, Count = 4, Interval = 3 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 8, Interval = 1 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Specter, Count = 3, Interval = 3 }
		}
	},
	[49] = {
		CashBonus = 1475,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.4,
		ShieldMultiplierOverride = 3,
		SpawnSequences = {
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.RevivedAbomination,
				Count = 8,
				Interval = 0.85,
				Stealth = true
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 1, Interval = 1.2 }
		}
	},
	[50] = {
		CashBonus = 10000,
		CustomWaveTime = 500,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.2,
		CashMultiplierOverride = 0.85,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMK4, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Ravage, Count = 1, Interval = 1.5 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 1, Interval = 1.2 }
		}
	},
	[51] = {
		CashBonus = 1525,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.7,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 2, Interval = 3 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Herculean, Count = 4, Interval = 2 }
		}
	},
	[52] = {
		CashBonus = 1550,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.25,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Herculean, Count = 10, Interval = 1.2 },
			{ StartDelay = 7, EnemyType = Enums.Enemies.AntiGolem, Count = 1, Interval = 3 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Grumble, Count = 2, Interval = 5 }
		}
	},
	[53] = {
		CashBonus = 1575,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 2.6,
		ShieldMultiplierOverride = 1.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 5, Interval = 1.2 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 1.2 }
		}
	},
	[54] = {
		CashBonus = 1600,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 5, Interval = 3 }
		}
	},
	[55] = {
		CashBonus = 1625,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 3, EnemyType = Enums.Enemies.Ravage, Count = 5, Interval = 1.2 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 4, Interval = 2 }
		}
	},
	[56] = {
		CashBonus = 1650,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 12,
				Interval = 1
			},
			{
				StartDelay = 0.5,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 12,
				Interval = 1
			}
		}
	},
	[57] = {
		CashBonus = 1675,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 2, Interval = 5 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 15,
				Interval = 1
			},
			{
				StartDelay = 0.5,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 15,
				Interval = 1
			}
		}
	},
	[58] = {
		CashBonus = 1700,
		CustomWaveTime = 160,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 3, Interval = 5 },
			{ StartDelay = 4, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 2, Interval = 5 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Ravage, Count = 2, Interval = 6 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 15,
				Interval = 1
			}
		}
	},
	[59] = {
		CashBonus = 1725,
		CustomWaveTime = 180,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 5, Interval = 2 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 15,
				Interval = 1
			},
			{ StartDelay = 5, EnemyType = Enums.Enemies.Breacher, Count = 15, Interval = 1 }
		}
	},
	[60] = {
		CashBonus = 10000,
		CustomWaveTime = 500,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMKIC, Count = 1, Interval = 1.2 },
			{ StartDelay = 10, EnemyType = Enums.Enemies.Eradidog, Count = 1, Interval = 7 }
		}
	}
}