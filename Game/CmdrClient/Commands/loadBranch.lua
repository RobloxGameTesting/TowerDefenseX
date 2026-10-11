return {
	Name = "loadbranch",
	Description = "Loads a config dashboard branch and applies its overrides to the live game. Enemy/ability edits apply immediately.",
	Group = "SuperBreadTester",
	Args = {
		{ Type = "string", Name = "branch", Description = "The config dashboard branch id to load" }
	}
}