local ShopDataV2 = require(game.ReplicatedStorage.Modules.ShopDataV2)
return function(registry)
	local v = {}

	for k, _ in ShopDataV2.Items.Enemies do
		table.insert(v, k)
	end

	registry:RegisterType("enemy", registry.Cmdr.Util.MakeEnumType("Enemy", v))
end