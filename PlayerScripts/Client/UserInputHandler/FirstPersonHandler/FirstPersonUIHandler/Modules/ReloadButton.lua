local ReloadButton = {}
ReloadButton.__index = ReloadButton
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local event = BindableHandler.GetEvent("DirectControlReload")

function ReloadButton.New(instance)
	local hotkey = instance:FindFirstChild("Hotkey")

	if hotkey then
		Keybinds.BindLabel(hotkey, "DirectControlReload")
	end

	instance.Activated:Connect(function()
		event:Fire()
	end)
	return (setmetatable({}, ReloadButton))
end

return ReloadButton