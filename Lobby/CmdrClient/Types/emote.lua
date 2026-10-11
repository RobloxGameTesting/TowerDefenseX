local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
return function(registry)
	local v = {}

	for k, _ in EmoteAnimationsV2 do
		table.insert(v, k)
	end

	registry:RegisterType("emote", registry.Cmdr.Util.MakeEnumType("Emote", v))
end