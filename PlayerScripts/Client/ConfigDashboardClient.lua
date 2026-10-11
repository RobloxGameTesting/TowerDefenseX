local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Shared = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))

if RunService:IsStudio() or Shared.IS_DEV_PLACE then
	task.spawn(function()
		local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
		local Applier = require(Common:WaitForChild("ConfigDashboard"):WaitForChild("Applier"))
		NetworkingHandler.GetEvent("ConfigDashboardOverride"):AttachCallback(function(p)
			if typeof(p) ~= "table" then
				return
			end

			local v = Applier.Apply(p)
			print(`[ConfigDashboard] Client applied {#v} override(s)`)
		end)
		NetworkingHandler.GetEvent("ConfigDashboardRequest"):FireServer()
	end)
end

return {}