local class = {}
class.__index = class
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isServer = RunService:IsServer()
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local v = {}

function class.GetRemoteFunctionWrappers()
	return v
end

if isServer then
	local function CreateRemoteFunction(name) -- 1 equivalent call inferred from this helper
		local remoteFunction = Instance.new("RemoteFunction")
		remoteFunction.Name = name
		remoteFunction.Parent = Remotes
		return remoteFunction
	end

	function class.New(name: string)
		local v2 = { Name = name, RemoteFunction = CreateRemoteFunction(name) } -- inferred equivalent call
		v[name] = v2
		return (setmetatable(v2, class))
	end

	function class.AttachCallback(p, callback)
		p.RemoteFunction.OnServerInvoke = function(p2, ...)
			return callback(p2, ...)
		end
	end

	function class.GetInitData(p)
		return { Name = p.Name }
	end

	return class
else
	function class.New(remoteFunction)
		local v2 = { Name = remoteFunction.Name, RemoteFunction = remoteFunction }
		v[remoteFunction.Name] = v2
		return (setmetatable(v2, class))
	end

	function class:InvokeServer(...)
		return self.RemoteFunction:InvokeServer(...)
	end

	return class
end