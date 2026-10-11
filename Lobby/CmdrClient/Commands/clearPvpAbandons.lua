return {
	Name = "clearpvpabandons",
	Description = "Clears all PVP abandons for a player",
	Group = "Programmer",
	Args = {
		{
			Type = "player",
			Name = "player",
			Description = "The player whose abandons to clear (defaults to you)",
			Optional = true
		}
	}
}