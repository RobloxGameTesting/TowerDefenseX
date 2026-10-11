local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common.Resources.Misc.RegularPowerUps.DropPod.Types)
local DropPodClass = require(script.DropPodClass)
local event = NetworkingHandler.GetEvent("DropPodInitReplication")
local event2 = NetworkingHandler.GetEvent("DropPodUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewDropPod(p)
	v[p.Hash] = DropPodClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

local DropPodHandler = {}

function DropPodHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function DropPodHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function DropPodHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = DropPodClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(p)
		if v[p.Hash] then
			v[p.Hash]:ReceiveUpdate(p.Type)
		end
	end)
end

return DropPodHandler