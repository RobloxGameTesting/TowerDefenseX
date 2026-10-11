local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
RunService:IsStudio()
local PlaceId = game.PlaceId
local v = PlaceId == 15433423608 or PlaceId == 11275324362
local v2 = PlaceId == 94707254819009 or PlaceId == 122629334167147
local Shared = { IS_DEV = true }
Shared.GAME_PLACE_ID = Shared.IS_DEV and (v and 15433423608 or v2 and 94707254819009 or 11739766412) or 0
Shared.LOBBY_PLACE_ID = Shared.IS_DEV and (v and 11275324362 or v2 and 122629334167147 or 9503261072) or 0
Shared.IS_DEV_PLACE = v
Shared.IS_PROD_PLACE = PlaceId == 11739766412 or PlaceId == 9503261072
Shared.IS_PERF_TESTING_PLACE = v2
Shared.IS_LIGHT = workspace:GetAttribute("IsLight") or false
Shared.FORCE_PAID_RANDOM_ITEMS_RESTRICTED = false
Shared.RANK_IMAGES = {
	"rbxassetid://14101347694",
	"rbxassetid://14101347580",
	"rbxassetid://14101347370",
	"rbxassetid://14101347172",
	"rbxassetid://14101346986",
	"rbxassetid://14101346803",
	"rbxassetid://14101346504",
	"rbxassetid://14101346288",
	"rbxthumb://type=Asset&w=420&h=420&id=15373285467",
	"rbxthumb://type=Asset&w=420&h=420&id=15373285347",
	"rbxthumb://type=Asset&w=420&h=420&id=15373285247",
	"rbxthumb://type=Asset&w=420&h=420&id=15373285116",
	"rbxthumb://type=Asset&w=420&h=420&id=15373285053",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284969",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284874",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284821",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284745",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284670",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284568",
	"rbxthumb://type=Asset&w=420&h=420&id=15373284487",
	"rbxthumb://type=Asset&w=420&h=420&id=15417011650",
	"rbxthumb://type=Asset&w=420&h=420&id=15417047974",
	"rbxthumb://type=Asset&w=420&h=420&id=15417045493",
	"rbxthumb://type=Asset&w=420&h=420&id=15373283920",
	"rbxthumb://type=Asset&w=420&h=420&id=15373283694",
	"rbxthumb://type=Asset&w=420&h=420&id=15373283594",
	"rbxthumb://type=Asset&w=420&h=420&id=15417013580",
	"rbxthumb://type=Asset&w=420&h=420&id=15373283184",
	"rbxthumb://type=Asset&w=420&h=420&id=15373283024",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282941",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282823",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282695",
	"rbxthumb://type=Asset&w=420&h=420&id=15417014791",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282474",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282371",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282237",
	"rbxthumb://type=Asset&w=420&h=420&id=15373282125",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281972",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281794",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281678",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281473",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281414",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281299",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281074",
	"rbxthumb://type=Asset&w=420&h=420&id=15373281002",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280917",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280766",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280559",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280420",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280285",
	"rbxthumb://type=Asset&w=420&h=420&id=15373280088",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279995",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279907",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279739",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279592",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279443",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279285",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279219",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279148",
	"rbxthumb://type=Asset&w=420&h=420&id=15373279074",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278954",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278805",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278635",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278468",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278337",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278217",
	"rbxthumb://type=Asset&w=420&h=420&id=15373278087",
	"http://www.roblox.com/asset/?id=15373277969",
	"rbxthumb://type=Asset&w=420&h=420&id=15417016741",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277804",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277637",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277548",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277400",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277228",
	"rbxthumb://type=Asset&w=420&h=420&id=15373277054",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276940",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276734",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276651",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276565",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276508",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276442",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276323",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276173",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276101",
	"rbxthumb://type=Asset&w=420&h=420&id=15373276026",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275942",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275838",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275750",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275661",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275582",
	"rbxthumb://type=Asset&w=420&h=420&id=15417012684",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275383",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275296",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275225",
	"rbxthumb://type=Asset&w=420&h=420&id=15373275092",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274954",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274856",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274772",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274772",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274641",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274534",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274409",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274300",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274226",
	"rbxthumb://type=Asset&w=420&h=420&id=15373274113",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273973",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273832",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273751",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273605",
	"rbxthumb://type=Asset&w=420&h=420&id=15417015668",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273453",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273244",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273142",
	"rbxthumb://type=Asset&w=420&h=420&id=15373273054",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272909",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272839",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272769",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272700",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272633",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272531",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272406",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272278",
	"rbxthumb://type=Asset&w=420&h=420&id=15373272118",
	"rbxthumb://type=Asset&w=420&h=420&id=15373271985",
	"rbxthumb://type=Asset&w=420&h=420&id=15373271907",
	"rbxthumb://type=Asset&w=420&h=420&id=15373271772",
	"rbxthumb://type=Asset&w=420&h=420&id=15373271634",
	"rbxthumb://type=Asset&w=420&h=420&id=15373271465",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270922",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270827",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270731",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270636",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270441",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270375",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270287",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270178",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270110",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270029",
	"rbxthumb://type=Asset&w=420&h=420&id=15373270029",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269932",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269851",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269774",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269714",
	"rbxthumb://type=Asset&w=420&h=420&id=15373269570"
}
Shared.RARITY_COLORS = {
	Common = Color3.new(0.278431, 0.92549, 0.082352),
	Uncommon = Color3.new(0.031372, 0.345098, 0.819607),
	Epic = Color3.new(0.498039, 0.058823, 0.913725),
	Legendary = Color3.new(0.780392, 0.074509, 0.074509),
	Exclusive = Color3.fromHex("#FFD700"),
	Hidden = Color3.fromRGB(255, 65, 198),
	Default = Color3.fromRGB(100, 100, 100)
}
Shared.RARITY_ORDER = { "Common", "Uncommon", "Epic", "Legendary", "Exclusive", "Default" }
Shared.RARITY_ODDS = { Common = 70, Uncommon = 20, Epic = 9, Legendary = 1 }
Shared.CURRENCY_COLORS = {
	Gold = Color3.fromRGB(180, 255, 0),
	Crystals = Color3.fromRGB(112, 193, 255),
	Cookies = Color3.fromRGB(255, 150, 89),
	Envelopes = Color3.fromRGB(232, 38, 80),
	Eggs = Color3.fromRGB(221, 45, 255),
	Burgers = Color3.fromRGB(255, 178, 0)
}
Shared.CURRENCY_ICONS = {
	Gold = "rbxassetid://134837596456923",
	Crystals = "rbxassetid://122394238360129",
	Cookies = "rbxassetid://104818398824260",
	Envelopes = "rbxassetid://125370784852520",
	Eggs = "rbxassetid://103457339935784",
	Burgers = "rbxassetid://73214393199461"
}
Shared.CURRENCY_ICONS_NO_COLOR = {
	Gold = "rbxassetid://112926450644370",
	Crystals = "rbxassetid://96218612292324",
	Cookies = "rbxassetid://82777650799112",
	Envelopes = "rbxassetid://128085230374057",
	Eggs = "rbxassetid://122204007416091",
	Burgers = "rbxassetid://136154568695094"
}
Shared.DOUBLE_TOKENS_ID = 2381665065
Shared.DOUBLE_TOKENS_GIFT_ID = 3715205776
Shared.DOUBLE_TOKENS_DURATION = 3600
Shared.DOUBLE_TOKENS_IMAGE = "rbxassetid://113271831736740"
Shared.SKIN_DEV_PRODUCT_IDS = {
	Juggernaut_RCU = v and 1746132411 or 1746131721,
	Operator_Dealer = v and 1748747329 or 1748747509,
	["Juggernaut_Tower Battles"] = v and 1700766781 or 1701193783,
	["EDJ_Tower Battles"] = v and 1700767894 or 1701193889,
	["Missile Trooper_Tower Battles"] = v and 1702723513 or 1702723103,
	["Sniper_Tower Battles"] = v and 1702723412 or 1702722959,
	["Operator_Tower Battles"] = v and 1702723465 or 1702723032,
	["Golden Juggernaut_Golden Commando"] = v and 1812221722 or 1812224574,
	Juggernaut_Eradicator = v and 1812221925 or 1812225162,
	John_Eradicator = v and 1812222244 or 1812224930,
	EDJ_Jolly = 3488501418,
	["Oil Derrick_Candy Mine"] = 3564608680,
	["Refractor_Home Defender"] = 3608030774,
	["Oil Derrick_WowBurger"] = 3608030896,
	["Behemoth Factory_Spider Tank"] = 3608063417
}
Shared.GOLD_TIER_TO_DEV_ID_MAP = { 1669991678, 1669991778, 1669991862, 1669991958 }
Shared.GOLD_DEV_ID_TO_SECONDARY_SOURCE = {
	[1669991678] = "Tier 1",
	[1669991778] = "Tier 2",
	[1669991862] = "Tier 3",
	[1669991958] = "Tier 4"
}
Shared.GOLD_DEV_ID_TO_AMOUNT_MAP = {
	[1669991678] = 1000,
	[1669991778] = 2050,
	[1669991862] = 4850,
	[1669991958] = 10000
}
Shared.CRYSTALS_DEV_ID_TO_AMOUNT_MAP = {
	[3380763241] = 315,
	[3380764641] = 1075,
	[3380765048] = 3315,
	[3380765504] = 9200
}
Shared.CRYSTALS_TIER_TO_DEV_ID_MAP = { 3380763241, 3380764641, 3380765048, 3380765504 }
Shared.CRYSTALS_DEV_ID_TO_SECONDARY_SOURCE = {
	[3380763241] = "Tier 1",
	[3380764641] = "Tier 2",
	[3380765048] = "Tier 3",
	[3380765504] = "Tier 4"
}
Shared.DONATION_TIER_TO_DEV_ID_MAP = {
	1691757441,
	1691757437,
	1691758036,
	1691758035,
	1691758033,
	1691758091,
	1691758545,
	1691758542,
	1691758553,
	1691758543,
	1691758554,
	1691758609
}
Shared.DONATION_DEV_ID_TO_AMOUNT_MAP = {
	[1691757441] = 25,
	[1691757437] = 50,
	[1691758036] = 100,
	[1691758035] = 250,
	[1691758033] = 500,
	[1691758091] = 1000,
	[1691758545] = 5000,
	[1691758542] = 10000,
	[1691758553] = 25000,
	[1691758543] = 50000,
	[1691758554] = 100000,
	[1691758609] = 250000
}
Shared.PASS_QUESTS_REFRESH_PRODUCT_ID = 2653981428
Shared.QUESTS_REFRESH_DAILY_PRODUCT_ID = 3326172854
Shared.QUESTS_REFRESH_WEEKLY_0_TO_29_PRODUCT_ID = 3326174374
Shared.QUESTS_REFRESH_WEEKLY_30_TO_59_PRODUCT_ID = 3335907496
Shared.QUESTS_REFRESH_WEEKLY_60_TO_89_PRODUCT_ID = 3335907658
Shared.QUESTS_REFRESH_WEEKLY_90_PLUS_PRODUCT_ID = 3335907904
Shared.QUESTS_REPAIR_DAILY_STREAK_PRODUCT_ID = 3335804895
Shared.QUESTS_REPAIR_WEEKLY_STREAK_PRODUCT_ID = 3335805011
Shared.MAGIC_SHOP_REFRESH_PRODUCT_ID = 3390855580
Shared.MEDALS_LIST = {
	[Enums.Difficulties.Easy] = {
		[true] = "rbxassetid://17189886947",
		[false] = "rbxassetid://17189887179"
	},
	[Enums.Difficulties.Intermediate] = {
		[true] = "rbxassetid://17189886351",
		[false] = "rbxassetid://17189886577"
	},
	[Enums.Difficulties.Elite] = {
		[true] = "rbxassetid://17189885937",
		[false] = "rbxassetid://17189886072"
	},
	[Enums.Difficulties.Expert] = {
		[true] = "rbxassetid://17189885454",
		[false] = "rbxassetid://17189885658"
	},
	[Enums.Difficulties.Party2025] = {
		[true] = "rbxassetid://104129551192740",
		[false] = "rbxassetid://117349457508533"
	},
	[Enums.Difficulties.Nightmare] = {
		[true] = "rbxassetid://112726179721835",
		[false] = "rbxassetid://135929642700636"
	},
	[Enums.Difficulties.UltraNightmare] = {
		[true] = "rbxassetid://73422734207898",
		[false] = "rbxassetid://137254494648108"
	}
}
Shared.VIP_TAG_COLOR = Color3.fromRGB(255, 215, 0)
Shared.VIP_TEXT_COLOR = Color3.fromRGB(255, 229, 83)
Shared.EASTER_EGG_MULTIPLIERS = {
	[Enums.Difficulties.Easter26Part1Easy] = 3,
	[Enums.Difficulties.Easter26Part1] = 3,
	[Enums.Difficulties.Easter26Part1Nightmare] = 6,
	[Enums.Difficulties.Easter26Part2Easy] = 3,
	[Enums.Difficulties.Easter26Part2] = 3,
	[Enums.Difficulties.Easter26Part2Nightmare] = 6,
	[Enums.Difficulties.MLG] = 2,
	[Enums.Difficulties.MLGNightmare] = 2,
	[Enums.Difficulties.Tutorial] = 0,
	[Enums.Difficulties.TowerBattles] = 2,
	[Enums.Difficulties.TowerBattlesNightmare] = 2,
	[Enums.Difficulties.HalloweenPart1] = 2,
	[Enums.Difficulties.HalloweenPart2] = 2,
	[Enums.Difficulties.HalloweenPart3] = 2,
	[Enums.Difficulties.HalloweenPart4] = 2,
	[Enums.Difficulties.HalloweenNightmarePart1] = 2,
	[Enums.Difficulties.HalloweenNightmarePart2] = 2,
	[Enums.Difficulties.HalloweenNightmarePart3] = 2,
	[Enums.Difficulties.HalloweenNightmarePart4] = 2,
	[Enums.Difficulties.Christmas24Part1] = 2,
	[Enums.Difficulties.Christmas24Part2] = 2,
	[Enums.Difficulties.Christmas24Part1Nightmare] = 2,
	[Enums.Difficulties.Christmas24Part2Nightmare] = 2,
	[Enums.Difficulties.Halloween2025] = 2,
	[Enums.Difficulties.Christmas25Part2Easy] = 2,
	[Enums.Difficulties.Christmas25Part2] = 2,
	[Enums.Difficulties.Christmas25Part2Nightmare] = 2
}
Shared.EASTER_BOSS_NUM_EGGS = 2
Shared.EASTER_MINIBOSS_NUM_EGGS = 1
Shared.EASTER_REGULAR_ENEMY_EGG_DROP_CHANCE = 0.0002
Shared.SUMMER_BURGER_MULTIPLIERS = {
	[Enums.Difficulties.Easy] = 1,
	[Enums.Difficulties.Intermediate] = 1,
	[Enums.Difficulties.Elite] = 1,
	[Enums.Difficulties.Expert] = 1
}
Shared.SUMMER_BOSS_NUM_BURGERS = 8
Shared.SUMMER_MINIBOSS_NUM_BURGERS = 4
Shared.SUMMER_REGULAR_ENEMY_BURGER_DROP_CHANCE = 0.0002
Shared.ITEM_SUBCATEGORY_ICONS = {
	[Enums.ItemSubcategories.Featured] = "rbxassetid://130077066355670",
	[Enums.ItemSubcategories.Event] = "rbxassetid://91557001982513",
	[Enums.ItemSubcategories.Offensive] = "rbxassetid://109251976589373",
	[Enums.ItemSubcategories.Support] = "rbxassetid://105693821240882",
	[Enums.ItemSubcategories.Boss] = "rbxassetid://104322178511064",
	[Enums.ItemSubcategories.Fodder] = "rbxassetid://109117538392544",
	[Enums.ItemSubcategories.Rusher] = "rbxassetid://104975695953411",
	[Enums.ItemSubcategories.Eco] = "rbxassetid://122035515192636"
}
local colors = {
	[Enums.ItemSubcategories.Featured] = Color3.fromRGB(95, 236, 255),
	[Enums.ItemSubcategories.Event] = Color3.fromRGB(131, 141, 255),
	[Enums.ItemSubcategories.Offensive] = Color3.fromRGB(255, 59, 59),
	[Enums.ItemSubcategories.Support] = Color3.fromRGB(0, 255, 144),
	[Enums.ItemSubcategories.Boss] = Color3.fromRGB(255, 64, 252),
	[Enums.ItemSubcategories.Fodder] = Color3.fromRGB(221, 221, 221),
	[Enums.ItemSubcategories.Rusher] = Color3.fromRGB(95, 236, 255),
	[Enums.ItemSubcategories.Eco] = Color3.fromRGB(0, 255, 157),
	[Enums.ItemSubcategories.Beginner] = Color3.fromRGB(34, 255, 130),
	[Enums.ItemSubcategories.Intermediate] = Color3.fromRGB(254, 237, 2),
	[Enums.ItemSubcategories.Advanced] = Color3.fromRGB(247, 25, 2),
	[Enums.ItemSubcategories.Nightmare] = Color3.fromRGB(255, 0, 251)
}
Shared.ITEM_SUBCATEGORY_COLORS = colors
Shared.ITEM_SUBCATEGORY_TICKS = {
	[Enums.ItemSubcategories.Beginner] = 1,
	[Enums.ItemSubcategories.Intermediate] = 2,
	[Enums.ItemSubcategories.Advanced] = 3,
	[Enums.ItemSubcategories.Nightmare] = 4
}
Shared.ITEM_SUBCATEGORY_ORDER = {
	[Enums.ItemSubcategories.Featured] = 0,
	[Enums.ItemSubcategories.Event] = 1,
	[Enums.ItemSubcategories.Fodder] = 2,
	[Enums.ItemSubcategories.Rusher] = 3,
	[Enums.ItemSubcategories.Support] = 4,
	[Enums.ItemSubcategories.Eco] = 5,
	[Enums.ItemSubcategories.Offensive] = 6,
	[Enums.ItemSubcategories.Boss] = 7,
	[Enums.ItemSubcategories.Beginner] = 8,
	[Enums.ItemSubcategories.Intermediate] = 9,
	[Enums.ItemSubcategories.Advanced] = 10,
	[Enums.ItemSubcategories.Nightmare] = 11
}
Shared.ITEM_TAG_ICONS = {
	[Enums.ItemTags.Ability] = "rbxassetid://126789854991219",
	[Enums.ItemTags.Arial] = "rbxassetid://86061487852470",
	[Enums.ItemTags.AntiAir] = "rbxassetid://83697385494344",
	[Enums.ItemTags.Armored] = "rbxassetid://95034411513042",
	[Enums.ItemTags.Bait] = "rbxassetid://81446086212238",
	[Enums.ItemTags.BossKiller] = "rbxassetid://124898361509320",
	[Enums.ItemTags.CrowdControl] = "rbxassetid://117053462799537",
	[Enums.ItemTags.Cryo] = "rbxassetid://110975544117925",
	[Enums.ItemTags.DPS] = "rbxassetid://121073119218161",
	[Enums.ItemTags.Healing] = "rbxassetid://105835678856940",
	[Enums.ItemTags.Income] = "rbxassetid://105835678856940",
	[Enums.ItemTags.Naval] = "rbxassetid://88143545286759",
	[Enums.ItemTags.Range] = "rbxassetid://94546894524650",
	[Enums.ItemTags.Spawner] = "rbxassetid://90498577293939",
	[Enums.ItemTags.Splash] = "rbxassetid://87266593580945",
	[Enums.ItemTags.Tank] = "rbxassetid://79496666431654",
	[Enums.ItemTags.Warship] = "rbxassetid://78752314338546"
}
Shared.DAMAGE_TYPE_ICONS = {
	[Enums.DamageTypes.Bullet] = "rbxassetid://14037836815",
	[Enums.DamageTypes.Explosive] = "rbxassetid://17099645519",
	[Enums.DamageTypes.Fire] = "rbxassetid://17099645425",
	[Enums.DamageTypes.Ice] = "rbxassetid://17099645354",
	[Enums.DamageTypes.Laser] = "rbxassetid://17105116313",
	[Enums.DamageTypes.Golden] = "rbxassetid://17105116313",
	[Enums.DamageTypes.Melee] = "rbxassetid://133022407815258",
	[Enums.DamageTypes.Collision] = "rbxassetid://128676491600472"
}
local colors2 = {
	[Enums.DamageTypes.Bullet] = Color3.fromRGB(155, 255, 89),
	[Enums.DamageTypes.Explosive] = Color3.fromRGB(255, 236, 28),
	[Enums.DamageTypes.Fire] = Color3.fromRGB(255, 133, 34),
	[Enums.DamageTypes.Ice] = Color3.fromRGB(125, 214, 255),
	[Enums.DamageTypes.Laser] = Color3.fromRGB(255, 75, 75),
	[Enums.DamageTypes.Golden] = Color3.fromRGB(255, 200, 0),
	[Enums.DamageTypes.Melee] = Color3.fromRGB(227, 157, 255),
	[Enums.DamageTypes.Collision] = Color3.fromRGB(255, 255, 255)
}
Shared.DAMAGE_TYPE_ICON_COLORS = colors2
Shared.POWERUP_CATEGORY_ICONS = {
	[Enums.PowerUpCategories.Offensive] = "rbxassetid://108851975459993",
	[Enums.PowerUpCategories.Defensive] = "rbxassetid://140640514620392"
}
local colors3 = {
	[Enums.PowerUpCategories.Offensive] = Color3.fromRGB(160, 119, 147),
	[Enums.PowerUpCategories.Defensive] = Color3.fromRGB(135, 126, 174)
}
Shared.POWERUP_CATEGORY_COLORS = colors3
Shared.STARTING_FREE_PVP_POWERUPS = {
	[Enums.PowerUps.PVPGlobalDamageMode] = 999,
	[Enums.PowerUps.PVPEnemySpeedBoost] = 999
}
Shared.VICTORY_MESSAGE_POOLS = {
	[Enums.Difficulties.TBPart2Hard] = {
		"claimed victory over the Void",
		"upheld the GDA's morale in the Void",
		"razed the Void",
		"defeated the Void"
	},
	[Enums.Difficulties.TBPart2Nightmare] = {
		"conquered the Void Lands",
		"claimed victory in the Void Lands",
		"razed the Void Lands",
		"proven the GDA's worth in the Void Lands",
		"shown the Void Lands who's in control"
	},
	[Enums.Difficulties.TBPart2Voidmare] = {
		"impressed the Void God",
		"shown the Void God the value of the GDA",
		"earned the GDA mercy from the Void God",
		"earned the GDA a place in the Void God's memory",
		"proven the GDA worthy before the Void God",
		"earned the Void God's respect",
		"earned the Void God's approval",
		"made the Void God reconsider the GDA's fate",
		"passed the Void God's judgment",
		"stood worthy before the Void God",
		"proven fearless before the Void God"
	}
}
local colors4 = {
	[Enums.Difficulties.TBPart2Hard] = Color3.fromHex("#7f78e2"),
	[Enums.Difficulties.TBPart2Nightmare] = Color3.fromHex("#ac6edf"),
	[Enums.Difficulties.TBPart2Voidmare] = Color3.fromHex("#f57fe5")
}
Shared.VICTORY_MESSAGE_COLORS = colors4
return Shared