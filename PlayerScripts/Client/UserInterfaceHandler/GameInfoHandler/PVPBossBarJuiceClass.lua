local PVPBossBarJuiceClass = {}
PVPBossBarJuiceClass.__index = PVPBossBarJuiceClass
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
local tweenInfo2 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.35)
local tweenInfo3 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local color = Color3.fromRGB(255, 60, 60)
local tweenInfo4 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo5 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local color2 = Color3.fromRGB(255, 255, 255)
local tweenInfo6 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function CancelTween(object) -- 8 equivalent calls inferred from this helper
	if object then
		object:Cancel()
	end
end

local function TintGhostColor(value: Color3) -- 1 equivalent call inferred from this helper
	return color2:Lerp(value, 0.35)
end

local function CreateGhostFrame(juiceFrame, juice)
	local frame = Instance.new("Frame")
	frame.Name = "GhostFrame"
	frame.BackgroundTransparency = 1
	frame.AnchorPoint = juiceFrame.AnchorPoint
	frame.Position = juiceFrame.Position
	frame.Size = juiceFrame.Size
	frame.ZIndex = juiceFrame.ZIndex - 1
	local frame2 = Instance.new("Frame")
	frame2.Name = "Ghost"
	frame2.BackgroundColor3 = TintGhostColor(juice.BackgroundColor3) -- inferred equivalent call
	frame2.BackgroundTransparency = 0.35
	frame2.BorderSizePixel = 0
	local uiGradient = juice:FindFirstChildWhichIsA("UIGradient")

	if uiGradient then
		local clone = uiGradient:Clone()
		local colorSequenceKeypoints = {}

		for _, keypoint in clone.Color.Keypoints do
			table.insert(
				colorSequenceKeypoints,
				ColorSequenceKeypoint.new(keypoint.Time, TintGhostColor(keypoint.Value))
			)
		end

		clone.Color = ColorSequence.new(colorSequenceKeypoints)
		clone.Parent = frame2
	end

	frame2.Size = UDim2.new(0, 0, 1, 0)
	frame2.Parent = frame
	frame.Parent = juiceFrame.Parent
	return frame2
end

local function CreateFlashOverlay(barParent)
	local frame = Instance.new("Frame")
	frame.Name = "FlashOverlay"
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.fromScale(1, 1)
	frame.ZIndex = 10
	local uiCorner = barParent:FindFirstChildWhichIsA("UICorner")

	if uiCorner then
		local clone = uiCorner:Clone()
		clone.Parent = frame
	end

	frame.Parent = barParent
	return frame
end

local function CaptureFadeTargets(content, p)
	local v = {}

	local function Add(instance, property: string) -- 5 equivalent calls inferred from this helper
		table.insert(v, { Instance = instance, Property = property, Original = instance[property] })
	end

	local function Scan(instance)
		if instance == p then
			return
		end

		if instance:IsA("GuiObject") then
			Add(instance, "BackgroundTransparency") -- inferred equivalent call
		end

		if instance:IsA("TextLabel") or instance:IsA("TextButton") then
			Add(instance, "TextTransparency") -- inferred equivalent call
			Add(instance, "TextStrokeTransparency") -- inferred equivalent call
		end

		if instance:IsA("ImageLabel") or instance:IsA("ImageButton") then
			Add(instance, "ImageTransparency") -- inferred equivalent call
		end

		if instance:IsA("UIStroke") then
			Add(instance, "Transparency") -- inferred equivalent call
		end

		for _, child in instance:GetChildren() do
			Scan(child)
		end
	end

	Scan(content)
	return v
end

function PVPBossBarJuiceClass.New()
	return (setmetatable({ Slots = {}, SeenBosses = {} }, PVPBossBarJuiceClass))
end

