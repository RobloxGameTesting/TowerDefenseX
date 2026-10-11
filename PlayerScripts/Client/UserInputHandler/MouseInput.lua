local MouseInput = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local event = BindableHandler.GetEvent("MouseButton1Down")
local event2 = BindableHandler.GetEvent("MouseButton1Up")
local event3 = BindableHandler.GetEvent("MouseButton3Down")
local event4 = BindableHandler.GetEvent("ScrollWheelUp")
local event5 = BindableHandler.GetEvent("ScrollWheelDown")
local v = true

function MouseInput.Initialize()
	UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
		if not v or gameProcessed then
			return
		end

		local userInputType = input.UserInputType
		local keyCode = input.KeyCode

		if userInputType == Enum.UserInputType.MouseButton1 or keyCode == Enum.KeyCode.ButtonR2 then
			event:Fire()
		end

		if userInputType == Enum.UserInputType.MouseButton3 then
			event3:Fire()
		end
	end)
	UserInputService.InputEnded:Connect(function(input, gameProcessed: boolean)
		if not v or gameProcessed then
			return
		end

		local userInputType = input.UserInputType
		local keyCode = input.KeyCode

		if userInputType == Enum.UserInputType.MouseButton1 or keyCode == Enum.KeyCode.ButtonR2 then
			event2:Fire()
		end
	end)
	UserInputService.InputChanged:Connect(function(input, gameProcessed: boolean)
		if not v or gameProcessed then
			return
		end

		local userInputType = input.UserInputType
		local _keyCode = input.KeyCode

		if userInputType == Enum.UserInputType.MouseWheel then
			local z = input.Position.Z

			if z > 0 then
				event4:Fire()
			elseif z < 0 then
				event5:Fire()
			end
		end
	end)
end

function MouseInput.Enable()
	v = true
end

function MouseInput.Disable()
	v = false
end

return MouseInput