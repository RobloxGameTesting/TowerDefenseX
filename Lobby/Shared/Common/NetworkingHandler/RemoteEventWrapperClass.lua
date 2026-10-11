local class = {}
class.__index = class
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local isServer = RunService:IsServer()
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local v = {}

function class.GetRemoteEventWrappers()
	return v
end

if isServer then
	local function CreateRemoteEvent(name) -- 1 equivalent call inferred from this helper
		local remoteEvent = Instance.new("RemoteEvent")
		remoteEvent.Name = name
		remoteEvent.Parent = Remotes
		return remoteEvent
	end

	function class.New(name: string, isServerToClient: boolean)
		local v2 = {
			Name = name,
			RemoteEvent = CreateRemoteEvent(name), -- inferred equivalent call
			IsServerToClient = isServerToClient
		}
		v[name] = v2
		return (setmetatable(v2, class))
	end

	function class:CheckFire()
		if not self.IsServerToClient then
			warn("Server calling remote meant for Client -> Server: " .. self.Name)
		end
	end

	function class:CheckAttach()
		if self.IsServerToClient then
			warn("Server attaching callback to remote meant for Server -> Client: " .. self.Name)
		end
	end

	function class:FireTo(player, ...)
		self:CheckFire()
		self.RemoteEvent:FireClient(player, ...)
	end

	function class:FireAll(...)
		self:CheckFire()
		self.RemoteEvent:FireAllClients(...)
	end

	function class:FireAllExcept(p, ...)
		self:CheckFire()

		for _, player in pairs(Players:GetPlayers()) do
			if player ~= p then
				self.RemoteEvent:FireClient(player, ...)
			end
		end
	end

	function class:AttachCallback(callback)
		self:CheckAttach()
		self.RemoteEvent.OnServerEvent:Connect(function(p, ...)
			callback(p, ...)
		end)
	end

	function class.GetInitData(p)
		return { Name = p.Name, IsServerToClient = p.IsServerToClient }
	end

	return class
else
	local function FindRemoteEvent(childName) -- 1 equivalent call inferred from this helper
		local child = Remotes:FindFirstChild(childName)

		if not child then
			warn("Remote event with name " .. childName .. " not found")
		end

		return child
	end

	function class.New(childName: string, isServerToClient: boolean)
		local v2 = {
			Name = childName,
			RemoteEvent = FindRemoteEvent(childName), -- inferred equivalent call
			IsServerToClient = isServerToClient
		}
		v[childName] = v2
		return (setmetatable(v2, class))
	end

	function class:CheckFire()
		if self.IsServerToClient then
			warn("Client calling remote meant for Server -> Client:" .. self.Name)
		end
	end

	function class:CheckAttach()
		if not self.IsServerToClient then
			warn("Client attaching callback to remote meant for Client -> Server:" .. self.Name)
		end
	end

	function class:FireServer(...)
		self:CheckFire()
		self.RemoteEvent:FireServer(...)
	end

	function class:AttachCallback(callback)
		self:CheckAttach()
		self.RemoteEvent.OnClientEvent:Connect(function(...)
			callback(...)
		end)
	end

	return class
end