local RangeTextClass = {}
RangeTextClass.__index = RangeTextClass
local parent = script.Parent.Parent
local parent2 = parent.Parent.Parent
local UserInputUtilities = require(parent2:WaitForChild("UserInputUtilities"))
local CurrentCamera = workspace.CurrentCamera

function RangeTextClass.New(textLabel, p)
	return (setmetatable({
		TextLabel = textLabel,
		Format = p and p.Format
	}, RangeTextClass))
end

function RangeTextClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self:_UpdateState()
end

function RangeTextClass.OnRenderStepped(data, _: number)
	if not data.Enabled then
		return
	end

	local module = require(parent)
	local crosshairPosition = module.GetCrosshairPosition()
	local screenPositionGetHitForFPSMode, v = UserInputUtilities.ScreenPositionGetHitForFPSMode(crosshairPosition)
	local v2 = not screenPositionGetHitForFPSMode and "-" or math.round((v - CurrentCamera.CFrame.Position).Magnitude)

	if data.Format then
		data.TextLabel.Text = string.format(data.Format, v2)
	else
		data.TextLabel.Text = tostring(v2)
	end
end

function RangeTextClass:_UpdateState()
	self.TextLabel.Visible = self.Enabled
end

return RangeTextClass