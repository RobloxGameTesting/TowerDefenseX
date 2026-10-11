local NetworkingHandler = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RemoteEventWrapperClass = require(script:WaitForChild("RemoteEventWrapperClass"))
local RemoteFunctionWrapperClass = require(script:WaitForChild("RemoteFunctionWrapperClass"))
local isServer = RunService:IsServer()
local remoteSetup = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("RemoteSetup")
local remoteEventWrappers = RemoteEventWrapperClass.GetRemoteEventWrappers()
local remoteFunctionWrappers = RemoteFunctionWrapperClass.GetRemoteFunctionWrappers()
local remoteEventCreated = remoteSetup:WaitForChild("RemoteEventCreated")
local remoteFunctionCreated = remoteSetup:WaitForChild("RemoteFunctionCreated")
local sendRemoteInitData = remoteSetup:WaitForChild("SendRemoteInitData")

if isServer then
	Players.PlayerAdded:Connect(function(player)
		local initDatas = {}
		local initDatas2 = {}

		for _, remoteEventWrapper in pairs(remoteEventWrappers) do
			table.insert(initDatas, remoteEventWrapper:GetInitData())
		end

		for _, remoteFunctionWrapper in pairs(remoteFunctionWrappers) do
			table.insert(initDatas2, remoteFunctionWrapper:GetInitData())
		end

		sendRemoteInitData:FireClient(player, initDatas, initDatas2)
	end)

	function NetworkingHandler.CreateRemoteEvent(p: string, flag: boolean)
		assert(p ~= nil, "Must specify valid remote name")
		assert(flag ~= nil, "Must specify if this remote is for server to client or vice versa")
		local v = RemoteEventWrapperClass.New(p, flag)
		remoteEventCreated:FireAllClients(v:GetInitData())
		return v
	end

	function NetworkingHandler.CreateRemoteFunction(p: string)
		assert(p ~= nil, "Must specify valid remote name")
		local v = RemoteFunctionWrapperClass.New(p)
		remoteFunctionCreated:FireAllClients(v:GetInitData())
		return v
	end

	function NetworkingHandler.GetEvent(p: string)
		local remoteEventWrapper = remoteEventWrappers[p]

		if not remoteEventWrapper then
			warn("No remote event with name " .. p)
		end

		return remoteEventWrapper
	end
else
	remoteEventCreated.OnClientEvent:Connect(function(p)
		RemoteEventWrapperClass.New(p.Name, p.IsServerToClient)
	end)
	remoteFunctionCreated.OnClientEvent:Connect(function(p)
		RemoteFunctionWrapperClass.New(p.Name)
	end)
	sendRemoteInitData.OnClientEvent:Connect(function(list, list2)
		for _, v in ipairs(list) do
			if not remoteEventWrappers[v.Name] then
				RemoteEventWrapperClass.New(v.Name, v.IsServerToClient)
			end
		end

		for _, v in ipairs(list2) do
			if not remoteFunctionWrappers[v.Name] then
				RemoteFunctionWrapperClass.New(v.Name)
			end
		end
	end)

	function NetworkingHandler.GetEvent(p: string)
		local remoteEventWrapper = remoteEventWrappers[p]
		local lastTime = os.clock()

		while not remoteEventWrapper do
			if os.clock() - lastTime > 5 then
				warn("Client stuck waiting for remote event with name " .. p)
				lastTime = os.clock()
			end

			task.wait()
			remoteEventWrapper = remoteEventWrappers[p]
		end

		return remoteEventWrapper
	end

	function NetworkingHandler.GetFunction(p: string)
		local remoteFunctionWrapper = remoteFunctionWrappers[p]
		local lastTime = os.clock()

		while not remoteFunctionWrapper do
			if os.clock() - lastTime > 5 then
				warn("Client stuck waiting for remote function with name " .. p)
				lastTime = os.clock()
			end

			task.wait()
			remoteFunctionWrapper = remoteFunctionWrappers[p]
		end

		return remoteFunctionWrapper
	end
end

return NetworkingHandler