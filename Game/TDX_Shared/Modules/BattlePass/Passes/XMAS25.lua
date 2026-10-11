local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local NameTagData = require(ReplicatedStorage.TDX_Shared.Modules.NameTagData)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.XMAS25,
	CardImage = 84989766295220,
	FrameImage = 122402358665019,
	BackgroundImage = 127160883914708,
	Colors = {
		Primary = Color3.fromRGB(173, 47, 38),
		Secondary = Color3.fromRGB(219, 59, 47),
		Tertiary = Color3.fromRGB(68, 102, 68),
		Tier = Color3.fromRGB(121, 182, 121)
	},
	UnlockProductInfo = { ProductId = 3541407514, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1771711200,
	Tiers = {
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 350,
			SkipProductId = 3486816520,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Crystals", Amount = 25 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MegaZed,
			Image = PowerUpsData[Enums.PowerUps.MegaZed].NoBGImage,
			TokensNeeded = 425,
			SkipProductId = 3486816541,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MegaZed, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 350,
			SkipProductId = 3486816559,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Gold", Amount = 1000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 325,
			SkipProductId = 3486816579,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "XP", Amount = 4000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25Cool,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.CryoRanger].Name,
			Image = "rbxassetid://139851276429251",
			TokensNeeded = 650,
			SkipProductId = 3486816596,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "Skin", Name = "Cryo Ranger_Cool" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.RangeField,
			Image = PowerUpsData[Enums.PowerUps.RangeField].NoBGImage,
			TokensNeeded = 375,
			SkipProductId = 3486816612,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.RangeField, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 400,
			SkipProductId = 3486816629,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Crystals", Amount = 100 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CryoBlast,
			Image = PowerUpsData[Enums.PowerUps.CryoBlast].NoBGImage,
			TokensNeeded = 475,
			SkipProductId = 3486816653,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CryoBlast, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25Gingerbread,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Juggernaut].Name,
			Image = "rbxassetid://133302274290097",
			TokensNeeded = 700,
			SkipProductId = 3486816668,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Skin", Name = "Juggernaut_Gingerbread" }
		},
		{
			LangKey = Lang.Strings.BattlePass.DisplayTypes.Cookies,
			Image = NameTagData.Effects.Cookies.Image,
			TokensNeeded = 550,
			SkipProductId = 3486816680,
			SkipProductDisplayPrice = 135,
			Prize = { Type = "NameTagEffect", Name = "Cookies" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.AirStrike,
			Image = PowerUpsData[Enums.PowerUps.AirStrike].NoBGImage,
			TokensNeeded = 475,
			SkipProductId = 3486816700,
			SkipProductDisplayPrice = 140,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.AirStrike, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 375,
			SkipProductId = 3486816722,
			SkipProductDisplayPrice = 85,
			Prize = { Type = "Gold", Amount = 1250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.DamageField,
			Image = PowerUpsData[Enums.PowerUps.DamageField].NoBGImage,
			TokensNeeded = 350,
			SkipProductId = 3486816741,
			SkipProductDisplayPrice = 90,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.DamageField, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 600,
			SkipProductId = 3486816756,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Crystals", Amount = 40 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25Gingerbread,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.John].Name,
			Image = "rbxassetid://74463361441831",
			TokensNeeded = 750,
			SkipProductId = 3486816778,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "Skin", Name = "John_Gingerbread" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 500,
			SkipProductId = 3486816795,
			SkipProductDisplayPrice = 110,
			Prize = { Type = "XP", Amount = 6250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 550,
			SkipProductId = 3486816815,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Crystals", Amount = 175 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.AC130Support,
			Image = PowerUpsData[Enums.PowerUps.AC130Support].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3486816832,
			SkipProductDisplayPrice = 135,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.AC130Support, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.CashCrate,
			Image = PowerUpsData[Enums.PowerUps.CashCrate].NoBGImage,
			TokensNeeded = 425,
			SkipProductId = 3486816857,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.CashCrate, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 450,
			SkipProductId = 3486816878,
			SkipProductDisplayPrice = 135,
			Prize = { Type = "Gold", Name = "", Amount = 1750 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25Santa,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Slammer].Name,
			Image = "rbxassetid://116118203796136",
			TokensNeeded = 800,
			SkipProductId = 3486816889,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "Skin", Name = "Slammer_Santa" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MegaZed,
			Image = PowerUpsData[Enums.PowerUps.MegaZed].NoBGImage,
			TokensNeeded = 550,
			SkipProductId = 3486816899,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MegaZed, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25ChristmasLights,
			Image = NameTagData.Effects.ChristmasLights.Image,
			TokensNeeded = 650,
			SkipProductId = 3486816925,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "NameTagEffect", Name = "ChristmasLights" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HealthCrate,
			Image = PowerUpsData[Enums.PowerUps.HealthCrate].NoBGImage,
			TokensNeeded = 575,
			SkipProductId = 3486816949,
			SkipProductDisplayPrice = 135,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.HealthCrate, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 750,
			SkipProductId = 3486816966,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Crystals", Amount = 60 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 825,
			SkipProductId = 3486816982,
			SkipProductDisplayPrice = 190,
			Prize = { Type = "XP", Amount = 10000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 600,
			SkipProductId = 3486817004,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "Crystals", Amount = 225 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 575,
			SkipProductId = 3486817019,
			SkipProductDisplayPrice = 165,
			Prize = { Type = "Gold", Amount = 2500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Punkbuster,
			Image = PowerUpsData[Enums.PowerUps.Punkbuster].NoBGImage,
			TokensNeeded = 585,
			SkipProductId = 3486817031,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.Punkbuster, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.RaptorStorm,
			Image = PowerUpsData[Enums.PowerUps.RaptorStorm].NoBGImage,
			TokensNeeded = 500,
			SkipProductId = 3486817051,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.RaptorStorm, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25HotChoccy,
			Image = "rbxassetid://134904933621397",
			TokensNeeded = 675,
			SkipProductId = 3486817068,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Emote", Name = "Hot Choccy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 750,
			SkipProductId = 3486817081,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Crystals", Amount = 60 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.GoldenMineLayer].Name,
			Image = "rbxassetid://119591870924783",
			TokensNeeded = 850,
			SkipProductId = 3486817099,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Skin", Name = "Golden Mine Layer_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.ReconDrone,
			Image = PowerUpsData[Enums.PowerUps.ReconDrone].NoBGImage,
			TokensNeeded = 375,
			SkipProductId = 3486817118,
			SkipProductDisplayPrice = 140,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.ReconDrone, Amount = 7 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 700,
			SkipProductId = 3486817135,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Crystals", Amount = 275 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 1075,
			SkipProductId = 3486817150,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "XP", Amount = 12000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS25Aurora,
			Image = NameTagData.Effects.Aurora.Image,
			TokensNeeded = 675,
			SkipProductId = 3486817168,
			SkipProductDisplayPrice = 215,
			Prize = { Type = "NameTagEffect", Name = "Aurora" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 600,
			SkipProductId = 3486817177,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Gold", Name = "", Amount = 2750 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.A10Strike,
			Image = PowerUpsData[Enums.PowerUps.A10Strike].NoBGImage,
			TokensNeeded = 475,
			SkipProductId = 3486817192,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.A10Strike, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.SR71Strike,
			Image = PowerUpsData[Enums.PowerUps.SR71Strike].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3486817212,
			SkipProductDisplayPrice = 175,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.SR71Strike, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XMAS24Christmas,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.ShieldTower].Name,
			Image = "rbxassetid://122897831434699",
			TokensNeeded = 900,
			SkipProductId = 3486817234,
			SkipProductDisplayPrice = 190,
			Prize = { Type = "Skin", Name = "Shield Tower_Christmas" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 2575,
			SkipProductId = 3486817248,
			SkipProductDisplayPrice = 550,
			Prize = { Type = "Gold", Amount = 4000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MOAB,
			Image = PowerUpsData[Enums.PowerUps.MOAB].NoBGImage,
			TokensNeeded = 575,
			SkipProductId = 3486817268,
			SkipProductDisplayPrice = 275,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MOAB, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 925,
			SkipProductId = 3486817299,
			SkipProductDisplayPrice = 265,
			Prize = { Type = "Crystals", Amount = 350 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 1400,
			SkipProductId = 3486817322,
			SkipProductDisplayPrice = 285,
			Prize = { Type = "XP", Amount = 13500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EmergencySupplyCrate,
			Image = PowerUpsData[Enums.PowerUps.EmergencySupplyCrate].NoBGImage,
			TokensNeeded = 600,
			SkipProductId = 3486817332,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.EmergencySupplyCrate, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 825,
			SkipProductId = 3486817352,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "Gold", Amount = 3500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MegaZed,
			Image = PowerUpsData[Enums.PowerUps.MegaZed].NoBGImage,
			TokensNeeded = 1500,
			SkipProductId = 3486817366,
			SkipProductDisplayPrice = 300,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MegaZed, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 800,
			SkipProductId = 3486817374,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Crystals", Amount = 60 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = PowerUpsData[Enums.PowerUps.NuclearMissile].NoBGImage,
			TokensNeeded = 60000,
			SkipProductId = 3486817392,
			SkipProductDisplayPrice = 750,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.NuclearMissile, Amount = 5 }
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