local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardemote",
	Description = "Gives a player an emote",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "SuperBreadTester",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give the emote to" },
		{ Type = "emote", Name = "emote", Description = "The emote to give" }
	}
}