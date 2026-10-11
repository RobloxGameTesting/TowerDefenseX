local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("WaveTypes"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("RewindProducts"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
return {
	DisplayName = "Slime Event Nightmare",
	PlayerCountToStartingCashMap = { 3000, 2400, 2100, 1900 },
	CashPerDamageData = {
		{ CashPerDamage = 1, CashPerDamageShared = 0 },
		{ CashPerDamage = 1, CashPerDamageShared = 0.6 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.3 },
		{ CashPerDamage = 0.8, CashPerDamageShared = 0.2 }
	},
	IntervalRewardData = {
		{ WaveNumber = 1, GoldReward = 5 },
		{ WaveNumber = 3, GoldReward = 15 },
		{ WaveNumber = 5, GoldReward = 50 },
		{ WaveNumber = 8, GoldReward = 100 },
		{ WaveNumber = 10, GoldReward = 300 },
		{ WaveNumber = 16, GoldReward = 500 },
		{ WaveNumber = 18, GoldReward = 800 },
		{ WaveNumber = 20, GoldReward = 1200 },
		{ WaveNumber = 24, GoldReward = 1750 },
		{ WaveNumber = 25, GoldReward = 2400 },
		{ WaveNumber = 29, GoldReward = 750 },
		{ WaveNumber = 30, GoldReward = 1000 },
		{ WaveNumber = 31, GoldReward = 1200 },
		{ WaveNumber = 35, GoldReward = 1800 }
	},
	RewindProductIntervalMap = {
		{ WaveNumber = 100, CostGold = 0, GainCash = 0, GainHP = 0 }
	},
	DefaultXPPerWavePassed = 135,
	StartingLives = 1000,
	SetUpTime = 15,
	PowerUpsDisabled = true,
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
					Enums.Towers.John,
					Enums.Towers.GoldenRanger,
					Enums.Towers.Juggernaut,
					Enums.Towers.Grenadier,
					Enums.Towers.JetTrooper,
					Enums.Towers.LaserGunner
				}
			},
			{
				Title = Lang.Strings.Game.LoadoutSelectionTitles.Support,
				Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
				IconId = "rbxassetid://112662075132649",
				VIPOnly = false,
				Towers = {
					Enums.Towers.LaserGunner,
					Enums.Towers.Zed,
					Enums.Towers.Medic,
					Enums.Towers.GoldenMineLayer,
					Enums.Towers.John,
					Enums.Towers.JetTrooper
				}
			},
			{
				Title = Lang.Strings.Game.LoadoutSelectionTitles.HeavyWeapons,
				Description = Lang.Strings.Game.LoadoutSelectionDescriptions.Empty,
				IconId = "rbxassetid://107079411064021",
				VIPOnly = false,
				Towers = {
					Enums.Towers.Artillery,
					Enums.Towers.GoldenJuggernaut,
					Enums.Towers.MachineGunner,
					Enums.Towers.John,
					Enums.Towers.Railgunner,
					Enums.Towers.Slammer
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
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 30,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 800,
			CustomWaveTime = 25,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 50,
					Interval = 0.4
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 3,
					Interval = 2.75
				}
			}
		},
		{
			CashBonus = 900,
			CustomWaveTime = 35,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 40,
					Interval = 0.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 3,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 4
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.25,
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
					AdditionalShieldMultiplier = 0.15,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 7,
					Interval = 1.1
				},
				{
					StartDelay = 9,
					EnemyType = Enums.Enemies.SlimeMob,
					AdditionalShieldMultiplier = 0.4,
					Count = 1,
					Interval = 1.1
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					Count = 30,
					AdditionalShieldMultiplier = 0.5,
					AdditionalSpeedBoostMultiplier = 0.25,
					Interval = 0.8
				}
			}
		},
		{
			CashBonus = 1150,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalShieldMultiplier = 0.35,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 50,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 1225,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeMob,
					Count = 4,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.15,
					Interval = 3
				},
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier2, Count = 3, Interval = 3 }
			}
		},
		{
			CashBonus = 1350,
			CashMultiplierOverride = 0.9,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 0.4,
					Count = 7,
					Interval = 0.9
				},
				{
					StartDelay = 10,
					AdditionalSpeedBoostMultiplier = 0.25,
					AdditionalShieldMultiplier = 1,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 7,
					Interval = 0.15
				}
			}
		},
		{
			CashBonus = 1450,
			SpawnSequences = {
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeBloat,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 2,
					Interval = 7
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.Multiplier2,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 1,
					Interval = 7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 0.4,
					Count = 3,
					Interval = 1.1
				}
			}
		},
		{
			CashBonus = 1650,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeMob,
					Count = 10,
					AdditionalSpeedBoostMultiplier = 0.15,
					Interval = 2.7
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Multiplier2,
					Count = 10,
					Interval = 2.7
				}
			}
		},
		{
			CashBonus = 1850,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0.2,
					EnemyType = Enums.Enemies.SlimeBloat,
					AdditionalShieldMultiplier = 0.25,
					AdditionalSpeedBoostMultiplier = 0.1,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 8,
					EnemyType = Enums.Enemies.SlimeWizard,
					Count = 1,
					AdditionalShieldMultiplier = 0.1,
					Interval = 2.5
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeMob,
					Count = 100,
					AdditionalShieldMultiplier = 0.2,
					AdditionalSpeedBoostMultiplier = 0.15,
					Interval = 0.25
				}
			}
		},
		{
			CashBonus = 2150,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 1,
					AdditionalShieldMultiplier = 0.5,
					Interval = 1
				},
				{ StartDelay = 4, EnemyType = Enums.Enemies.SlimeWizard, Count = 4, Interval = 2 }
			}
		},
		{
			CashBonus = 2850,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalShieldMultiplier = 1,
					Stealth = true,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.SlimeBloat,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 2,
					Stealth = true,
					Interval = 3
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 10,
					Stealth = true,
					Interval = 0.5
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 1,
					Stealth = true,
					AdditionalSpeedBoostMultiplier = 0.5,
					Count = 3,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 3250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 8,
					Interval = 0.7
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeSoldier,
					AdditionalShieldMultiplier = 3,
					Count = 5,
					Interval = 0.4
				},
				{
					StartDelay = 5,
					EnemyType = Enums.Enemies.MagmaSlime,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 4,
					Interval = 5
				},
				{
					StartDelay = 11,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 6,
					AdditionalShieldMultiplier = 2,
					Interval = 0.4
				},
				{
					StartDelay = 16,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 6,
					AdditionalShieldMultiplier = 2,
					Interval = 0.4
				},
				{
					StartDelay = 20,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 7,
					AdditionalShieldMultiplier = 2,
					Interval = 0.4
				},
				{
					StartDelay = 24,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 9,
					AdditionalShieldMultiplier = 2,
					Interval = 0.4
				},
				{
					StartDelay = 27,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 12,
					AdditionalShieldMultiplier = 2,
					Interval = 0.4
				}
			}
		},
		{
			CashBonus = 3500,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Stealth = true,
					Count = 7,
					Interval = 2
				},
				{
					StartDelay = 7,
					EnemyType = Enums.Enemies.SlimeBrute,
					AdditionalShieldMultiplier = 1,
					Stealth = true,
					Count = 1,
					Interval = 0.3
				}
			}
		},
		{
			CashBonus = 4000,
			CustomWaveTime = 90,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					Count = 200,
					AdditionalSpeedBoostMultiplier = 1,
					AdditionalHealthMultiplier = 11,
					AdditionalShieldMultiplier = 4.5,
					Interval = 0.15
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.MagmaSlime,
					Count = 7,
					AdditionalSpeedBoostMultiplier = 0.3,
					Interval = 4
				}
			}
		},
		{
			CashBonus = 10000,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.Multiplier3, Count = 3, Interval = 3 },
				{ StartDelay = 12, EnemyType = Enums.Enemies.Multiplier3, Count = 1, Interval = 3 },
				{
					StartDelay = 12,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalSpeedBoostMultiplier = 0.25,
					Stealth = true,
					Count = 1,
					Interval = 0
				}
			}
		},
		{
			CashBonus = 120000,
			CustomWaveTime = 500,
			CashMultiplierOverride = 1.65,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.SlimeCaptain1, Count = 1, Interval = 3 },
				{
					StartDelay = 2,
					EnemyType = Enums.Enemies.SlimeWizard,
					AdditionalShieldMultiplier = 0.7,
					Count = 24,
					Interval = 2
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.CorruptedPredator,
					AdditionalShieldMultiplier = 0.5,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.PlagueDoctor,
					Stealth = true,
					AdditionalShieldMultiplier = 1,
					Count = 1,
					Interval = 3
				},
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalShieldMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 2,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 7500,
			CashMultiplierOverride = 0.8,
			CustomWaveTime = 100,
			SpawnSequences = {
				{ StartDelay = 1, EnemyType = Enums.Enemies.MegaSlime, Count = 1, Interval = 14 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.TBSlimeBoss,
					AdditionalShieldMultiplier = 4,
					AdditionalHealthMultiplier = 2,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 45,
					Interval = 0.7
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
					AdditionalShieldMultiplier = 2,
					Interval = 0.8
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.65,
					Count = 15,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 8250,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeGolem,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 3,
					Interval = 5
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.SlimeWizard,
					AdditionalShieldMultiplier = 2,
					AdditionalHealthMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.3,
					Count = 3,
					Interval = 1
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.MinionSlime,
					AdditionalShieldMultiplier = 3,
					AdditionalHealthMultiplier = 40,
					Count = 70,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 8500,
			CustomWaveTime = 100,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.MagmaSlime,
					AdditionalShieldMultiplier = 1,
					AdditionalSpeedBoostMultiplier = 0.2,
					Count = 7,
					Interval = 0.7
				},
				{
					StartDelay = 6,
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 1,
					AdditionalShieldMultiplier = 40,
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalHealthMultiplier = 20,
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
					AdditionalSpeedBoostMultiplier = 0.2,
					AdditionalShieldMultiplier = 0.4,
					Count = 50,
					Interval = 1.3
				},
				{
					StartDelay = 10,
					EnemyType = Enums.Enemies.Multiplier2,
					AdditionalSpeedBoostMultiplier = 0.35,
					Count = 3,
					Interval = 10
				},
				{
					StartDelay = 3,
					EnemyType = Enums.Enemies.SlimeAbsorber,
					AdditionalSpeedBoostMultiplier = 0.35,
					AdditionalShieldMultiplier = 2,
					Count = 50,
					Interval = 0.6
				}
			}
		},
		{
			CashBonus = 9000,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					AdditionalShieldMultiplier = 2,
					Count = 24,
					Interval = 0.5
				}
			}
		},
		{
			CashBonus = 10000,
			CustomWaveTime = 120,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.Slime,
					AdditionalShieldMultiplier = 1.5,
					AdditionalHealthMultiplier = 10000,
					AdditionalSpeedBoostMultiplier = 0.25,
					Count = 1,
					Interval = 0.7
				}
			}
		},
		{
			CashBonus = 100000,
			CashMultiplierOverride = 0.95,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MegaSlime, Count = 1, Interval = 6 },
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.SlimeCharger,
					Count = 75,
					AdditionalShieldMultiplier = 0.75,
					Interval = 0.7
				},
				{
					StartDelay = 30,
					EnemyType = Enums.Enemies.NightmareSlimeKing,
					Count = 1,
					Interval = 1.5
				},
				{
					StartDelay = 33,
					EnemyType = Enums.Enemies.RevivedPlagueDoctorRework,
					Count = 1,
					Interval = 1.5
				}
			}
		}
	}
}