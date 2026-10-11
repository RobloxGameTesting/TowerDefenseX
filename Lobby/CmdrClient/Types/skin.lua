local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Crates = require(TDX_Shared.Modules.Crates)
return function(registry)
	local v = {}

	for k, _ in Crates.GetAllSkins() do
		table.insert(v, k)
	end

	registry:RegisterType("skin", registry.Cmdr.Util.MakeEnumType("Skin", v))
end