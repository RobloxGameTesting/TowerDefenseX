local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local Enums = require(Common:WaitForChild("Enums"))
local ShopDataV2Towers = {
	[Enums.Towers.Ranger] = {
		ViewportName = "Ranger",
		Price = 0,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Shotgunner] = {
		ViewportName = "Shotgunner",
		Price = 450,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Operator] = {
		ViewportName = "Operator",
		Price = 1250,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.MineLayer] = {
		ViewportName = "Mine Layer",
		Price = 1450,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Juggernaut] = {
		ViewportName = "Juggernaut",
		Price = 13250,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Farm] = {
		ViewportName = "Farm",
		Price = 2200,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.EDJ] = {
		ViewportName = "EDJ",
		Price = 3200,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.MissileTrooper] = {
		ViewportName = "Missile Trooper",
		Price = 2000,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Warship] = {
		ViewportName = "Warship",
		Price = 75000,
		MinLevel = 100,
		ProductId = 1725456708,
		PriceInRobux = 4950,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.CryoBlaster] = {
		ViewportName = "Cryo Blaster",
		Price = 2000,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.LaserGunner] = {
		ViewportName = "Laser Gunner",
		Price = 5500,
		MinLevel = 20,
		ProductId = 1691366905,
		PriceInRobux = 400,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Sniper] = {
		ViewportName = "Sniper",
		Price = 1650,
		MinLevel = 15,
		ProductId = 1669970778,
		PriceInRobux = 150,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Artillery] = {
		ViewportName = "Artillery",
		Price = 8750,
		MinLevel = 30,
		ProductId = 1691241834,
		PriceInRobux = 800,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.PatrolBoat] = {
		ViewportName = "Patrol Boat",
		Price = 2150,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.John] = {
		ViewportName = "John",
		Price = 4500,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Barracks] = {
		ViewportName = "Barracks",
		Price = 2350,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Railgunner] = {
		ViewportName = "Railgunner",
		Price = 15000,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.CryoRanger] = {
		IsOffsale = true,
		ViewportName = "Cryo Ranger",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		LimitedTime = true,
		ProductId = 1711785582,
		PriceInRobux = 325,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.Grenadier] = {
		ViewportName = "Grenadier",
		Price = 2750,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Toxicnator] = {
		ViewportName = "Toxicnator",
		Price = 6500,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.ArmoredFactory] = {
		ViewportName = "Armored Factory",
		Price = 12000,
		MinLevel = 35,
		ProductId = 1770565748,
		PriceInRobux = 825,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.GoldenRanger] = {
		ViewportName = "Golden Ranger",
		Price = 38500,
		MinLevel = 50,
		ProductId = 3250983455,
		PriceInRobux = 1800,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.GoldenJuggernaut] = {
		ViewportName = "Golden Juggernaut",
		Price = 85000,
		MinLevel = 75,
		ProductId = 3250983381,
		PriceInRobux = 3400,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.XWMTurret] = {
		ViewportName = "XWM Turret",
		Price = 32000,
		MinLevel = 50,
		ProductId = 1812273030,
		PriceInRobux = 2500,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Slammer] = {
		ViewportName = "Slammer",
		Price = 22000,
		MinLevel = 75,
		ProductId = 1839118976,
		PriceInRobux = 1900,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Medic] = {
		ViewportName = "Medic",
		Price = 14000,
		MinLevel = 0,
		ProductId = 2651566940,
		PriceInRobux = 600,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.Zed] = {
		IsRobuxOnly = true,
		ViewportName = "Zed",
		Price = 2100000000,
		MinLevel = 0,
		ProductId = 1874102225,
		PriceInRobux = 3000,
		LimitedTime = true,
		OverrideLayoutOrder = 0,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.Commander] = {
		ViewportName = "Commander",
		Price = 10000,
		Currency = "Crystals",
		MinLevel = 0,
		ProductId = 1874101728,
		PriceInRobux = 775,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.Ghost] = {
		ViewportName = "Ghost",
		Price = 15000,
		PriceInRobux = 1200,
		ProductId = 1894742126,
		MinLevel = 60,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.GoldenMineLayer] = {
		ViewportName = "Golden Mine Layer",
		Price = 69000,
		PriceInRobux = 2900,
		ProductId = 1910805128,
		MinLevel = 82,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.Helicopter] = {
		ViewportName = "Helicopter",
		Price = 82000,
		PriceInRobux = 4200,
		ProductId = 1942573254,
		MinLevel = 85,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.Sentry] = {
		ViewportName = "Sentry",
		Price = 7250,
		MinLevel = 0,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.Scarecrow] = {
		IsOffsale = true,
		ViewportName = "Scarecrow",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 2381651761,
		PriceInRobux = 50,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.FlameTrooper] = {
		ViewportName = "Flame Trooper",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 2381651956,
		PriceInRobux = 700,
		LimitedTime = true,
		OverrideLayoutOrder = 0,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.Relic] = {
		IsOffsale = true,
		ViewportName = "Relic",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		PriceInRobux = 2500,
		ProductId = 2381655995,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.Mobster] = {
		ViewportName = "Mobster",
		Price = 15000,
		MinLevel = 50,
		ProductId = 2666178930,
		PriceInRobux = 1000,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.CryoHelicopter] = {
		IsOffsale = true,
		ViewportName = "Cryo Helicopter",
		Price = 2100000000,
		MinLevel = 0,
		LimitedTime = true,
		IsRobuxOnly = true,
		ProductId = 2669119390,
		PriceInRobux = 2500,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.IceBreaker] = {
		IsOffsale = true,
		ViewportName = "Ice Breaker",
		Price = 2100000000,
		MinLevel = 0,
		LimitedTime = true,
		IsRobuxOnly = true,
		ProductId = 2692076184,
		PriceInRobux = 1250,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.AATurret] = {
		ViewportName = "AA Turret",
		Price = 11000,
		MinLevel = 0,
		ProductId = 3248104034,
		PriceInRobux = 275,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.TrollTower] = {
		ViewportName = "Troll Tower",
		Price = 2100000000,
		MinLevel = 0,
		LimitedTime = true,
		IsRobuxOnly = true,
		ProductId = 3254079508,
		PriceInRobux = 67,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.MachineGunner] = {
		ViewportName = "Machine Gunner",
		Price = 18000,
		MinLevel = 45,
		ProductId = 3263159519,
		PriceInRobux = 550,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.GoldenMobster] = {
		ViewportName = "Golden Mobster",
		Price = 90000,
		MinLevel = 110,
		ProductId = 3273511854,
		PriceInRobux = 3850,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.CombatDrone] = {
		ViewportName = "Combat Drone",
		Price = 72000,
		MinLevel = 100,
		ProductId = 3275354461,
		PriceInRobux = 2700,
		Subcategory = Enums.ItemSubcategories.Advanced
	},
	[Enums.Towers.JetTrooper] = {
		ViewportName = "Jet Trooper",
		Price = 9500,
		MinLevel = 25,
		ProductId = 3334669151,
		PriceInRobux = 450,
		Subcategory = Enums.ItemSubcategories.Intermediate
	},
	[Enums.Towers.GooGunner] = {
		ViewportName = "Goo Gunner",
		Price = 2100000000,
		MinLevel = 0,
		IsOffsale = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.ShockTrooper] = {
		IsOffsale = true,
		ViewportName = "Shock Trooper",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 3442350660,
		PriceInRobux = 750,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.ShieldTower] = {
		ViewportName = "Shield Tower",
		Price = 2875,
		Currency = "Crystals",
		MinLevel = 35,
		ProductId = 3343868839,
		PriceInRobux = 1200,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.Refractor] = {
		ViewportName = "Refractor",
		Price = 14500,
		Currency = "Crystals",
		MinLevel = 35,
		ProductId = 3352877240,
		PriceInRobux = 5850,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.BehemothFactory] = {
		ViewportName = "Behemoth Factory",
		Price = 8450,
		Currency = "Crystals",
		MinLevel = 35,
		ProductId = 3354867816,
		PriceInRobux = 3450,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.WarMachineFactory] = {
		ViewportName = "War Machine Factory",
		Price = 13550,
		Currency = "Crystals",
		MinLevel = 35,
		ProductId = 3405290714,
		PriceInRobux = 5500,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.OilDerrick] = {
		ViewportName = "Oil Derrick",
		Price = 6250,
		Currency = "Crystals",
		MinLevel = 35,
		ProductId = 3464269894,
		PriceInRobux = 1500,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.CryoMortar] = {
		IsOffsale = true,
		ViewportName = "Cryo Mortar",
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		PriceInRobux = 775,
		ProductId = 3488422827,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.PsychoSlayer] = {
		IsOffsale = true,
		ViewportName = "Psycho Slayer",
		Price = 2100000000,
		Currency = "Cookies",
		MinLevel = 0,
		ProductId = 3485899242,
		PriceInRobux = 2875,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.CombatMedic] = {
		ViewportName = "Combat Medic",
		Price = 13275,
		Currency = "Crystals",
		MinLevel = 60,
		ProductId = 3408555722,
		PriceInRobux = 1400,
		Subcategory = Enums.ItemSubcategories.Nightmare
	},
	[Enums.Towers.NoobTuber] = {
		ViewportName = "Noob Tuber",
		Price = 4000,
		Currency = "Gold",
		MinLevel = 0,
		ProductId = 3553816277,
		PriceInRobux = 175,
		OverrideLayoutOrder = 1,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.ScoutHelicopter] = {
		ViewportName = "Scout Helicopter",
		Price = 9000,
		Currency = "Gold",
		MinLevel = 0,
		ProductId = 3554883767,
		PriceInRobux = 550,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.Stinger] = {
		ViewportName = "Stinger",
		Price = 3000,
		Currency = "Gold",
		MinLevel = 0,
		ProductId = 3555784419,
		PriceInRobux = 150,
		Subcategory = Enums.ItemSubcategories.Beginner
	},
	[Enums.Towers.ChickenHouse] = {
		IsOffsale = true,
		ViewportName = "Chicken House",
		MinLevel = 0,
		IsRobuxOnly = true,
		ProductId = 3563884741,
		PriceInRobux = 100,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.BubbleBlower] = {
		IsOffsale = true,
		ViewportName = "Bubble Blower",
		Price = 525,
		Currency = "Eggs",
		MinLevel = 0,
		ProductId = 3579554447,
		PriceInRobux = 450,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.GoldenWarship] = {
		IsOffsale = true,
		ViewportName = "Golden Warship",
		Price = 1676767,
		MinLevel = 200,
		ProductId = 3566244870,
		PriceInRobux = 8250,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	},
	[Enums.Towers.MLRS] = {
		IsOffsale = true,
		New = true,
		ViewportName = "MLRS",
		Price = 500,
		Currency = "Burgers",
		MinLevel = 0,
		ProductId = 3607694925,
		PriceInRobux = 600,
		LimitedTime = true,
		Subcategory = Enums.ItemSubcategories.Event
	}
}