function PVPBossBarJuiceClass.RegisterSlot(p, p2: number, data)
	local uiScale = Instance.new("UIScale")
	uiScale.Parent = data.Content
	local uiScale2

	if data.HeadshotImage then
		uiScale2 = Instance.new("UIScale")
		uiScale2.Parent = data.HeadshotImage
	end

	local flash = CreateFlashOverlay(data.BarParent)
	local ghost = CreateGhostFrame(data.JuiceFrame, data.Juice)
	p.Slots[p2] = {
		Frame = data.Frame,
		BaseZIndex = data.Frame.ZIndex,
		AspectConstraint = data.Frame:FindFirstChildWhichIsA("UIAspectRatioConstraint"),
		SizeConstraint = data.Frame:FindFirstChildWhichIsA("UISizeConstraint"),
		BaseSize = nil,
		BaseMinSize = nil,
		Content = data.Content,
		ContentScale = uiScale,
		HeadshotScale = uiScale2,
		Flash = flash,
		Ghost = ghost,
		FadeTargets = CaptureFadeTargets(data.Content, flash),
		FadeTweens = {},
		BasePosition = nil,
		Occupant = nil,
		LastFraction = nil,
		Token = 0,
		GhostToken = 0,
		SlideTween = nil,
		PopTween = nil,
		FlashTween = nil,
		ScaleTween = nil,
		GhostTween = nil,
		CollapseTween = nil
	}
end

function PVPBossBarJuiceClass:NotifyBossRemoved(p, flag: boolean?)
	self.SeenBosses[p] = nil

	if not flag then
		return
	end

	for _, slot in pairs(self.Slots) do
		if slot.Occupant ~= p then
			continue
		end

		self:PlayDeathFade(slot)
		break
	end
end

function PVPBossBarJuiceClass:PlayFlash(state, backgroundColor: Color3, backgroundTransparency: number, p)
	CancelTween(state.FlashTween) -- inferred equivalent call
	local flash = state.Flash
	flash.BackgroundColor3 = backgroundColor
	flash.BackgroundTransparency = backgroundTransparency
	flash.Size = UDim2.fromScale(1, 1)
	state.FlashTween = TweenService:Create(flash, p, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1.35, 1.35)
	})
	state.FlashTween:Play()
end

function PVPBossBarJuiceClass:RestoreFade(p)
	for _, fadeTween in p.FadeTweens do
		fadeTween:Cancel()
	end

	table.clear(p.FadeTweens)

	for _, fadeTarget in p.FadeTargets do
		fadeTarget.Instance[fadeTarget.Property] = fadeTarget.Original
	end
end

function PVPBossBarJuiceClass:ResetGhost(state)
	CancelTween(state.GhostTween) -- inferred equivalent call
	state.GhostTween = nil
	state.GhostToken += 1
	state.Ghost.Size = UDim2.new(0, 0, 1, 0)
end

function PVPBossBarJuiceClass:CancelSlotAnimations(state)
	state.Token += 1
	CancelTween(state.SlideTween) -- inferred equivalent call
	CancelTween(state.PopTween) -- inferred equivalent call
	CancelTween(state.FlashTween) -- inferred equivalent call
	CancelTween(state.ScaleTween) -- inferred equivalent call
	CancelTween(state.CollapseTween) -- inferred equivalent call
	state.SlideTween = nil
	state.PopTween = nil
	state.FlashTween = nil
	state.ScaleTween = nil
	state.CollapseTween = nil

	if state.BaseSize then
		state.Frame.Size = state.BaseSize
		state.BaseSize = nil
	end

	if state.AspectConstraint and state.AspectConstraint.Parent ~= state.Frame then
		state.AspectConstraint.Parent = state.Frame
	end

	if state.SizeConstraint and state.BaseMinSize then
		state.SizeConstraint.MinSize = state.BaseMinSize
		state.BaseMinSize = nil
	end

	self:RestoreFade(state)
	state.ContentScale.Scale = 1

	if state.HeadshotScale then
		state.HeadshotScale.Scale = 1
	end

	state.Flash.BackgroundTransparency = 1
	state.Flash.Size = UDim2.fromScale(1, 1)
	state.Frame.ZIndex = state.BaseZIndex
	state.Content.Visible = true

	if state.BasePosition then
		state.Content.Position = state.BasePosition
	end
end

