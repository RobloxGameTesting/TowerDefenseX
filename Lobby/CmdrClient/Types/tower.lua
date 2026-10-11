local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Enums = require(TDX_Shared.Common.Enums)
return function(registry)
	local towers = {}

	for _, tower in Enums.Towers do
		table.insert(towers, tower)
	end

	registry:RegisterType("tower", registry.Cmdr.Util.MakeEnumType("Tower", towers))
end