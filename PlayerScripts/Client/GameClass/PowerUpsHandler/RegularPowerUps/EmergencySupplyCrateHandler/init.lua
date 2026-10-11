local EmergencySupplyCrateHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("NetworkingUtilities"))
local EmergencySupplyCrateClass = require(script:WaitForChild("EmergencySupplyCrateClass"))
require(common.Resources.Misc.RegularPowerUps.EmergencySupplyCrate.Types)
local event = NetworkingHandler.GetEvent("EmergencySupplyCrateInitReplication")
local event2 = NetworkingHandler.GetEvent("EmergencySupplyCrateUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewPlane(p)
	v[p.Hash] = EmergencySupplyCrateClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function EmergencySupplyCrateHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function EmergencySupplyCrateHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function EmergencySupplyCrateHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = EmergencySupplyCrateClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return EmergencySupplyCrateHandler