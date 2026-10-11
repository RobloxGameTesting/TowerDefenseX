local CutsceneScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("WaveTypes"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("SoundHandler"))
local DEBUG_CUTSCENE_CONTROLS = _G.DEBUG_CUTSCENE_CONTROLS
local cutsceneScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("CutsceneScreen")
local background = cutsceneScreen:WaitForChild("Background")
local subtitleText = cutsceneScreen:WaitForChild("SubtitleText")
local flag = false
local v = 0
local v2 = nil

local function GetDebugAnimationTimeLabel()
	if v2 then
		return v2
	end

	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "DebugAnimationTime"
	textLabel.AnchorPoint = Vector2.new(0, 0)
	textLabel.Position = UDim2.new(0, 12, 0, 12)
	textLabel.Size = UDim2.new(0, 110, 0, 26)
	textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BackgroundTransparency = 0.4
	textLabel.BorderSizePixel = 0
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Font = Enum.Font.Code
	textLabel.TextSize = 20
	textLabel.ZIndex = 10
	textLabel.Visible = false
	textLabel.Parent = cutsceneScreen
	v2 = textLabel
	return v2
end

local function Color3ToRGBText(color: Color3) -- 2 equivalent calls inferred from this helper
	return string.format("%d,%d,%d", math.round(color.R * 255), math.round(color.G * 255), (math.round(color.B * 255)))
end

function CutsceneScreenHandler.ShowScreen()
	cutsceneScreen.Visible = true
end

function CutsceneScreenHandler.HideScreen()
	cutsceneScreen.Visible = false
end

function CutsceneScreenHandler.FadeInBackground(duration: number)
	TweenService:Create(background, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 0
	}):Play()
end

function CutsceneScreenHandler.FadeOutBackground(duration: number)
	TweenService:Create(background, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	}):Play()
end

function CutsceneScreenHandler.SetBackgroundColor(backgroundColor: Color3)
	background.BackgroundColor3 = backgroundColor
end

function CutsceneScreenHandler.ShowBackground()
	background.BackgroundTransparency = 0
end

function CutsceneScreenHandler.HideBackground()
	background.BackgroundTransparency = 1
end

function CutsceneScreenHandler.WriteSubtitle(p: string, color: Color3?, p2: string, color2: Color3?, p3: number)
	local v3 = color or Color3.fromRGB(255, 255, 255)
	local v4 = color2 or Color3.fromRGB(255, 255, 255)
	subtitleText.Text = `<font color="rgb({Color3ToRGBText(v3)})">{p}: </font>` .. `<font color="rgb({Color3ToRGBText(v4)})">{p2}</font>` -- inferred equivalent call
	subtitleText.Visible = true

	if subtitleText.TextBounds.X + 100 > cutsceneScreen.AbsoluteSize.X then
		subtitleText.TextSize = 16

		if subtitleText.TextBounds.X + 100 > cutsceneScreen.AbsoluteSize.X then
			subtitleText.TextSize = 14

			if subtitleText.TextBounds.X + 100 > cutsceneScreen.AbsoluteSize.X then
				subtitleText.TextSize = 12

				if subtitleText.TextBounds.X + 100 > cutsceneScreen.AbsoluteSize.X then
					subtitleText.TextSize = 10
				end
			end
		end
	else
		subtitleText.TextSize = 18
	end

	subtitleText.Size = UDim2.new(0, subtitleText.TextBounds.X + 42, 0, subtitleText.TextBounds.Y + 14)
	v = p3
	flag = true
end

function CutsceneScreenHandler.DebugSetAnimationTime(p: number?, flag2: boolean?)
	if not DEBUG_CUTSCENE_CONTROLS then
		return
	end

	local debugAnimationTimeLabel = GetDebugAnimationTimeLabel()

	if not p then
		debugAnimationTimeLabel.Visible = false
		return
	end

	debugAnimationTimeLabel.Text = string.format(flag2 and "%.2f ||" or "%.2f", p)
	debugAnimationTimeLabel.Visible = true
end

local event = NetworkingHandler.GetEvent("DevCutsceneControlRequest")
local v3 = nil
local frame = nil
local frame2 = nil
local textLabel = nil
local textButton = nil
local textLabel2 = nil
local v4 = false
local v5 = 0
local v6 = false

