local parent = script.Parent
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	local v = tick() * 80 % 250
	parent.Position = UDim2.new(parent.Position.X.Scale, 0, parent.Position.Y.Scale, v)
end)