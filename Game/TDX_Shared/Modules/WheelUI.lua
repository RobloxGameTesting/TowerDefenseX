local WheelUI = {}
WheelUI.__index = WheelUI

local function GetSelectedFromXY(frame, slotCount: number, p: number, p2: number, flag: boolean?)
	local absolutePosition = frame.AbsolutePosition
	local absoluteSize = frame.AbsoluteSize
	local v = absolutePosition.X + absoluteSize.X * 0.5
	local v2 = absolutePosition.Y + absoluteSize.Y * 0.5
	local v3 = math.fmod(math.deg((math.atan2(flag and p2 - v2 or v2 - p2, p - v))), 360) - 90

	if v3 < 0 then
		v3 += 360
	end

	return (math.ceil(v3 / (360 / slotCount)))
end

function WheelUI.new(frame, value: number?)
	return (setmetatable({
		Frame = frame,
		SlotCount = value or 6,
		Selected = 1
	}, WheelUI))
end

function WheelUI.Show(p)
	p.Frame.Visible = true
end

function WheelUI.Hide(p)
	for i = 1, p.SlotCount do
		local child = p.Frame:FindFirstChild((tostring(i)))

		if not child then
			continue
		end

		local selected = child:FindFirstChild("selected")

		if selected then
			selected.Visible = false
		end
	end

	p.Frame.Visible = false
end

function WheelUI.Toggle(p)
	p.Frame.Visible = not p.Frame.Visible
	return p.Frame.Visible
end

function WheelUI.IsVisible(p)
	return p.Frame.Visible
end

function WheelUI.GetSelected(p)
	return p.Selected
end

function WheelUI:UpdateSelectedFromPosition(p: number, p2: number, flag: boolean?)
	local selected2 = GetSelectedFromXY(self.Frame, self.SlotCount, p, p2, flag)
	self.Selected = selected2

	for i = 1, self.SlotCount do
		local child = self.Frame:FindFirstChild((tostring(i)))

		if not child then
			continue
		end

		local selected = child:FindFirstChild("selected")

		if selected then
			selected.Visible = i == selected2
		end
	end
end

function WheelUI.SetSlotContent(p, p2: number, callback)
	local child = p.Frame:FindFirstChild((tostring(p2)))

	if child then
		callback(child)
	end
end

function WheelUI.ClearSlotContent(p, p2: number)
	local child = p.Frame:FindFirstChild((tostring(p2)))

	if child then
		local viewportFrame = child:FindFirstChild("ViewportFrame")
		local worldModel = viewportFrame and viewportFrame:FindFirstChild("WorldModel")

		if worldModel then
			worldModel:ClearAllChildren()
		end
	end
end

function WheelUI:Destroy()
	self.Frame = nil
end

return WheelUI