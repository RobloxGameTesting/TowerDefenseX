return {
	Name = "spectate",
	Description = "Teleports you into a user's ongoing game as a spectator",
	Group = "Developer",
	Args = {
		{ Type = "integer", Name = "userId", Description = "The user id of the player to spectate" }
	}
}