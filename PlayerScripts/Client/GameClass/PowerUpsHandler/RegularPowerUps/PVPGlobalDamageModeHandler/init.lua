local PVPGlobalDamageModeHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local PVPGlobalDamageModeClass = require(script:WaitForChild("PVPGlobalDamageModeClass"))
require(common.Resources.Misc.RegularPowerUps.PVPGlobalDamageMode.Types)
local event = NetworkingHandler.GetEvent("PVPGlobalDamageModeInitReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewObj(p)
	v[p.Hash] = PVPGlobalDamageModeClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function PVPGlobalDamageModeHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function PVPGlobalDamageModeHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function PVPGlobalDamageModeHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = PVPGlobalDamageModeClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
end

return PVPGlobalDamageModeHandler