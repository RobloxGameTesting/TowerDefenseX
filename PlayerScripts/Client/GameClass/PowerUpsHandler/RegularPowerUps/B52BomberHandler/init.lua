local B52BomberHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("NetworkingUtilities"))
local B52BomberClass = require(script:WaitForChild("B52BomberClass"))
require(common.Resources.Misc.RegularPowerUps.B52Bomber.Types)
local event = NetworkingHandler.GetEvent("B52BomberInitReplication")
local event2 = NetworkingHandler.GetEvent("B52BomberUpdateReplication")
local v = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function NewPlane(p)
	v[p.Hash] = B52BomberClass.New(p, DEFAULT_SPEED_MULTIPLIER)
end

function B52BomberHandler:Run()
	for _, v2 in pairs(v) do
		if v2:CanCleanup() then
			v[v2.Hash] = nil
		end

		v2:Run(self)
	end
end

function B52BomberHandler.SetSpeedMultiplier(p: number)
	for _, v2 in pairs(v) do
		v2:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function B52BomberHandler.Initialize()
	event:AttachCallback(function(list)
		for _, v2 in ipairs(list) do
			v[v2.Hash] = B52BomberClass.New(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end)
	event2:AttachCallback(function(data)
		local v2 = v[data.Hash]

		if v2 then
			v2:ReceiveUpdate(data.Type, data.Data)
		end
	end)
end

return B52BomberHandler