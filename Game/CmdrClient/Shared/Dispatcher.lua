local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Util = require(script.Parent.Util)
local Command = require(script.Parent.Command)
local v = false
local v2 = { Cmdr = nil, Registry = nil }

function v2:Evaluate(text: string, executor, flag: boolean?, p)
	if RunService:IsClient() == true and executor ~= Players.LocalPlayer then
		error("[Cmdr] Can't evaluate a command that isn't sent by the local player.")
	end

	local splitString = Util.SplitString(text)
	local alias = table.remove(splitString, 1)
	local command = self.Registry:GetCommand(alias)

	if not command then
		return
			false,
			("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(alias)))
	end

	local mashExcessArguments = Util.MashExcessArguments(splitString, #command.Args)
	local v3 = Command.new({
		Dispatcher = self,
		Text = text,
		CommandObject = command,
		Alias = alias,
		Executor = executor,
		Arguments = mashExcessArguments,
		Data = p
	})
	local parsed, v4 = v3:Parse(flag)

	if parsed then
		return v3
	end

	return false, v4
end

function v2:EvaluateAndRun(p: string, p2, options)
	local v3 = p2 or Players.LocalPlayer
	local v4 = options or {}

	if RunService:IsClient() and v4.IsHuman then
		self:PushHistory(p)
	end

	local evaluate, v5 = self:Evaluate(p, v3, nil, v4.Data)

	if not evaluate then
		return v5
	end

	local success, result = xpcall(function()
		local v6, v7 = evaluate:Validate(true)

		if v6 then
			return evaluate:Run() or "Command executed."
		end

		return v7
	end, function(p3)
		return debug.traceback((tostring(p3)))
	end)

	if not success then
		warn((`[Cmdr] Error occurred while evaluating command string %q\n{tostring(result)}`):format(p))
	end

	return success and result or "An error occurred while running this command. Check the console for more information."
end

function v2.Send(p, p2: string, p3)
	if RunService:IsClient() == false then
		error("[Cmdr] Dispatcher:Send can only be called from the client.")
	end

	return p.Cmdr.RemoteFunction:InvokeServer(p2, { Data = p3 })
end

function v2:Run(...)
	if not Players.LocalPlayer then
		error("[Cmdr] Dispatcher:Run can only be called from the client.")
	end

	local v3 = { ... }
	local v4 = v3[1]

	for i = 2, #v3 do
		v4 ..= " " .. tostring(v3[i])
	end

	local evaluate, v5 = self:Evaluate(v4, Players.LocalPlayer)

	if not evaluate then
		error(v5)
	end

	local v6, v7 = evaluate:Validate(true)

	if not v6 then
		error(v7)
	end

	return evaluate:Run()
end

function v2.RunGuards(_, p, ...)
	local guards = p.Object.Guards

	if guards == nil then
		return
	end

	local typeName = typeof(guards)
	assert(typeName == "table", `expected a table for Command.Guards, got {typeName}`)

	for _, guard in pairs(guards) do
		local typeName2 = typeof(guard)
		assert(typeName2 == "function", `expected a function for a value in Command.Guards, got {typeName2}`)
		local v3 = guard(p, ...)

		if v3 ~= nil then
			return (tostring(v3))
		end
	end
end

function v2.RunHooks(p, p2: string, object, ...)
	if not p.Registry.Hooks[p2] then
		error(("[Cmdr] Invalid hook name: %q"):format(p2), 2)
	end

	if
		p2 == "BeforeRun"
		and #p.Registry.Hooks[p2] == 0
		and object.Group ~= "DefaultUtil"
		and object.Group ~= "UserAlias"
		and object:HasImplementation()
	then
		if not RunService:IsStudio() then
			return "Command blocked for security as no BeforeRun hook is configured."
		end

		if v == false then
			object:Reply(
				(RunService:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html",
				Color3.fromRGB(255, 228, 26)
			)
			v = true
		end
	end

	for _, v3 in ipairs(p.Registry.Hooks[p2]) do
		local callback = v3.callback(object, ...)

		if callback ~= nil then
			return (tostring(callback))
		end
	end
end

function v2:PushHistory(p: string)
	assert(RunService:IsClient(), "[Cmdr] PushHistory may only be used from the client.")
	local history = self:GetHistory()

	if Util.TrimString(p) == "" or p == history[#history] then
		return
	end

	history[#history + 1] = p
	TeleportService:SetTeleportSetting("CmdrCommandHistory", history)
end

function v2:GetHistory()
	assert(RunService:IsClient(), "[Cmdr] GetHistory may only be used from the client.")
	return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {}
end

return function(cmdr)
	v2.Cmdr = cmdr
	v2.Registry = cmdr.Registry
	return v2
end