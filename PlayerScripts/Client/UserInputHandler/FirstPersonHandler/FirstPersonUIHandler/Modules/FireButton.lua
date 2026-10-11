local FireButton = {}
FireButton.__index = FireButton
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local event = BindableHandler.GetEvent("MouseButton1Down")
local event2 = BindableHandler.GetEvent("MouseButton1Up")

function FireButton:New()
	self.MouseButton1Down:Connect(function()
		event:Fire()
	end)
	self.MouseButton1Up:Connect(function()
		event2:Fire()
	end)
	UserInputService.LastInputTypeChanged:Connect(function(p)
		if p == Enum.UserInputType.Touch then
			self.Visible = true
		else
			self.Visible = false
		end
	end)
	self.Visible = UserInputService:GetLastInputType() == Enum.UserInputType.Touch
	return (setmetatable({}, FireButton))
end

return FireButton