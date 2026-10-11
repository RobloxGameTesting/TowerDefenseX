local ControlsWindow = {}
ControlsWindow.__index = ControlsWindow
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Keybinds = require(Common:WaitForChild("Keybinds"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Util = require(TDX_Shared.Modules.Util)
local rbxassetfontsfamiliesGothamSSmjson = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(12, 16, 4)
local color3 = Color3.fromRGB(184, 254, 0)
local color4 = Color3.fromRGB(255, 95, 95)
local v = {
	Normal = {
		Background = Color3.fromRGB(32, 43, 9),
		BackgroundTransparency = 0.15,
		StrokeColor = color3,
		StrokeTransparency = 0.55,
		TextColor = color
	},
	Hovered = {
		Background = Color3.fromRGB(60, 82, 14),
		BackgroundTransparency = 0.05,
		StrokeColor = color3,
		StrokeTransparency = 0,
		TextColor = color
	},
	Active = {
		Background = color3,
		BackgroundTransparency = 0,
		StrokeColor = color3,
		StrokeTransparency = 0,
		TextColor = color2
	},
	Warning = {
		Background = Color3.fromRGB(72, 18, 18),
		BackgroundTransparency = 0.05,
		StrokeColor = color4,
		StrokeTransparency = 0,
		TextColor = color
	}
}
local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local udim = UDim.new(0.15, 0)

local function Numbered(p: string, p2: number)
	local result = {}

	for i = 1, p2 do
		table.insert(result, `{p}{i}`)
	end

	return result
end

local v2 = {
	{
		{
			Title = "PLACEMENT",
			Rows = {
				{
					Label = "CANCEL PLACEMENT",
					Actions = { "StopTowerPlacement" }
				},
				{
					Label = "ROTATE TOWER",
					Actions = { "RotateTowerPlacement" }
				},
				{
					Label = "TOWER SLOTS",
					Actions = Numbered("SelectTower", 10),
					ChipLabel = "TOWER SLOT"
				}
			}
		},
		{
			Title = "SELECTED TOWER",
			Rows = {
				{
					Label = "UPGRADE PATH 1",
					Actions = { "UpgradeTowerPath1" }
				},
				{
					Label = "UPGRADE PATH 2",
					Actions = { "UpgradeTowerPath2" }
				},
				{
					Label = "SELL",
					Actions = { "SellTower" }
				},
				{ Label = "ABILITIES", Actions = Numbered("UseAbility", 4), ChipLabel = "ABILITY" },
				{
					Label = "PREVIOUS TARGETING",
					Actions = { "ChangeQueryModeLeft" }
				},
				{
					Label = "NEXT TARGETING",
					Actions = { "ChangeQueryModeRight" }
				}
			}
		},
		{
			Title = "INTERFACE",
			Rows = {
				{
					Label = "UPGRADE SHOP",
					Actions = { "OpenUpgradeShop" }
				},
				{
					Label = "SWITCH PVP TAB",
					Actions = { "SwitchPVPTab" }
				}
			}
		}
	},
	{
		{
			Title = "DIRECT CONTROL",
			Rows = {
				{
					Label = "EXIT",
					Actions = { "DirectControlStop" }
				},
				{
					Label = "RELOAD",
					Actions = { "DirectControlReload" }
				},
				{
					Label = "MOVE UP",
					Actions = { "DirectControlMoveUp" }
				},
				{
					Label = "MOVE DOWN",
					Actions = { "DirectControlMoveDown" }
				},
				{
					Label = "ABILITY",
					Actions = { "DirectControlAbility" }
				},
				{
					Label = "WEAPONS",
					Actions = Numbered("DirectControlSelectWeapon", 9),
					ChipLabel = "WEAPON"
				},
				{
					Label = "ZOOM OUT",
					Actions = { "DirectControlZoomOut" }
				},
				{
					Label = "ZOOM IN",
					Actions = { "DirectControlZoomIn" }
				}
			}
		},
		{
			Title = "SOCIAL",
			Rows = {
				{
					Label = "PING",
					Actions = { "Ping" }
				},
				{
					Label = "EMOTE WHEEL",
					Actions = { "Emote" }
				}
			}
		},
		{
			Title = "LOBBY",
			Rows = {
				{
					Label = "EAT FOOD",
					Actions = { "EatFood" }
				}
			}
		}
	}
}

local function CreateText(p) -- 1 equivalent call inferred from this helper
	p.BackgroundTransparency = 1
	p.FontFace = rbxassetfontsfamiliesGothamSSmjson
	p.TextScaled = true
	p.TextColor3 = p.TextColor3 or color
	return Util.Create("TextLabel", p)
end

local function CreateButton(list)
	local normal = v.Normal
	local v3 = {
		Name = "Label",
		TextColor3 = normal.TextColor,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.82, 0.55),
		BackgroundTransparency = 1,
		FontFace = rbxassetfontsfamiliesGothamSSmjson,
		TextScaled = true
	}
	v3.TextColor3 = v3.TextColor3 or color
	local v4 = Util.Create("TextLabel", v3)
	local v5 = Util.Create("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = normal.StrokeColor,
		Transparency = normal.StrokeTransparency,
		Thickness = 1.5
	})
	list.Text = ""
	list.AutoButtonColor = false
	list.BorderSizePixel = 0
	list.BackgroundColor3 = normal.Background
	list.BackgroundTransparency = normal.BackgroundTransparency
	table.insert(list, v4)
	table.insert(list, v5)
	table.insert(list, Util.Create("UICorner", { CornerRadius = udim }))
	table.insert(
		list,
		Util.Create("UIGradient", {
			Rotation = 90,
			Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(160, 160, 160))
		})
	)
	local v6 = Util.Create("TextButton", list)
	v6:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		v5.Thickness = math.max(1, v6.AbsoluteSize.Y * 0.05)
	end)
	local v7 = false
	local v8 = "Normal"

	local function UpdateStyle()
		local v9 = v[v8 == "Normal" and v7 and "Hovered" or v8]
		TweenService:Create(v6, tweenInfo, {
			BackgroundColor3 = v9.Background,
			BackgroundTransparency = v9.BackgroundTransparency
		}):Play()
		TweenService:Create(v5, tweenInfo, {
			Color = v9.StrokeColor,
			Transparency = v9.StrokeTransparency
		}):Play()
		TweenService:Create(v4, tweenInfo, { TextColor3 = v9.TextColor }):Play()
	end

	v6.MouseEnter:Connect(function()
		v7 = true
		UpdateStyle()
	end)
	v6.MouseLeave:Connect(function()
		v7 = false
		UpdateStyle()
	end)
	return v6, v4, function(p: string)
		v8 = p
		UpdateStyle()
	end
