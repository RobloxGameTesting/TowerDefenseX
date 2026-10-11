local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ProjectileTypes"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("Utilities"))
local VisualEffectHandler = require(script.Parent:WaitForChild("VisualEffectHandler"))
local event = NetworkingHandler.GetEvent("NewBurnEffect")
local event2 = NetworkingHandler.GetEvent("RemoveBurnEffect")
local v = {}
event:AttachCallback(function(data)
	local v2 = {
		Name = data.Name,
		Position = data.Position,
		IsContinuous = true,
		PlayUntilManuallyStopped = true
	}
	local visualEffect = VisualEffectHandler.NewVisualEffect(v2)
	v[data.Hash] = visualEffect
end)
event2:AttachCallback(function(p: number)
	local v2 = v[p]

	if not v2 then
		print("BurnEffectHandler: didn't find visual effect to remove")
		return
	end

	v2:StopEarly()
	v[p] = nil
end)
return {}