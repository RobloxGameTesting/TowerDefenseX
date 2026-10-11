return {
	Name = "giftcrate",
	Description = "Gifts a crate",
	Group = "Programmer",
	Args = {
		{ Type = "integer", Name = "userid", Description = "The player to gift the crate to" },
		{ Type = "crate", Name = "crate", Description = "The crate to gift" }
	}
}