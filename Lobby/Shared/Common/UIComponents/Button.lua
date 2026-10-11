local Button = {}
Button.__index = Button
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Common = ReplicatedStorage.Shared.Common
require(Common:WaitForChild("Types"))
local Constants = require(Common:WaitForChild("Constants"))
local AudioHandler = require(Common:WaitForChild("AudioHandler"))
local Utils = require(Common:WaitForChild("Utils"))
local Enums = require(Common:WaitForChild("Enums"))
local ButtonStates = Enums.ButtonStates

local function ValidateConfig(data) -- 1 equivalent call inferred from this helper
	if not data.ButtonUI then
		warn("Button config missing ButtonUI")
	end

	if not data.Name then
		warn("Button config missing Name")
	end
end

function Button.New(data)
	ValidateConfig(data) -- inferred equivalent call
	local buttonUI = data.ButtonUI
	buttonUI.AutoButtonColor = false
	local primary = Constants.Colors.ButtonColors.Primary
	local backgroundColor = data.BackgroundColor or primary.Normal
	local hoverColor = data.HoverColor or primary.Hover
	local pressedColor = data.PressedColor or primary.Pressed
	local disabledColor = data.DisabledColor or primary.Disabled
	local textColor = data.TextColor or Constants.Colors.ButtonColors.Text.Normal
	local v = {
		Name = data.Name,
		ButtonUI = buttonUI,
		IconImage = nil,
		TextLabel = nil,
		CurrentState = ButtonStates.Normal,
		Enabled = data.Enabled == nil or data.Enabled,
		IsHovering = false,
		NormalColor = backgroundColor,
		HoverColor = hoverColor,
		PressedColor = pressedColor,
		DisabledColor = disabledColor,
		TextColor = textColor,
		OnClick = data.OnClick,
		ClickSFX = data.SFX,
		IconOnly = data.IconOnly or false,
		Cooldown = data.Cooldown or 0,
		CooldownActive = false,
		CooldownOverlay = nil,
		CooldownTween = nil,
		CooldownConnection = nil,
		CurrentTween = nil
	}
	setmetatable(v, Button)

	if v.IconOnly then
		buttonUI.BackgroundTransparency = 1
	end

	if data.Icon then
		v:SetIcon(data.Icon)
	end

	if data.Text then
		v:SetText(data.Text)
	end

	v:ConnectEvents()
	v:SetState(ButtonStates.Normal)
	return v
end

function Button:SetIcon(p: string)
	local image = Constants.Icons[p] or p

	if self.IconImage then
		self.IconImage.Image = image
		return
	end

	local imageLabel = self.ButtonUI:FindFirstChildOfClass("ImageLabel")

	if imageLabel then
		imageLabel.Image = image
		self.IconImage = imageLabel
	end
end

function Button:SetText(text: string)
	if self.TextLabel then
		self.TextLabel.Text = text
		Utils.ResizeToFitText(self.TextLabel)
	else
		local textLabel = self.ButtonUI:FindFirstChildOfClass("TextLabel")

		if textLabel then
			textLabel.Text = text
			self.TextLabel = textLabel
			Utils.ResizeToFitText(textLabel)
		end
	end
end

function Button:ConnectEvents()
	local buttonUI = self.ButtonUI
	buttonUI.MouseEnter:Connect(function()
		self.IsHovering = true

		if self.Enabled and not self.CooldownActive and self.CurrentState ~= ButtonStates.Pressed then
			self:SetState(ButtonStates.Hover)
		end
	end)
	buttonUI.MouseLeave:Connect(function()
		self.IsHovering = false

		if self.Enabled and not self.CooldownActive and self.CurrentState ~= ButtonStates.Pressed then
			self:SetState(ButtonStates.Normal)
		end
	end)
	buttonUI.Activated:Connect(function()
		if self.Enabled and not self.CooldownActive then
			self:SetState(ButtonStates.Pressed)

			if self.ClickSFX and self.ClickSFX ~= "" then
				AudioHandler.PlaySound(self.ClickSFX)
			end

			local v = not self.OnClick or self.OnClick() ~= false
			task.wait(Constants.ButtonPressedHoldDuration)

			if not self.Enabled then
				return
			end

			if self.Cooldown > 0 and v then
				self:StartCooldown()
			elseif self.IsHovering then
				self:SetState(ButtonStates.Hover)
			else
				self:SetState(ButtonStates.Normal)
			end
		end
	end)
end

