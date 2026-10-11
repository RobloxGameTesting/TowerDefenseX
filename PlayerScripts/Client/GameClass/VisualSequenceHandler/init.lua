local VisualSequenceHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local v = HashGeneratorClass.New()
local v2 = {}
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local event = NetworkingHandler.GetEvent("PlayVisualSequence")
local event2 = NetworkingHandler.GetEvent("RemoveVisualFarmCrates")

function VisualSequenceHandler.StartNewSequence(childName: string, p)
	local child = script.Sequences:FindFirstChild(childName)

	if child == nil then
		return error("Sequence name \"" .. childName .. "\" could not be found!")
	end

	local v3 = v:Get()
	local module = require(child)
	local v4 = module.new(v3, childName, p, DEFAULT_SPEED_MULTIPLIER)
	v2[v3] = v4
	return v4
end

function VisualSequenceHandler:Run()
	for _, v3 in v2 do
		v3:Run(self)

		if not v3:IsCleanupReady() then
			continue
		end

		v2[v3.Hash] = nil
		v3:Destroy()
	end
end

function VisualSequenceHandler.SetSpeedMultiplier(p: number)
	DEFAULT_SPEED_MULTIPLIER = p

	for _, v3 in v2 do
		if v3.SpeedMultiplierChanged then
			v3:SpeedMultiplierChanged(p)
		end
	end
end

function VisualSequenceHandler.Restart()
	for _, v3 in v2 do
		if v3.EndOnRestart and v3.EndEarly then
			v3:EndEarly()
		end
	end
end

event:AttachCallback(function(p: string, p2)
	VisualSequenceHandler.StartNewSequence(p, p2)
end)
event2:AttachCallback(function()
	for _, v3 in v2 do
		if v3.Name == "FarmCrateDrop" then
			v3:EndEarly()
		end
	end
end)
return VisualSequenceHandler