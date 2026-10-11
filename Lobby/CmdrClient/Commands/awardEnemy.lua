local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardenemy",
	Description = "Gives a player an enemy",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give the enemy to" },
		{ Type = "enemy", Name = "enemy", Description = "The enemy to give" }
	}
}