local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("RewindProducts"))
return {
	DisplayName = "Tutorial",
	StartingCash = 1075,
	CashPerDamageData = {
		{ CashPerDamage = 3, CashPerDamageShared = 0 }
	},
	IntervalRewardData = {
		{ WaveNumber = 8, GoldReward = 100, TokensReward = 0 }
	},
	DefaultXPPerWavePassed = 0,
	StartingLives = 300,
	SetUpTime = 5,
	WaveSkippingDisabled = true,
	PowerUpsDisabled = true,
	IsTutorial = true,
	TutorialData = {
		ActionSequences = {
			{
				WaveNumber = 1,
				Triggering = { OnWaveStart = true },
				DialogueSequence = "TutorialWave1",
				Actions = {
					{
						DisplayElementIds = { "TowerBarButton1" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 1,
						PositionData = {
							Position = createVector(-185.697, 56.185, -21.038),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerBarButton1" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 1,
						PositionData = {
							Position = createVector(-179.332, 56.093, -28.482),
							Epsilon = 1
						}
					}
				}
			},
			{
				WaveNumber = 1,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave2",
				Actions = {
					{
						CashBonus = 1350,
						DisplayElementIds = { "TowerUpgrade1" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-185.697, 56.185, -21.038),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 3, Path2Level = 0 }
					}
				}
			},
			{
				WaveNumber = 2,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave3",
				Actions = {
					{
						CashBonus = 700,
						DisplayElementIds = { "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-185.697, 56.185, -21.038),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 3, Path2Level = 2 }
					}
				}
			},
			{
				WaveNumber = 3,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave4",
				Actions = {
					{
						CashBonus = 1650,
						DisplayElementIds = { "TowerUpgrade1" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-185.697, 56.185, -21.038),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 4, Path2Level = 2 }
					}
				}
			},
			{
				WaveNumber = 4,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave5",
				Actions = {
					{
						CashBonus = 15000,
						DisplayElementIds = { "TowerBarButton1" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 1,
						PositionData = {
							Position = createVector(-185.697, 56.185, -17.715),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-185.697, 56.185, -17.715),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 2, Path2Level = 5 }
					}
				}
			},
			{
				WaveNumber = 5,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave6",
				Actions = {
					{
						CashBonus = 19750,
						DisplayElementIds = { "TowerBarButton2" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 2,
						PositionData = {
							Position = createVector(-180.598, 58.742, -7.712),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-180.598, 58.742, -7.712),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 5, Path2Level = 2 }
					}
				}
			},
			{
				WaveNumber = 6,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave7",
				Actions = {
					{
						CashBonus = 19750,
						DisplayElementIds = { "TowerBarButton2" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 2,
						PositionData = {
							Position = createVector(-180.655, 58.742, -4.246),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-180.655, 58.742, -4.246),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 5, Path2Level = 2 }
					}
				}
			},
			{
				WaveNumber = 7,
				Triggering = { OnWavePassed = true },
				Delay = 0.75,
				DialogueSequence = "TutorialWave8",
				Actions = {
					{
						CashBonus = 60000,
						DisplayElementIds = { "TowerBarButton2" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 2,
						PositionData = {
							Position = createVector(-175.289, 58.742, -8.247),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerBarButton2" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 2,
						PositionData = {
							Position = createVector(-177.471, 58.742, -4.852),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerBarButton2" },
						ForcedAction = Enums.TutorialActions.Placement,
						ForcedTowersBarIndex = 2,
						PositionData = {
							Position = createVector(-172.992, 58.742, -4.63),
							Epsilon = 1
						}
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-175.289, 58.742, -8.247),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 5, Path2Level = 2 }
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-177.471, 58.742, -4.852),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 5, Path2Level = 2 }
					},
					{
						DisplayElementIds = { "TowerUpgrade1", "TowerUpgrade2" },
						ForcedAction = Enums.TutorialActions.Upgrade,
						PositionData = {
							Position = createVector(-172.992, 58.742, -4.63),
							Epsilon = 1.01
						},
						UpgradeData = { Path1Level = 5, Path2Level = 2 }
					}
				}
			},
			{
				WaveNumber = 8,
				Triggering = { OnWaveStart = true },
				EnableFreeBuild = true,
				Actions = {}
			},
			{
				WaveNumber = 8,
				Triggering = { OnVictoryDelayStarted = true },
				DialogueSequence = "TutorialPassed",
				Actions = {}
			}
		}
	},
	PreloadDialogueName = "Tutorial",
	VictoryDelay = 30,
	VictoryBadgeIds = { 2968370383250655 },
	ForcedTowerInventory = { Enums.Towers.Ranger, Enums.Towers.MissileTrooper, "", "", "", "" },
	AmbientPlaylist = { "Tutorial1", "Tutorial2" },
	Waves = {
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.ZBot, Count = 5, Interval = 1.3 }
			}
		},
		{
			CashBonus = 0,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.ZBot,
					Count = 4,
					Stealth = true,
					Interval = 1.1
				}
			}
		},
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.ZBot, Count = 10, Interval = 0.8 },
				{ StartDelay = 4, EnemyType = Enums.Enemies.THeavy, Count = 4, Interval = 1.7 },
				{ StartDelay = 1, EnemyType = Enums.Enemies.SpeedBot, Count = 1, Interval = 0.4 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.SpeedBot, Count = 4, Interval = 0.75 }
			}
		},
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.PSmasher, Count = 1, Interval = 1 },
				{ StartDelay = 7, EnemyType = Enums.Enemies.THeavy, Count = 4, Interval = 1.7 }
			}
		},
		{
			CashBonus = 0,
			SpawnSequences = {
				{ StartDelay = 0, EnemyType = Enums.Enemies.MKIBoss, Count = 3, Interval = 3 },
				{ StartDelay = 11, EnemyType = Enums.Enemies.THeavy, Count = 6, Interval = 0.9 }
			}
		},
		{
			CashBonus = 0,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Aero, Count = 3, Interval = 6 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.THeavy, Count = 10, Interval = 3 },
				{ StartDelay = 10, EnemyType = Enums.Enemies.MKIBoss, Count = 1, Interval = 3 }
			}
		},
		{
			CashBonus = 0,
			CashPerDamage = 1.2,
			CustomWaveTime = 300,
			SpawnSequences = {
				{ StartDelay = 3, EnemyType = Enums.Enemies.Aero, Count = 2, Interval = 3 },
				{ StartDelay = 0, EnemyType = Enums.Enemies.THeavy, Count = 15, Interval = 3 },
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.SpeedBot,
					Count = 15,
					AdditionalShieldMultiplier = 5,
					Interval = 0.6
				},
				{ StartDelay = 5, EnemyType = Enums.Enemies.MKIBoss, Count = 7, Interval = 2.5 },
				{
					StartDelay = 15,
					EnemyType = Enums.Enemies.PSmasher,
					AdditionalShieldMultiplier = 2,
					Count = 1,
					Interval = 2.5
				},
				{
					StartDelay = 22,
					EnemyType = Enums.Enemies.CrushOTron9000,
					Count = 1,
					Interval = 1
				}
			}
		},
		{
			CashBonus = 0,
			CashPerDamage = 1,
			CustomWaveTime = 300,
			SpawnSequences = {
				{
					StartDelay = 0,
					EnemyType = Enums.Enemies.THeavy,
					AdditionalShieldMultiplier = 4,
					Count = 20,
					Interval = 0.7
				},
				{
					StartDelay = 1,
					EnemyType = Enums.Enemies.MKIBoss,
					AdditionalShieldMultiplier = 1,
					Count = 5,
					Interval = 1
				},
				{ StartDelay = 8, EnemyType = Enums.Enemies.Aero, Count = 5, Interval = 3.5 },
				{
					StartDelay = 14,
					EnemyType = Enums.Enemies.PSmasher,
					Count = 2,
					AdditionalShieldMultiplier = 2.5,
					Interval = 3.5
				},
				{ StartDelay = 20, EnemyType = Enums.Enemies.EradB, Count = 1, Interval = 3.5 },
				{
					StartDelay = 26,
					EnemyType = Enums.Enemies.THeavy,
					Count = 20,
					AdditionalShieldMultiplier = 2.5,
					Interval = 1
				}
			}
		}
	}
}