end

local function CreateChevron(list)
	local function CreateBar(rotation: number, p: number)
		return Util.Create("Frame", {
			Name = "Bar",
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.45, p),
			Size = UDim2.fromScale(0.62, 0.16),
			Rotation = rotation,
			Util.Create("UICorner", { CornerRadius = UDim.new(0.5, 0) })
		})
	end

	list.Name = "Chevron"
	list.BackgroundTransparency = 1
	table.insert(list, Util.Create("UIAspectRatioConstraint", { AspectRatio = 1 }))
	table.insert(list, CreateBar(-45, 0.29))
	table.insert(list, CreateBar(45, 0.71))
	return Util.Create("Frame", list)
end

function ControlsWindow:AddSettingsTab(instance)
	local v3 = {}
	local v4 = 0

	for _, button in ipairs(self:GetChildren()) do
		if not button:IsA("GuiButton") then
			continue
		end

		table.insert(v3, button)
		v4 = math.max(v4, button.LayoutOrder)
	end

	local clone = instance:Clone()
	clone.Name = "Controls"
	clone.LayoutOrder = v4 + 1
	clone:SetAttribute("First", nil)
	clone.Parent = self
	table.insert(v3, clone)
	local textLabel = clone:FindFirstChildWhichIsA("TextLabel")

	if textLabel then
		textLabel.Text = "CONTROLS"
	end

	self.Size = UDim2.new(0.9, 0, self.Size.Y.Scale, self.Size.Y.Offset)

	for _, v5 in ipairs(v3) do
		v5.Size = UDim2.fromScale(1 / #v3, 1)
	end

	return clone
end

function ControlsWindow.new(p, onBack)
	local object = setmetatable({
		Cleaner = Cleaner.new(),
		OnBack = onBack,
		KeyButtons = {},
		ActionNames = {},
		Capture = nil,
		CancelledByClick = nil,
		StatusToken = 0,
		Root = nil,
		Status = nil
	}, ControlsWindow)
	object:_Build(p)
	object.Cleaner:Add(Keybinds.Changed:Connect(function()
		object:_Refresh()
	end))
	object.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
		object:_OnInputBegan(input, gameProcessed)
	end))
	object.Cleaner:Add(object.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if not object.Root.Visible then
			object:_StopCapture()
		end
	end))
	object.Cleaner:Add(GuiService.MenuOpened:Connect(function()
		object:_StopCapture()
	end))
	return object
