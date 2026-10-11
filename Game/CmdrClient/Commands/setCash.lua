return {
	Name = "setcash",
	Description = "Sets the amount of cash a player has",
	Group = "Developer",
	Args = {
		{ Type = "player", Name = "player", Description = "The player whose cash to set" },
		{
			Type = "nonNegativeInteger",
			Name = "value",
			Description = "The amount to set the cash to"
		}
	}
}