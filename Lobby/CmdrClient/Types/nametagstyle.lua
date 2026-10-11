local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local ResourceManager = require(TDX_Shared.Common.ResourceManager)
return function(registry)
	local names = {}

	for _, child in ResourceManager.GetMiscResource("NameTags", true).Styles:GetChildren() do
		table.insert(names, child.Name)
	end

	registry:RegisterType("nametagstyle", registry.Cmdr.Util.MakeEnumType("NameTagStyle", names))
end