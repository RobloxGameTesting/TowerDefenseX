local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "setnametagstyle",
	Description = "",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Manager",
	Args = {
		{ Type = "nametagstyle", Name = "style", Description = "" }
	}
}