local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local BattlePass = require(TDX_Shared.Modules.BattlePass)
return function(registry)
	local v = {}

	for k, _ in BattlePass.GetAllPasses() do
		table.insert(v, k)
	end

	registry:RegisterType("battlepass", registry.Cmdr.Util.MakeEnumType("BattlePass", v))
end