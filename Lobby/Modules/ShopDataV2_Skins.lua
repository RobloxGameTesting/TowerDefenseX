local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Crates = require(TDX_Shared.Modules.Crates)
local Shared = require(TDX_Shared.Modules.Shared)
local Enums = require(Common:WaitForChild("Enums"))
local ShopDataV2Skins = {
	Juggernaut_RCU = {
		MinLevel = 0,
		ViewportName = "Juggernaut",
		IsRobuxOnly = true,
		PriceInRobux = 175,
		Price = 2100000000,
		ExpectedSkin = "Juggernaut_RCU",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS.Juggernaut_RCU
	},
	Operator_Dealer = {
		MinLevel = 0,
		ViewportName = "Operator",
		IsRobuxOnly = true,
		PriceInRobux = 125,
		Price = 2100000000,
		ExpectedSkin = "Operator_Dealer",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS.Operator_Dealer
	},
	["Juggernaut_Tower Battles"] = {
		PriceInRobux = 85,
		OnSale = true,
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Juggernaut_Tower Battles",
		ViewportName = "Juggernaut",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Juggernaut_Tower Battles"]
	},
	["EDJ_Tower Battles"] = {
		PriceInRobux = 325,
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "EDJ_Tower Battles",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["EDJ_Tower Battles"],
		ViewportName = "EDJ"
	},
	["Missile Trooper_Tower Battles"] = {
		PriceInRobux = 85,
		OnSale = true,
		Price = 2100000000,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Missile Trooper_Tower Battles",
		ViewportName = "Missile Trooper",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Missile Trooper_Tower Battles"]
	},
	["Sniper_Tower Battles"] = {
		PriceInRobux = 85,
		OnSale = true,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Sniper_Tower Battles",
		ViewportName = "Sniper",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Sniper_Tower Battles"]
	},
	["Operator_Tower Battles"] = {
		PriceInRobux = 85,
		OnSale = true,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Operator_Tower Battles",
		ViewportName = "Operator",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Operator_Tower Battles"]
	},
	["Golden Juggernaut_Golden Commando"] = {
		PriceInRobux = 225,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Golden Juggernaut_Golden Commando",
		ViewportName = "Golden Juggernaut",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Golden Juggernaut_Golden Commando"]
	},
	Juggernaut_Eradicator = {
		PriceInRobux = 150,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "Juggernaut_Eradicator",
		ViewportName = "Juggernaut",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS.Juggernaut_Eradicator
	},
	John_Eradicator = {
		PriceInRobux = 125,
		Price = 0,
		MinLevel = 0,
		IsRobuxOnly = true,
		ExpectedSkin = "John_Eradicator",
		ViewportName = "John",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS.John_Eradicator
	},
	EDJ_Jolly = {
		IsOffsale = true,
		LimitedTime = true,
		PriceInRobux = 675,
		Price = 100,
		Currency = "Cookies",
		MinLevel = 0,
		ExpectedSkin = "EDJ_Jolly",
		ProductId = 3488501418,
		ViewportName = "EDJ"
	},
	["Oil Derrick_Candy Mine"] = {
		IsOffsale = true,
		HideInShop = true,
		LimitedTime = true,
		PriceInRobux = 400,
		Price = 300,
		Currency = "Eggs",
		MinLevel = 0,
		ExpectedSkin = "Oil Derrick_Candy Mine",
		ProductId = 3564608680,
		ViewportName = "Oil Derrick"
	},
	["Refractor_Home Defender"] = {
		IsOffsale = true,
		LimitedTime = true,
		PriceInRobux = 750,
		Price = 675,
		Currency = "Burgers",
		MinLevel = 0,
		ExpectedSkin = "Refractor_Home Defender",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Refractor_Home Defender"],
		ViewportName = "Refractor"
	},
	["Oil Derrick_WowBurger"] = {
		IsOffsale = true,
		LimitedTime = true,
		PriceInRobux = 375,
		Price = 325,
		Currency = "Burgers",
		MinLevel = 0,
		ExpectedSkin = "Oil Derrick_WowBurger",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Oil Derrick_WowBurger"],
		ViewportName = "Oil Derrick"
	},
	["Behemoth Factory_Spider Tank"] = {
		IsOffsale = true,
		LimitedTime = true,
		PriceInRobux = 550,
		Price = 475,
		Currency = "Burgers",
		MinLevel = 0,
		ExpectedSkin = "Behemoth Factory_Spider Tank",
		ProductId = Shared.SKIN_DEV_PRODUCT_IDS["Behemoth Factory_Spider Tank"],
		ViewportName = "Behemoth Factory"
	},
	Phaser_Void = {
		IsOffsale = true,
		Price = 2100000000,
		MinLevel = 0,
		ExpectedSkin = "Phaser_Void",
		ViewportName = "Phaser"
	}
}

for k, v in Crates.GetAllSkins() do
	if not (ShopDataV2Skins[k] == nil and v.Rarity ~= Enums.SkinRarities.Hidden) then
		continue
	end

	local v2 = {
		IsOffsale = v.CrateName == "Unobtainable",
		ViewportName = string.split(k, "_")[1],
		Price = 2100000000,
		FromCrate = v.CrateName,
		MinLevel = 0
	}

	if v2.IsOffsale then
		v2.FromCrate = nil
	end

	ShopDataV2Skins[k] = v2
end

return ShopDataV2Skins