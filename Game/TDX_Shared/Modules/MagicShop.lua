local WeightedRandom = require(script.Parent.WeightedRandom)
local v = {
	GoldToCrystals150To1 = {
		Type = "GoldToCrystalsConversion",
		GoldRatio = 150,
		AvailableCrystals = NumberRange.new(100, 200),
		Weight = 15
	},
	GoldToCrystals125To1 = {
		Type = "GoldToCrystalsConversion",
		GoldRatio = 125,
		AvailableCrystals = NumberRange.new(100, 200),
		Weight = 10
	},
	GoldToCrystals100To1 = {
		Type = "GoldToCrystalsConversion",
		GoldRatio = 100,
		AvailableCrystals = NumberRange.new(100, 150),
		Weight = 15
	},
	GoldToCrystals75To1 = {
		Type = "GoldToCrystalsConversion",
		GoldRatio = 75,
		AvailableCrystals = NumberRange.new(100, 150),
		Weight = 5
	},
	GoldToCrystals50To1 = {
		Type = "GoldToCrystalsConversion",
		GoldRatio = 50,
		AvailableCrystals = NumberRange.new(100, 150),
		Weight = 1
	},
	CookiesToCrystals100To1 = {
		Type = "CrystalsToCookiesConversion",
		GoldRatio = 100,
		AvailableCrystals = NumberRange.new(3, 8),
		Weight = 0
	},
	CookiesToCrystals75To1 = {
		Type = "CrystalsToCookiesConversion",
		GoldRatio = 75,
		AvailableCrystals = NumberRange.new(3, 6),
		Weight = 0
	},
	CookiesToCrystals50To1 = {
		Type = "CrystalsToCookiesConversion",
		GoldRatio = 50,
		AvailableCrystals = NumberRange.new(3, 5),
		Weight = 0
	}
}
local weights = {}

for k, v2 in v do
	weights[k] = v2.Weight
end

local v2 = WeightedRandom.from(weights)
local MagicShop = {
	ATTR_MAGIC_SHOP_END_TIME = "MagicShopEndTime",
	TAG_MAGIC_SHOP_NPC = "MagicShopNPC"
}

function MagicShop.GetEntry(p: string)
	return v[p]
end

function MagicShop.GetRandomEntryId(p: number?)
	return v2:GetRandomValue(p and Random.new(p) or nil)
end

return MagicShop