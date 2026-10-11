local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
require(TDX_Shared:WaitForChild("Modules").Shared)
require(TDX_Shared:WaitForChild("Common").Types)
local Enums = require(TDX_Shared:WaitForChild("Common").Enums)
NumberRange.new(0, 1e999)
local numberRange = NumberRange.new(0, 29)
local numberRange2 = NumberRange.new(30, 59)
local numberRange3 = NumberRange.new(60, 89)
local numberRange4 = NumberRange.new(90, 1e999)
local numberRange5 = NumberRange.new(-1, -1)
return {
	WinEasyMode3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Easy,
		GoldReward = 400,
		XPReward = 800,
		LevelRequirement = numberRange
	},
	Deal200kDamage = {
		QuestType = "Damage",
		ProgressRequired = 200000,
		GoldReward = 225,
		XPReward = 225,
		LevelRequirement = numberRange
	},
	Deal150kDamageWithRanger = {
		QuestType = "DamageWithTower",
		ProgressRequired = 150000,
		Identifier = Enums.Towers.Ranger,
		GoldReward = 175,
		XPReward = 200,
		LevelRequirement = numberRange
	},
	Deal150kDamageWithMissileTrooper = {
		QuestType = "DamageWithTower",
		ProgressRequired = 150000,
		Identifier = Enums.Towers.MissileTrooper,
		GoldReward = 175,
		XPReward = 200,
		LevelRequirement = numberRange
	},
	Deal125kDamageWithShotgunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 125000,
		Identifier = Enums.Towers.Shotgunner,
		GoldReward = 175,
		XPReward = 200,
		LevelRequirement = numberRange
	},
	BeatEasyMapsTwoTimes = {
		QuestType = "WinsOnMapDifficulties",
		ProgressRequired = 2,
		Identifier = Enums.MapDifficulties.Easy,
		GoldReward = 350,
		XPReward = 500,
		LevelRequirement = numberRange
	},
	BeatNormalMapsTwoTimes = {
		QuestType = "WinsOnMapDifficulties",
		ProgressRequired = 2,
		Identifier = Enums.MapDifficulties.Normal,
		GoldReward = 425,
		XPReward = 500,
		LevelRequirement = numberRange
	},
	BeatSimpleMapsTwoTimes = {
		QuestType = "WinsOnMapDifficulties",
		ProgressRequired = 2,
		Identifier = Enums.MapDifficulties.Simple,
		GoldReward = 300,
		XPReward = 350,
		LevelRequirement = numberRange
	},
	Use200TowerAbilities = {
		QuestType = "TowerAbilities",
		ProgressRequired = 200,
		GoldReward = 325,
		XPReward = 200,
		LevelRequirement = numberRange
	},
	Kill500Enemies = {
		QuestType = "Kills",
		ProgressRequired = 500,
		GoldReward = 225,
		XPReward = 250,
		LevelRequirement = numberRange
	},
	Upgrade40RangersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 40,
		Identifier = `{Enums.Towers.Ranger}_1`,
		GoldReward = 250,
		XPReward = 250,
		LevelRequirement = numberRange
	},
	Upgrade40MissileTroopersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 40,
		Identifier = `{Enums.Towers.MissileTrooper}_1`,
		GoldReward = 250,
		XPReward = 250,
		LevelRequirement = numberRange
	},
	WinIntermediateMode3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Intermediate,
		GoldReward = 650,
		XPReward = 1250,
		LevelRequirement = numberRange2
	},
	Deal500kDamage = {
		QuestType = "Damage",
		ProgressRequired = 500000,
		GoldReward = 300,
		XPReward = 800,
		LevelRequirement = numberRange2
	},
	Deal250kDamageWithOperator = {
		QuestType = "DamageWithTower",
		ProgressRequired = 250000,
		Identifier = Enums.Towers.Operator,
		GoldReward = 250,
		XPReward = 375,
		LevelRequirement = numberRange2
	},
	Deal325kDamageWithMissileTrooper = {
		QuestType = "DamageWithTower",
		ProgressRequired = 325000,
		Identifier = Enums.Towers.MissileTrooper,
		GoldReward = 275,
		XPReward = 400,
		LevelRequirement = numberRange2
	},
	Deal150kDamageWithGrenadier = {
		QuestType = "DamageWithTower",
		ProgressRequired = 150000,
		Identifier = Enums.Towers.Grenadier,
		GoldReward = 200,
		XPReward = 275,
		LevelRequirement = numberRange2
	},
	Win3EasyMapsOnIntermediate = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 3,
		Identifier = `{Enums.MapDifficulties.Easy}_{Enums.Difficulties.Intermediate}`,
		GoldReward = 400,
		XPReward = 1000,
		LevelRequirement = numberRange2
	},
	Win2NormalMapsOnIntermediate = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 2,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Intermediate}`,
		GoldReward = 350,
		XPReward = 850,
		LevelRequirement = numberRange2
	},
	Win2SimpleMapsOnIntermediate = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 2,
		Identifier = `{Enums.MapDifficulties.Simple}_{Enums.Difficulties.Intermediate}`,
		GoldReward = 300,
		XPReward = 650,
		LevelRequirement = numberRange2
	},
	WinFiveGames = {
		QuestType = "Wins",
		ProgressRequired = 5,
		GoldReward = 325,
		XPReward = 700,
		LevelRequirement = numberRange2
	},
	Kill777Enemies = {
		QuestType = "Kills",
		ProgressRequired = 777,
		GoldReward = 275,
		XPReward = 300,
		LevelRequirement = numberRange2
	},
	Win1HardMapOnEasy = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Hard}_{Enums.Difficulties.Easy}`,
		GoldReward = 375,
		XPReward = 700,
		LevelRequirement = numberRange2
	},
	Deal100kDamageWithBarracks = {
		QuestType = "DamageWithTower",
		ProgressRequired = 100000,
		Identifier = Enums.Towers.Barracks,
		GoldReward = 175,
		XPReward = 300,
		LevelRequirement = numberRange2
	},
	Deal150kDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 150000,
		Identifier = Enums.Towers.John,
		GoldReward = 200,
		XPReward = 300,
		LevelRequirement = numberRange2
	},
	Upgrade50OperatorsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 50,
		Identifier = `{Enums.Towers.Operator}_1`,
		GoldReward = 275,
		XPReward = 275,
		LevelRequirement = numberRange2
	},
	Upgrade50MissileTroopersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 50,
		Identifier = `{Enums.Towers.MissileTrooper}_1`,
		GoldReward = 275,
		XPReward = 275,
		LevelRequirement = numberRange2
	},
	Upgrade20GrenadiersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Grenadier}_1`,
		GoldReward = 250,
		XPReward = 250,
		LevelRequirement = numberRange2
	},
	UseOperatorHumveeAbility15Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 15,
		Identifier = `{Enums.Towers.Operator}_SpawnHumvee`,
		GoldReward = 200,
		XPReward = 250,
		LevelRequirement = numberRange2
	},
	UseJohnAxeAbility5Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 5,
		Identifier = `{Enums.Towers.John}_JohnAxeAttack`,
		GoldReward = 175,
		XPReward = 200,
		LevelRequirement = numberRange2
	},
	UseJohnRageAbility12Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 12,
		Identifier = `{Enums.Towers.John}_JohnRageMode`,
		GoldReward = 200,
		XPReward = 250,
		LevelRequirement = numberRange2
	},
	WinEliteMode2Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 2,
		Identifier = Enums.Difficulties.Elite,
		GoldReward = 700,
		XPReward = 1500,
		LevelRequirement = numberRange3
	},
	Deal1MTotalDamage = {
		QuestType = "Damage",
		ProgressRequired = 1000000,
		GoldReward = 400,
		XPReward = 1000,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithLaserGunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.LaserGunner,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithGrenadier = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.Grenadier,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithPatrolBoat = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.PatrolBoat,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.John,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithSentry = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.Sentry,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithJuggernaut = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.Juggernaut,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithRailgunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.Railgunner,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Deal300kDamageWithMobster = {
		QuestType = "DamageWithTower",
		ProgressRequired = 300000,
		Identifier = Enums.Towers.Mobster,
		GoldReward = 300,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Win3NormalMapsOnElite = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 3,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Elite}`,
		GoldReward = 700,
		XPReward = 1500,
		LevelRequirement = numberRange3
	},
	WinEliteOnHardMap = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Hard}_{Enums.Difficulties.Elite}`,
		GoldReward = 500,
		XPReward = 1000,
		LevelRequirement = numberRange3
	},
	WinEasyOnImpossibleMap = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Impossible}_{Enums.Difficulties.Easy}`,
		GoldReward = 450,
		XPReward = 800,
		LevelRequirement = numberRange3
	},
	UseMobsterBountyAbility15Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 15,
		Identifier = `{Enums.Towers.Mobster}_Place Bounty`,
		GoldReward = 400,
		XPReward = 700,
		LevelRequirement = numberRange3
	},
	UseLaserGunnerShockRoundAbility15Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 15,
		Identifier = `{Enums.Towers.LaserGunner}_LaserGunnerShockRounds`,
		GoldReward = 400,
		XPReward = 700,
		LevelRequirement = numberRange3
	},
	UseJohnAxeAbility15Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 15,
		Identifier = `{Enums.Towers.John}_JohnAxeAttack`,
		GoldReward = 400,
		XPReward = 700,
		LevelRequirement = numberRange3
	},
	Upgrade20EDJsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.EDJ}_2`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade40JuggernautsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 40,
		Identifier = `{Enums.Towers.Juggernaut}_1`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade25JuggernautsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 25,
		Identifier = `{Enums.Towers.Juggernaut}_2`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade20JohnsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.John}_2`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade10FarmsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.Farm}_2`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade50SentriesTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 50,
		Identifier = `{Enums.Towers.Sentry}_1`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Kill2000Enemies = {
		QuestType = "Kills",
		ProgressRequired = 2000,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange3
	},
	Win3SimpleMapsOnElite = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 3,
		Identifier = `{Enums.MapDifficulties.Simple}_{Enums.Difficulties.Elite}`,
		GoldReward = 650,
		XPReward = 1200,
		LevelRequirement = numberRange3
	},
	Win1ExpertGame = {
		QuestType = "WinsOnMode",
		ProgressRequired = 1,
		Identifier = Enums.Difficulties.Expert,
		GoldReward = 750,
		XPReward = 1750,
		LevelRequirement = numberRange3
	},
	DefeatDestructor2Times = {
		QuestType = "BossKills",
		ProgressRequired = 2,
		Identifier = Enums.Enemies.Destructor,
		GoldReward = 600,
		XPReward = 1000,
		LevelRequirement = numberRange3
	},
	PassWave30OnExpert2Times = {
		QuestType = "PassWaveOnMode",
		ProgressRequired = 2,
		Identifier = `{Enums.Difficulties.Expert}_30`,
		GoldReward = 400,
		XPReward = 700,
		LevelRequirement = numberRange3
	},
	KillVXDrone3Times = {
		QuestType = "BossKills",
		ProgressRequired = 3,
		Identifier = Enums.Enemies.VXDrone,
		GoldReward = 500,
		XPReward = 800,
		LevelRequirement = numberRange3
	},
	Upgrade20RailgunnersTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Railgunner}_2`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade10RailgunnersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.Railgunner}_1`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	Upgrade15MobstersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 15,
		Identifier = `{Enums.Towers.Mobster}_1`,
		GoldReward = 325,
		XPReward = 400,
		LevelRequirement = numberRange3
	},
	PassWave80OnEndlessEasyMap = {
		QuestType = "PassWaveOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Easy}_{Enums.Difficulties.Endless}_80`,
		CrystalsReward = 60,
		XPReward = 7500,
		LevelRequirement = numberRange4
	},
	WinElite3TimesOnNormalMaps = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 3,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Elite}`,
		CrystalsReward = 20,
		XPReward = 3250,
		LevelRequirement = numberRange4
	},
	WinExpertTwiceOnEasyMaps = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 2,
		Identifier = `{Enums.MapDifficulties.Easy}_{Enums.Difficulties.Expert}`,
		CrystalsReward = 25,
		XPReward = 3000,
		LevelRequirement = numberRange4
	},
	DefeatEradicatorMKIVTwice = {
		QuestType = "BossKills",
		ProgressRequired = 2,
		Identifier = Enums.Enemies.EradicatorMK4,
		CrystalsReward = 25,
		XPReward = 2000,
		LevelRequirement = numberRange4
	},
	DefeatEradicatorMKICTwice = {
		QuestType = "BossKills",
		ProgressRequired = 2,
		Identifier = Enums.Enemies.EradicatorMKIC,
		CrystalsReward = 35,
		XPReward = 2500,
		LevelRequirement = numberRange4
	},
	DefeatApexPredatorTwice = {
		QuestType = "BossKills",
		ProgressRequired = 2,
		Identifier = Enums.Enemies.ApexPredator,
		CrystalsReward = 50,
		XPReward = 3000,
		LevelRequirement = numberRange4
	},
	WinExpertTwiceOnNormalMaps = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 2,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Expert}`,
		CrystalsReward = 35,
		XPReward = 2500,
		LevelRequirement = numberRange4
	},
	WinEliteOnceOnHardMap = {
		QuestType = "WinsOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Hard}_{Enums.Difficulties.Elite}`,
		CrystalsReward = 16,
		XPReward = 1500,
		LevelRequirement = numberRange4
	},
	Deal2MTotalDamage = {
		QuestType = "Damage",
		ProgressRequired = 2000000,
		CrystalsReward = 15,
		XPReward = 1100,
		LevelRequirement = numberRange4
	},
	PassWave80OnEndlessSimpleMap = {
		QuestType = "PassWaveOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Simple}_{Enums.Difficulties.Endless}_80`,
		CrystalsReward = 25,
		XPReward = 1800,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithJuggernaut = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.Juggernaut,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithJohn = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.John,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithXWM = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.XWMTurret,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal500kDamageWithSlammer = {
		QuestType = "DamageWithTower",
		ProgressRequired = 500000,
		Identifier = Enums.Towers.Slammer,
		CrystalsReward = 10,
		XPReward = 625,
		LevelRequirement = numberRange4
	},
	Kill4000Enemies = {
		QuestType = "Kills",
		ProgressRequired = 4000,
		CrystalsReward = 10,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithSentry = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.Sentry,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithArtillery = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.Artillery,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal650kDamageWithAATurret = {
		QuestType = "DamageWithTower",
		ProgressRequired = 650000,
		Identifier = Enums.Towers.AATurret,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithMachineGunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.MachineGunner,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithGhost = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.Ghost,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithGoldenRanger = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.GoldenRanger,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithArmoredFactory = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.ArmoredFactory,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithGoldenJuggernaut = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.GoldenJuggernaut,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithRailgunner = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.Railgunner,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithGoldenMineLayer = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.GoldenMineLayer,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Deal1MDamageWithPatrolBoat = {
		QuestType = "DamageWithTower",
		ProgressRequired = 1000000,
		Identifier = Enums.Towers.PatrolBoat,
		CrystalsReward = 11,
		XPReward = 725,
		LevelRequirement = numberRange4
	},
	Upgrade20GoldenJuggernautsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.GoldenJuggernaut}_1`,
		CrystalsReward = 10,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade30GoldenRangersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 30,
		Identifier = `{Enums.Towers.GoldenRanger}_1`,
		GoldReward = 375,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade20SlammersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Slammer}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade20MedicsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Medic}_1`,
		GoldReward = 350,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	Upgrade16HelicoptersTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 16,
		Identifier = `{Enums.Towers.Helicopter}_2`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade16AATurretsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 16,
		Identifier = `{Enums.Towers.AATurret}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade16ArtilleriesTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 16,
		Identifier = `{Enums.Towers.Artillery}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade22ArtilleriesTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 22,
		Identifier = `{Enums.Towers.Artillery}_2`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade20SlammersTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Slammer}_2`,
		GoldReward = 350,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	Upgrade10ToxicnatorsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.Toxicnator}_2`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	Upgrade20XWMsTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.XWMTurret}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade12XWMsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 12,
		Identifier = `{Enums.Towers.XWMTurret}_2`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade40RailgunnersTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 40,
		Identifier = `{Enums.Towers.Railgunner}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade20ArmoredFactoriesTo5_2 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.ArmoredFactory}_1`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade30RailgunnersTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 30,
		Identifier = `{Enums.Towers.Railgunner}_2`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	Upgrade10MedicsTo2_5 = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.Medic}_2`,
		GoldReward = 350,
		XPReward = 600,
		LevelRequirement = numberRange4
	},
	UseGoldenJuggernautReboot20Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.GoldenJuggernaut}_RebootSystems`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	UseGoldenMineLayerSMine35Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 35,
		Identifier = `{Enums.Towers.GoldenMineLayer}_Hand Throw`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	UseGoldenRangerGrenade25Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 25,
		Identifier = `{Enums.Towers.GoldenRanger}_Golden Ranger Grenade`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	WinEasyModePublic3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Easy,
		CrystalsReward = 28,
		XPReward = 2800,
		LevelRequirement = numberRange4
	},
	WinIntermediateModePublic3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Intermediate,
		CrystalsReward = 40,
		XPReward = 4250,
		LevelRequirement = numberRange4
	},
	WinEliteModePublic3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Elite,
		CrystalsReward = 49,
		XPReward = 5000,
		LevelRequirement = numberRange4
	},
	WinExpertModePublic3Times = {
		QuestType = "WinsOnMode",
		ProgressRequired = 3,
		Identifier = Enums.Difficulties.Expert,
		CrystalsReward = 65,
		XPReward = 10000,
		LevelRequirement = numberRange4
	},
	PassWave80OnEndlessNormalMap = {
		QuestType = "PassWaveOnMapDifficultyAndMode",
		ProgressRequired = 1,
		Identifier = `{Enums.MapDifficulties.Normal}_{Enums.Difficulties.Endless}_80`,
		CrystalsReward = 80,
		XPReward = 8000,
		LevelRequirement = numberRange4
	},
	Deal200kDamageWithCryoBlaster = {
		QuestType = "DamageWithTower",
		ProgressRequired = 200000,
		Identifier = Enums.Towers.CryoBlaster,
		GoldReward = 300,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	UseMobsterBounty20Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Mobster}_Place Bounty`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	UseSlammerSlam20Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 20,
		Identifier = `{Enums.Towers.Slammer}_Grand Slam`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange4
	},
	UseEDJEncore10Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.EDJ}_Encore`,
		GoldReward = 325,
		XPReward = 500,
		LevelRequirement = numberRange5
	},
	UseEDJAbility12Times = {
		QuestType = "SpecificTowerAbilities",
		ProgressRequired = 12,
		Identifier = `{Enums.Towers.EDJ}_Encore`,
		GoldReward = 400,
		XPReward = 700,
		LevelRequirement = numberRange5
	},
	PlayTheTutorial = {
		QuestType = "WinsOnMode",
		ProgressRequired = 1,
		Identifier = Enums.Difficulties.Tutorial,
		GoldReward = 1000,
		XPReward = 4000,
		LevelRequirement = numberRange5
	},
	WinChristmas25Part1Twice = {
		QuestType = "WinsOnMode",
		ProgressRequired = 2,
		Identifier = Enums.Difficulties.Christmas25Part1,
		CookiesReward = 6,
		XPReward = 500,
		LevelRequirement = numberRange5
	},
	WinChristmas25Part1NightmareTwice = {
		QuestType = "WinsOnMode",
		ProgressRequired = 2,
		Identifier = Enums.Difficulties.Christmas25Part1Nightmare,
		CookiesReward = 10,
		XPReward = 1000,
		LevelRequirement = numberRange5
	},
	WinChristmas25Part2Twice = {
		QuestType = "WinsOnMode",
		ProgressRequired = 2,
		Identifier = Enums.Difficulties.Christmas25Part2,
		CookiesReward = 8,
		XPReward = 500,
		LevelRequirement = numberRange5
	},
	WinChristmas25Part2NightmareTwice = {
		QuestType = "WinsOnMode",
		ProgressRequired = 2,
		Identifier = Enums.Difficulties.Christmas25Part2Nightmare,
		CookiesReward = 12,
		XPReward = 1000,
		LevelRequirement = numberRange5
	},
	Deal200kDamageWithCryoMortar = {
		QuestType = "DamageWithTower",
		ProgressRequired = 200000,
		Identifier = Enums.Towers.CryoMortar,
		CookiesReward = 3,
		XPReward = 300,
		LevelRequirement = numberRange5
	},
	Upgrade10CryoMortarsToMax = {
		QuestType = "LevelTowersToMax",
		ProgressRequired = 10,
		Identifier = `{Enums.Towers.CryoMortar}_1`,
		CookiesReward = 3,
		XPReward = 500,
		LevelRequirement = numberRange5
	}
}