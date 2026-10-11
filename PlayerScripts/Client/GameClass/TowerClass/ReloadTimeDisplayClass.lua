local ReloadTimeDisplayClass = {}
ReloadTimeDisplayClass.__index = ReloadTimeDisplayClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))

function ReloadTimeDisplayClass.New(parent)
	local miscResource = ResourceManager.GetMiscResource("ReloadGui")
	miscResource.Enabled = false
	miscResource.Parent = parent
	local frame = miscResource:WaitForChild("Frame")
	return (setmetatable(
		{
			ReloadTimeGui = miscResource,
			Juice = frame:FindFirstChild("Bar"):FindFirstChild("JuiceHolder"):FindFirstChild("Juice"),
			TimeText = frame:FindFirstChild("TimeText")
		},
		ReloadTimeDisplayClass
	))
end

function ReloadTimeDisplayClass.Update(p, p2: number, p3: number)
	local v = p2 / p3
	p.Juice.Size = UDim2.new(math.clamp(1 - v, 0, 1), 0, 1, 0)

	if p2 >= 1 then
		p.TimeText.Text = math.round(p2)
	else
		p.TimeText.Text = string.format("%.1f", p2)
	end
end

function ReloadTimeDisplayClass.Show(p)
	p.ReloadTimeGui.Enabled = true
end

function ReloadTimeDisplayClass.Hide(p)
	p.ReloadTimeGui.Enabled = false
end

function ReloadTimeDisplayClass:Destroy()
	self.ReloadTimeGui:Destroy()
end

return ReloadTimeDisplayClass