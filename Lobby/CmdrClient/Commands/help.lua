return {
	Name = "help",
	Aliases = { "cmds", "commands" },
	Description = "Displays a list of all commands, or inspects one command.",
	Group = "Help",
	Args = {
		{
			Type = "command",
			Name = "Command",
			Description = "The command to view information on",
			Optional = true
		}
	},
	ClientRun = function(object, p)
		if p then
			local command = object.Cmdr.Registry:GetCommand(p)
			object:Reply(`Command: {command.Name}`, Color3.fromRGB(230, 126, 34))

			if command.Aliases and #command.Aliases > 0 then
				object:Reply(`Aliases: {table.concat(command.Aliases, ", ")}`, Color3.fromRGB(230, 230, 230))
			end

			if command.Description then
				object:Reply(`Description: {command.Description}`, Color3.fromRGB(230, 230, 230))
			end

			if command.Group then
				object:Reply(`Group: {command.Group}`, Color3.fromRGB(230, 230, 230))
			end

			if command.Args then
				for i, arg in ipairs(command.Args) do
					object:Reply(`#{i} {type(arg) ~= "table" and "Unknown (inline argument)" or `{arg.Name}{arg.Optional == true and "?" or ""}: {arg.Type} - {arg.Description}`}`)
				end
			end
		else
			object:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n")
			object:Reply("Tips\n----\n• Utilize the Tab key to automatically complete commands\n• Easily select and copy command output\n")
			local commands = object.Cmdr.Registry:GetCommands()
			table.sort(commands, function(a, b)
				if a.Group and b.Group then
					return a.Group < b.Group
				end

				return a.Group
			end)
			local v = nil

			for _, command in ipairs(commands) do
				local group = command.Group or "No Group"

				if v ~= group then
					object:Reply(`\n{group}\n{string.rep("-", #group)}`)
					v = group
				end

				local v2

				if command.Description then
					v2 = `{command.Name} - {command.Description}`
				else
					v2 = command.Name
				end

				object:Reply(v2)
			end
		end

		return ""
	end
}