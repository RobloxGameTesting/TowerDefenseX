local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local ResourceManager = require(TDX_Shared.Common.ResourceManager)
return function(registry)
	local names = {}

	for _, child in ResourceManager.GetMiscResource("NameTags", true).Effects:GetChildren() do
		table.insert(names, child.Name)
	end

	registry:RegisterType("nametageffect", registry.Cmdr.Util.MakeEnumType("NameTagEffect", names))
end