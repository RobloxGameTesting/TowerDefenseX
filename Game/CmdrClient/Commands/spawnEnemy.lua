return {
	Name = "spawnenemy",
	Description = "Spawns an enemy!!!",
	Group = "SuperBreadTester",
	Args = {
		{ Type = "enemy", Name = "enemy", Description = "The enemy to spawn" },
		{
			Type = "integer",
			Name = "spawn count",
			Description = "The number of this enemy to spawn",
			Optional = true
		},
		{
			Type = "number",
			Name = "spawn interval",
			Description = "The time (in seconds) between spawns",
			Optional = true,
			Default = 1
		},
		{
			Type = "number",
			Name = "health multiplier",
			Description = "The multiplier to apply to the enemy's health",
			Optional = true
		}
	}
}