end

function ControlsWindow:_Build(parent)
	local v3 = Util.Create("ImageButton", {
		Name = "Controls",
		Visible = false,
		ZIndex = 12,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.95, 0.73),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		AutoButtonColor = false,
		Util.Create("UIAspectRatioConstraint", { AspectRatio = 1.716 })
	})
	Util.Create("ImageLabel", {
		Name = "Background",
		ZIndex = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Image = "rbxassetid://127027899917293",
		ScaleType = Enum.ScaleType.Stretch,
		Parent = v3
	})
	local parent2, v4 = CreateButton({
		Name = "Back",
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0.04, 0.073),
		Size = UDim2.fromScale(0.085, 0.05),
		Parent = v3
	})
	CreateChevron({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.22, 0.5),
		Size = UDim2.fromScale(1, 0.42),
		Parent = parent2
	})
	v4.Text = "BACK"
	v4.Position = UDim2.fromScale(0.6, 0.5)
	v4.Size = UDim2.fromScale(0.5, 0.5)
	parent2:AddTag("ClickEffectNoScale")
	parent2.Activated:Connect(function()
		self:Close()
		self.OnBack()
	end)
	local v5 = {
		Name = "Title",
		Text = "CONTROLS",
		TextXAlignment = Enum.TextXAlignment.Left,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0.14, 0.073),
		Size = UDim2.fromScale(0.365, 0.0445),
		Parent = v3,
		BackgroundTransparency = 1
	}
	v5.FontFace = rbxassetfontsfamiliesGothamSSmjson
	v5.TextScaled = true
	v5.TextColor3 = v5.TextColor3 or color
	Util.Create("TextLabel", v5)
	Util.Create("ImageButton", {
		Name = "Close",
		BackgroundTransparency = 1,
		Image = "rbxassetid://10862994489",
		HoverImage = "rbxassetid://10862994753",
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.995, 0.005),
		Size = UDim2.fromScale(0.09, 0.09),
		Util.Create("UIAspectRatioConstraint", { AspectRatio = 1 }),
		Parent = v3
	}):AddTag("CloseButton")
	Util.Create("Frame", {
		Name = "Divider",
		BackgroundColor3 = color3,
		BackgroundTransparency = 0.7,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.fromScale(0.5, 0.175),
		Size = UDim2.new(0, 2, 0.66, 0),
		Parent = v3
	})

	for i, list in ipairs(v2) do
		local parent3 = Util.Create("ScrollingFrame", {
			Name = `Column{i}`,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.fromScale(i == 1 and 0.05 or 0.525, 0.165),
			Size = UDim2.fromScale(0.425, 0.68),
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 4,
			ScrollBarImageColor3 = color3,
			VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
			Util.Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
			Util.Create("UIPadding", { PaddingRight = UDim.new(0.012, 0) }),
			Parent = v3
		})
		local count = 0

		for _, v6 in ipairs(list) do
			count += 1
			local createHeader = self:_CreateHeader(v6.Title, count)
			createHeader.Parent = parent3

			for _, row in ipairs(v6.Rows) do
				count += 1
				local createRow = self:_CreateRow(row, count)
				createRow.Parent = parent3
			end
		end
	end

	self.Status = CreateText({ -- inferred equivalent call
		Name = "Status",
		Text = "CLICK A KEY TO CHANGE IT  •  RIGHT-CLICK TO CLEAR IT",
		TextTransparency = 0.35,
		TextXAlignment = Enum.TextXAlignment.Left,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0.04, 0.935),
		Size = UDim2.fromScale(0.7, 0.026),
		Parent = v3
	})
	local v6, v7, v8 = CreateButton({
		Name = "ResetAll",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.fromScale(0.96, 0.935),
		Size = UDim2.fromScale(0.12, 0.055),
		Parent = v3
	})
	v7.Text = "RESET ALL"
	v6:AddTag("ClickEffectNoScale")
	local count = 0

	local function EndResetConfirm() -- 2 equivalent calls inferred from this helper
		count += 1
		v7.Text = "RESET ALL"
		v8("Normal")
	end

	v6.Activated:Connect(function()
		self:_StopCapture()

		if v7.Text == "RESET ALL" then
			count += 1
			local v9 = count
			v7.Text = "CONFIRM?"
			v8("Warning")
			task.delay(3, function()
				if count == v9 then
					EndResetConfirm() -- inferred equivalent call
				end
			end)
		else
			EndResetConfirm() -- inferred equivalent call

			if Keybinds.ResetAll() then
				SoundHandler.Play("SettingOff")
				self:_SetStatus("ALL KEYS RESET TO DEFAULTS", false, true)
			end
		end
	end)
	self.Root = v3
	self.Cleaner:Add(v3)
	self:_Refresh()
	v3.Parent = parent
