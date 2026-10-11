local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local InputUtilities = {}

function InputUtilities.AddUserInputListener(p, p2, p3, callback)
	return UserInputService["Input" .. p]:Connect(function(p4, p5)
		if
			p5 and not p3
			or p4.UserInputType ~= p2
			or p2 == Enum.UserInputType.Keyboard and UserInputService:GetFocusedTextBox()
		then
			return
		end

		callback(p4)
	end)
end

function InputUtilities.AreKeysPressed(...)
	local listMembers = Utilities.GetListMembers(UserInputService:GetKeysPressed(), "KeyCode")
	local count = 0

	for _, v in pairs({ ... }) do
		if table.find(listMembers, v) then
			count += 1
		end
	end

	return count == #{ ... }
end

function InputUtilities.ShiftHeld()
	return UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
end

function InputUtilities.CtrlHeld()
	return UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
end

return InputUtilities