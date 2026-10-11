return {
	Name = "gifttower",
	Description = "Gifts a tower",
	Group = "Manager",
	Args = {
		{ Type = "integer", Name = "userid", Description = "The player to gift the tower to" },
		{ Type = "tower", Name = "tower", Description = "The tower to gift" }
	}
}