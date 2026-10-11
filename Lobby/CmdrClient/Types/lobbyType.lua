local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local LobbyTypeUtilities = require(TDX_Shared.Common.LobbyTypeUtilities)
return function(registry)
	local v = {}

	for k, _ in LobbyTypeUtilities.LOBBY_TYPES do
		table.insert(v, k)
	end

	registry:RegisterType("lobbyType", registry.Cmdr.Util.MakeEnumType("LobbyType", v))
end