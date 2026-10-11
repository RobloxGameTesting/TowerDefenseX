local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
return {
	Name = "awardpowerup",
	Description = "Gives a player some powerups",
	Group = Shared.IS_DEV_PLACE and "Contractor" or "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player to give the powerups to" },
		{ Type = "powerup", Name = "powerup", Description = "The powerup to give" },
		{
			Type = "positiveInteger",
			Name = "amount",
			Description = "The number of powerups to give",
			Optional = true,
			Default = 1
		}
	}
}