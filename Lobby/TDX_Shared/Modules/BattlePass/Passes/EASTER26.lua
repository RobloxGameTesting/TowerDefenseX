local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local NameTagData = require(ReplicatedStorage.TDX_Shared.Modules.NameTagData)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.EASTER26,
	CardImage = 97788613967558,
	FrameImage = 116325651756967,
	BackgroundImage = 92505425667422,
	Colors = {
		Primary = Color3.fromHex("9C87BD"),
		Secondary = Color3.fromHex("84B5BF"),
		Tertiary = Color3.fromHex("84B5BF"),
		Tier = Color3.fromHex("84B5BF")
	},
	UnlockProductInfo = { ProductId = 3599867620, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1780347600,
	Quests = {
		BeatEasyMode = {
			QuestType = "WinsOnMode",
			TokenReward = 325,
			ProgressRequired = 1,
			Identifier = Enums.Difficulties.Easy
		},
		BeatHardMapsThreeTimes = {
			QuestType = "WinsOnMapDifficulties",
			TokenReward = 425,
			ProgressRequired = 3,
			Identifier = Enums.MapDifficulties.Hard
		},
		DefeatPredatorTenTimes = {
			QuestType = "BossKills",
			TokenReward = 350,
			ProgressRequired = 10,
			Identifier = Enums.Enemies.Predator
		},
		WinThreeGames = { QuestType = "Wins", TokenReward = 285, ProgressRequired = 3 },
		Kill4kEnemies = { QuestType = "Kills", TokenReward = 350, ProgressRequired = 4000 },
		BeatNightOneNightmareTwice = {
			QuestType = "WinsOnMode",
			Identifier = Enums.Difficulties.HalloweenNightmarePart1,
			TokenReward = 675,
			ProgressRequired = 2
		},
		DefeatEradicatorThreeTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.Eradicator,
			TokenReward = 400,
			ProgressRequired = 3
		},
		DefeatRevivedPlagueDoctorTwoTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.RevivedPlagueDoctorRework,
			TokenReward = 450,
			ProgressRequired = 2
		},
		WinSevenGames = { QuestType = "Wins", TokenReward = 777, ProgressRequired = 7 },
		DefeatEradicatorMK2TwoTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.EradicatorMK2Rework,
			TokenReward = 450,
			ProgressRequired = 2
		},
		DefeatPlagueDoctorFourTimes = {
			QuestType = "BossKills",
			Identifier = Enums.Enemies.PlagueDoctor,
			TokenReward = 350,
			ProgressRequired = 3
		},
		Use100TowerAbilities = {
			QuestType = "TowerAbilities",
			TokenReward = 250,
			ProgressRequired = 100
		},
		BeatImpossibleMapsThreeTimes = {
			QuestType = "WinsOnMapDifficulties",
			TokenReward = 650,
			ProgressRequired = 3,
			Identifier = Enums.MapDifficulties.Impossible
		},
		BeatEliteOnSurvival202 = {
			QuestType = "WinsOnMapAndMode",
			TokenReward = 600,
			ProgressRequired = 1,
			Identifier = `{Enums.Maps.Survival202}_{Enums.Difficulties.Elite}`
		},
		Kill2kEnemies = { QuestType = "Kills", TokenReward = 275, ProgressRequired = 2000 },
		Kill1kEnemies = { QuestType = "Kills", TokenReward = 200, ProgressRequired = 1000 },
		BeatEasyOnBaseplate = {
			QuestType = "WinsOnMapAndMode",
			TokenReward = 550,
			ProgressRequired = 1,
			Identifier = `{Enums.Maps.Baseplate}_{Enums.Difficulties.Easy}`
		}
	},
	Tiers = {
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 350,
			SkipProductId = 3564263111,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Crystals", Amount = 75 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 250,
			SkipProductId = 3564263121,
			SkipProductDisplayPrice = 65,
			Prize = { Type = "Gold", Amount = 1000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 275,
			SkipProductId = 3564263128,
			SkipProductDisplayPrice = 70,
			Prize = { Type = "XP", Amount = 3750 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Easter,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Operator].Name,
			Image = "rbxassetid://135196403830127",
			TokensNeeded = 700,
			SkipProductId = 3564263140,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "Skin", Name = "Operator_Easter" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 450,
			SkipProductId = 3564263153,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Gold", Amount = 1250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Bunny,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Grenadier].Name,
			Image = "rbxassetid://116173821691058",
			TokensNeeded = 750,
			SkipProductId = 3564263160,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Skin", Name = "Grenadier_Bunny" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.EasterEggsplosion.Name,
			Image = NameTagData.Effects.EasterEggsplosion.Image,
			TokensNeeded = 500,
			SkipProductId = 3564263170,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "NameTagEffect", Name = "EasterEggsplosion" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 900,
			SkipProductId = 3564263177,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "Gold", Amount = 2000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 550,
			SkipProductId = 3564263185,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Crystals", Amount = 300 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Easter,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Artillery].Name,
			Image = "rbxassetid://137865874162484",
			TokensNeeded = 1000,
			SkipProductId = 3564263189,
			SkipProductDisplayPrice = 165,
			Prize = { Type = "Skin", Name = "Artillery_Easter" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 600,
			SkipProductId = 3564263198,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Gold", Amount = 1500 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Bunny Plush"].Name,
			Image = "rbxassetid://115722741343042",
			TokensNeeded = 1000,
			SkipProductId = 3564263207,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "Emote", Name = "Bunny Plush" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 350,
			SkipProductId = 3564263220,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "XP", Amount = 5000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Bunny,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Slammer].Name,
			Image = "rbxassetid://82317965832332",
			TokensNeeded = 850,
			SkipProductId = 3564263228,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Skin", Name = "Slammer_Bunny" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.EasterGlow.Name,
			Image = NameTagData.Effects.EasterGlow.Image,
			TokensNeeded = 725,
			SkipProductId = 3564263235,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "NameTagEffect", Name = "EasterGlow" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 600,
			SkipProductId = 3564263242,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Gold", Amount = 2500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Easter,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.CombatMedic].Name,
			Image = "rbxassetid://85953767205430",
			TokensNeeded = 900,
			SkipProductId = 3564263253,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "Skin", Name = "Combat Medic_Easter" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 700,
			SkipProductId = 3564263264,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "XP", Amount = 5000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 725,
			SkipProductId = 3564263273,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Crystals", Name = "Crystals", Amount = 500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Easter,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Commander].Name,
			Image = "rbxassetid://127778526237257",
			TokensNeeded = 950,
			SkipProductId = 3564263282,
			SkipProductDisplayPrice = 300,
			Prize = { Type = "Skin", Name = "Commander_Easter" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.EasterBunnies.Name,
			Image = NameTagData.Effects.EasterBunnies.Image,
			TokensNeeded = 1000,
			SkipProductId = 3564263292,
			SkipProductDisplayPrice = 325,
			Prize = { Type = "NameTagEffect", Name = "EasterBunnies" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.GoldenZed,
			Image = PowerUpsData[Enums.PowerUps.GoldenZed].NoBGImage,
			TokensNeeded = 800,
			SkipProductId = 3564263299,
			SkipProductDisplayPrice = 350,
			Prize = { Type = "PowerUp", Name = "GoldenZed", Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EASTER26Easter,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.XWMTurret].Name,
			Image = "rbxassetid://77336902849543",
			TokensNeeded = 1500,
			SkipProductId = 3564263310,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "XWM Turret_Easter" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = PowerUpsData[Enums.PowerUps.NuclearMissile].NoBGImage,
			TokensNeeded = 30000,
			SkipProductId = 3564263320,
			SkipProductDisplayPrice = 1000,
			Prize = { Type = "PowerUp", Name = "NuclearMissile", Amount = 5 }
		}
	}
}