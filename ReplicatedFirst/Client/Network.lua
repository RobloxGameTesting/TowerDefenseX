debug.setmemorycategory("Client/Network")
local v = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local network = ReplicatedStorage:WaitForChild("Network")
local Network = {}

function Network.HookEvent(childName, callback)
	local v2 = v[childName] or network:FindFirstChild(childName)

	if not v[childName] then
		v[childName] = v2
	end

	if v2 then
		return v2.OnClientEvent:connect(function(...)
			callback(...)
		end)
	end

	warn("no hook for", childName)
end

function Network.HookInvoke(childName, callback)
	local v2 = v[childName] or network:FindFirstChild(childName)

	if not v[childName] then
		v[childName] = v2
	end

	if v2 then
		v2.OnClientInvoke = function(...)
			return callback(...)
		end
	else
		warn("no hook for", childName)
	end
end

function Network.Fire(childName, ...)
	local v2 = v[childName] or network:FindFirstChild(childName)

	if not v[childName] then
		v[childName] = v2
	end

	if v2 then
		v2:FireServer(...)
	else
		warn("no hook for", childName)
	end
end

function Network.Invoke(childName, ...)
	local v2 = v[childName] or network:FindFirstChild(childName)

	if not v[childName] then
		v[childName] = v2
	end

	if v2 then
		return v2:InvokeServer(...)
	end

	warn("no hook for", childName)
	return nil
end

return Network