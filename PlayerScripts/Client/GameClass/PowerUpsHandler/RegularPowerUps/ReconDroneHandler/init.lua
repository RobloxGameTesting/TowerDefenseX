local ReconDroneHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("NetworkingUtilities"))
local ReconDroneClass = require(script:WaitForChild("ReconDroneClass"))
require(common.Resources.Misc.RegularPowerUps.ReconDrone.Types)
local event = NetworkingHandler.GetEvent("ReconDroneInitReplication")
local event2 = NetworkingHandler.GetEvent("ReconDroneUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewPlane(p)
	v[p.Hash] = ReconDroneClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function ReconDroneHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function ReconDroneHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function ReconDroneHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = ReconDroneClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return ReconDroneHandler