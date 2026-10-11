return {
	Name = "norestartloadbranch",
	Description = "Loads a config dashboard branch and applies its overrides to the live game. some edits may require a restart.",
	Group = "SuperBreadTester",
	Args = {
		{ Type = "string", Name = "branch", Description = "The config dashboard branch id to load" }
	}
}