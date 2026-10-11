local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Enums = require(ReplicatedStorage.TDX_Shared.Common.Enums)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local NameTagData = require(ReplicatedStorage.TDX_Shared.Modules.NameTagData)
return {
	DisplayName = Lang.Strings.BattlePass.PassNames.TB2,
	CardImage = 87112989914472,
	BackgroundImage = 98810302823297,
	FrameImage = 83982895056366,
	PurchaseRemainingTiersInfo = { Enabled = true, Discount = 15 },
	Colors = {
		Primary = Color3.fromHex("B65CFF"),
		Secondary = Color3.fromHex("6970DB"),
		Tertiary = Color3.fromHex("B65CFF"),
		Tier = Color3.fromHex("B65CFF")
	},
	StartUnix = 0,
	EndUnix = 1797163200,
	Tiers = {
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Void Gummies"].Name,
			Image = "rbxassetid://100663238025950",
			TokensNeeded = 500,
			SkipProductId = 3708794888,
			SkipProductDisplayPrice = 100,
			BuyRemainingProductId = 3708812928,
			Prize = { Type = "Emote", Name = "Void Gummies" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.VoidCalling,
			Image = PowerUpsData[Enums.PowerUps.VoidCalling].NoBGImage,
			TokensNeeded = 400,
			SkipProductId = 3708794896,
			SkipProductDisplayPrice = 85,
			BuyRemainingProductId = 3708812948,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.VoidCalling, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://133874319839778",
			TokensNeeded = 2500,
			SkipProductId = 3708794897,
			SkipProductDisplayPrice = 350,
			BuyRemainingProductId = 3708812951,
			Prize = { Type = "Tower", Name = Enums.Towers.Scout, RefundAmount = 1500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Void,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://93267711078782",
			TokensNeeded = 1200,
			SkipProductId = 3708794899,
			SkipProductDisplayPrice = 225,
			BuyRemainingProductId = 3708812953,
			Prize = { Type = "Skin", Name = "Scout_Void" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2GDA,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://103870879128264",
			TokensNeeded = 1200,
			SkipProductId = 3708794901,
			SkipProductDisplayPrice = 225,
			BuyRemainingProductId = 3708812957,
			Prize = { Type = "Skin", Name = "Scout_GDA" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 325,
			SkipProductId = 3708794904,
			SkipProductDisplayPrice = 70,
			BuyRemainingProductId = 3708812959,
			Prize = { Type = "XP", Amount = 4500 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.ExoVoidsVision.Name,
			Image = NameTagData.Effects.ExoVoidsVision.Image,
			TokensNeeded = 950,
			SkipProductId = 3708794908,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708812963,
			Prize = { Type = "NameTagEffect", Name = "ExoVoidsVision" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.NormalPVP].Name,
			Image = "rbxassetid://130225668957371",
			TokensNeeded = 275,
			SkipProductId = 3708794910,
			SkipProductDisplayPrice = 50,
			BuyRemainingProductId = 3708812965,
			Prize = { Type = "Enemy", Name = Enums.Enemies.NormalPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Red,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://118683026525004",
			TokensNeeded = 975,
			SkipProductId = 3708794912,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708812966,
			Prize = { Type = "Skin", Name = "Scout_Red" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MegaZed,
			Image = PowerUpsData[Enums.PowerUps.MegaZed].NoBGImage,
			TokensNeeded = 800,
			SkipProductId = 3708794914,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708812968,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MegaZed, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.ShadePVP].Name,
			Image = "rbxassetid://70956082826794",
			TokensNeeded = 325,
			SkipProductId = 3708794915,
			SkipProductDisplayPrice = 65,
			BuyRemainingProductId = 3708812969,
			Prize = { Type = "Enemy", Name = Enums.Enemies.ShadePVP }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Jeep Patrol"].Name,
			Image = "rbxassetid://128969045101859",
			TokensNeeded = 1500,
			SkipProductId = 3708794919,
			SkipProductDisplayPrice = 275,
			BuyRemainingProductId = 3708812974,
			Prize = { Type = "Emote", Name = "Jeep Patrol" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.UmbrixVision.Name,
			Image = NameTagData.Effects.UmbrixVision.Image,
			TokensNeeded = 950,
			SkipProductId = 3708794921,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708812976,
			Prize = { Type = "NameTagEffect", Name = "UmbrixVision" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.SlowPVP].Name,
			Image = "rbxassetid://126645867385732",
			TokensNeeded = 325,
			SkipProductId = 3708794927,
			SkipProductDisplayPrice = 65,
			BuyRemainingProductId = 3708812977,
			Prize = { Type = "Enemy", Name = Enums.Enemies.SlowPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Void,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.NoobTuber].Name,
			Image = "rbxassetid://119903425912669",
			TokensNeeded = 1275,
			SkipProductId = 3708794929,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708812980,
			Prize = { Type = "Skin", Name = "Noob Tuber_Void" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.MysteryPVP].Name,
			Image = "rbxassetid://93650787614897",
			TokensNeeded = 875,
			SkipProductId = 3708794930,
			SkipProductDisplayPrice = 100,
			BuyRemainingProductId = 3708812981,
			Prize = { Type = "Enemy", Name = Enums.Enemies.MysteryPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 575,
			SkipProductId = 3708794931,
			SkipProductDisplayPrice = 125,
			BuyRemainingProductId = 3708812985,
			Prize = { Type = "Crystals", Amount = 250 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.VoidsVision.Name,
			Image = NameTagData.Effects.VoidsVision.Image,
			TokensNeeded = 950,
			SkipProductId = 3708794933,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708812987,
			Prize = { Type = "NameTagEffect", Name = "VoidsVision" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Void,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.John].Name,
			Image = "rbxassetid://110160639905908",
			TokensNeeded = 1350,
			SkipProductId = 3708794936,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708812990,
			Prize = { Type = "Skin", Name = "John_Void" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.GoldenZed,
			Image = PowerUpsData[Enums.PowerUps.GoldenZed].NoBGImage,
			TokensNeeded = 825,
			SkipProductId = 3708794937,
			SkipProductDisplayPrice = 165,
			BuyRemainingProductId = 3708812991,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.GoldenZed, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 325,
			SkipProductId = 3708794939,
			SkipProductDisplayPrice = 70,
			BuyRemainingProductId = 3708812993,
			Prize = { Type = "XP", Amount = 6500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Statue,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Commander].Name,
			Image = "rbxassetid://87147335966835",
			TokensNeeded = 1300,
			SkipProductId = 3708794942,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708812997,
			Prize = { Type = "Skin", Name = "Commander_Statue" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Aviator].Name,
			Image = "rbxassetid://87033387551190",
			TokensNeeded = 12000,
			SkipProductId = 3708794945,
			SkipProductDisplayPrice = 1200,
			BuyRemainingProductId = 3708812999,
			Prize = { Type = "Tower", Name = Enums.Towers.Aviator, RefundAmount = 3000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Purple,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Aviator].Name,
			Image = "rbxassetid://135470383681434",
			TokensNeeded = 975,
			SkipProductId = 3708794947,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813003,
			Prize = { Type = "Skin", Name = "Aviator_Purple" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 575,
			SkipProductId = 3708794949,
			SkipProductDisplayPrice = 125,
			BuyRemainingProductId = 3708813007,
			Prize = { Type = "Crystals", Amount = 250 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.TheVoid.Name,
			Image = NameTagData.Effects.TheVoid.Image,
			TokensNeeded = 950,
			SkipProductId = 3708794952,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813010,
			Prize = { Type = "NameTagEffect", Name = "TheVoid" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Warship Throw"].Name,
			Image = "rbxassetid://85138931627701",
			TokensNeeded = 1825,
			SkipProductId = 3708794956,
			SkipProductDisplayPrice = 275,
			BuyRemainingProductId = 3708813013,
			Prize = { Type = "Emote", Name = "Warship Throw" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Pink,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Zed].Name,
			Image = "rbxassetid://93303134481699",
			TokensNeeded = 1350,
			SkipProductId = 3708794959,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708813015,
			Prize = { Type = "Skin", Name = "Zed_Pink" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.A10Strike,
			Image = PowerUpsData[Enums.PowerUps.A10Strike].NoBGImage,
			TokensNeeded = 450,
			SkipProductId = 3708794961,
			SkipProductDisplayPrice = 100,
			BuyRemainingProductId = 3708813017,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.A10Strike, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.MOAB,
			Image = PowerUpsData[Enums.PowerUps.MOAB].NoBGImage,
			TokensNeeded = 500,
			SkipProductId = 3708794963,
			SkipProductDisplayPrice = 100,
			BuyRemainingProductId = 3708813019,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.MOAB, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.MalignantPVP].Name,
			Image = "rbxassetid://74727750348335",
			TokensNeeded = 950,
			SkipProductId = 3708794964,
			SkipProductDisplayPrice = 165,
			BuyRemainingProductId = 3708813024,
			Prize = { Type = "Enemy", Name = Enums.Enemies.MalignantPVP }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.NosowyPVP].Name,
			Image = "rbxassetid://121451533349358",
			TokensNeeded = 500,
			SkipProductId = 3708794967,
			SkipProductDisplayPrice = 100,
			BuyRemainingProductId = 3708813026,
			Prize = { Type = "Enemy", Name = Enums.Enemies.NosowyPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.VoidCalling,
			Image = PowerUpsData[Enums.PowerUps.VoidCalling].NoBGImage,
			TokensNeeded = 1500,
			SkipProductId = 3708794970,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708813028,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.VoidCalling, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = PowerUpsData[Enums.PowerUps.NuclearMissile].NoBGImage,
			TokensNeeded = 4000,
			SkipProductId = 3708794972,
			SkipProductDisplayPrice = 400,
			BuyRemainingProductId = 3708813030,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.NuclearMissile, Amount = 1 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2GDA,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Aviator].Name,
			Image = "rbxassetid://114861659405229",
			TokensNeeded = 1350,
			SkipProductId = 3708794975,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708813031,
			Prize = { Type = "Skin", Name = "Aviator_GDA" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.VoidStars.Name,
			Image = NameTagData.Effects.VoidStars.Image,
			TokensNeeded = 950,
			SkipProductId = 3708794976,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813035,
			Prize = { Type = "NameTagEffect", Name = "VoidStars" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Biker,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Zed].Name,
			Image = "rbxassetid://71399484107222",
			TokensNeeded = 1500,
			SkipProductId = 3708794978,
			SkipProductDisplayPrice = 300,
			BuyRemainingProductId = 3708813041,
			Prize = { Type = "Skin", Name = "Zed_Biker" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 375,
			SkipProductId = 3708794979,
			SkipProductDisplayPrice = 85,
			BuyRemainingProductId = 3708813042,
			Prize = { Type = "XP", Amount = 7500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Void,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.GoldenRanger].Name,
			Image = "rbxassetid://105201951484368",
			TokensNeeded = 1500,
			SkipProductId = 3708794980,
			SkipProductDisplayPrice = 300,
			BuyRemainingProductId = 3708813045,
			Prize = { Type = "Skin", Name = "Golden Ranger_Void" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 325,
			SkipProductId = 3708794983,
			SkipProductDisplayPrice = 75,
			BuyRemainingProductId = 3708813048,
			Prize = { Type = "Gold", Amount = 2500 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.GeneralLeahWorld.Name,
			Image = NameTagData.Effects.GeneralLeahWorld.Image,
			TokensNeeded = 1000,
			SkipProductId = 3708794985,
			SkipProductDisplayPrice = 185,
			BuyRemainingProductId = 3708813049,
			Prize = { Type = "NameTagEffect", Name = "GeneralLeahWorld" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.CystPVP].Name,
			Image = "rbxassetid://139645262155233",
			TokensNeeded = 700,
			SkipProductId = 3708794987,
			SkipProductDisplayPrice = 115,
			BuyRemainingProductId = 3708813053,
			Prize = { Type = "Enemy", Name = Enums.Enemies.CystPVP }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Void Rest Time"].Name,
			Image = "rbxassetid://100659919062461",
			TokensNeeded = 1500,
			SkipProductId = 3708794989,
			SkipProductDisplayPrice = 325,
			BuyRemainingProductId = 3708813054,
			Prize = { Type = "Emote", Name = "Void Rest Time" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 575,
			SkipProductId = 3708794994,
			SkipProductDisplayPrice = 125,
			BuyRemainingProductId = 3708813056,
			Prize = { Type = "Crystals", Amount = 250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.DropPod,
			Image = PowerUpsData[Enums.PowerUps.DropPod].NoBGImage,
			TokensNeeded = 900,
			SkipProductId = 3708794997,
			SkipProductDisplayPrice = 150,
			BuyRemainingProductId = 3708813059,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.DropPod, Amount = 3 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Hidden,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Medic].Name,
			Image = "rbxassetid://126505911756254",
			TokensNeeded = 1400,
			SkipProductId = 3708795000,
			SkipProductDisplayPrice = 285,
			BuyRemainingProductId = 3708813062,
			Prize = { Type = "Skin", Name = "Medic_Hidden" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Void Plush"].Name,
			Image = "rbxassetid://93830927948809",
			TokensNeeded = 1250,
			SkipProductId = 3708795002,
			SkipProductDisplayPrice = 225,
			BuyRemainingProductId = 3708813063,
			Prize = { Type = "Emote", Name = "Void Plush" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Hidden,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Ghost].Name,
			Image = "rbxassetid://91423681608511",
			TokensNeeded = 1400,
			SkipProductId = 3708795003,
			SkipProductDisplayPrice = 285,
			BuyRemainingProductId = 3708813066,
			Prize = { Type = "Skin", Name = "Ghost_Hidden" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.VoidDimension.Name,
			Image = NameTagData.Effects.VoidDimension.Image,
			TokensNeeded = 1000,
			SkipProductId = 3708795005,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708813070,
			Prize = { Type = "NameTagEffect", Name = "VoidDimension" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.MalicePVP].Name,
			Image = "rbxassetid://81972150872467",
			TokensNeeded = 750,
			SkipProductId = 3708795007,
			SkipProductDisplayPrice = 120,
			BuyRemainingProductId = 3708813073,
			Prize = { Type = "Enemy", Name = Enums.Enemies.MalicePVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 575,
			SkipProductId = 3708795011,
			SkipProductDisplayPrice = 125,
			BuyRemainingProductId = 3708813076,
			Prize = { Type = "Crystals", Amount = 250 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Void,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Aviator].Name,
			Image = "rbxassetid://88117191117258",
			TokensNeeded = 1350,
			SkipProductId = 3708795014,
			SkipProductDisplayPrice = 275,
			BuyRemainingProductId = 3708813079,
			Prize = { Type = "Skin", Name = "Aviator_Void" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.MysteryVPVP].Name,
			Image = "rbxassetid://121724985692530",
			TokensNeeded = 1000,
			SkipProductId = 3708795016,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813082,
			Prize = { Type = "Enemy", Name = Enums.Enemies.MysteryVPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2DeathKnight,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Juggernaut].Name,
			Image = "rbxassetid://115818042251687",
			TokensNeeded = 1500,
			SkipProductId = 3708795019,
			SkipProductDisplayPrice = 325,
			BuyRemainingProductId = 3708813083,
			Prize = { Type = "Skin", Name = "Juggernaut_Death Knight" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.VoidWardenPVP].Name,
			Image = "rbxassetid://107475666279843",
			TokensNeeded = 1000,
			SkipProductId = 3708795022,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813084,
			Prize = { Type = "Enemy", Name = Enums.Enemies.VoidWardenPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2HotPink,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://130751290609614",
			TokensNeeded = 975,
			SkipProductId = 3708795027,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813086,
			Prize = { Type = "Skin", Name = "Scout_Hot Pink" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2CrazY,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://87600499599306",
			TokensNeeded = 975,
			SkipProductId = 3708795030,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813088,
			Prize = { Type = "Skin", Name = "Scout_CrazY" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Black,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Scout].Name,
			Image = "rbxassetid://127556267561772",
			TokensNeeded = 975,
			SkipProductId = 3708795032,
			SkipProductDisplayPrice = 175,
			BuyRemainingProductId = 3708813089,
			Prize = { Type = "Skin", Name = "Scout_Black" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.NeuronPVP].Name,
			Image = "rbxassetid://74703812865902",
			TokensNeeded = 650,
			SkipProductId = 3708795033,
			SkipProductDisplayPrice = 110,
			BuyRemainingProductId = 3708813094,
			Prize = { Type = "Enemy", Name = Enums.Enemies.NeuronPVP }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Phaser].Name,
			Image = "rbxassetid://127894112465013",
			TokensNeeded = 19000,
			SkipProductId = 3708795035,
			SkipProductDisplayPrice = 2800,
			BuyRemainingProductId = 3708813095,
			Prize = { Type = "Tower", Name = Enums.Towers.Phaser, RefundAmount = 6000 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2GDA,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Phaser].Name,
			Image = "rbxassetid://87071033248495",
			TokensNeeded = 1500,
			SkipProductId = 3708795036,
			SkipProductDisplayPrice = 325,
			BuyRemainingProductId = 3708813098,
			Prize = { Type = "Skin", Name = "Phaser_GDA" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Crystals,
			Image = "rbxassetid://78715160697152",
			TokensNeeded = 1150,
			SkipProductId = 3708795039,
			SkipProductDisplayPrice = 250,
			BuyRemainingProductId = 3708813102,
			Prize = { Type = "Crystals", Amount = 500 }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.TB2Hidden,
			TowerLangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.Mobster].Name,
			Image = "rbxassetid://91966760194201",
			TokensNeeded = 1600,
			SkipProductId = 3708795041,
			SkipProductDisplayPrice = 350,
			BuyRemainingProductId = 3708813103,
			Prize = { Type = "Skin", Name = "Mobster_Hidden" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.Gold,
			Image = "rbxassetid://18445794169",
			TokensNeeded = 750,
			SkipProductId = 3708795045,
			SkipProductDisplayPrice = 150,
			BuyRemainingProductId = 3708813105,
			Prize = { Type = "Gold", Amount = 5000 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.CarcinPVP].Name,
			Image = "rbxassetid://110542927591536",
			TokensNeeded = 900,
			SkipProductId = 3708795046,
			SkipProductDisplayPrice = 135,
			BuyRemainingProductId = 3708813108,
			Prize = { Type = "Enemy", Name = Enums.Enemies.CarcinPVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.GoldenZed,
			Image = PowerUpsData[Enums.PowerUps.GoldenZed].NoBGImage,
			TokensNeeded = 1200,
			SkipProductId = 3708795049,
			SkipProductDisplayPrice = 150,
			BuyRemainingProductId = 3708813109,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.GoldenZed, Amount = 2 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.NameTagEffects.SixSeven.Name,
			Image = NameTagData.Effects.SixSeven.Image,
			TokensNeeded = 6767,
			SkipProductId = 3708795054,
			SkipProductDisplayPrice = 267,
			BuyRemainingProductId = 3708813110,
			Prize = { Type = "NameTagEffect", Name = "SixSeven" }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Enemies[Enums.Enemies.VoidPrimePVP].Name,
			Image = "rbxassetid://85509241707560",
			TokensNeeded = 9750,
			SkipProductId = 3708795056,
			SkipProductDisplayPrice = 1150,
			BuyRemainingProductId = 3708813115,
			Prize = { Type = "Enemy", Name = Enums.Enemies.VoidPrimePVP }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.XP,
			Image = "rbxassetid://18459450827",
			TokensNeeded = 1750,
			SkipProductId = 3708795058,
			SkipProductDisplayPrice = 200,
			BuyRemainingProductId = 3708813118,
			Prize = { Type = "XP", Amount = 20000 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Towers[Enums.Towers.VoidTraitor].Name,
			Image = "rbxassetid://86630199911239",
			TokensNeeded = 22000,
			SkipProductId = 3713224589,
			SkipProductDisplayPrice = 3500,
			BuyRemainingProductId = 3713225352,
			Prize = { Type = "Tower", Name = Enums.Towers.VoidTraitor, RefundAmount = 8000 }
		},
		{
			LangKey = Lang.Strings.AssetInfo.Emotes["Commander Toy"].Name,
			Image = "rbxassetid://73264039568908",
			TokensNeeded = 1375,
			SkipProductId = 3713224597,
			SkipProductDisplayPrice = 300,
			BuyRemainingProductId = 3713225384,
			Prize = { Type = "Emote", Name = "Commander Toy" }
		},
		{
			LangKey = Lang.Strings.BattlePass.ItemNames.NuclearMissile,
			Image = PowerUpsData[Enums.PowerUps.NuclearMissile].NoBGImage,
			TokensNeeded = 30000,
			SkipProductId = 3708795060,
			SkipProductDisplayPrice = 600,
			Prize = { Type = "PowerUp", Name = Enums.PowerUps.NuclearMissile, Amount = 3 }
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
		},
		Send1000IonGuards = {
			QuestType = "PVPSends",
			TokenReward = 900,
			ProgressRequired = 225,
			Identifier = Enums.Enemies.IonGuard
		},
		Send3Eradicators = {
			QuestType = "PVPSends",
			TokenReward = 1000,
			ProgressRequired = 3,
			Identifier = Enums.Enemies.EradicatorMKIPVP
		},
		Send2500Fallouts = {
			QuestType = "PVPSends",
			TokenReward = 850,
			ProgressRequired = 400,
			Identifier = Enums.Enemies.Fallout
		},
		Send200Boss2s = {
			QuestType = "PVPSends",
			TokenReward = 700,
			ProgressRequired = 50,
			Identifier = Enums.Enemies.Boss2
		},
		Send1000HeavyMetals = {
			QuestType = "PVPSends",
			TokenReward = 900,
			ProgressRequired = 200,
			Identifier = Enums.Enemies.HeavyMetal
		},
		Send3CaptainSlimes = {
			QuestType = "PVPSends",
			TokenReward = 900,
			ProgressRequired = 3,
			Identifier = Enums.Enemies.CaptainSlimePVP
		},
		Send3EradBs = {
			QuestType = "PVPSends",
			TokenReward = 500,
			ProgressRequired = 3,
			Identifier = Enums.Enemies.EradBPVP
		},
		Send400SlowDroids = {
			QuestType = "PVPSends",
			TokenReward = 400,
			ProgressRequired = 200,
			Identifier = Enums.Enemies.HeavyDroid
		},
		WinTBPart2Hard = {
			QuestType = "WinsOnMode",
			TokenReward = 850,
			ProgressRequired = 1,
			Identifier = Enums.Difficulties.TBPart2Hard
		},
		Deal500kDamageWithScout = {
			QuestType = "DamageWithTower",
			TokenReward = 500,
			ProgressRequired = 500000,
			Identifier = Enums.Towers.Scout
		}
	}
}