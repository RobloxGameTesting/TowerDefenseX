local PVPUberFieldHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local PVPUberFieldClass = require(script:WaitForChild("PVPUberFieldClass"))
require(common.Resources.Misc.RegularPowerUps.PVPUberField.Types)
local event = NetworkingHandler.GetEvent("PVPUberFieldInitReplication")
local event2 = NetworkingHandler.GetEvent("PVPUberFieldUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewObj(p)
	v[p.Hash] = PVPUberFieldClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function PVPUberFieldHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function PVPUberFieldHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function PVPUberFieldHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = PVPUberFieldClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return PVPUberFieldHandler