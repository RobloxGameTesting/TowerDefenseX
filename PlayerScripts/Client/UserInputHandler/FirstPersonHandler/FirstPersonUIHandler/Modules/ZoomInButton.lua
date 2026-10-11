local ZoomInButton = {}
ZoomInButton.__index = ZoomInButton
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local event = BindableHandler.GetEvent("ScrollWheelUp")

function ZoomInButton.New(p)
	p.Activated:Connect(function()
		event:Fire()
	end)
	return (setmetatable({}, ZoomInButton))
end

return ZoomInButton