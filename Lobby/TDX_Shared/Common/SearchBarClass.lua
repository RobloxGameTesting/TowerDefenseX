local SearchBarClass = {}
SearchBarClass.__index = SearchBarClass

function SearchBarClass.New(data)
	local searchBarGui = data.SearchBarGui
	local textBox = searchBarGui:FindFirstChild("TextBox")
	local searchIcon = searchBarGui:FindFirstChild("SearchIcon")
	local focused = searchIcon and searchIcon:FindFirstChild("Focused")
	local focused2 = searchBarGui:FindFirstChild("Focused")
	local hovered = searchBarGui:FindFirstChild("Hovered")
	local v = {
		IsHovered = false,
		IsFocused = false,
		TextChangedCallback = data.TextChangedCallback,
		AccentColor = data.AccentColor,
		Focused = function(self)
			self.IsFocused = true
			self:_UpdateState()
		end,
		FocusLost = function(self)
			self.IsFocused = false
			self:_UpdateState()
		end,
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		TextChanged = function(self)
			if self.TextChangedCallback then
				self.TextChangedCallback(textBox.Text)
			end
		end,
		Clear = function(_)
			textBox.Text = ""
		end,
		_UpdateState = function(self)
			if self.IsFocused then
				focused2.Visible = true
				hovered.Visible = false

				if focused then
					focused.Visible = true
				end
			elseif self.IsHovered then
				focused2.Visible = false
				hovered.Visible = true

				if focused then
					focused.Visible = false
				end
			else
				focused2.Visible = false
				hovered.Visible = false

				if focused then
					focused.Visible = false
				end
			end
		end
	}
	textBox.Focused:Connect(function()
		v:Focused()
	end)
	textBox.FocusLost:Connect(function(flag: boolean)
		v:FocusLost(flag)
	end)
	textBox.MouseEnter:Connect(function()
		v:Hovered()
	end)
	textBox.MouseLeave:Connect(function()
		v:Unhovered()
	end)
	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		v:TextChanged()
	end)

	if v.AccentColor then
		focused.ImageColor3 = v.AccentColor
		focused2.UIStroke.Color = v.AccentColor
		hovered.UIStroke.Color = v.AccentColor
	end

	return (setmetatable(v, SearchBarClass))
end

return SearchBarClass