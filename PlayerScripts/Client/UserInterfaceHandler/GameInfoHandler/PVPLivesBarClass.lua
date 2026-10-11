local PVPLivesBarClass = {}
PVPLivesBarClass.__index = PVPLivesBarClass
local TweenService = game:GetService("TweenService")
local color = Color3.fromRGB(255, 255, 255)
local PVP_TEAM_BAR_COLORS = _G.PVP_TEAM_BAR_COLORS

local function CancelTween(object) -- 6 equivalent calls inferred from this helper
	if object then
		object:Cancel()
	end
end

local function GetJuiceWidth(p: number, juiceDecoration) -- 3 equivalent calls inferred from this helper
	return (math.max(p - juiceDecoration.Size.X.Scale, 0))
end

local function TintGhostColor(value: Color3) -- 3 equivalent calls inferred from this helper
	return color:Lerp(value, 0.35)
end

local function ApplyRamp(p, color2: Color3, color3: Color3) -- 3 equivalent calls inferred from this helper
	if p then
		p.Color = ColorSequence.new(color2, color3)
	end
end

local function CreateGhostFrame(juiceFrame, juice, flag: boolean)
	local frame = Instance.new("Frame")
	frame.Name = "GhostFrame"
	frame.BackgroundTransparency = 1
	frame.AnchorPoint = juiceFrame.AnchorPoint
	frame.Position = juiceFrame.Position
	frame.Size = juiceFrame.Size
	frame.ZIndex = 1
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

	local anchorPoint

	if flag then
		anchorPoint = Vector2.new(1, 0)
	else
		anchorPoint = Vector2.new(0, 0)
	end

	frame2.AnchorPoint = anchorPoint
	local position

	if flag then
		position = UDim2.new(1, 0, 0, 0)
	else
		position = UDim2.new(0, 0, 0, 0)
	end

	frame2.Position = position
	frame2.Size = UDim2.new(0, 0, 1, 0)
	frame2.Parent = frame
	frame.Parent = juiceFrame.Parent
	return frame2
end

function PVPLivesBarClass.New(instance, flag: boolean)
	local juiceFrame = instance:WaitForChild("JuiceFrame")
	local juice = juiceFrame:WaitForChild("Juice")
	local hpFrame = instance:WaitForChild("HPFrame")
	local uiScale = Instance.new("UIScale")
	uiScale.Parent = hpFrame
	local juiceDecoration = juiceFrame:WaitForChild("JuiceDecoration")
	local ghost = CreateGhostFrame(juiceFrame, juice, flag)
	return (setmetatable({
		Juice = juice,
		JuiceDecoration = juiceDecoration,
		HPText = hpFrame:WaitForChild("HPText"),
		HPScale = uiScale,
		Ghost = ghost,
		JuiceGradient = juice:FindFirstChildWhichIsA("UIGradient"),
		DecorationGradient = juiceDecoration:FindFirstChildWhichIsA("UIGradient"),
		GhostGradient = ghost:FindFirstChildWhichIsA("UIGradient"),
		TeamIndex = nil,
		LastFraction = nil,
		DisplayedHP = nil,
		TargetHP = nil,
		HPAnimFrom = 0,
		HPAnimStart = nil,
		GhostToken = 0,
		JuiceTween = nil,
		GhostTween = nil,
		ScaleTween = nil
	}, PVPLivesBarClass))
end

function PVPLivesBarClass:SetTeamIndex(teamIndex: number?)
	local v = teamIndex and PVP_TEAM_BAR_COLORS[teamIndex]

	if not v or self.TeamIndex == teamIndex then
		return
	end

	self.TeamIndex = teamIndex
	ApplyRamp(self.JuiceGradient, v.Fill[1], v.Fill[2]) -- inferred equivalent call
	ApplyRamp(self.DecorationGradient, v.Cap[1], v.Cap[2]) -- inferred equivalent call
	ApplyRamp(self.GhostGradient, TintGhostColor(v.Fill[1]), TintGhostColor(v.Fill[2])) -- inferred equivalent call
