local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Slime Event",
	PlayerCountToStartingCashMap = { 1950, 1450, 1375, 1250 },
	CashPerDamageData = {
		{ CashPerDamage = 0.85, CashPerDamageShared = 0 },
		{ CashPerDamage = 0.7, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 0.5, CashPerDamageShared = 0.5 },
		{ CashPerDamage = 0.4, CashPerDamageShared = 0.3 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 3, GoldReward = 10 },
		{ WaveNumber = 5, GoldReward = 45 },
		{ WaveNumber = 8, GoldReward = 100 },
		{ WaveNumber = 10, GoldReward = 265 },
		{ WaveNumber = 16, GoldReward = 300 },
		{ WaveNumber = 18, GoldReward = 450 },
		{ WaveNumber = 20, GoldReward = 650 },
		{ WaveNumber = 23, GoldReward = 800 },
		{ WaveNumber = 25, GoldReward = 1200 },
		{ WaveNumber = 29, GoldReward = 750 },
		{ WaveNumber = 30, GoldReward = 1000 },
		{ WaveNumber = 31, GoldReward = 1200 },
		{ WaveNumber = 35, GoldReward = 1800 }
	},
	RewindProductIntervalMap = {
		{ WaveNumber = 100, CostGold = 0, GainCash = 0, GainHP = 0 }
	},
	MaximumRewinds = 1,
	DefaultXPPerWavePassed = 85,
	StartingLives = 2000,
	SetUpTime = 15,
	NoTowerDamageAllowed = true,
	LoadoutSelectionData = {
		SubtitleOverride = Lang.Strings.Game.LoadoutSelectionSubtitles.SlimeEvent,
		NoSkip = false,
		SkipPenaltyPercentage = 0.3,
		LoadoutSelectionConfigs = {
			{
				Title = Lang.Strings.Game.LoadoutSelectionTitles.Assault,
				Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
				IconId = "rbxassetid://77242869433652",
				VIPOnly = false,
				Towers = {
					Enums.Towers.Shotgunner,
					Enums.Towers.Grenadier,
					Enums.Towers.Juggernaut,
					Enums.Towers.Operator,
					Enums.Towers.MissileTrooper,
					Enums.Towers.John
				}
			},
			{
				Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
				Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
				IconId = "rbxassetid://112662075132649",
				VIPOnly = false,
				Towers = {
					Enums.Towers.EDJ,
					Enums.Towers.Barracks,
					Enums.Towers.Grenadier,
					Enums.Towers.John,
					Enums.Towers.Operator,
					Enums.Towers.LaserGunner
				}
			},
			{
				Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
				Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
				IconId = "rbxassetid://107079411064021",
				VIPOnly = false,
				Towers = {
					Enums.Towers.Artillery,
					Enums.Towers.Juggernaut,
					Enums.Towers.MineLayer,
					Enums.Towers.John,
					Enums.Towers.Railgunner,
					Enums.Towers.MissileTrooper
				}
			}
		}
	},
	AmbientPlaylist = {
		"SlimeEvent1",
		"SlimeEvent2",
		"SlimeEvent3",
		"SlimeEvent4",
		"SlimeEvent5",
		"SlimeEvent6",
		"SlimeEvent7"
	},
	Waves = {
		{
			CashBonus = 0,
			CustomWaveTime = 20,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 24, Interval = 0.4 }
			}
		},
		{
			CashBonus = 800,
			CustomWaveTime = 25,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 50, Interval = 0.4 }
			}
		},
		{
			CashBonus = 900,
			CustomWaveTime = 35,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 40, Interval = 0.5 },
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 3,
					Interval = 1.4
				}
			}
		},
		{
			CashBonus = 1000,
			CustomWaveTime = 50,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 6,
					Interval = 1.1
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 30, Interval = 0.8 }
			}
		},
		{
			CashBonus = 1150,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 3,
					Interval = 0.3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 70, Interval = 0.6 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 3,
					Interval = 0.3
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 3,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 1225,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.SlimeMob, Count = 3, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.Slime, Count = 70, Interval = 0.3 }
			}
		},
		{
			CashBonus = 1350,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 7,
					Interval = 1.5
				},
				{
					StartDelay = 0,
					AdditionalSpeedBoostMultiplier = 0.25,
					EnemyType = Enums.Enemies.Slime,
					Count = 25,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 1450,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 3,
					Interval = 1.1
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 3,
					Interval = 1.1
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 3,
					Interval = 1.1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					Count = 65,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 0.2
				},
				{ StartDelay = 2, EnemyType = Enums.Enemies.SlimeMob, Count = 3, Interval = 6 }
			}
		},
		{
			CashBonus = 1650,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SlimeBloat, Count = 1, Interval = 8 },
				{
					StartDelay = 2.5,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 3,
					Interval = 3
				},
				{ StartDelay = 17, EnemyType = Enums.Enemies.SlimeSoldier, Count = 3, Interval = 1 }
			}
		},
		{
			CashBonus = 1850,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.SlimeBloat, Count = 3, Interval = 12 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeMob,
					Count = 7,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 2.5
				}
			}
		},
		{
			CashBonus = 2150,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalShieldMultiplier = 0.3,
					Count = 30,
					Interval = 1
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.SlimeAbsorber, Count = 3, Interval = 5 },
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeMob,
					Count = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 0.1,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 2850,
			CustomWaveTime = 120,
			SpawnSequences = {
				{ StartDelay = 2, EnemyType = Enums.Enemies.SlimeWizard, Count = 1, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.SlimeBloat, Count = 1, Interval = 0.5 },
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 10,
					Interval = 0.5
				},
				{
					StartDelay = 13,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 2,
					Interval = 5
				}
			}
		},
		{
			CashBonus = 3250,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 65,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 0.7
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalShieldMultiplier = 0.5,
					Count = 5,
					Interval = 0.4
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 5,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.4
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 6,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.4
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 7,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.4
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 9,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.4
				},
				{
					StartDelay = 27,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 12,
					AdditionalShieldMultiplier = 0.5,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 4500,
			CustomWaveTime = 120,
			CashMultiplierOverride = 1.1,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.SlimeBloat, Count = 9, Interval = 1.5 },
				{
					StartDelay = 19,
					EnemyType = Enums.Enemies.SlimeWizard,
					Count = 1,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 5750,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					Count = 100,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalHealthMultiplier = 11,
					AdditionalShieldMultiplier = 0.8,
					Interval = 0.25
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 4,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 7
				}
			}
		},
		{
			CashBonus = 10000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 6,
					Interval = 3.7
				}
			}
		},
		{
			CashBonus = 7500,
			CustomWaveTime = 120,
			CashMultiplierOverride = 1.35,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.SlimeBrute, Count = 2, Interval = 12 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					Count = 35,
					AdditionalSpeedBoostMultiplier = 0.1,
					Interval = 0.7
				},
				{ StartDelay = 10, EnemyType = Enums.Enemies.SlimeWizard, Count = 2, Interval = 5 }
			}
		},
		{
			CashBonus = 60000,
			CustomWaveTime = 500,
			CashMultiplierOverride = 1.55,
			SpawnSequences = {
				{ StartDelay = 7, EnemyType = Enums.Enemies.SlimeCaptain1, Count = 1, Interval = 3 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeBloat,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 0.2,
					Count = 5,
					Interval = 0.5
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalHealthMultiplier = 2,
					Count = 10,
					Interval = 0.3
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.SlimeBloat, Count = 3, Interval = 3 },
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.Slime,
					AdditionalShieldMultiplier = 2,
					AdditionalHealthMultiplier = 4,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 100,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 8000,
			CashMultiplierOverride = 0.7,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 18,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1.2
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 9,
					Interval = 2
				}
			}
		},
		{
			CashBonus = 8250,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeBrute,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 9,
					Interval = 1.7
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 1,
					Count = 30,
					Interval = 1
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeWizard,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 7,
					Interval = 5
				},
				{
					StartDelay = 17,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 3,
					AdditionalShieldMultiplier = 1,
					Interval = 0.95
				}
			}
		},
		{
			CashBonus = 8500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MagmaSlime, Count = 7, Interval = 2 },
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.SlimeBloat,
					Count = 21,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 8750,
			CustomWaveTime = 200,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeBrute,
					AdditionalSpeedBoostMultiplier = 0.35,
					AdditionalShieldMultiplier = 0.1,
					Count = 50,
					Interval = 1.3
				}
			}
		},
		{
			CashBonus = 9000,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MagmaSlime, Count = 15, Interval = 1.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 2,
					Count = 15,
					Interval = 1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalShieldMultiplier = 1.2,
					Count = 24,
					Interval = 1.5
				},
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.SlimeGolem,
					AdditionalShieldMultiplier = 1.5,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 1,
					Interval = 3
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalShieldMultiplier = 1.1,
					AdditionalHealthMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 30,
					Interval = 0.7
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.MagmaSlime, Count = 5, Interval = 5 },
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SlimeWizard,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 10,
					Interval = 2
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SlimeBloat,
					AdditionalShieldMultiplier = 2,
					Count = 3,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 150000,
			CashMultiplierOverride = 0.85,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MegaSlime, Count = 1, Interval = 1.5 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 75,
					Interval = 0.7
				},
				{ StartDelay = 15, EnemyType = Enums.Enemies.SlimeKing, Count = 1, Interval = 1.5 }
			}
		}
	}
}