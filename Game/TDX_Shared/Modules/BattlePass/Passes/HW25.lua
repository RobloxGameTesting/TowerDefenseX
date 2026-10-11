local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.HW25,
	CardImage = 76656580981481,
	FrameImage = 111198933488741,
	BackgroundImage = 114276751614747,
	Colors = {
		Primary = Color3.fromRGB(176, 55, 34),
		Secondary = Color3.fromRGB(247, 117, 30),
		Tertiary = Color3.fromRGB(247, 117, 30),
		Tier = Color3.fromRGB(255, 66, 52)
	},
	UnlockProductInfo = { ProductId = 3466244172, ProductDisplayPrice = 499 },
	StartUnix = 0,
	EndUnix = 1765231200,
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
			TokensNeeded = 375,
			SkipProductId = 3444579357,
			SkipProductDisplayPrice = 50,
			Prize = { Type = "Crystals", Amount = 75 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Candy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.Operator.Name,
			Image = "rbxassetid://72172927371922",
			TokensNeeded = 525,
			SkipProductId = 3444597115,
			SkipProductDisplayPrice = 75,
			Prize = { Type = "Skin", Name = "Operator_Candy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 325,
			SkipProductId = 3444597973,
			SkipProductDisplayPrice = 85,
			Prize = { Type = "Gold", Amount = 1500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.DamageField,
			Image = PowerUpsData[Enums.PowerUps.DamageField].NoBGImage,
			TokensNeeded = 300,
			SkipProductId = 3444598088,
			SkipProductDisplayPrice = 100,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.DamageField, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Candy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.AATurret].Name,
			Image = "rbxassetid://101001874081178",
			TokensNeeded = 625,
			SkipProductId = 3444598240,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "Skin", Name = "AA Turret_Candy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 475,
			SkipProductId = 3444598458,
			SkipProductDisplayPrice = 150,
			Prize = { Type = "Crystals", Amount = 150 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.RangeField,
			Image = PowerUpsData[Enums.PowerUps.RangeField].NoBGImage,
			TokensNeeded = 350,
			SkipProductId = 3444598595,
			SkipProductDisplayPrice = 165,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.RangeField, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pumpkin,
			TowerLangKey = Lang.Strings.AssetInfo.Towers.John.Name,
			Image = "rbxassetid://108436859796084",
			TokensNeeded = 750,
			SkipProductId = 3444598711,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Skin", Name = "John_Pumpkin" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 375,
			SkipProductId = 3444598973,
			SkipProductDisplayPrice = 135,
			Prize = { Type = "Gold", Amount = 1800 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25CandyBucket,
			Image = "rbxassetid://136556565083467",
			TokensNeeded = 650,
			SkipProductId = 3444599086,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Emote", Name = "Candy Bucket" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25FlameBats,
			Image = "rbxassetid://99071336706954",
			TokensNeeded = 500,
			SkipProductId = 3444599187,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "NameTagEffect", Name = "FlameBats" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 700,
			SkipProductId = 3444599276,
			SkipProductDisplayPrice = 225,
			Prize = { Type = "XP", Amount = 10000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Candy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Sentry].Name,
			Image = "rbxassetid://98583680427656",
			TokensNeeded = 750,
			SkipProductId = 3444599361,
			SkipProductDisplayPrice = 190,
			Prize = { Type = "Skin", Name = "Sentry_Evil" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.UberField,
			Image = PowerUpsData[Enums.PowerUps.UberField].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3444599696,
			SkipProductDisplayPrice = 210,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.UberField, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 575,
			SkipProductId = 3444599798,
			SkipProductDisplayPrice = 220,
			Prize = { Type = "Crystals", Amount = 200 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Zombie,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.LaserGunner].Name,
			Image = "rbxassetid://119972868449595",
			TokensNeeded = 750,
			SkipProductId = 3444599903,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "Skin", Name = "Laser Gunner_Zombie" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.DamageField,
			Image = PowerUpsData[Enums.PowerUps.DamageField].NoBGImage,
			TokensNeeded = 425,
			SkipProductId = 3444599975,
			SkipProductDisplayPrice = 125,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.DamageField, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.AirStrike,
			Image = PowerUpsData[Enums.PowerUps.AirStrike].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3444600091,
			SkipProductDisplayPrice = 165,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.AirStrike, Amount = 5 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pumpkin,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.GoldenJuggernaut].Name,
			Image = "rbxassetid://84848746757305",
			TokensNeeded = 1025,
			SkipProductId = 3444600213,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "Golden Juggernaut_Pumpkin" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Pumpkin,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Commander].Name,
			Image = "rbxassetid://115837251127924",
			TokensNeeded = 925,
			SkipProductId = 3444600597,
			SkipProductDisplayPrice = 350,
			Prize = { Type = "Skin", Name = "Commander_Pumpkin" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.RangeField,
			Image = PowerUpsData[Enums.PowerUps.RangeField].NoBGImage,
			TokensNeeded = 500,
			SkipProductId = 3444600740,
			SkipProductDisplayPrice = 240,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.RangeField, Amount = 7 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Toy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.FlameTrooper].Name,
			Image = "rbxassetid://120570390778432",
			TokensNeeded = 850,
			SkipProductId = 3444600858,
			SkipProductDisplayPrice = 325,
			Prize = { Type = "Skin", Name = "Flame Trooper_Toy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Neko,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Ghost].Name,
			Image = "rbxassetid://109813577399914",
			TokensNeeded = 1000,
			SkipProductId = 3444600996,
			SkipProductDisplayPrice = 375,
			Prize = { Type = "Skin", Name = "Ghost_Neko" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 700,
			SkipProductId = 3444601126,
			SkipProductDisplayPrice = 300,
			Prize = { Type = "XP", Amount = 10000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Spooky,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Railgunner].Name,
			Image = "rbxassetid://127912284114310",
			TokensNeeded = 950,
			SkipProductId = 3444601227,
			SkipProductDisplayPrice = 350,
			Prize = { Type = "Skin", Name = "Railgunner_Spooky" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Spooky,
			Image = "rbxassetid://102133051863460",
			TokensNeeded = 1000,
			SkipProductId = 3444601327,
			SkipProductDisplayPrice = 375,
			Prize = { Type = "NameTagEffect", Name = "Spooky" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.EmergencyCrate,
			Image = PowerUpsData[Enums.PowerUps.EmergencySupplyCrate].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3444601451,
			SkipProductDisplayPrice = 185,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.EmergencySupplyCrate, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 450,
			SkipProductId = 3444601559,
			SkipProductDisplayPrice = 200,
			Prize = { Type = "Gold", Amount = 2000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Skeleton,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Refractor].Name,
			Image = "rbxassetid://87570415858974",
			TokensNeeded = 1075,
			SkipProductId = 3444601734,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "Refractor_Skeleton" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.UberField,
			Image = PowerUpsData[Enums.PowerUps.UberField].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3444601863,
			SkipProductDisplayPrice = 250,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.UberField, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25Toy,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.GoldenRanger].Name,
			Image = "rbxassetid://79728840289095",
			TokensNeeded = 950,
			SkipProductId = 3444602001,
			SkipProductDisplayPrice = 375,
			Prize = { Type = "Skin", Name = "Golden Ranger_Toy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW25PumpkinRide,
			Image = "rbxassetid://126978421954741",
			TokensNeeded = 825,
			SkipProductId = 3444602127,
			SkipProductDisplayPrice = 450,
			Prize = { Type = "Emote", Name = "Pumpkin Ride" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 2675,
			SkipProductId = 3444602217,
			SkipProductDisplayPrice = 675,
			Prize = { Type = "Gold", Amount = 3000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.HW24Cardboard,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.ShockTrooper].Name,
			Image = "rbxassetid://132677734510569",
			TokensNeeded = 875,
			SkipProductId = 3444602284,
			SkipProductDisplayPrice = 400,
			Prize = { Type = "Skin", Name = "Shock Trooper_Cardboard" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = PowerUpsData[Enums.PowerUps.NuclearMissile].NoBGImage,
			TokensNeeded = 6000,
			SkipProductId = 3444602353,
			SkipProductDisplayPrice = 700,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.NuclearMissile, Amount = 1 }
		}
	}
}