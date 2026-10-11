local parent = script.Parent
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function()
	parent.Position = UDim2.new(0.5, math.random(-250, 250), 0.5, math.random(-250, 250))
end)