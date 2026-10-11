local ScalingCardClass = {}
ScalingCardClass.__index = ScalingCardClass
local color = Color3.new(1, 1, 1)

function ScalingCardClass.New(instance, value: number?, parentUIScales, noIcons: boolean?)
	local contentFrame = instance:FindFirstChild("ContentFrame")
	local uiListLayout = contentFrame:FindFirstChild("UIListLayout")
	local itemTemplate = contentFrame:FindFirstChild("ItemTemplate")
	itemTemplate.Visible = false
	local v = {
		CardFrame = instance,
		ContentFrame = contentFrame,
		ItemTemplate = itemTemplate,
		MaximumRows = value or 10,
		ParentUIScales = parentUIScales,
		NoIcons = noIcons,
		ItemYSize = itemTemplate.Size.Y.Offset,
		ItemYPadding = uiListLayout.Padding.Offset,
		FrameXBuffer = -contentFrame.Size.X.Offset / 2,
		FrameYBuffer = -contentFrame.Size.Y.Offset / 2,
		Items = {},
		NextItemIndex = 1
	}
	setmetatable(v, ScalingCardClass)
	v:Initialize()
	return v
end

function ScalingCardClass:Initialize()
	for i = 1, self.MaximumRows do
		self.Items[i] = self:_NewItem()
	end
end

function ScalingCardClass:ShowIfActiveItems()
	if self:GetActiveItemCount() > 0 then
		self.CardFrame.Visible = true
	else
		self.CardFrame.Visible = false
	end
end

function ScalingCardClass.Hide(p)
	p.CardFrame.Visible = false
end

function ScalingCardClass.SetPosition(p, position: UDim2)
	p.CardFrame.Position = position
end

function ScalingCardClass:_GetUIScaleFactor()
	if not self.ParentUIScales then
		return 1
	end

	local v = 1

	for _, parentUIScale in pairs(self.ParentUIScales) do
		v *= parentUIScale.Scale
	end

	return v
end

function ScalingCardClass:ScaleFrame()
	local itemYSize = self.ItemYSize
	local itemYPadding = self.ItemYPadding
	local frameXBuffer = self.FrameXBuffer
	local frameYBuffer = self.FrameYBuffer
	local activeItemCount = self:GetActiveItemCount()
	local uiScaleFactor = self:_GetUIScaleFactor()
	local v = 0

	for _, item in pairs(self.Items) do
		if not item:IsActive() then
			continue
		end

		local v2 = item:GetWidth() / uiScaleFactor + item:GetTextOffset()

		if v < v2 then
			v = v2
		end
	end

	local v2 = math.ceil(2 * frameXBuffer + v)
	local v3 = 2 * frameYBuffer + activeItemCount * itemYSize + (activeItemCount - 1) * itemYPadding
	self.CardFrame.Size = UDim2.new(0, v2, 0, v3)
end

function ScalingCardClass:GetActiveItemCount()
	local count = 0

	for _, item in pairs(self.Items) do
		if item:IsActive() then
			count += 1
		end
	end

	return count
end

function ScalingCardClass:ActivateItem(p: string, p2)
	if self.NextItemIndex > self.MaximumRows then
		return
	end

	if self.Items[self.NextItemIndex]:Activate(p, p2) then
		self.NextItemIndex += 1
	end
end

function ScalingCardClass:DeactivateAllItems()
	for _, item in pairs(self.Items) do
		if item:Deactivate() then
			self.NextItemIndex -= 1
		end
	end
end

function ScalingCardClass.GetYShiftPerItem(p)
	return p.ItemYSize + p.ItemYPadding
end

function ScalingCardClass:_NewItem()
	local clone = self.ItemTemplate:Clone()
	clone.Visible = false
	clone.Parent = self.ContentFrame
	return {
		ItemGui = clone,
		Icon = not self.NoIcons and clone:FindFirstChild("IconHolder"):FindFirstChild("Icon"),
		TextLabel = clone:FindFirstChild("Text"),
		Active = false,
		CurrentWidth = 0,
		DefaultTextOffset = clone:FindFirstChild("Text").Position.X.Offset,
		IsActive = function(self)
			return self.Active
		end,
		Activate = function(self, text: string, data)
			local icon = self.Icon

			if not icon and (data.ImageId or data.ImageScale or data.ImageRotation) then
				warn("ScalingCardClass: Attempted to set icon properties on an item without an icon.")
				return false
			end

			if self.Active then
				return false
			end

			local itemGui = self.ItemGui
			local textLabel = self.TextLabel
			textLabel.Text = text

			if data.LayoutOrder then
				itemGui.LayoutOrder = data.LayoutOrder
			end

			if data.TextSize then
				textLabel.TextSize = data.TextSize
			end

			textLabel.TextColor3 = data.TextColor or color

			if data.TextYAlignment then
				textLabel.TextYAlignment = data.TextYAlignment
			end

			if icon then
				icon.Image = data.ImageId or ""
				icon.Size = UDim2.new(data.ImageScale or 1, 0, data.ImageScale or 1, 0)
				icon.Rotation = data.ImageRotation or 0
			end

			local defaultTextOffset = self.DefaultTextOffset
			local v = not data.ImageId and 0 or defaultTextOffset
			textLabel.Position = UDim2.new(0, v, textLabel.Position.Y.Scale, textLabel.Position.Y.Offset)
			itemGui.Visible = true
			self.Active = true
			self.CurrentWidth = textLabel.TextBounds.X
			return true
		end,
		Deactivate = function(self)
			if not self.Active then
				return false
			end

			self.ItemGui.Visible = false
			self.Active = false
			return true
		end,
		GetWidth = function(self)
			return self.CurrentWidth
		end,
		GetTextOffset = function(self)
			return self.TextLabel.Position.X.Offset
		end
	}
end

return ScalingCardClass