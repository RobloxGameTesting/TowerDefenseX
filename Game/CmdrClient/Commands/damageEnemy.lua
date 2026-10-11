return {
	Name = "damageenemyoftype",
	Description = "Damages all enemies of type",
	Group = "Programmer",
	Args = {
		{ Type = "enemy", Name = "enemy", Description = "The enemy type to target" },
		{
			Type = "nonNegativeInteger",
			Name = "damage",
			Description = "The amount of damage to apply"
		}
	}
}