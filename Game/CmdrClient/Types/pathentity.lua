local common = game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
return function(registry)
	local pathEntities = {}

	for _, pathEntity in Enums.PathEntities do
		table.insert(pathEntities, pathEntity)
	end

	registry:RegisterType("pathentity", registry.Cmdr.Util.MakeEnumType("PathEntity", pathEntities))
end