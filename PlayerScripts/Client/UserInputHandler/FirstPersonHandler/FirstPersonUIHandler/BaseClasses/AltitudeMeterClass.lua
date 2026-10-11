local AltitudeMeterClass = {}
AltitudeMeterClass.__index = AltitudeMeterClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))

local function GetTicks(ticks)
	local children = {}

	for i = 1, 7 do
		local child = ticks:FindFirstChild((tostring(i)))

		if child then
			table.insert(children, child)
		else
			warn("Tick " .. i .. " not found in TicksFrame")
		end
	end

	return children
end

function AltitudeMeterClass.New(frame, p)
	local altitudeText = frame.AltitudeText
	local ticks = frame.Bar.Ticks
	return (setmetatable({
		Frame = frame,
		AltitudeTextLabel = altitudeText,
		TicksFrame = ticks,
		Ticks = GetTicks(ticks),
		Interval = p and p.Interval or 20,
		TicksFrameOffsetY = ticks.Position.Y.Offset,
		Tower = nil
	}, AltitudeMeterClass))
end

function AltitudeMeterClass:SetEnabled(enabled: boolean)
	self.Enabled = enabled
	self:_UpdateState()
end

function AltitudeMeterClass:SetTower(tower)
	self.Tower = tower
end

function AltitudeMeterClass:Run(_: number)
	if not (self.Enabled and self.Tower) then
		return
	end

	local primaryPart = self.Tower.Character:GetCharacterModel().PrimaryPart
	local nodesMinY = MapHandler.GetNodesMinY()
	local v = primaryPart.Position.Y - nodesMinY
	local v2 = math.round(v)
	local v3 = math.abs(v2) < 0.1 and 0 or v2
	self.AltitudeTextLabel.Text = `ALT: {v3}`
	self:_RunTicks(v)
end

function AltitudeMeterClass:_RunTicks(p: number)
	local interval = self.Interval
	local ticksFrame = self.TicksFrame
	local ticks = self.Ticks
	local v = math.floor(p / interval) * interval
	local v2 = (p - v) / interval

	for i, tick in ipairs(ticks) do
		if i % 2 ~= 0 then
			tick.TextLabel.Text = tostring(v + (5 - i) * 0.5 * interval)
		end
	end

	ticksFrame.Position = UDim2.new(0.5, 0, -0.5 + 0.5 * v2, self.TicksFrameOffsetY)
end

function AltitudeMeterClass:_UpdateState()
	self.Frame.Visible = self.Enabled
end

return AltitudeMeterClass