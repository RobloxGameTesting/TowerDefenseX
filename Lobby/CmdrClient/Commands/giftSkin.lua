return {
	Name = "giftskin",
	Description = "Gifts a skin to a player",
	Group = "Manager",
	Args = {
		{ Type = "integer", Name = "userid", Description = "The player to gift the skin to" },
		{ Type = "skin", Name = "skin", Description = "The skin to gift" }
	}
}