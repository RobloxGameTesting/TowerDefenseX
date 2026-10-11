local PVPRangeBoostHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local PVPRangeBoostClass = require(script:WaitForChild("PVPRangeBoostClass"))
require(common.Resources.Misc.RegularPowerUps.PVPRangeBoost.Types)
local event = NetworkingHandler.GetEvent("PVPRangeBoostInitReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewObj(p)
	v[p.Hash] = PVPRangeBoostClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function PVPRangeBoostHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function PVPRangeBoostHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function PVPRangeBoostHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = PVPRangeBoostClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
end

return PVPRangeBoostHandler