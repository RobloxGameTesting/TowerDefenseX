local v = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local RemoteEventWrapperClass = require(script:WaitForChild("RemoteEventWrapperClass"))
local RemoteFunctionWrapperClass = require(script:WaitForChild("RemoteFunctionWrapperClass"))
local isServer = RunService:IsServer()
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local remoteEventWrappers = RemoteEventWrapperClass.GetRemoteEventWrappers()
local remoteFunctionWrappers = RemoteFunctionWrapperClass.GetRemoteFunctionWrappers()

if isServer then
	function v.CreateRemoteEvent(p: string, flag: boolean)
		assert(p ~= nil, "Must specify valid remote name")

		if flag == nil then
			warn("Must specify if this remote is for server to client or vice versa, defaulting to true for now")
			flag = true
		end

		return (RemoteEventWrapperClass.New(p, flag))
	end

	function v.CreateRemoteFunction(p: string)
		assert(p ~= nil, "Must specify valid remote name")
		return (RemoteFunctionWrapperClass.New(p))
	end

	function v.GetEvent(p: string)
		local remoteEventWrapper = remoteEventWrappers[p]

		if not remoteEventWrapper then
			warn("No remote event with name " .. p)
		end

		return remoteEventWrapper
	end

	return v
else
	local function ProcessChild(instance)
		if instance:IsA("RemoteEvent") then
			RemoteEventWrapperClass.New(instance)
		elseif instance:IsA("RemoteFunction") then
			RemoteFunctionWrapperClass.New(instance)
		end
	end

	Remotes.ChildAdded:Connect(ProcessChild)

	for _, child in ipairs(Remotes:GetChildren()) do
		if child:IsA("RemoteEvent") then
			RemoteEventWrapperClass.New(child)
		elseif child:IsA("RemoteFunction") then
			RemoteFunctionWrapperClass.New(child)
		end
	end

	function v.GetEvent(p: string)
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

	function v.GetFunction(p: string)
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

	return v
end