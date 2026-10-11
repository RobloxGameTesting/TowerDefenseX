local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Argument = require(script.Parent.Argument)
local isServer = RunService:IsServer()
local Command = {}
Command.__index = Command

function Command.new(data)
	local v = {
		Dispatcher = data.Dispatcher,
		Cmdr = data.Dispatcher.Cmdr,
		Name = data.CommandObject.Name,
		RawText = data.Text,
		Object = data.CommandObject,
		Group = data.CommandObject.Group,
		State = {},
		Aliases = data.CommandObject.Aliases,
		Alias = data.Alias,
		Description = data.CommandObject.Description,
		Executor = data.Executor,
		ArgumentDefinitions = data.CommandObject.Args,
		RawArguments = data.Arguments,
		Arguments = {},
		Data = data.Data,
		Response = nil,
		Guards = data.Guards
	}
	setmetatable(v, Command)
	return v
end

function Command.Parse(data, p)
	local v = false

	for i, argumentDefinition in ipairs(data.ArgumentDefinitions) do
		if type(argumentDefinition) == "function" then
			argumentDefinition = argumentDefinition(data)

			if argumentDefinition == nil then
				break
			end
		end

		local v2

		if argumentDefinition.Default == nil then
			v2 = argumentDefinition.Optional ~= true
		else
			v2 = false
		end

		if v2 and v then
			error(("[Cmdr] Command %q: Required arguments cannot occur after optional arguments."):format(data.Name))
		else
			v = not v2 or v
		end

		if data.RawArguments[i] == nil and v2 and p ~= true then
			return false, ("Required argument #%d %s is missing."):format(i, argumentDefinition.Name)
		end

		if data.RawArguments[i] or p then
			data.Arguments[i] = Argument.new(data, argumentDefinition, data.RawArguments[i] or "")
		end
	end

	return true
end

function Command:Validate(p)
	self._Validated = true
	local v = ""
	local v2 = true

	for k, argument in pairs(self.Arguments) do
		local v3, v4 = argument:Validate(p)

		if v3 then
			continue
		end

		v = ("%s; #%d %s: %s"):format(v, k, argument.Name, v4 or "error")
		v2 = false
	end

	return v2, v:sub(3)
end

function Command.GetLastArgument(p)
	for i = #p.Arguments, 1, -1 do
		if p.Arguments[i].RawValue then
			return p.Arguments[i]
		end
	end
end

function Command:GatherArgumentValues()
	local result = {}

	for i = 1, #self.ArgumentDefinitions do
		local argument = self.Arguments[i]

		if argument then
			result[i] = argument:GetValue()
		elseif type(self.ArgumentDefinitions[i]) == "table" then
			result[i] = self.ArgumentDefinitions[i].Default
		end
	end

	return result, #self.ArgumentDefinitions
end

function Command:Run()
	if self._Validated == nil then
		error("[Cmdr] Must validate a command before running.")
	end

	local v = self.Dispatcher:RunHooks("BeforeRun", self)

	if v then
		return v
	end

	local v2 = self.Dispatcher:RunGuards(self)

	if v2 then
		return v2
	end

	if not isServer and self.Object.Data and self.Data == nil then
		local argumentValues, v3 = self:GatherArgumentValues()
		self.Data = self.Object.Data(self, unpack(argumentValues, 1, v3))
	end

	if not isServer and self.Object.ClientRun then
		local argumentValues, v3 = self:GatherArgumentValues()
		self.Response = self.Object.ClientRun(self, unpack(argumentValues, 1, v3))
	end

	if self.Response == nil then
		if self.Object.Run then
			local argumentValues, v3 = self:GatherArgumentValues()
			self.Response = self.Object.Run(self, unpack(argumentValues, 1, v3))
		elseif isServer then
			if self.Object.ClientRun then
				warn(`[Cmdr] {self.Name} command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.`)
			else
				warn(`[Cmdr] {self.Name} command has no implementation!`)
			end

			self.Response = "No implementation."
		else
			self.Response = self.Dispatcher:Send(self.RawText, self.Data)
		end
	end

	local v3 = self.Dispatcher:RunHooks("AfterRun", self)
	return v3 or self.Response
end

function Command.GetArgument(p, p2)
	return p.Arguments[p2]
end

function Command:GetData()
	if self.Data then
		return self.Data
	end

	if self.Object.Data and not isServer then
		self.Data = self.Object.Data(self)
	end

	return self.Data
end

function Command:SendEvent(player, value, ...)
	local v = typeof(player) == "Instance" and player:IsA("Player")
	assert(v, "[Cmdr] Argument #1 must be a Player")
	assert(type(value) == "string", "[Cmdr] Argument #2 must be a string")

	if isServer then
		self.Dispatcher.Cmdr.RemoteEvent:FireClient(player, value, ...)
	elseif self.Dispatcher.Cmdr.Events[value] then
		assert(
			player == Players.LocalPlayer,
			"[Cmdr] Event messages can only be sent to the local player on the client."
		)
		self.Dispatcher.Cmdr.Events[value](...)
	end
end

function Command.BroadcastEvent(p, ...)
	if not isServer then
		error("[Cmdr] Can't broadcast event messages from the client.", 2)
	end

	p.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end

function Command:Reply(...)
	return self:SendEvent(self.Executor, "AddLine", ...)
end

function Command:GetStore(...)
	return self.Dispatcher.Cmdr.Registry:GetStore(...)
end

function Command.HasImplementation(p)
	if RunService:IsClient() and p.Object.ClientRun or p.Object.Run then
		return true
	end

	return false
end

return Command