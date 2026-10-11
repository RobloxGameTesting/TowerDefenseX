debug.setmemorycategory("Client/Data")
local Signal = require(game.ReplicatedStorage.TDX_Shared.Modules.Signal)
local Players = game:GetService("Players")
local dataUpdate = Players.LocalPlayer:WaitForChild("-DataUpdate")
local updated = Signal.new()
local Data = { Updated = updated, Cache = {} }

function Data.Get(p)
	return Data.Cache[p]
end

function Data.Set(p, p2)
	Data.Cache[p] = p2
end

function Data.Update(p, callback)
	Data.Cache[p] = callback(Data.Cache[p])
end

local flag = false
dataUpdate.OnClientEvent:connect(function(p, cache, p2)
	if p == 0 then
		flag = true
		Data.Cache = cache
		updated:Fire(cache)
	elseif p == 1 then
		Data.Cache[cache] = p2
		updated:Fire(cache, p2)
	end
end)
dataUpdate:FireServer()

repeat
	task.wait(0.1)
until flag

return Data