end

function ControlsWindow._CreateHeader(_, p: string, layoutOrder: number)
	local create = Util.Create
	local v3 = {
		Name = p,
		LayoutOrder = layoutOrder,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		nil,
		nil,
		nil
	}
	local v4 = Util.Create("UIAspectRatioConstraint", { AspectRatio = 12 })
	local v5 = {
		Name = "Title",
		Text = p,
		TextColor3 = color3,
		TextXAlignment = Enum.TextXAlignment.Left,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 0.78),
		Size = UDim2.fromScale(1, 0.5),
		BackgroundTransparency = 1
	}
	v5.FontFace = rbxassetfontsfamiliesGothamSSmjson
	v5.TextScaled = true
	v5.TextColor3 = v5.TextColor3 or color
	do local _values = table.pack(v4, Util.Create("TextLabel", v5), Util.Create("Frame", {
	Name = "Underline",
	BackgroundColor3 = color3,
	BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0, 1),
	Position = UDim2.fromScale(0, 0.94),
	Size = UDim2.new(1, 0, 0, 2),
	Util.Create("UIGradient", {
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 1) })
	})
})); for _k = 1, _values.n do v3[_k] = _values[_k] end end
	return create("Frame", v3)
end

function ControlsWindow:_CreateRow(data, layoutOrder: number)
	local v3 = data.ChipLabel ~= nil
	local parent = Util.Create("Frame", {
		Name = data.Label,
		LayoutOrder = layoutOrder,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Util.Create("UIAspectRatioConstraint", { AspectRatio = 16.5 }),
		CreateText({
			Name = "Label",
			Text = data.Label,
			TextXAlignment = Enum.TextXAlignment.Left,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.fromScale(v3 and 0.3 or 0.52, 0.46)
		})
	})

	if v3 then
		local parent2 = Util.Create("Frame", {
			Name = "Chips",
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromScale(0.66, 0.78),
			Util.Create("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0.01, 0)
			}),
			Parent = parent
		})

		for i, action in ipairs(data.Actions) do
			self.ActionNames[action] = `{data.ChipLabel} {i}`
			self:_CreateKeyButton(action, 1, {
				Name = action,
				LayoutOrder = i,
				Size = UDim2.fromScale(0.091, 1),
				Parent = parent2
			})
		end

		return parent
	else
		local action = data.Actions[1]
		self.ActionNames[action] = data.Label

		for i = 1, 2 do
			self:_CreateKeyButton(action, i, {
				Name = `Slot{i}`,
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.fromScale(i == 1 and 0.785 or 1, 0.5),
				Size = UDim2.fromScale(0.19, 0.78),
				Parent = parent
			})
		end

		return parent
	end
end

function ControlsWindow:_CreateKeyButton(actionId: string, slot: number, p)
	local button, label, setState = CreateButton(p)
	local v3 = {
		Button = button,
		Label = label,
		ActionId = actionId,
		Slot = slot,
		SetState = setState
	}
	table.insert(self.KeyButtons, v3)
	button.Activated:Connect(function()
		if self.CancelledByClick == v3 then
			self.CancelledByClick = nil
		else
			self:_StartCapture(v3)
		end
	end)
	button.MouseButton2Click:Connect(function()
		self:_StopCapture()

		if Keybinds.GetKeys(actionId, "Keyboard")[slot] and Keybinds.Unassign(actionId, slot) then
			SoundHandler.Play("SettingOff")
		end
	end)
