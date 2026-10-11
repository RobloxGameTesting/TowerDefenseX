local random = Random.new()
return {
	Name = "rand",
	Aliases = {},
	Description = "Returns a random number between min and max",
	Group = "DefaultUtil",
	Args = {
		{
			Type = "integer",
			Name = "First number",
			Description = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."
		},
		{
			Type = "integer",
			Name = "Second number",
			Description = "The upper bound.",
			Optional = true
		}
	},
	ClientRun = function(_, p, p2)
		local v

		if p2 then
			v = random:NextInteger(p, p2)
		else
			v = random:NextInteger(1, p)
		end

		return (tostring(v))
	end
}