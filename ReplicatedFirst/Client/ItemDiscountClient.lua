local RunService = game:GetService("RunService")
local ShopUtil = require(game.ReplicatedStorage.Modules.ShopUtil)
local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
local Network = require(script.Parent.Network)
local Signal = require(game.ReplicatedStorage.Modules.Signal)
local v = {}
local ItemDiscountClient = {
	DiscountsChanged = Signal.new(),
	GetDiscount = function(p)
		local encodeItemIdentifier = ShopUtil.EncodeItemIdentifier(p)
		return v[encodeItemIdentifier]
	end,
	GetPriceWithDiscount = function(p)
		local encodeItemIdentifier = ShopUtil.EncodeItemIdentifier(p)
		local price = ShopDataV2.Items[p.Type][p.Name].Price

		if not price then
			return nil
		end

		if v[encodeItemIdentifier] then
			return (math.round(price * (1 - v[encodeItemIdentifier])))
		end

		return price
	end,
	IsDiscounted = function(p)
		local encodeItemIdentifier = ShopUtil.EncodeItemIdentifier(p)
		return v[encodeItemIdentifier] ~= nil
	end
}
Network.HookEvent("UpdateItemDiscounts", function(p)
	v = p
	ItemDiscountClient.DiscountsChanged:Fire(v)

	if RunService:IsStudio() then
		print("[ItemDiscountClient] Discounts changed: ", v)
	end
end)
return ItemDiscountClient