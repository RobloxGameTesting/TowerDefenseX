return {
	Name = "simulatepvpabandon",
	Description = "Simulates a PVP match abandon for testing penalties",
	Group = "Programmer",
	Args = {
		{
			Type = "player",
			Name = "player",
			Description = "The player to add an abandon to (defaults to you)",
			Optional = true
		}
	}
}