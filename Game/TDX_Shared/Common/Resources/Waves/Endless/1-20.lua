local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	{
		CashBonus = 0,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Contained, Count = 9, Interval = 0.75 }
		}
	},
	{
		CashBonus = 325,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 1, EnemyType = Enums.Enemies.Contained, Count = 13, Interval = 0.8 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.LightContained, Count = 3, Interval = 1.2 }
		}
	},
	{
		CashBonus = 350,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.LightContained, Count = 12, Interval = 1.2 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Contained, Count = 7, Interval = 0.75 }
		}
	},
	{
		CashBonus = 375,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.HeavyContained, Count = 4, Interval = 1.7 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.LightContained,
				Count = 15,
				Interval = 0.75
			}
		}
	},
	{
		CashBonus = 400,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 2, EnemyType = Enums.Enemies.Disposalist, Count = 1, Interval = 1.2 },
			{
				StartDelay = 0,
				EnemyType = Enums.Enemies.HeavyContained,
				Count = 10,
				Interval = 0.67
			}
		}
	},
	{
		CashBonus = 425,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.MutantXcientist, Count = 1, Interval = 2.4 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.LightContained,
				Count = 25,
				Interval = 0.15
			}
		}
	},
	{
		CashBonus = 450,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.MutantXcientist, Count = 2, Interval = 1.2 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.HeavyContained,
				Count = 12,
				Interval = 0.75
			}
		}
	},
	{
		CashBonus = 475,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 7,
				EnemyType = Enums.Enemies.HeavyContained,
				Count = 12,
				Interval = 0.25
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.Disposalist, Count = 3, Interval = 1.3 }
		}
	},
	{
		CashBonus = 500,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Prisoner, Count = 8, Interval = 1.2 }
		}
	},
	{
		CashBonus = 525,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 1, EnemyType = Enums.Enemies.MutantXcientist, Count = 4, Interval = 2.5 },
			{ StartDelay = 0, EnemyType = Enums.Enemies.Prisoner, Count = 12, Interval = 1 }
		}
	},
	{
		CashBonus = 550,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Xcientist, Count = 7, Interval = 1.2 }
		}
	},
	{
		CashBonus = 575,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.MutantXcientist, Count = 7, Interval = 3 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Prisoner, Count = 12, Interval = 1 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.Disposalist, Count = 2, Interval = 8 }
		}
	},
	{
		CashBonus = 600,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ShockHead, Count = 13, Interval = 1 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.MutantXcientist, Count = 4, Interval = 3 }
		}
	},
	{
		CashBonus = 625,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Brute, Count = 1, Interval = 4 },
			{
				StartDelay = 4,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 5,
				Interval = 3.56
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.ShockHead, Count = 15, Interval = 0.83 }
		}
	},
	{
		CashBonus = 650,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ShockHead, Count = 40, Interval = 1 },
			{ StartDelay = 3, EnemyType = Enums.Enemies.Disposalist, Count = 4, Interval = 1.2 },
			{ StartDelay = 5, EnemyType = Enums.Enemies.MutantXcientist, Count = 5, Interval = 7 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.Prisoner, Count = 12, Interval = 1 }
		}
	},
	{
		CashBonus = 675,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{
				StartDelay = 3,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 10,
				Interval = 1.7
			},
			{ StartDelay = 3, EnemyType = Enums.Enemies.Disposalist, Count = 1, Interval = 1.2 },
			{
				StartDelay = 14.5,
				EnemyType = Enums.Enemies.Disposalist,
				Count = 1,
				Interval = 1.2,
				Stealth = true
			},
			{ StartDelay = 0, EnemyType = Enums.Enemies.Brute, Count = 2, Interval = 4 },
			{
				StartDelay = 12,
				EnemyType = Enums.Enemies.Brute,
				Count = 1,
				Interval = 4,
				Stealth = true
			}
		}
	},
	{
		CashBonus = 700,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1.2,
		ShieldMultiplierOverride = 1,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Guardian, Count = 1, Interval = 1.2 },
			{ StartDelay = 4, EnemyType = Enums.Enemies.Disposalist, Count = 3, Interval = 1.8 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.HeavyContained, Count = 20, Interval = 1.2 },
			{ StartDelay = 2, EnemyType = Enums.Enemies.MutantXcientist, Count = 3, Interval = 1 },
			{ StartDelay = 8, EnemyType = Enums.Enemies.LightContained, Count = 30, Interval = 0.6 }
		}
	},
	{
		CashBonus = 725,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.Xcientist, Count = 30, Interval = 0.75 },
			{
				StartDelay = 1,
				EnemyType = Enums.Enemies.Prisoner,
				Count = 20,
				Stealth = true,
				Interval = 1.2
			}
		}
	},
	{
		CashBonus = 750,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 1, Interval = 4 },
			{
				StartDelay = 2,
				EnemyType = Enums.Enemies.MutantXcientist,
				Count = 5,
				Stealth = true,
				Interval = 4.21
			},
			{ StartDelay = 5, EnemyType = Enums.Enemies.Disposalist, Count = 3, Interval = 1.2 }
		}
	},
	{
		CashBonus = 775,
		CustomWaveTime = 100,
		HealthMultiplierOverride = 1,
		SpeedBoostMultiplierOverride = 1,
		ShieldMultiplierOverride = 0,
		CashMultiplierOverride = 1,
		SpawnSequences = {
			{ StartDelay = 0, EnemyType = Enums.Enemies.ArmoredTank, Count = 2, Interval = 10 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.Xcientist, Count = 20, Interval = 1.5 },
			{ StartDelay = 4, EnemyType = Enums.Enemies.Disposalist, Count = 5, Interval = 3.65 },
			{ StartDelay = 1, EnemyType = Enums.Enemies.ShockHead, Count = 30, Interval = 0.85 }
		}
	}
}