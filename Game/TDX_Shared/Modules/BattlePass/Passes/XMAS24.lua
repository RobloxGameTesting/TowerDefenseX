local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(ReplicatedStorage.TDX_Shared.Common.Types)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.XMAS24,
	CardImage = 101507254512201,
	FrameImage = 122402358665019,
	BackgroundImage = 127160883914708,
	Colors = {
		Primary = Color3.fromRGB(173, 47, 38),
		Secondary = Color3.fromRGB(219, 59, 47),
		Tertiary = Color3.fromRGB(68, 102, 68),
		Tier = Color3.fromRGB(121, 182, 121)
	},
	UnlockProductInfo = { ProductId = 3294045229, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1738346400,
	Tiers = {
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Shotgunner.Name,
			Image = "rbxassetid://78459515067936",
			TokensNeeded = 450,
			SkipProductId = 2677010321,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Skin", Name = "Shotgunner_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CryoBlast,
			Image = "rbxassetid://86077305831253",
			TokensNeeded = 500,
			SkipProductId = 2677010400,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CryoBlast, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Missile Trooper"].Name,
			Image = "rbxassetid://127083841604390",
			TokensNeeded = 850,
			SkipProductId = 2677010468,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "Skin", Name = "Missile Trooper_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 600,
			SkipProductId = 2677010527,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "Gold", Amount = 1500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Sentry.Name,
			Image = "rbxassetid://90053065795039",
			TokensNeeded = 925,
			SkipProductId = 2677010607,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Skin", Name = "Sentry_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24HotChocolate,
			Image = "rbxassetid://80644067381180",
			TokensNeeded = 825,
			SkipProductId = 2677010688,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Emote", Name = "Hot Chocolate" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CryoBlast,
			Image = "rbxassetid://86077305831253",
			TokensNeeded = 1175,
			SkipProductId = 2677010788,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CryoBlast, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 1000,
			SkipProductId = 2677010870,
			SkipProductDisplayPrice = 325,
			Prize = { Type = "Gold", Amount = 2500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.John.Name,
			Image = "rbxassetid://102627813835248",
			TokensNeeded = 1000,
			SkipProductId = 2677010955,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "John_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 1250,
			SkipProductId = 2677011092,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "XP", Amount = 15000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Golden Ranger"].Name,
			Image = "rbxassetid://78021077682658",
			TokensNeeded = 1000,
			SkipProductId = 2677011187,
			SkipProductDisplayPrice = 500,
			Prize = { Type = "Skin", Name = "Golden Ranger_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24EradicatorToy,
			Image = "rbxassetid://90959400221039",
			TokensNeeded = 1250,
			SkipProductId = 2677011248,
			SkipProductDisplayPrice = 525,
			Prize = { Type = "Emote", Name = "Eradicator Toy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["XWM Turret"].Name,
			Image = "rbxassetid://136772044548245",
			TokensNeeded = 1400,
			SkipProductId = 2677011346,
			SkipProductDisplayPrice = 750,
			Prize = { Type = "Skin", Name = "XWM Turret_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CryoBlast,
			Image = "rbxassetid://86077305831253",
			TokensNeeded = 1675,
			SkipProductId = 2677011475,
			SkipProductDisplayPrice = 550,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CryoBlast, Amount = 10 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Ghost.Name,
			Image = "rbxassetid://89695247405045",
			TokensNeeded = 1400,
			SkipProductId = 2677011545,
			SkipProductDisplayPrice = 1000,
			Prize = { Type = "Skin", Name = "Ghost_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 1375,
			SkipProductId = 2677011637,
			SkipProductDisplayPrice = 750,
			Prize = { Type = "Gold", Amount = 4000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CryoBlast,
			Image = "rbxassetid://86077305831253",
			TokensNeeded = 3000,
			OriginalTokensNeeded = 25000,
			SkipProductId = 2677012114,
			SkipProductDisplayPrice = 2400,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CryoBlast, Amount = 15 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MOAB,
			Image = "rbxassetid://129018894210944",
			TokensNeeded = 2500,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MOAB, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 8250,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "XP", Amount = 25000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = "rbxassetid://111184498286499",
			TokensNeeded = 20000,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.NuclearMissile, Amount = 3 }
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