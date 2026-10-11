local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Enums = require(TDX_Shared.Common.Enums)
return function(registry)
	local powerUps = {}

	for _, powerUp in Enums.PowerUps do
		table.insert(powerUps, powerUp)
	end

	registry:RegisterType("powerup", registry.Cmdr.Util.MakeEnumType("PowerUp", powerUps))
end