function PVPBossBarJuiceClass:PlayEntrance(state)
	local content = state.Content

	if not state.BasePosition then
		state.BasePosition = content.Position
	end

	local basePosition = state.BasePosition
	state.Frame.ZIndex = state.BaseZIndex + 10
	content.Visible = false
	content.Position = basePosition - UDim2.fromScale(0, 3)
	local token = state.Token
	task.spawn(function()
		RunService.Heartbeat:Wait()

		if state.Token ~= token then
			return
		end

		local y = state.Frame.AbsoluteSize.Y
		local v = not (y > 0) and 1.2
			or math.max(
				(content.AbsolutePosition.Y + 3 * y + content.AbsoluteSize.Y + GuiService:GetGuiInset().Y + 50) / y,
				1.2
			)
		content.Position = basePosition - UDim2.fromScale(0, v)
		content.Visible = true
		state.SlideTween = TweenService:Create(content, tweenInfo, { Position = basePosition })
		state.SlideTween:Play()

		if state.HeadshotScale then
			state.HeadshotScale.Scale = 0.6
			state.PopTween = TweenService:Create(state.HeadshotScale, tweenInfo2, { Scale = 1 })
			state.PopTween:Play()
		end

		task.delay(0.35, function()
			if state.Token ~= token then
				return
			end

			state.Frame.ZIndex = state.BaseZIndex
			self:PlayFlash(state, color, 0.15, tweenInfo4)
			state.ContentScale.Scale = 1.06
			state.ScaleTween = TweenService:Create(state.ContentScale, tweenInfo3, { Scale = 1 })
			state.ScaleTween:Play()
		end)
	end)
end

function PVPBossBarJuiceClass:PlayDeathFade(state)
	self:CancelSlotAnimations(state)
	state.ContentScale.Scale = 1
	state.ScaleTween = TweenService:Create(state.ContentScale, tweenInfo6, { Scale = 0.9 })
	state.ScaleTween:Play()

	for _, fadeTarget in state.FadeTargets do
		local v = TweenService:Create(fadeTarget.Instance, tweenInfo6, { [fadeTarget.Property] = 1 })
		table.insert(state.FadeTweens, v)
		v:Play()
	end

	local frame = state.Frame
	local parent = frame.Parent
	local y = frame.AbsoluteSize.Y
	state.BaseSize = frame.Size

	if state.AspectConstraint then
		state.AspectConstraint.Parent = nil
	end

	if state.SizeConstraint then
		state.BaseMinSize = state.SizeConstraint.MinSize
		state.SizeConstraint.MinSize = Vector2.new(state.BaseMinSize.X, 0)
	end

	if parent.AbsoluteSize.Y > 0 then
		frame.Size = UDim2.new(state.BaseSize.X.Scale, state.BaseSize.X.Offset, y / parent.AbsoluteSize.Y, 0)
	end

	state.CollapseTween = TweenService:Create(frame, tweenInfo6, {
		Size = UDim2.new(state.BaseSize.X.Scale, state.BaseSize.X.Offset, 0, 0)
	})
	state.CollapseTween:Play()
end

function PVPBossBarJuiceClass:ShowSlot(p: number, occupant, lastFraction: number)
	local slot = self.Slots[p]

	if not slot then
		return
	end

	if slot.Occupant ~= occupant then
		local v = not self.SeenBosses[occupant]
		slot.Occupant = occupant
		slot.LastFraction = nil
		self:ResetGhost(slot)
		self:CancelSlotAnimations(slot)

		if lastFraction <= 0 then
			self:PlayDeathFade(slot)
		else
			self.SeenBosses[occupant] = true

			if v then
				self:PlayEntrance(slot)
			end
		end
	end

	local lastFraction2 = slot.LastFraction
	slot.LastFraction = lastFraction

	if lastFraction2 and lastFraction < lastFraction2 then
		CancelTween(slot.GhostTween) -- inferred equivalent call
		slot.Ghost.Size = UDim2.new(math.max(slot.Ghost.Size.X.Scale, lastFraction2), 0, 1, 0)
		slot.GhostToken += 1
		local ghostToken = slot.GhostToken
		task.delay(0.4, function()
			if slot.GhostToken ~= ghostToken then
				return
			end

			local tween = TweenService:Create(slot.Ghost, tweenInfo5, {
				Size = UDim2.new(slot.LastFraction or 0, 0, 1, 0)
			})
			slot.GhostTween = tween
			tween:Play()
		end)
	elseif lastFraction2 and lastFraction2 < lastFraction then
		self:ResetGhost(slot)
	end
end

function PVPBossBarJuiceClass:HideSlot(p: number, p2)
	local slot = self.Slots[p]

	if not slot then
		p2.Visible = false
		return
	end

	if slot.Occupant then
		slot.Occupant = nil
		slot.LastFraction = nil
		self:ResetGhost(slot)
		self:CancelSlotAnimations(slot)
	end

	slot.Frame.Visible = false
end

return PVPBossBarJuiceClass