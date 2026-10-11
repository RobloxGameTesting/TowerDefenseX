local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.TB,
	CardImage = 111907797664851,
	FrameImage = 120387415836264,
	Colors = {
		Primary = Color3.fromRGB(101, 135, 20),
		Secondary = Color3.fromRGB(180, 255, 0),
		Tertiary = Color3.fromRGB(100, 164, 100),
		Tier = Color3.fromRGB(121, 182, 121)
	},
	UnlockProductInfo = { ProductId = 3294044524, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1727067599,
	Tiers = {
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBFragger,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Grenadier.Name,
			Image = "rbxassetid://18394254965",
			TokensNeeded = 525,
			SkipProductId = 1872723660,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Skin", Name = "Grenadier_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBFarm,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Farm.Name,
			Image = "rbxassetid://18394255422",
			TokensNeeded = 625,
			SkipProductId = 1872728892,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Skin", Name = "Farm_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBCryoGunner,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Cryo Blaster"].Name,
			Image = "rbxassetid://18394255793",
			TokensNeeded = 625,
			SkipProductId = 1872729310,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "Skin", Name = "Cryo Blaster_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBRailgunner,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Railgunner.Name,
			Image = "rbxassetid://18394251911",
			TokensNeeded = 725,
			SkipProductId = 1872729563,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Skin", Name = "Railgunner_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.StrykerRush,
			Image = "rbxassetid://18459999550",
			TokensNeeded = 450,
			SkipProductId = 1872729876,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.StrykerRush, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBRave,
			Image = "rbxassetid://18459449975",
			TokensNeeded = 1250,
			SkipProductId = 1872730137,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Emote", Name = "Rave" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.GoldenZed,
			Image = "rbxassetid://18394253506",
			TokensNeeded = 1450,
			SkipProductId = 1872730430,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.GoldenZed, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBBarracks,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Barracks.Name,
			Image = "rbxassetid://18459450647",
			TokensNeeded = 1000,
			SkipProductId = 1872730598,
			SkipProductDisplayPrice = 275,
			Prize = { Type = "Skin", Name = "Barracks_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 575,
			SkipProductId = 1872731240,
			SkipProductDisplayPrice = 300,
			Prize = { Type = "Gold", Amount = 1250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.GoldenZed,
			Image = "rbxassetid://18394253506",
			TokensNeeded = 2475,
			SkipProductId = 1872731521,
			SkipProductDisplayPrice = 325,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.GoldenZed, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBBenchRest,
			Image = "rbxassetid://18459449625",
			TokensNeeded = 1500,
			SkipProductId = 1872731833,
			SkipProductDisplayPrice = 350,
			Prize = { Type = "Emote", Name = "Bench Rest" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.StrykerRush,
			Image = "rbxassetid://18459999550",
			TokensNeeded = 1250,
			SkipProductId = 1872732070,
			SkipProductDisplayPrice = 375,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.StrykerRush, Amount = 9 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBEndbringer,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Slammer.Name,
			Image = "rbxassetid://18445793325",
			TokensNeeded = 1000,
			SkipProductId = 1872732359,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "Slammer_Endbringer" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBArmoredFactory,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Armored Factory"].Name,
			Image = "rbxassetid://18394252548",
			TokensNeeded = 1775,
			SkipProductId = 1872732677,
			SkipProductDisplayPrice = 425,
			Prize = { Type = "Skin", Name = "Armored Factory_Tower Battles" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBGoldenScout,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Golden Ranger"].Name,
			Image = "rbxassetid://18394254070",
			TokensNeeded = 1000,
			SkipProductId = 1872732979,
			SkipProductDisplayPrice = 450,
			Prize = { Type = "Skin", Name = "Golden Ranger_Golden Scout" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBRockbandDJ,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.EDJ.Name,
			Image = "rbxassetid://18445792827",
			TokensNeeded = 2475,
			SkipProductId = 1872733274,
			SkipProductDisplayPrice = 475,
			Prize = { Type = "Skin", Name = "EDJ_Rockband" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 2200,
			OriginalTokensNeeded = 2375,
			SkipProductId = 1872733502,
			SkipProductDisplayPrice = 750,
			Prize = { Type = "Gold", Amount = 2400 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBCommanderGDA,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Commander.Name,
			Image = "rbxassetid://18445793885",
			TokensNeeded = 750,
			SkipProductId = 1872733738,
			SkipProductDisplayPrice = 850,
			Prize = { Type = "Skin", Name = "Commander_GDA" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBZedGDA,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Zed.Name,
			Image = "rbxassetid://18394254551",
			TokensNeeded = 750,
			SkipProductId = 1872734388,
			SkipProductDisplayPrice = 1050,
			Prize = { Type = "Skin", Name = "Zed_GDA" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBSubstitute,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Commander.Name,
			Image = "rbxassetid://18394252218",
			TokensNeeded = 750,
			SkipProductId = 1872734668,
			SkipProductDisplayPrice = 1100,
			Prize = { Type = "Skin", Name = "Commander_Substitute" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TBLifeguard,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Commander.Name,
			Image = "rbxassetid://18394253045",
			TokensNeeded = 750,
			SkipProductId = 1872734957,
			SkipProductDisplayPrice = 800,
			Prize = { Type = "Skin", Name = "Commander_Lifeguard" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.A10Strike,
			Image = "rbxassetid://135145837577374",
			TokensNeeded = 1400,
			OriginalTokensNeeded = 5750,
			SkipProductId = 1872734084,
			SkipProductDisplayPrice = 1000,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.A10Strike, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 12500,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "XP", Amount = 50000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 45000,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "Gold", Amount = 10000 }
		}
	},
	Quests = {
		BeatEasyMode = {
			QuestType = "WinsOnMode",
			TokenReward = 300,
			ProgressRequired = 1,
			Identifier = Enums.Difficulties.Easy
		},
		BeatHardMapsThreeTimes = {
			QuestType = "WinsOnMapDifficulties",
			TokenReward = 250,
			ProgressRequired = 3,
			Identifier = Enums.MapDifficulties.Hard
		},
		DefeatPredatorTenTimes = {
			QuestType = "BossKills",
			TokenReward = 325,
			ProgressRequired = 10,
			Identifier = Enums.Enemies.Predator
		},
		WinThreeGames = { QuestType = "Wins", TokenReward = 275, ProgressRequired = 3 },
		Kill4kEnemies = { QuestType = "Kills", TokenReward = 250, ProgressRequired = 4000 },
		BeatNightOneNightmareTwice = {
			QuestType = "WinsOnMode",
			Identifier = Enums.Difficulties.HalloweenNightmarePart1,
			TokenReward = 250,
			ProgressRequired = 2
		},
		DefeatEradicatorThreeTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.Eradicator,
			TokenReward = 300,
			ProgressRequired = 3
		},
		DefeatRevivedPlagueDoctorTwoTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.RevivedPlagueDoctorRework,
			TokenReward = 300,
			ProgressRequired = 2
		},
		WinSevenGames = { QuestType = "Wins", TokenReward = 400, ProgressRequired = 7 },
		DefeatEradicatorMK2TwoTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.EradicatorMK2Rework,
			TokenReward = 300,
			ProgressRequired = 2
		},
		DefeatPlagueDoctorFourTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.PlagueDoctor,
			TokenReward = 300,
			ProgressRequired = 3
		},
		Use100TowerAbilities = {
			QuestType = "TowerAbilities",
			TokenReward = 150,
			ProgressRequired = 100
		},
		BeatImpossibleMapsThreeTimes = {
			QuestType = "WinsOnMapDifficulties",
			TokenReward = 600,
			ProgressRequired = 3,
			Identifier = Enums.MapDifficulties.Impossible
		},
		BeatEliteOnSurvival202 = {
			QuestType = "WinsOnMapAndMode",
			TokenReward = 350,
			ProgressRequired = 1,
			Identifier = `{Enums.Maps.Survival202}_{Enums.Difficulties.Elite}`
		},
		Kill2kEnemies = { QuestType = "Kills", TokenReward = 175, ProgressRequired = 2000 },
		Kill1kEnemies = { QuestType = "Kills", TokenReward = 125, ProgressRequired = 1000 },
		BeatEasyOnBaseplate = {
			QuestType = "WinsOnMapAndMode",
			TokenReward = 425,
			ProgressRequired = 1,
			Identifier = `{Enums.Maps.Baseplate}_{Enums.Difficulties.Easy}`
		}
	}
}