end

function PVPLivesBarClass:Punch()
	CancelTween(self.ScaleTween) -- inferred equivalent call
	self.HPScale.Scale = 1.12
	local tween = TweenService:Create(
		self.HPScale,
		TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Scale = 1 }
	)
	self.ScaleTween = tween
	tween:Play()
end

function PVPLivesBarClass:Step()
	local hpAnimStart = self.HPAnimStart
	local targetHP = self.TargetHP

	if not (hpAnimStart and targetHP) then
		return
	end

	local v = math.min((os.clock() - hpAnimStart) / 0.3, 1)
	local displayedHP = self.HPAnimFrom + (targetHP - self.HPAnimFrom) * v
	self.DisplayedHP = displayedHP
	self.HPText.Text = `{math.ceil(displayedHP)} HP`

	if v >= 1 then
		self.HPAnimStart = nil
	end
end

function PVPLivesBarClass:Refresh(p: number?, p2: number?)
	if p and p2 and not (p2 <= 0) then
		local lastFraction2 = math.min(1, p / p2)
		local lastFraction = self.LastFraction
		self.LastFraction = lastFraction2

		if lastFraction == nil then
			self.Juice.Size = UDim2.new(GetJuiceWidth(lastFraction2, self.JuiceDecoration), 0, 1, 0) -- inferred equivalent call
		elseif lastFraction2 ~= lastFraction then
			CancelTween(self.JuiceTween) -- inferred equivalent call
			local tween = TweenService:Create(
				self.Juice,
				TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{
					Size = UDim2.new(GetJuiceWidth(lastFraction2, self.JuiceDecoration), 0, 1, 0) -- inferred equivalent call
				}
			)
			self.JuiceTween = tween
			tween:Play()
		end

		self.JuiceDecoration.Visible = lastFraction2 > 0

		if lastFraction and lastFraction2 < lastFraction then
			CancelTween(self.GhostTween) -- inferred equivalent call
			self.Ghost.Size = UDim2.new(math.max(self.Ghost.Size.X.Scale, lastFraction), 0, 1, 0)
			self.GhostToken += 1
			local ghostToken = self.GhostToken
			task.delay(0.4, function()
				if self.GhostToken ~= ghostToken then
					return
				end

				local tween = TweenService:Create(
					self.Ghost,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{
						Size = UDim2.new(self.LastFraction or 0, 0, 1, 0)
					}
				)
				self.GhostTween = tween
				tween:Play()
			end)

			if lastFraction - lastFraction2 > 0.05 then
				self:Punch()
			end
		elseif lastFraction and lastFraction < lastFraction2 then
			CancelTween(self.GhostTween) -- inferred equivalent call
			self.GhostToken += 1
			self.Ghost.Size = UDim2.new(0, 0, 1, 0)
		end

		if self.TargetHP ~= p then
			local displayedHP = self.DisplayedHP

			if displayedHP == nil then
				self.DisplayedHP = p
				self.HPText.Text = `{math.ceil(p)} HP`
			else
				self.HPAnimFrom = displayedHP
				self.HPAnimStart = os.clock()
			end

			self.TargetHP = p
		end
	else
		CancelTween(self.JuiceTween) -- inferred equivalent call
		CancelTween(self.GhostTween) -- inferred equivalent call
		self.GhostToken += 1
		self.Juice.Size = UDim2.new(GetJuiceWidth(1, self.JuiceDecoration), 0, 1, 0) -- inferred equivalent call
		self.JuiceDecoration.Visible = true
		self.Ghost.Size = UDim2.new(0, 0, 1, 0)
		self.HPText.Text = "-"
		self.LastFraction = nil
		self.DisplayedHP = nil
		self.TargetHP = nil
		self.HPAnimStart = nil
	end
end

return PVPLivesBarClass