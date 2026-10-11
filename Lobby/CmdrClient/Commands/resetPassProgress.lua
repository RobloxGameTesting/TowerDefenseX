local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "resetpassprogress",
	Description = "Resets a player's battlepass progress (tokens, claimed tiers, quests). Keeps the pass unlocked",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player whose progress to reset" },
		{
			Type = "battlepass",
			Name = "battlepass",
			Description = "The battlepass to reset (defaults to their active pass)",
			Optional = true
		}
	}
}