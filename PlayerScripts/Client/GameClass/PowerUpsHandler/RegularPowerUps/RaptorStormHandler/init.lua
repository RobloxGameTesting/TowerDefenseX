local RaptorStormHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("NetworkingUtilities"))
local RaptorStormClass = require(script:WaitForChild("RaptorStormClass"))
require(common.Resources.Misc.RegularPowerUps.RaptorStorm.Types)
local event = NetworkingHandler.GetEvent("RaptorStormInitReplication")
local event2 = NetworkingHandler.GetEvent("RaptorStormUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewPlane(p)
	v[p.Hash] = RaptorStormClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function RaptorStormHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function RaptorStormHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function RaptorStormHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = RaptorStormClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return RaptorStormHandler