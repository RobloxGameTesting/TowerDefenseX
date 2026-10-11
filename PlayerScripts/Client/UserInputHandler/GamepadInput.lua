local InputUtilities = require(script.Parent:WaitForChild("InputUtilities"))
local HotkeyActions = require(script.Parent:WaitForChild("HotkeyActions"))
local Gamepad1 = Enum.UserInputType.Gamepad1
local v = true
local v2 = false
local GamepadInput = {}

function GamepadInput.Initialize()
	InputUtilities.AddUserInputListener("Began", Gamepad1, false, function(p)
		if not v then
			return
		end

		HotkeyActions.Dispatch("Began", v2, "Gamepad", p.KeyCode)
	end)
	InputUtilities.AddUserInputListener("Ended", Gamepad1, false, function(p)
		if not v then
			return
		end

		HotkeyActions.Dispatch("Ended", v2, "Gamepad", p.KeyCode)
	end)
end

function GamepadInput.Enable()
	v = true
end

function GamepadInput.Disable()
	v = false
end

function GamepadInput.SetIsDirectControlMode(flag: boolean)
	v2 = flag
end

return GamepadInput