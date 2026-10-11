local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.HW24,
	CardImage = 131633529318983,
	FrameImage = 111198933488741,
	BackgroundImage = 114276751614747,
	Colors = {
		Primary = Color3.fromRGB(176, 70, 34),
		Secondary = Color3.fromRGB(247, 146, 30),
		Tertiary = Color3.fromRGB(247, 146, 30),
		Tier = Color3.fromRGB(255, 103, 52)
	},
	UnlockProductInfo = { ProductId = 3294044784, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1734649200,
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
	},
	Tiers = {
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Cardboard,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Ranger.Name,
			Image = "rbxassetid://117243628820445",
			TokensNeeded = 400,
			SkipProductId = 2378358354,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Skin", Name = "Ranger_Cardboard" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Cardboard,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Shotgunner.Name,
			Image = "rbxassetid://86777223550625",
			TokensNeeded = 450,
			SkipProductId = 2378374457,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Skin", Name = "Shotgunner_Cardboard" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 500,
			SkipProductId = 2378387318,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "Gold", Amount = 1000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Candy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Grenadier.Name,
			Image = "rbxassetid://103925098872828",
			TokensNeeded = 425,
			SkipProductId = 2378402983,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Skin", Name = "Grenadier_Candy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 875,
			SkipProductId = 2378419812,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "Gold", Amount = 2250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Halloween,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Farm.Name,
			Image = "rbxassetid://98799129491348",
			TokensNeeded = 475,
			SkipProductId = 2378443889,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Skin", Name = "Farm_Halloween" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Astronaut,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Toxicnator.Name,
			Image = "rbxassetid://98048980016432",
			TokensNeeded = 550,
			SkipProductId = 2378463907,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "Skin", Name = "Toxicnator_Astronaut" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Cardboard,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.John.Name,
			Image = "rbxassetid://116325936315454",
			TokensNeeded = 675,
			SkipProductId = 2378488078,
			SkipProductDisplayPrice = 275,
			Prize = { Type = "Skin", Name = "John_Cardboard" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.A10Strike,
			Image = "rbxassetid://135145837577374",
			TokensNeeded = 1000,
			SkipProductId = 2378505691,
			SkipProductDisplayPrice = 300,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.A10Strike, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pumpkin,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Juggernaut.Name,
			Image = "rbxassetid://89739658823878",
			TokensNeeded = 800,
			SkipProductId = 2378521989,
			SkipProductDisplayPrice = 325,
			Prize = { Type = "Skin", Name = "Juggernaut_Pumpkin" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Toxic,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.John.Name,
			Image = "rbxassetid://123632294868733",
			TokensNeeded = 800,
			SkipProductId = 2378538479,
			SkipProductDisplayPrice = 350,
			Prize = { Type = "Skin", Name = "John_Toxic" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Relic,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Cryo Blaster"].Name,
			Image = "rbxassetid://131257347428936",
			TokensNeeded = 800,
			SkipProductId = 2378554906,
			SkipProductDisplayPrice = 375,
			Prize = { Type = "Skin", Name = "Cryo Blaster_Relic" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 1500,
			SkipProductId = 2378575317,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Gold", Amount = 3750 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Mysterious,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Mine Layer"].Name,
			Image = "rbxassetid://92414143520927",
			TokensNeeded = 750,
			SkipProductId = 2378597894,
			SkipProductDisplayPrice = 425,
			Prize = { Type = "Skin", Name = "Mine Layer_Mysterious" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MOAB,
			Image = "rbxassetid://129018894210944",
			TokensNeeded = 2475,
			SkipProductId = 2378611484,
			SkipProductDisplayPrice = 450,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MOAB, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.DropPod,
			Image = "rbxassetid://92362054959653",
			TokensNeeded = 1850,
			OriginalTokensNeeded = 9250,
			SkipProductId = 2378636760,
			SkipProductDisplayPrice = 475,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.DropPod, Amount = 7 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Head,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Slammer.Name,
			Image = "rbxassetid://71810273146759",
			TokensNeeded = 925,
			SkipProductId = 2378656534,
			SkipProductDisplayPrice = 625,
			Prize = { Type = "Skin", Name = "Slammer_Head" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Conga,
			Image = "rbxassetid://107380888641792",
			TokensNeeded = 1275,
			SkipProductId = 2378684363,
			SkipProductDisplayPrice = 725,
			Prize = { Type = "Emote", Name = "Conga" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24PlagueDoctor,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Medic.Name,
			Image = "rbxassetid://129753082939675",
			TokensNeeded = 1175,
			SkipProductId = 2378702450,
			SkipProductDisplayPrice = 800,
			Prize = { Type = "Skin", Name = "Medic_Plague Doctor" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pumpkin,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["XWM Turret"].Name,
			Image = "rbxassetid://87523645022625",
			TokensNeeded = 1175,
			SkipProductId = 2378731480,
			SkipProductDisplayPrice = 925,
			Prize = { Type = "Skin", Name = "XWM Turret_Pumpkin" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Patriot,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Golden Juggernaut"].Name,
			Image = "rbxassetid://125318651955583",
			TokensNeeded = 1375,
			SkipProductId = 2378754905,
			SkipProductDisplayPrice = 1000,
			Prize = { Type = "Skin", Name = "Golden Juggernaut_Patriot" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 3000,
			OriginalTokensNeeded = 19000,
			SkipProductId = 2378769070,
			SkipProductDisplayPrice = 1200,
			Prize = { Type = "Gold", Amount = 5000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pirate,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Commander.Name,
			Image = "rbxassetid://139012250816274",
			TokensNeeded = 1200,
			SkipProductId = 2378798721,
			SkipProductDisplayPrice = 500,
			Prize = { Type = "Skin", Name = "Commander_Pirate" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Clown,
			TowerLangKey = Lang.Strings.AssetInfo.Towers["Armored Factory"].Name,
			Image = "rbxassetid://132607054333384",
			TokensNeeded = 1575,
			SkipProductId = 2378814150,
			SkipProductDisplayPrice = 525,
			Prize = { Type = "Skin", Name = "Armored Factory_Clown" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 5750,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "Gold", Amount = 10000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 8500,
			SkipProductId = 0,
			SkipProductDisplayPrice = 0,
			Prize = { Type = "XP", Amount = 50000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = "rbxassetid://111184498286499",
			TokensNeeded = 35000,
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
	}
}