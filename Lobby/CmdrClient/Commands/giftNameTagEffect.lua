return {
	Name = "giftnametageffect",
	Description = "Gifts a name tag effect",
	Group = "Manager",
	Args = {
		{
			Type = "integer",
			Name = "userid",
			Description = "The player to gift the name tag effect to"
		},
		{
			Type = "nametageffect",
			Name = "nametageffect",
			Description = "The name tag effect to gift"
		}
	}
}