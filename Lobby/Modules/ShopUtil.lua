local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopDataV2 = require(script.Parent.ShopDataV2)
local Crates = require(ReplicatedStorage:WaitForChild("TDX_Shared").Modules.Crates)
require(ReplicatedStorage.TDX_Shared.Common.CurrencyTypes)
local ShopUtil = {}

function ShopUtil.EncodeItemIdentifier(p)
	return `{p.Type}_{p.Name}`
end

function ShopUtil.DecodeItemIdentifier(value: string)
	local parts = value:split("_")
	assert(#parts >= 2, "Invalid item identifier")
	local part = parts[1]
	local joined = table.concat(parts, "_", 2)

	if not ShopDataV2.Items[part] then
		error(`Invalid item type: {part} (item = {joined})`)
	end

	return { Type = part, Name = joined }
end

function ShopUtil.GetBuyAllCrateSkinsInfo(p: string, p2)
	local crate = ShopDataV2.Items.Crates[p]

	if not crate or crate.IsOffsale or crate.BuyAllDisabled then
		return nil
	end

	local crateData = Crates.GetCrateData(p)

	if not crateData.CanBeOpened then
		return nil
	end

	local v = {}
	local count = 0
	local names = {}

	for _, skin in crateData.Skins do
		if v[skin.Name] then
			continue
		end

		v[skin.Name] = true
		count += 1

		if not p2[skin.Name] then
			table.insert(names, skin.Name)
		end
	end

	local v2 = {
		SkinCount = count,
		MissingSkins = names,
		Currency = crate.Currency or "Gold"
	}

	if crate.BuyAllProductId and crate.PriceInRobux and #names == count then
		v2.ProductId = crate.BuyAllProductId
		v2.PriceInRobux = crate.PriceInRobux * count
	end

	if not crate.IsRobuxOnly and crate.Price and crate.Price > 0 and #names > 0 then
		v2.Price = crate.Price * #names
	end

	if v2.ProductId == nil and v2.Price == nil then
		return nil
	end

	return v2
end

return ShopUtil