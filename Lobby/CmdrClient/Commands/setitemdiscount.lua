return {
	Name = "setitemdiscount",
	Description = "Sets a discount for a shop item",
	Group = "Programmer",
	Args = {
		{
			Type = "string",
			Name = "item",
			Description = "The encoded ItemIdentifier (e.g. Towers_Sniper)"
		},
		{
			Type = "number",
			Name = "discount",
			Description = "The discount (0 to remove, e.g. 0.2 for 20%)"
		}
	}
}