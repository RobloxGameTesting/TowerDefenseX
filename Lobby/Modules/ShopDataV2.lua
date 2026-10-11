local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("CurrencyTypes"))

local function calculateSortPriority(p) -- 2 equivalent calls inferred from this helper
	if p.Data.New then
		return 1
	end

	if p.Data.LimitedTime then
		return 2
	end

	if p.Data.OnSale then
		return 3
	end

	if p.Data.Currency == "Crystals" then
		return 4
	end

	return 5
end

local function defaultSort(p, p2)
	local sortPriority = calculateSortPriority(p) -- inferred equivalent call
	local sortPriority2 = calculateSortPriority(p2) -- inferred equivalent call

	if sortPriority == sortPriority2 then
		return p.Name < p2.Name
	end

	return sortPriority < sortPriority2
end

local function costSortGold(p, p2)
	local currency = p.Data.Currency or "Gold"
	local currency2 = p2.Data.Currency or "Gold"

	if currency == "Gold" and currency2 ~= "Gold" then
		return true
	end

	if currency ~= "Gold" and currency2 == "Gold" or currency ~= "Gold" and currency2 ~= "Gold" then
		return false
	end

	local price = p.Data.Price or 1e999
	local price2 = p2.Data.Price or 1e999

	if price == price2 then
		return p.Name < p2.Name
	end

	return price < price2
end

local function costSortCrystals(p, p2)
	if p.Data.Currency == "Crystals" and p2.Data.Currency ~= "Crystals" then
		return true
	end

	if p.Data.Currency ~= "Crystals" and p2.Data.Currency == "Crystals" then
		return false
	end

	if p.Data.Currency == "Crystals" or p2.Data.Currency == "Crystals" then
		return p.Data.Price == p2.Data.Price and p.Name < p2.Name or p.Data.Price < p2.Data.Price
	end

	return false
end

local function costSortRobux(p, p2)
	local priceInRobux = p.Data.PriceInRobux or 2100000000
	local priceInRobux2 = p2.Data.PriceInRobux or 2100000000
	return priceInRobux == priceInRobux2 and p.Name < p2.Name or priceInRobux < priceInRobux2
end

local function sortRarity(p, p2)
	if p.Rarity == p2.Rarity then
		return p.Name < p2.Name
	end

	return p.Rarity < p2.Rarity
end

