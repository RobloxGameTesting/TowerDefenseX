return {
	Name = "spawnpathentity",
	Description = "Spawns a path entity!!",
	Group = "SuperBreadTester",
	Args = {
		{ Type = "pathentity", Name = "pathentity", Description = "The path entity to spawn" },
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
			Type = "string",
			Name = "skin",
			Description = "The skin to apply to this path entity",
			Optional = true
		}
	}
}