local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Director"))

for _, moduleScript in TDX_Shared:WaitForChild("Components"):GetDescendants() do
	if moduleScript:IsA("ModuleScript") then
		require(moduleScript)
	end
end

return {}