local common = game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return function(registry)
	local enemies = {}

	for _, enemy in Enums.Enemies do
		table.insert(enemies, enemy)
	end

	registry:RegisterType("enemy", registry.Cmdr.Util.MakeEnumType("Enemy", enemies))
end