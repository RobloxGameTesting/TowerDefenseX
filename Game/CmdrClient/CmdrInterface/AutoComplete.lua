local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function findIgnoringWhitespace(value: string, value2: string)
	local v = {}
	local v2 = {}

	for i = 1, #value do
		local v3 = value:sub(i, i)

		if v3:match("%s") then
			continue
		end

		table.insert(v, v3:lower())
		table.insert(v2, i)
	end

	local v3 = value2:lower():gsub("%s", "")

	if v3 == "" then
		return nil, nil
	end

	local v4, v5 = table.concat(v):find(v3, 1, true)

	if v4 == nil then
		return nil, nil
	end

	return v2[v4], v2[v5]
end

return function(p)
	local v = { Items = {}, ItemOptions = {}, SelectedItem = 0 }
	local util = p.Util
	local autocomplete = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Autocomplete")
	local textButton = autocomplete:WaitForChild("TextButton")
	local title = autocomplete:WaitForChild("Title")
	local description = autocomplete:WaitForChild("Description")
	local entry = autocomplete.Parent:WaitForChild("Frame"):WaitForChild("Entry")
	textButton.Parent = nil
	local scrollBarThickness = autocomplete.ScrollBarThickness

	local function SetText(title2, field, name, p2) -- 2 equivalent calls inferred from this helper
		title2.Visible = name ~= nil
		field.Text = name or ""

		if p2 then
			field.Size = UDim2.new(
				0,
				util.GetTextSize(name or "", field, Vector2.new(1000, 1000), 1, 0).X,
				title2.Size.Y.Scale,
				title2.Size.Y.Offset
			)
		end
	end

	local function UpdateContainerSize()
		autocomplete.Size = UDim2.new(
			0,
			math.max(title.Field.TextBounds.X + title.Field.Type.TextBounds.X, autocomplete.Size.X.Offset),
			0,
			(math.min(
				autocomplete.UIListLayout.AbsoluteContentSize.Y,
				autocomplete.Parent.AbsoluteSize.Y - autocomplete.AbsolutePosition.Y - 10
			))
		)
	end

	local function UpdateInfoDisplay(options)
		SetText(title, title.Field, options.name, true)
		SetText( -- inferred equivalent call
			title.Field.Type,
			title.Field.Type,
			options.type and ": " .. options.type:sub(1, 1):upper() .. options.type:sub(2)
		)
		SetText(description, description.Label, options.description) -- inferred equivalent call
		description.Label.TextColor3 = options.invalid and Color3.fromRGB(255, 73, 73) or Color3.fromRGB(255, 255, 255)
		description.Size = UDim2.new(1, 0, 0, 40)

		while not description.Label.TextFits do
			description.Size += UDim2.new(0, 0, 0, 2)

			if description.Size.Y.Offset > 500 then
				break
			end
		end

		task.wait()
		autocomplete.UIListLayout:ApplyLayout()
		UpdateContainerSize()
		autocomplete.ScrollBarThickness = scrollBarThickness
	end

	function v:Show(items, options)
		local options2 = options or {}

		for _, item in pairs(self.Items) do
			if item.gui then
				item.gui:Destroy()
			end
		end

		self.SelectedItem = 1
		self.Items = items
		self.Prefix = options2.prefix or ""
		self.LastItem = options2.isLast or false
		self.Command = options2.command
		self.Arg = options2.arg
		self.NumArgs = options2.numArgs
		self.IsPartial = options2.isPartial
		autocomplete.ScrollBarThickness = 0
		local v2 = 200

		for k, item in pairs(self.Items) do
			local v3 = item[1]
			local v4 = item[2]
			local clone = textButton:Clone()
			clone.Name = v3 .. v4
			clone.BackgroundTransparency = k == self.SelectedItem and 0.5 or 1
			local v5, v6 = string.find(v4:lower(), v3:lower(), 1, true)

			if v5 == nil then
				v5, v6 = findIgnoringWhitespace(v4, v3)
				v3 = not v5 and "" or string.sub(v4, v5, v6) or ""
			end

			if v5 == nil and v6 == nil then
				v5 = 1
				v6 = 0
			end

			clone.Typed.Text = string.rep(" ", v5 - 1) .. v3
			clone.Suggest.Text = string.sub(v4, 0, v5 - 1) .. string.rep(" ", #v3) .. string.sub(v4, v6 + 1)
			clone.Parent = autocomplete
			clone.LayoutOrder = k
			local v7 = k
			clone.Activated:Connect(function()
				if self.Items ~= items then
					return
				end

				self:Select(v7 - self.SelectedItem)

				if self.OnItemActivated then
					self.OnItemActivated()
				end
			end)
			local v8 = math.max(clone.Typed.TextBounds.X, clone.Suggest.TextBounds.X) + 20

			if v2 < v8 then
				v2 = v8
			end

			item.gui = clone
		end

		autocomplete.UIListLayout:ApplyLayout()
		local text = entry.TextBox.Text
		local splitString = util.SplitString(text)

		if text:sub(#text, #text) == " " and not options2.at then
			splitString[#splitString + 1] = "e"
		end

		table.remove(splitString, #splitString)
		local v3 = (options2.at and options2.at or #table.concat(splitString, " ") + 1) * 7
		autocomplete.Position = UDim2.new(
			0,
			entry.TextBox.AbsolutePosition.X - 10 + v3,
			0,
			entry.TextBox.AbsolutePosition.Y + 30
		)
		autocomplete.Size = UDim2.new(0, v2, 0, autocomplete.UIListLayout.AbsoluteContentSize.Y)
		autocomplete.Visible = true

		if self.Items[1] then
			options2 = self.Items[1].options or options2
		end

		UpdateInfoDisplay(options2)
	end

	function v.GetSelectedItem(_)
		if autocomplete.Visible == false then
			return nil
		end

		return v.Items[v.SelectedItem]
	end

	function v.Hide(_)
		autocomplete.Visible = false
	end

	function v.IsVisible(_)
		return autocomplete.Visible
	end

	function v.ContainsPoint(_, p2)
		if not autocomplete.Visible then
			return false
		end

		local absolutePosition = autocomplete.AbsolutePosition
		local absoluteSize = autocomplete.AbsoluteSize
		return p2.X >= absolutePosition.X
			and p2.X <= absolutePosition.X + absoluteSize.X
			and p2.Y >= absolutePosition.Y
			and p2.Y <= absolutePosition.Y + absoluteSize.Y
	end

	function v:Select(p2)
		if not autocomplete.Visible then
			return
		end

		self.SelectedItem += p2

		if self.SelectedItem > #self.Items then
			self.SelectedItem = 1
		elseif self.SelectedItem < 1 then
			self.SelectedItem = #self.Items
		end

		for k, item in pairs(self.Items) do
			item.gui.BackgroundTransparency = k == self.SelectedItem and 0.5 or 1
		end

		autocomplete.CanvasPosition = Vector2.new(
			0,
			(math.max(
				0,
				title.Size.Y.Offset + description.Size.Y.Offset + self.SelectedItem * textButton.Size.Y.Offset - autocomplete.Size.Y.Offset
			))
		)

		if self.Items[self.SelectedItem] and self.Items[self.SelectedItem].options then
			UpdateInfoDisplay(self.Items[self.SelectedItem].options or {})
		end
	end

	autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateContainerSize)
	return v
end