local function GetDebugScrubber()
	if v3 then
		return v3
	end

	local UserInputService = game:GetService("UserInputService")
	local frame3 = Instance.new("Frame")
	frame3.Name = "DebugScrubber"
	frame3.AnchorPoint = Vector2.new(0.5, 1)
	frame3.Position = UDim2.new(0.5, 0, 1, -24)
	frame3.Size = UDim2.new(0.55, 0, 0, 34)
	frame3.BackgroundTransparency = 1
	frame3.ZIndex = 10
	frame3.Visible = false
	frame3.Parent = cutsceneScreen
	textButton = Instance.new("TextButton")
	textButton.Name = "PlayButton"
	textButton.Size = UDim2.new(0, 34, 0, 34)
	textButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textButton.BackgroundTransparency = 0.4
	textButton.BorderSizePixel = 0
	textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	textButton.Font = Enum.Font.Code
	textButton.TextSize = 20
	textButton.Text = "||"
	textButton.ZIndex = 11
	textButton.Parent = frame3
	frame = Instance.new("Frame")
	frame.Name = "Bar"
	frame.AnchorPoint = Vector2.new(0, 0.5)
	frame.Position = UDim2.new(0, 44, 0.5, 0)
	frame.Size = UDim2.new(1, -160, 0, 26)
	frame.BackgroundTransparency = 1
	frame.ZIndex = 11
	frame.Parent = frame3
	local frame4 = Instance.new("Frame")
	frame4.Name = "Track"
	frame4.AnchorPoint = Vector2.new(0, 0.5)
	frame4.Position = UDim2.new(0, 0, 0.5, 0)
	frame4.Size = UDim2.new(1, 0, 0, 8)
	frame4.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame4.BackgroundTransparency = 0.4
	frame4.BorderSizePixel = 0
	frame4.ZIndex = 11
	frame4.Parent = frame
	frame2 = Instance.new("Frame")
	frame2.Name = "Fill"
	frame2.Size = UDim2.new(0, 0, 1, 0)
	frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame2.BorderSizePixel = 0
	frame2.ZIndex = 12
	frame2.Parent = frame4
	textLabel = Instance.new("TextLabel")
	textLabel.Name = "Time"
	textLabel.AnchorPoint = Vector2.new(1, 0.5)
	textLabel.Position = UDim2.new(1, 0, 0.5, 0)
	textLabel.Size = UDim2.new(0, 106, 0, 26)
	textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BackgroundTransparency = 0.4
	textLabel.BorderSizePixel = 0
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.Font = Enum.Font.Code
	textLabel.TextSize = 14
	textLabel.ZIndex = 11
	textLabel.Parent = frame3
	textLabel2 = Instance.new("TextLabel")
	local v7 = textLabel2
	v7.Name = "HoverTime"
	v7.AnchorPoint = Vector2.new(0.5, 1)
	v7.Size = UDim2.new(0, 62, 0, 22)
	v7.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	v7.BackgroundTransparency = 0.2
	v7.BorderSizePixel = 0
	v7.TextColor3 = Color3.fromRGB(255, 255, 255)
	v7.Font = Enum.Font.Code
	v7.TextSize = 14
	v7.ZIndex = 13
	v7.Visible = false
	v7.Parent = frame

	local function GetBarFraction(p: number) -- 4 equivalent calls inferred from this helper
		local x = frame.AbsolutePosition.X
		local x2 = frame.AbsoluteSize.X
		return (math.clamp((p - x) / x2, 0, 1))
	end

	local function PreviewFraction(p: number) -- 3 equivalent calls inferred from this helper
		frame2.Size = UDim2.new(p, 0, 1, 0)
		textLabel.Text = string.format("%.2f / %.2f", p * v5, v5)
	end

	local function UpdateHoverLabel(p: number) -- 2 equivalent calls inferred from this helper
		local barFraction = GetBarFraction(p) -- inferred equivalent call
		v7.Position = UDim2.new(barFraction, 0, 0, -4)
		v7.Text = string.format("%.2f", barFraction * v5)
		v7.Visible = true
	end

	frame.MouseMoved:Connect(function(p: number)
		UpdateHoverLabel(p) -- inferred equivalent call
	end)
	frame.MouseLeave:Connect(function()
		if not v4 then
			v7.Visible = false
		end
	end)
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			v4 = true
			PreviewFraction(GetBarFraction(input.Position.X)) -- inferred equivalent call
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if v4 and input.UserInputType == Enum.UserInputType.MouseMovement then
			PreviewFraction(GetBarFraction(input.Position.X)) -- inferred equivalent call
			UpdateHoverLabel(input.Position.X) -- inferred equivalent call
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if v4 and input.UserInputType == Enum.UserInputType.MouseButton1 then
			v4 = false
			v7.Visible = false
			local barFraction = GetBarFraction(input.Position.X) -- inferred equivalent call
			PreviewFraction(barFraction) -- inferred equivalent call
			event:FireServer("Seek", barFraction * v5)
		end
	end)
	textButton.Activated:Connect(function()
		event:FireServer(v6 and "Resume" or "Pause")
	end)
	v3 = frame3
	return frame3
end

function CutsceneScreenHandler.DebugUpdateScrubber(p: number?, p2: number?, flag2: boolean?)
	if p and p2 and not (p2 <= 0) then
		local getDebugScrubber = GetDebugScrubber()
		getDebugScrubber.Visible = true
		v5 = p2
		v6 = flag2 or false
		textButton.Text = v6 and " >" or "||"

		if not v4 then
			frame2.Size = UDim2.new(math.clamp(p / p2, 0, 1), 0, 1, 0)
			textLabel.Text = string.format("%.2f / %.2f", p, p2)
		end
	elseif v3 then
		v3.Visible = false
		v4 = false
		textLabel2.Visible = false
	end
end

RunService.Heartbeat:Connect(function(dt: number)
	if flag then
		v -= dt

		if v <= 0 then
			subtitleText.Visible = false
			flag = false
		end
	end
end)
return CutsceneScreenHandler