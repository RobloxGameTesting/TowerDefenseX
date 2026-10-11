local common = game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapData = require(common:WaitForChild("MapData"))
return function(registry)
	local v = {}

	for k in MapData do
		table.insert(v, k)
	end

	table.sort(v)
	registry:RegisterType("map", registry.Cmdr.Util.MakeEnumType("Map", v))
end