local ShopDataV2_NameTags = require(script.Parent.ShopDataV2_NameTags)
return {
	PageMeta = {
		Towers = {
			OwnedPillVisible = true,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = true,
			UnownedPillVisible = false,
			SortOrders = {
				Default = defaultSort,
				["Cost (Gold)"] = costSortGold,
				["Cost (Robux)"] = costSortRobux,
				["Cost (Crystals)"] = costSortCrystals
			},
			SortOrdering = {
				Default = 1,
				["Cost (Gold)"] = 2,
				["Cost (Robux)"] = 4,
				["Cost (Crystals)"] = 3
			},
			InventoryOverride = {
				OwnedPillVisible = false,
				OffsalePillVisible = false,
				CrateSkinsPillVisible = false,
				SortVisible = false,
				UnownedPillVisible = true,
				SortOrders = { Default = defaultSort },
				SortOrdering = { Default = 1 }
			}
		},
		Skins = {
			OwnedPillVisible = true,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = true,
			SortVisible = true,
			UnownedPillVisible = false,
			SortOrders = {
				Default = defaultSort,
				["Cost (Gold)"] = costSortGold,
				["Cost (Robux)"] = costSortRobux,
				Rarity = sortRarity
			},
			SortOrdering = { Default = 1, ["Cost (Gold)"] = 2, ["Cost (Robux)"] = 3, Rarity = 4 },
			InventoryOverride = {
				OwnedPillVisible = false,
				OffsalePillVisible = false,
				CrateSkinsPillVisible = false,
				SortVisible = true,
				UnownedPillVisible = true,
				SortOrders = {
					Default = defaultSort,
					["Cost (Gold)"] = costSortGold,
					["Cost (Robux)"] = costSortRobux,
					Rarity = sortRarity
				},
				SortOrdering = {
					Default = 1,
					["Cost (Gold)"] = 2,
					["Cost (Robux)"] = 3,
					Rarity = 4
				}
			}
		},
		Crates = {
			OwnedPillVisible = false,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = false,
			UnownedPillVisible = false,
			SortOrders = { Default = defaultSort },
			SortOrdering = { Default = 1 }
		},
		PowerUps = {
			OwnedPillVisible = false,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = true,
			UnownedPillVisible = false,
			SortOrders = {
				Default = defaultSort,
				["Cost (Gold)"] = costSortGold,
				["Cost (Robux)"] = costSortRobux
			},
			SortOrdering = { Default = 1, ["Cost (Gold)"] = 2, ["Cost (Robux)"] = 3 },
			InventoryOverride = {
				OwnedPillVisible = false,
				OffsalePillVisible = false,
				CrateSkinsPillVisible = false,
				SortVisible = false,
				UnownedPillVisible = false,
				SortOrders = { Default = defaultSort },
				SortOrdering = { Default = 1 }
			}
		},
		Emotes = {
			OwnedPillVisible = true,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = true,
			UnownedPillVisible = false,
			SortOrders = {
				Default = defaultSort,
				["Cost (Gold)"] = costSortGold,
				["Cost (Robux)"] = costSortRobux
			},
			SortOrdering = { Default = 1, ["Cost (Gold)"] = 2, ["Cost (Robux)"] = 3 },
			InventoryOverride = {
				OwnedPillVisible = false,
				OffsalePillVisible = false,
				CrateSkinsPillVisible = false,
				SortVisible = false,
				UnownedPillVisible = true,
				SortOrders = { Default = defaultSort },
				SortOrdering = { Default = 1 }
			}
		},
		Bundles = {
			OwnedPillVisible = false,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = false,
			UnownedPillVisible = false,
			SortOrders = { Default = defaultSort },
			SortOrdering = { Default = 1 }
		},
		NameTagEffects = {
			OwnedPillVisible = false,
			OffsalePillVisible = false,
			CrateSkinsPillVisible = false,
			SortVisible = false,
			UnownedPillVisible = false,
			SortOrders = { Default = defaultSort },
			SortOrdering = { Default = 1 },
			InventoryOverride = {
				OwnedPillVisible = false,
				OffsalePillVisible = false,
				CrateSkinsPillVisible = false,
				SortVisible = false,
				UnownedPillVisible = false,
				SortOrders = { Default = defaultSort },
				SortOrdering = { Default = 1 }
			}
		},
		Enemies = {
			OwnedPillVisible = true,
			OffsalePillVisible = true,
			CrateSkinsPillVisible = false,
			SortVisible = true,
			UnownedPillVisible = false,
			SortOrders = {
				Default = defaultSort,
				["Cost (Gold)"] = costSortGold,
				["Cost (Robux)"] = costSortRobux
			},
			SortOrdering = { Default = 1, ["Cost (Gold)"] = 2, ["Cost (Robux)"] = 4 }
		}
	},
	Items = {
		Bundles = require(script.Parent.ShopDataV2_Bundles),
		Towers = require(script.Parent.ShopDataV2_Towers),
		Skins = require(script.Parent.ShopDataV2_Skins),
		Crates = require(script.Parent.ShopDataV2_Crates),
		PowerUps = require(script.Parent.ShopDataV2_PowerUps),
		Emotes = require(script.Parent.ShopDataV2_Emotes),
		NameTagStyles = ShopDataV2_NameTags.Styles,
		NameTagEffects = ShopDataV2_NameTags.Effects,
		Enemies = require(script.Parent.ShopDataV2_Enemies)
	}
}