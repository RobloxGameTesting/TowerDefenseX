local ExitButton = {}
ExitButton.__index = ExitButton
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local event = BindableHandler.GetEvent("StopTowerDirectControl")

function ExitButton.New(instance)
	local hotkey = instance:FindFirstChild("Hotkey")

	if hotkey then
		Keybinds.BindLabel(hotkey, "DirectControlStop")
	end

	instance.Activated:Connect(function()
		event:Fire()
	end)
	return (setmetatable({}, ExitButton))
end

return ExitButton