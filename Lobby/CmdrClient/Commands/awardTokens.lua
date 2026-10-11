local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardtokens",
	Description = "Gives a player battle pass tokens",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give tokens to" },
		{ Type = "battlepass", Name = "pass", Description = "The pass to award tokens for" },
		{ Type = "integer", Name = "value", Description = "The amount of tokens to give" }
	}
}