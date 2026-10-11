local HealingFieldHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local HealingFieldClass = require(script:WaitForChild("HealingFieldClass"))
require(common.Resources.Misc.RegularPowerUps.HealingField.Types)
local event = NetworkingHandler.GetEvent("HealingFieldInitReplication")
local event2 = NetworkingHandler.GetEvent("HealingFieldUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewObj(p)
	v[p.Hash] = HealingFieldClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function HealingFieldHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function HealingFieldHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function HealingFieldHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = HealingFieldClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return HealingFieldHandler