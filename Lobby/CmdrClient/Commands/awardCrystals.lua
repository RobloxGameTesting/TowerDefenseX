local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardcrystals",
	Description = "Gives a player crystals",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give crystals to" },
		{ Type = "integer", Name = "value", Description = "The amount of crystals to give" }
	}
}