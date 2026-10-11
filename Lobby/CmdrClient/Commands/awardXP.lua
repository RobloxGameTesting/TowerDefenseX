local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardxp",
	Description = "Gives a player XP",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give XP to" },
		{ Type = "integer", Name = "value", Description = "The amount of XP to give" }
	}
}