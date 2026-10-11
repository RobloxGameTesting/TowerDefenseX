local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local InputUtilities = require(script.Parent:WaitForChild("InputUtilities"))
local HotkeyActions = require(script.Parent:WaitForChild("HotkeyActions"))
local Keyboard = Enum.UserInputType.Keyboard
local LeftShift = Enum.KeyCode.LeftShift
local RightShift = Enum.KeyCode.RightShift
local isStudio = RunService:IsStudio()
local v = { [Enum.KeyCode.Seven] = true, [Enum.KeyCode.Eight] = true, [Enum.KeyCode.Nine] = true }
local event = BindableHandler.GetEvent("ToggleAdminPanel")
local event2 = BindableHandler.GetEvent("ShiftDown")
local event3 = BindableHandler.GetEvent("ShiftUp")
local event4 = BindableHandler.GetEvent("AdminPressButtonWithName")
local v2 = true
local v3 = false
local KeyboardInput = {}

function KeyboardInput.Initialize()
	InputUtilities.AddUserInputListener("Began", Keyboard, false, function(p)
		if not v2 then
			return
		end

		local keyCode = p.KeyCode

		if not (isStudio and v[keyCode] and InputUtilities.CtrlHeld() and InputUtilities.ShiftHeld()) then
			HotkeyActions.Dispatch("Began", v3, "Keyboard", keyCode)
		end

		if keyCode == LeftShift or keyCode == RightShift then
			event2:Fire()
		end

		if InputUtilities.ShiftHeld() then
			if keyCode == Enum.KeyCode.T then
				event:Fire()
			elseif keyCode == Enum.KeyCode.Minus then
				event4:Fire("SpeedToggle", true)
			elseif keyCode == Enum.KeyCode.Equals then
				event4:Fire("SpeedToggle")
			elseif keyCode == Enum.KeyCode.LeftBracket then
				event4:Fire("Pause")
			elseif keyCode == Enum.KeyCode.RightBracket then
				event4:Fire("KillAll", true)
			end
		end
	end)
	InputUtilities.AddUserInputListener("Ended", Keyboard, false, function(p)
		if not v2 then
			return
		end

		local keyCode = p.KeyCode
		HotkeyActions.Dispatch("Ended", v3, "Keyboard", keyCode)

		if keyCode == LeftShift or keyCode == RightShift then
			event3:Fire()
		end
	end)
end

function KeyboardInput.Enable()
	v2 = true
end

function KeyboardInput.Disable()
	v2 = false
end

function KeyboardInput.SetIsDirectControlMode(flag: boolean)
	v3 = flag
end

return KeyboardInput