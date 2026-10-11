return {
	Name = "getelo",
	Description = "Shows a player's PVP ELO ratings (Studio/dev places only)",
	Group = "SuperBreadTester",
	Args = {
		{
			Type = "player",
			Name = "player",
			Description = "The player whose ELO to check (defaults to you)",
			Optional = true
		}
	}
}