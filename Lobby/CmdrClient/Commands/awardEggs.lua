local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardeggs",
	Description = "Gives eggs to a player",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Manager",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give eggs to" },
		{ Type = "integer", Name = "value", Description = "The amount of eggs give" }
	}
}