local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
require(TDX_Shared:WaitForChild("Modules").Shared)
require(TDX_Shared:WaitForChild("Common").Types)
local Enums = require(TDX_Shared:WaitForChild("Common").Enums)
local numberRange = NumberRange.new(0, 29)
local numberRange2 = NumberRange.new(30, 59)
local numberRange3 = NumberRange.new(60, 89)
local numberRange4 = NumberRange.new(90, 1e999)
local numberRange5 = NumberRange.new(-1, -1)
return {
	Deal1M200KDamage = {
		QuestType = "Damage",
		ProgressRequired = 1200000,
		GoldReward = 1200,
		XPReward = 3000,
		LevelRequirement = numberRange
	},
	WinEasyMode10Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 10,
		Identifier = Enums.Difficulties.Easy,
		GoldReward = 1750,
		XPReward = 4250,
		LevelRequirement = numberRange
	},
	Kill6000Enemies = {
		QuestType = "Kills",
		ProgressRequired = 6000,
		GoldReward = 1250,
		XPReward = 3500,
		LevelRequirement = numberRange
	},
	WinOnBloxOut7Times = {
		QuestType = "WinsOnMap",
		ProgressRequired = 7,
		Identifier = Enums.Maps.BloxOut,
		GoldReward = 1400,
		XPReward = 3800,
		LevelRequirement = numberRange
	},
	WinTowerBattlesPart1Normal4Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 4,
		Identifier = Enums.Difficulties.TowerBattles,
		GoldReward = 2500,
		XPReward = 5500,
		LevelRequirement = numberRange
	},
	WinHalloween24Part1Normal4Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 4,
		Identifier = Enums.Difficulties.HalloweenPart1,
		GoldReward = 2000,
		XPReward = 5000,
		LevelRequirement = numberRange
	},
	Deal5M500KDamage = {
		QuestType = "Damage",
		ProgressRequired = 5500000,
		GoldReward = 1500,
		XPReward = 6500,
		LevelRequirement = numberRange2
	},
	Kill75kEnemies = {
		QuestType = "Kills",
		ProgressRequired = 75000,
		GoldReward = 2000,
		XPReward = 6000,
		LevelRequirement = numberRange5
	},
	Kill7500Enemies = {
		QuestType = "Kills",
		ProgressRequired = 7500,
		GoldReward = 2000,
		XPReward = 6000,
		LevelRequirement = numberRange2
	},
	Kill30Predators = {
		QuestType = "BossKills",
		ProgressRequired = 30,
		Identifier = Enums.Enemies.Predator,
		GoldReward = 1925,
		XPReward = 7250,
		LevelRequirement = numberRange2
	},
	Deal2MDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 2000000,
		Identifier = Enums.Towers.John,
		GoldReward = 2000,
		XPReward = 7000,
		LevelRequirement = numberRange2
	},
	Deal3MDamageWithJuggernaut = {
		QuestType = "DamageWithTower",
		ProgressRequired = 3000000,
		Identifier = Enums.Towers.Juggernaut,
		GoldReward = 2250,
		XPReward = 7500,
		LevelRequirement = numberRange2
	},
	WinHalloween24Part2Normal6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.HalloweenPart2,
		GoldReward = 2350,
		XPReward = 8000,
		LevelRequirement = numberRange2
	},
	WinTowerBattlesPart1Normal7Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 7,
		Identifier = Enums.Difficulties.TowerBattles,
		GoldReward = 2500,
		XPReward = 10000,
		LevelRequirement = numberRange2
	},
	WinHalloween24Part3Normal6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.HalloweenPart3,
		GoldReward = 2500,
		XPReward = 8250,
		LevelRequirement = numberRange2
	},
	WinChristmas24Part1Normal6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.Christmas24Part1,
		GoldReward = 2450,
		XPReward = 8000,
		LevelRequirement = numberRange2
	},
	WinIntermediateMode9Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 9,
		Identifier = Enums.Difficulties.Intermediate,
		GoldReward = 3000,
		XPReward = 9000,
		LevelRequirement = numberRange2
	},
	Deal12MDamage = {
		QuestType = "Damage",
		ProgressRequired = 12000000,
		GoldReward = 3250,
		XPReward = 11750,
		LevelRequirement = numberRange3
	},
	Kill250kEnemies = {
		QuestType = "Kills",
		ProgressRequired = 250000,
		GoldReward = 2725,
		XPReward = 10000,
		LevelRequirement = numberRange5
	},
	Kill25kEnemies = {
		QuestType = "Kills",
		ProgressRequired = 25000,
		GoldReward = 2725,
		XPReward = 10000,
		LevelRequirement = numberRange3
	},
	WinExpertOnEasyMaps5Times = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 5,
		Identifier = `{Enums.MapDifficulties.Easy}_{Enums.Difficulties.Expert}`,
		GoldReward = 5750,
		XPReward = 15000,
		LevelRequirement = numberRange3
	},
	WinEliteOnNormalMaps4Times = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 4,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Elite}`,
		GoldReward = 4250,
		XPReward = 10000,
		LevelRequirement = numberRange3
	},
	WinChristmas24Part2Normal6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.Christmas24Part2,
		GoldReward = 4750,
		XPReward = 12000,
		LevelRequirement = numberRange3
	},
	WinHalloween24Part3Normal7Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 7,
		Identifier = Enums.Difficulties.HalloweenPart3,
		GoldReward = 5000,
		XPReward = 10000,
		LevelRequirement = numberRange3
	},
	WinIntermediateOnHardMaps8Times = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 8,
		Identifier = `{Enums.MapDifficulties.Hard}_{Enums.Difficulties.Intermediate}`,
		GoldReward = 4500,
		XPReward = 11750,
		LevelRequirement = numberRange3
	},
	Deal7MDamageWithArtillery = {
		QuestType = "DamageWithTower",
		ProgressRequired = 7000000,
		Identifier = Enums.Towers.Artillery,
		GoldReward = 3000,
		XPReward = 12000,
		LevelRequirement = numberRange3
	},
	Deal5MDamageWithRailgunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 5000000,
		Identifier = Enums.Towers.Railgunner,
		GoldReward = 2875,
		XPReward = 9500,
		LevelRequirement = numberRange3
	},
	Deal4MDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 4000000,
		Identifier = Enums.Towers.John,
		GoldReward = 2850,
		XPReward = 9000,
		LevelRequirement = numberRange3
	},
	WinHalloween24Part4Normal6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.HalloweenPart4,
		GoldReward = 6000,
		XPReward = 17500,
		LevelRequirement = numberRange3
	},
	Deal50MDamage = {
		QuestType = "Damage",
		ProgressRequired = 50000000,
		GoldReward = 3800,
		XPReward = 14000,
		LevelRequirement = numberRange4
	},
	Kill500kEnemies = {
		QuestType = "Kills",
		ProgressRequired = 500000,
		GoldReward = 5000,
		XPReward = 16000,
		LevelRequirement = numberRange5
	},
	Kill50kEnemies = {
		QuestType = "Kills",
		ProgressRequired = 50000,
		CrystalsReward = 100,
		XPReward = 16000,
		LevelRequirement = numberRange4
	},
	WinExpertOnNormalMaps6Times = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 6,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Expert}`,
		CrystalsReward = 140,
		XPReward = 22000,
		LevelRequirement = numberRange4
	},
	WinEliteOnHardMaps7Times = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 7,
		Identifier = `{Enums.MapDifficulties.Hard}_{Enums.Difficulties.Elite}`,
		CrystalsReward = 130,
		XPReward = 18000,
		LevelRequirement = numberRange4
	},
	WinTBNightmareOnBorderlands3Times = {
		QuestType = "WinsOnMapAndMode",
		ProgressRequired = 3,
		Identifier = `{Enums.Maps.Borderlands}_{Enums.Difficulties.TowerBattlesNightmare}`,
		CrystalsReward = 130,
		XPReward = 17000,
		LevelRequirement = numberRange4
	},
	WinChristmas24Part2Nightmare5Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 5,
		Identifier = Enums.Difficulties.Christmas24Part2Nightmare,
		CrystalsReward = 120,
		XPReward = 18000,
		LevelRequirement = numberRange4
	},
	WinHalloween24Part2Nightmare6Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 6,
		Identifier = Enums.Difficulties.HalloweenNightmarePart2,
		CrystalsReward = 110,
		XPReward = 15000,
		LevelRequirement = numberRange4
	},
	WinHalloween24Part3Nightmare5Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 5,
		Identifier = Enums.Difficulties.HalloweenNightmarePart3,
		CrystalsReward = 130,
		XPReward = 19750,
		LevelRequirement = numberRange4
	},
	WinHalloween24Part4Nightmare5Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 5,
		Identifier = Enums.Difficulties.HalloweenNightmarePart4,
		CrystalsReward = 150,
		XPReward = 24000,
		LevelRequirement = numberRange4
	},
	Deal10MDamageWithLaserGunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 10000000,
		Identifier = Enums.Towers.LaserGunner,
		CrystalsReward = 80,
		XPReward = 11750,
		LevelRequirement = numberRange4
	},
	Deal5MDamageWithSentry = {
		QuestType = "DamageWithTower",
		ProgressRequired = 5000000,
		Identifier = Enums.Towers.Sentry,
		GoldReward = 3750,
		XPReward = 10000,
		LevelRequirement = numberRange4
	},
	Deal5MDamageWithToxicnator = {
		QuestType = "DamageWithTower",
		ProgressRequired = 5000000,
		Identifier = Enums.Towers.Toxicnator,
		GoldReward = 3750,
		XPReward = 10000,
		LevelRequirement = numberRange4
	},
	Deal5MDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 5000000,
		Identifier = Enums.Towers.John,
		GoldReward = 3750,
		XPReward = 10000,
		LevelRequirement = numberRange4
	},
	DefeatEmperor5Times = {
		QuestType = "BossKills",
		ProgressRequired = 5,
		Identifier = Enums.Enemies.Emperor,
		CrystalsReward = 600,
		XPReward = 25000,
		LevelRequirement = numberRange4
	}
}