function Button:SetState(currentState: string)
	if self.CurrentState == currentState then
		return
	end

	self.CurrentState = currentState

	if self.CurrentTween then
		self.CurrentTween:Cancel()
	end

	local tweenInfo = TweenInfo.new(Constants.ButtonAnimationDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	if self.IconOnly then
		local uiScale = self.ButtonUI:FindFirstChildOfClass("UIScale")

		if uiScale then
			local iconButtonHoverScale = 1

			if currentState == ButtonStates.Hover then
				iconButtonHoverScale = Constants.IconButtonHoverScale
			elseif currentState == ButtonStates.Pressed then
				iconButtonHoverScale = Constants.IconButtonPressedScale
			end

			self.CurrentTween = TweenService:Create(uiScale, tweenInfo, {
				Scale = iconButtonHoverScale
			})
		end
	else
		local normalColor = self.NormalColor

		if currentState == ButtonStates.Hover then
			normalColor = self.HoverColor
		elseif currentState == ButtonStates.Pressed then
			normalColor = self.PressedColor
		elseif currentState == ButtonStates.Disabled then
			normalColor = self.DisabledColor
		end

		self.CurrentTween = TweenService:Create(self.ButtonUI, tweenInfo, {
			ImageColor3 = normalColor
		})
	end

	if self.CurrentTween then
		self.CurrentTween:Play()
	end
end

function Button:StartCooldown()
	self.CooldownActive = true

	if self.CurrentTween then
		self.CurrentTween:Cancel()
		self.CurrentTween = nil
	end

	if not self.CooldownOverlay then
		local frame = Instance.new("Frame")
		frame.Name = "CooldownOverlay"
		frame.AnchorPoint = Vector2.new(0, 0)
		frame.Position = UDim2.new(0, 0, 0, 0)
		frame.Size = UDim2.new(0, 0, 1, 0)
		frame.BackgroundColor3 = self.NormalColor
		frame.BorderSizePixel = 0
		frame.ZIndex = self.ButtonUI.ZIndex + 1
		frame.Parent = self.ButtonUI
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 6)
		uiCorner.Parent = frame
		self.CooldownOverlay = frame
	end

	local cooldownOverlay = self.CooldownOverlay

	if not cooldownOverlay then
		return
	end

	if self.IconImage then
		self.IconImage.Visible = false
	end

	if self.TextLabel then
		self.TextLabel.Visible = false
	end

	local uiListLayout = self.ButtonUI:FindFirstChildOfClass("UIListLayout")

	if uiListLayout then
		uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	end

	self.ButtonUI.ImageColor3 = self.DisabledColor
	cooldownOverlay.Visible = true
	cooldownOverlay.Size = UDim2.new(0, 0, 1, 0)

	if self.CooldownTween then
		self.CooldownTween:Cancel()
		self.CooldownTween = nil
	end

	if self.CooldownConnection then
		self.CooldownConnection:Disconnect()
		self.CooldownConnection = nil
	end

	local tween = TweenService:Create(
		cooldownOverlay,
		TweenInfo.new(self.Cooldown, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
		{ Size = UDim2.new(1, 0, 1, 0) }
	)
	self.CooldownTween = tween
	self.CooldownConnection = tween.Completed:Connect(function(p)
		if p ~= Enum.PlaybackState.Completed then
			return
		end

		self.CooldownActive = false
		self.ButtonUI.ImageColor3 = self.NormalColor
		cooldownOverlay.Visible = false
		local uiListLayout2 = self.ButtonUI:FindFirstChildOfClass("UIListLayout")

		if uiListLayout2 then
			uiListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
		end

		if self.IconImage then
			self.IconImage.Visible = true
		end

		if self.TextLabel then
			self.TextLabel.Visible = true
			self.TextLabel.TextTransparency = 1
			TweenService:Create(
				self.TextLabel,
				TweenInfo.new(Constants.ButtonAnimationDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ TextTransparency = 0 }
			):Play()
		end

		if not self.Enabled then
			return
		end

		if self.IsHovering then
			self:SetState(ButtonStates.Hover)
		else
			self:SetState(ButtonStates.Normal)
		end
	end)
	tween:Play()
end

function Button:SetEnabled(enabled: boolean)
	self.Enabled = enabled

	if enabled then
		self:SetState(ButtonStates.Normal)
	else
		self:SetState(ButtonStates.Disabled)
	end
end

function Button:SetOnClick(onClick)
	self.OnClick = onClick
end

function Button.Destroy(p)
	if p.CurrentTween then
		p.CurrentTween:Cancel()
	end
end

return Button