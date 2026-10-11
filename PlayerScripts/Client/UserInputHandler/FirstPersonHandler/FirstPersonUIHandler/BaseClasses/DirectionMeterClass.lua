local DirectionMeterClass = {}
DirectionMeterClass.__index = DirectionMeterClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
local CurrentCamera = workspace.CurrentCamera

function DirectionMeterClass.New(frame, _)
	return (setmetatable({
		Frame = frame,
		AngleTextLabel = frame.AngleText,
		TicksFrame = frame.Bar.Inner.Ticks,
		PreviousCFrame = nil,
		Tower = nil
	}, DirectionMeterClass))
end

function DirectionMeterClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self:_UpdateState()
end

function DirectionMeterClass:SetTower(tower)
	self.Tower = tower
end

function DirectionMeterClass:Run(p: number)
	if not (self.Enabled and self.Tower) then
		return
	end

	local cframe = CurrentCamera.CFrame

	if not self.PreviousCFrame then
		self.PreviousCFrame = cframe
	end

	local cframe2 = self.PreviousCFrame:Lerp(cframe, p * 4)
	self.PreviousCFrame = cframe2
	local _, v = cframe2:ToOrientation()
	local v2 = math.deg(v) * -1
	local v3

	if v2 < -0.99 then
		v3 = v2 + 360
	else
		v3 = v2 < 0 and 0 or v2
	end

	self.AngleTextLabel.Text = `{math.round(v3)}`
	self:_RunTicks(v3)
end

function DirectionMeterClass:_RunTicks(p: number)
	local ticksFrame = self.TicksFrame
	local v = p / 360
	ticksFrame.Position = UDim2.new(v * -2, 0, 0.5, 0)
end

function DirectionMeterClass:_UpdateState()
	self.Frame.Visible = self.Enabled
end

return DirectionMeterClass