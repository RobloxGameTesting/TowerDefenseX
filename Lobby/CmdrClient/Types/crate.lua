local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Crates = require(TDX_Shared.Modules.Crates)
return function(registry)
	local v = {}

	for k, _ in Crates.GetCrates() do
		table.insert(v, k)
	end

	registry:RegisterType("crate", registry.Cmdr.Util.MakeEnumType("Crate", v))
end