end

function ControlsWindow:_RefreshButton(data)
	if self.Capture == data then
		data.Label.Text = "..."
		data.Label.TextTransparency = 0
	else
		local v3 = Keybinds.GetKeys(data.ActionId, "Keyboard")[data.Slot]
		data.Label.Text = not v3 and "-" or Keybinds.GetKeyDisplayName(v3)
		data.Label.TextTransparency = v3 and 0 or 0.5
	end
end

function ControlsWindow:_Refresh()
	for _, keyButton in ipairs(self.KeyButtons) do
		self:_RefreshButton(keyButton)
	end
end

function ControlsWindow:_GetIdleStatus()
	local capture = self.Capture

	if capture then
		return `PRESS A KEY FOR {self.ActionNames[capture.ActionId]}  •  CLICK ANYWHERE TO CANCEL`
	end

	return "CLICK A KEY TO CHANGE IT  •  RIGHT-CLICK TO CLEAR IT"
end

function ControlsWindow:_SetStatus(text: string, flag: boolean?, flag2: boolean?)
	self.StatusToken += 1
	local statusToken = self.StatusToken
	self.Status.Text = text
	local status = self.Status
	local textColor

	if flag then
		textColor = color4
	else
		textColor = color
	end

	status.TextColor3 = textColor

	if flag2 then
		task.delay(3, function()
			if self.StatusToken == statusToken then
				self:_SetStatus(self:_GetIdleStatus())
			end
		end)
	end
end

function ControlsWindow:_StartCapture(capture)
	self:_StopCapture()
	self.Capture = capture
	capture.SetState("Active")
	self:_RefreshButton(capture)
	self:_SetStatus(self:_GetIdleStatus())
	Keybinds.SetCapturing(true)
end

function ControlsWindow:_StopCapture()
	local capture = self.Capture

	if not capture then
		return
	end

	self.Capture = nil
	capture.SetState("Normal")
	self:_RefreshButton(capture)
	self:_SetStatus("CLICK A KEY TO CHANGE IT  •  RIGHT-CLICK TO CLEAR IT")
	task.defer(function()
		if not self.Capture then
			Keybinds.SetCapturing(false)
		end
	end)
end

function ControlsWindow:_OnInputBegan(p, flag: boolean)
	local capture = self.Capture
	local userInputType = p.UserInputType

	if userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.MouseButton2 then
		self.CancelledByClick = capture
		self:_StopCapture()
	else
		if not capture or userInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		local keyCode = p.KeyCode

		if keyCode == Enum.KeyCode.Escape then
			self:_StopCapture()
			return
		end

		if flag then
			return
		end

		local name = keyCode.Name

		if not Keybinds.IsBindableKey(name) then
			self:_SetStatus(`{Keybinds.GetKeyDisplayName(name)} IS RESERVED, TRY ANOTHER KEY`, true, true)
			return
		end

		self:_StopCapture()
		local v3, v4 = Keybinds.Assign(capture.ActionId, capture.Slot, name)

		if not v3 then
			self:_SetStatus("COULDN'T SAVE THAT KEY, TRY AGAIN", true, true)
			return
		end

		SoundHandler.Play("SettingOn")

		if #v4 > 0 then
			local v5 = {}

			for _, v6 in ipairs(v4) do
				table.insert(v5, self.ActionNames[v6] or v6)
			end

			self:_SetStatus(`{Keybinds.GetKeyDisplayName(name)} MOVED FROM {table.concat(v5, ", ")}`, false, true)
		end
	end
end

function ControlsWindow:Open()
	self:_Refresh()
	self:_SetStatus("CLICK A KEY TO CHANGE IT  •  RIGHT-CLICK TO CLEAR IT")
	self.Root.Visible = true
end

function ControlsWindow:Close()
	self:_StopCapture()
	self.Root.Visible = false
end

function ControlsWindow.IsOpen(p)
	return p.Root.Visible
end

function ControlsWindow:Destroy()
	self:_StopCapture()
	self.Cleaner:Clean()
end

return ControlsWindow