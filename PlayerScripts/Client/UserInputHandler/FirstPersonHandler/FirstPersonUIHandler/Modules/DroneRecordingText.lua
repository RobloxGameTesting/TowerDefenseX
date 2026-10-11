local DroneRecordingText = {}
DroneRecordingText.__index = DroneRecordingText
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))

function DroneRecordingText:New()
	local flag = true

	while task.wait(1) do
		if flag then
			self.TextTransparency = 1
			flag = false
		else
			self.TextTransparency = 0
			flag = true
		end
	end

	return (setmetatable({}, DroneRecordingText))
end

return DroneRecordingText