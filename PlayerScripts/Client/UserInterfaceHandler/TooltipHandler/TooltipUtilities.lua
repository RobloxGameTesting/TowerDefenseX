local TooltipUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("ColorUtilities"))
local mouse = Players.LocalPlayer:GetMouse()

function TooltipUtilities.GetMouseXY()
	return mouse.X, mouse.Y
end

function TooltipUtilities:PositionTooltipAtMousePosition(udim: UDim2?)
	if self then
		local mouseXY, v = TooltipUtilities.GetMouseXY()
		local udim2 = UDim2.new(0, mouseXY, 0, v)

		if udim then
			udim2 += udim
		end

		self.Position = udim2
	end
end

return TooltipUtilities