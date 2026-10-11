local PVPAirStrikeHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local AirStrikeClass = require(script.Parent:WaitForChild("AirStrikeHandler"):WaitForChild("AirStrikeClass"))
require(common.Resources.Misc.RegularPowerUps.AirStrike.Types)
local event = NetworkingHandler.GetEvent("PVPAirStrikeInitReplication")
local event2 = NetworkingHandler.GetEvent("PVPAirStrikeUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewPlane(p)
	v[p.Hash] = AirStrikeClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function PVPAirStrikeHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function PVPAirStrikeHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function PVPAirStrikeHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = AirStrikeClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return PVPAirStrikeHandler