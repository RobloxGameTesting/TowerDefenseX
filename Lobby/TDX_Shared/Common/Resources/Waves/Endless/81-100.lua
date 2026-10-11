local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	[81] = {
		CashBonus = 20000,
		CustomWaveTime = 600,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.25,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 10,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Redacted, Count = 1, Interval = 5 }
		}
	},
	[82] = {
		CashBonus = 6,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1.5,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0.5,
		CashMultiplierOverride = 0.5,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradidog, Count = 7, Interval = 4 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Avatar, Count = 10, Interval = 1 }
		}
	},
	[83] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.4,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 2, Interval = 5 }
		}
	},
	[84] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.6,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Suppressor, Count = 25, Interval = 1 },
			{ StartDelay = 20, EnemyType = Enums.Enemies.Avatar, Count = 5, Interval = 0.1 }
		}
	},
	[85] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 15,
				Interval = 1
			},
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 15,
				Interval = 1
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.ResurrectedJohn, Count = 7, Interval = 2.2 }
		}
	},
	[86] = {
		CashBonus = 1775,
		CustomWaveTime = 120,
		HealthMultiplierOverride = 1.5,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 1.2,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 5 }
		}
	},
	[87] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Eradidog, Count = 5, Interval = 1 }
		}
	},
	[88] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.5,
		ShieldMultiplierOverride = 0.3,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 7, Interval = 1 }
		}
	},
	[89] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 0.15,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 1, Interval = 5 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 7, Interval = 2.2 }
		}
	},
	[90] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 2.5,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Entity, Count = 1, Interval = 5 }
		}
	},
	[91] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0.5,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Ravage,
				Count = 15,
				Interval = 1,
				Stealth = true
			}
		}
	},
	[92] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.MultiplierX,
				Count = 1,
				Interval = 5,
				Stealth = true
			}
		}
	},
	[93] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 3,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.AntiGolem, Count = 1, Interval = 5 }
		}
	},
	[94] = {
		CashBonus = 1775,
		CustomWaveTime = 120,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Goliath, Count = 4, Interval = 7 }
		}
	},
	[95] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 4,
		SpeedBoostMultiplierOverride = 1.3,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.PlagueGuardian,
				Count = 5,
				Interval = 2,
				Stealth = true
			},
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.Ravage,
				Count = 2,
				Interval = 2,
				Stealth = true
			}
		}
	},
	[96] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 1.2,
		SpawnSequences = {
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner1,
				Count = 20,
				Interval = 1,
				Stealth = true
			},
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.ResurrectedLaserGunner2,
				Count = 20,
				Interval = 1,
				Stealh = true
			}
		}
	},
	[97] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 25,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.EliteGrenadier, Count = 3, Interval = 1 }
		}
	},
	[98] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 2,
		SpeedBoostMultiplierOverride = 3.5,
		ShieldMultiplierOverride = 2,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Grumble, Count = 1, Interval = 5 }
		}
	},
	[99] = {
		CashBonus = 1775,
		HealthMultiplierOverride = 3,
		SpeedBoostMultiplierOverride = 2,
		ShieldMultiplierOverride = 0,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Adversary, Count = 1, Interval = 5 }
		}
	},
	[100] = {
		CashBonus = 1775,
		CustomWaveTime = 260,
		HealthMultiplierOverride = 1.2,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 0.8,
		SpawnSequences = {
			{
				StartDelay = 4,
				EnemyType = Enums.Enemies.EradicatorMK2,
				Count = 1,
				Interval = 5,
				AdditionalHealthMultiplier = 2
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.EradicatorMKIC, Count = 1, Interval = 2.2 },
			{
				StartDelay = 8,
				EnemyType = Enums.Enemies.Eradicator,
				Count = 1,
				Interval = 5,
				AdditionalHealthMultiplier = 5
			},
			{ StartDelay = 12, EnemyType = Enums.Enemies.Eradidog, Count = 5, Interval = 5 },
			{
				StartDelay = 15,
				EnemyType = Enums.Enemies.RevivedAbomination,
				Count = 10,
				Interval = 1
			},
			{ StartDelay = 12, EnemyType = Enums.Enemies.EradicatorMK4, Count = 1, Interval = 5 }
		}
	}
}