return {
	Name = "giftpass",
	Description = "Gifts a battlepass to a player",
	Group = "Manager",
	Args = {
		{ Type = "integer", Name = "userid", Description = "The player to gift the pass to" },
		{ Type = "battlepass", Name = "battlepass", Description = "The battlepass to gift" }
	}
}