if not _G.TB2_EVENT_ENABLED then
	return ShopDataV2Towers
end

ShopDataV2Towers[Enums.Towers.Aviator] = {
	LimitedTime = true,
	New = true,
	ViewportName = "Aviator",
	MinLevel = 0,
	IsRobuxOnly = true,
	ProductId = 3609907271,
	PriceInRobux = 1200,
	OverrideLayoutOrder = 0,
	Subcategory = Enums.ItemSubcategories.Event
}
ShopDataV2Towers[Enums.Towers.Phaser] = {
	LimitedTime = true,
	New = true,
	ViewportName = "Phaser",
	MinLevel = 0,
	IsRobuxOnly = true,
	ProductId = 3611386855,
	PriceInRobux = 2800,
	OverrideLayoutOrder = 0,
	Subcategory = Enums.ItemSubcategories.Event
}
ShopDataV2Towers[Enums.Towers.Scout] = {
	New = true,
	LimitedTime = true,
	ViewportName = "Scout",
	MinLevel = 0,
	IsRobuxOnly = true,
	ProductId = 3611386868,
	PriceInRobux = 350,
	OverrideLayoutOrder = 0,
	Subcategory = Enums.ItemSubcategories.Event
}
ShopDataV2Towers[Enums.Towers.VoidTraitor] = {
	New = true,
	LimitedTime = true,
	ViewportName = "Void Traitor",
	MinLevel = 0,
	IsRobuxOnly = true,
	ProductId = 3708955717,
	PriceInRobux = 3500,
	OverrideLayoutOrder = 0,
	Subcategory = Enums.ItemSubcategories.Event
}
return ShopDataV2Towers