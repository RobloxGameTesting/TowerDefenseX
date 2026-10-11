local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
return {
	Resolve = function(value: string, instance)
		local humanoid

		if instance then
			humanoid = instance:FindFirstChildOfClass("Humanoid")
		end

		if not humanoid then
			return value
		end

		local v = value:sub(-4) == " R15"
		local v2

		if humanoid.RigType == Enum.HumanoidRigType.R15 then
			if v then
				v2 = value
			else
				v2 = value .. " R15"
			end
		elseif v then
			v2 = value:sub(1, -5)
		else
			v2 = value
		end

		if EmoteAnimationsV2[v2] then
			return v2
		end

		return value
	end
}