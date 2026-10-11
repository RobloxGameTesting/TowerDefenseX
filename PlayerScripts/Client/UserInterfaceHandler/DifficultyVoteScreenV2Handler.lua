local DifficultyVoteScreenV2Handler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("WaveTypes"))
local Enums = require(common:WaitForChild("Enums"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local LobbyTypeUtilities = require(common:WaitForChild("LobbyTypeUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local RewardsHelper = require(common:WaitForChild("RewardsHelper"))
local MapDifficultyRewardsData = require(common:WaitForChild("MapDifficultyRewardsData"))
local RewardMultipliers = require(common:WaitForChild("RewardMultipliers"))
local tweenInfo = TweenInfo.new(0.2)
local tweenInfo2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo5 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo6 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local udim = UDim2.fromScale(0, 0)
local udim2 = UDim2.fromScale(0, 0.9)
local udim3 = UDim2.fromScale(0, 0.95)
local udim4 = UDim2.fromScale(0, 1)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(150, 150, 150)
local color3 = Color3.fromRGB(100, 100, 100)
local color4 = Color3.fromRGB(255, 255, 255)
local color5 = Color3.fromRGB(98, 98, 98)
local v = {
	{
		Name = "Gold",
		GetAmount = function(p, p2)
			return RewardsHelper.GetMaximumWaveReward(p, "GoldReward") * RewardMultipliers.Get("Gold") * MapDifficultyRewardsData.GetGoldMultiplier(p2)
		end
	},
	{
		Name = "XP",
		GetAmount = function(p, p2)
			return RewardsHelper.GetMaximumWaveXPReward(p) * RewardMultipliers.Get("XP") * MapDifficultyRewardsData.GetXPMultiplier(p2)
		end
	},
	{
		Name = "Crystals",
		GetAmount = function(p, p2)
			return RewardsHelper.GetMaximumWaveReward(p, "CrystalsReward") * RewardMultipliers.Get("Crystals") * MapDifficultyRewardsData.GetCrystalsMultiplier(p2)
		end
	},
	{
		Name = "Tokens",
		GetAmount = function(p, p2)
			return RewardsHelper.GetMaximumWaveReward(p, "TokensReward") * RewardMultipliers.Get("Tokens") * MapDifficultyRewardsData.GetTokensMultiplier(p2)
		end
	}
}
local event = NetworkingHandler.GetEvent("DifficultyVoteCast")
local event2 = NetworkingHandler.GetEvent("DifficultyVoteStateUpdate")
local event3 = NetworkingHandler.GetEvent("DifficultyVoteReady")
local event4 = BindableHandler.GetEvent("ErrorPrompt")
local event5 = BindableHandler.GetEvent("SetMapDifficulty")
local difficultyVoteScreenV2 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("DifficultyVoteScreenV2")
local background = difficultyVoteScreenV2:WaitForChild("Background")
local options = difficultyVoteScreenV2:WaitForChild("Options")
local template = options:WaitForChild("Template")
local voteFrame = difficultyVoteScreenV2:WaitForChild("VoteFrame")
local voteButton = voteFrame:WaitForChild("VoteButton")
local statusTextLabel = voteFrame:WaitForChild("StatusTextLabel")
local titleFrame = difficultyVoteScreenV2:WaitForChild("TitleFrame")
local titleTextLabel = titleFrame:WaitForChild("TitleTextLabel")
local backgroundTransparency = background.BackgroundTransparency
local position = difficultyVoteScreenV2.Position
local position4 = difficultyVoteScreenV2.Position + UDim2.fromScale(0, 0.9)
local position2 = titleFrame.Position
local position5 = titleFrame.Position - UDim2.fromScale(0, 0.15)
local position3 = voteFrame.Position
local position6 = voteFrame.Position + UDim2.fromScale(0, 0.15)
local blurEffect = nil
local tweens = {}
local threads = {}
local v2 = nil
local v3 = {}
local v4 = {}
local v5 = false
local v6 = nil
local v7 = nil
local votingScreenMusicName = nil
local Easy = Enums.MapDifficulties.Easy

local function ScaleUDim2(size: UDim2, p: number) -- 1 equivalent call inferred from this helper
	return UDim2.new(size.X.Scale * p, size.X.Offset * p, size.Y.Scale * p, size.Y.Offset * p)
end

local function StateUpdate(data)
	local voteMap = data.VoteMap
	local v8 = 0

	for _, v9 in pairs(voteMap) do
		v8 = math.max(v8, v9)
	end

	for k, v9 in pairs(v3) do
		local v10 = voteMap[k] or 0
		v9:UpdateVoteCount(v10, v8 > 0 and v10 == v8)
	end

	for k in pairs(data.VoteMap) do
		if not v3[k] then
			warn("DifficultyVoteScreenV2Handler state update: no card for difficulty: " .. k)
		end
	end

	v2:UpdateCounts(data.ReadyCount, data.PlayerCount)
end

local function NewCard(name: string, layoutOrder: number)
	local waveConfig = ResourceManager.GetWaveConfig(name)

	if not waveConfig then
		warn("DifficultyVoteScreenV2Handler: no wave config for difficulty: " .. name)
		return nil
	end

	local clone = template:Clone()
	clone.Name = name
	clone.LayoutOrder = layoutOrder
	clone.Size = udim2
	clone.Visible = true
	local background2 = clone:FindFirstChild("Background")
	local title = clone:FindFirstChild("Title")
	local votes = clone:FindFirstChild("Votes")
	local votesTextLabel = votes and votes:FindFirstChild("VotesTextLabel")
	local uiGradient = votes and votes:FindFirstChild("UIGradient")
	local rewards = clone:FindFirstChild("Rewards")
	local uiStroke = background2:FindFirstChild("UIStroke")

	if background2 then
		local difficultyVoteScreenV2Icon = waveConfig.DifficultyVoteScreenV2Icon

		if difficultyVoteScreenV2Icon then
			background2.Image = difficultyVoteScreenV2Icon
		else
			warn("DifficultyVoteScreenV2Handler: no DifficultyVoteScreenV2Icon for difficulty: " .. name)
		end
	end

	if title then
		title.Text = waveConfig.DifficultyVoteScreenV2Title or waveConfig.DisplayNameShort or waveConfig.DisplayName
	end

	if votes then
		votes.Visible = false
	end

	if rewards then
		rewards.Visible = false
	end

	local v8 = {
		Difficulty = name,
		WavesConfig = waveConfig,
		IsHovered = false,
		IsSelected = false,
		Button = clone,
		Background = background2,
		Title = title,
		Votes = votes,
		VotesTextLabel = votesTextLabel,
		VotesGradient = uiGradient,
		Rewards = rewards,
		Stroke = uiStroke,
		SizeTween = nil,
		Clicked = function(self)
			event:FireServer(self.Difficulty)
			SoundHandler.Play("ClickTower")
			self:Select()
		end,
		Select = function(self)
			if v6 == self then
				return
			end

			if v6 then
				v6:Deselect()
			end

			v6 = self
			self.IsSelected = true
			self:_UpdateState()

			if v2 then
				v2:SelectionChanged()
			end
		end,
		Deselect = function(self)
			if v6 == self then
				v6 = nil
			end

			self.IsSelected = false
			self:_UpdateState()

			if v2 then
				v2:SelectionChanged()
			end
		end,
		UpdateVoteCount = function(self, p: number, enabled: boolean)
			if not self.Votes then
				return
			end

			if self.VotesTextLabel then
				self.VotesTextLabel.Text = `{p} {p == 1 and "VOTE" or "VOTES"}`
			end

			if self.VotesGradient then
				self.VotesGradient.Enabled = enabled
			end

			local votes2 = self.Votes
			local backgroundColor

			if enabled then
				backgroundColor = color4
			else
				backgroundColor = color5
			end

			votes2.BackgroundColor3 = backgroundColor
			self.Votes.Visible = p > 0
		end,
		UpdateRewards = function(self)
			local rewards2 = self.Rewards

			if not rewards2 then
				return
			end

			for _, v8 in ipairs(v) do
				local child = rewards2:FindFirstChild(v8.Name)
				local label = child and child:FindFirstChild("Label")

				if not (child and label) then
					continue
				end

				local v9 = math.round((v8.GetAmount(self.WavesConfig, Easy)))
				label.Text = `+{v9}`
				child.Visible = v9 > 0
			end
		end,
		_TweenSize = function(self, udim5: UDim2)
			if
				not v5
				or self.SizeTween
				and table.find(tweens, self.SizeTween)
				and self.SizeTween.PlaybackState == Enum.PlaybackState.Playing
			then
				return
			end

			if self.SizeTween then
				self.SizeTween:Cancel()
			end

			self.SizeTween = TweenService:Create(self.Button, tweenInfo, { Size = udim5 })
			self.SizeTween:Play()
		end,
		_UpdateState = function(self)
			local isHovered = self.IsHovered or self.IsSelected

			if self.Stroke then
				self.Stroke.Enabled = true
				self.Stroke.Thickness = isHovered and 0.01 or 0.005
				local stroke = self.Stroke
				local color6

				if self.IsHovered then
					color6 = color
				elseif self.IsSelected then
					color6 = color2
				else
					color6 = color3
				end

				stroke.Color = color6
			end

			if self.Rewards then
				self.Rewards.Visible = isHovered
			end

			local v8 = self.IsHovered and 0 or self.IsSelected and 0.15 or 0.3

			if self.Background then
				TweenService:Create(self.Background, tweenInfo, { ImageTransparency = v8 }):Play()
			end

			if self.Title then
				TweenService:Create(self.Title, tweenInfo, { TextTransparency = v8 }):Play()
			end

			if self.IsHovered then
				self:_TweenSize(udim4)
			elseif self.IsSelected then
				self:_TweenSize(udim3)
			else
				self:_TweenSize(udim2)
			end
		end
	}
	clone:GetPropertyChangedSignal("GuiState"):Connect(function()
		local guiState = clone.GuiState
		v8.IsHovered = guiState == Enum.GuiState.Hover or guiState == Enum.GuiState.Press
		v8:_UpdateState()
	end)
	clone.Activated:Connect(function()
		v8:Clicked()
	end)
	v8:UpdateRewards()
	v8:_UpdateState()
	clone.Parent = options
	return v8
end

local function NewVoteButton(voteButton2)
	local v8 = {
		IsHovered = false,
		Enabled = false,
		Button = voteButton2,
		DefaultSize = voteButton2.Size,
		HoveredSize = ScaleUDim2(voteButton2.Size, 1.04), -- inferred equivalent call
		EnabledLook = { voteButton2:FindFirstChild("GradientEnabled"), (voteButton2:FindFirstChild("UIStrokeEnabled")) },
		DisabledLook = {
			voteButton2:FindFirstChild("GradientDisabled"),
			(voteButton2:FindFirstChild("UIStrokeDisabled"))
		},
		Clicked = function(self)
			if not self.Enabled then
				event4:Fire("Vote for a mode first!")
				return
			end

			SoundHandler.Play("ClickTower")
			event3:FireServer()
		end,
		SelectionChanged = function(self)
			self.Enabled = (v6 or v7) and true or false
			self:_UpdateState()
		end,
		UpdateCounts = function(self, p: number, p2: number)
			statusTextLabel.Text = `{p}/{p2} ready`
		end,
		_UpdateState = function(self)
			local button = self.Button

			for _, v8 in ipairs(self.EnabledLook) do
				v8.Enabled = self.Enabled
			end

			for _, v8 in ipairs(self.DisabledLook) do
				v8.Enabled = not self.Enabled
			end

			local size

			if self.Enabled and self.IsHovered then
				size = self.HoveredSize
			else
				size = self.DefaultSize
			end

			TweenService:Create(button, tweenInfo3, { Size = size }):Play()
		end
	}
	voteButton2:GetPropertyChangedSignal("GuiState"):Connect(function()
		local guiState = voteButton2.GuiState
		v8.IsHovered = guiState == Enum.GuiState.Hover or guiState == Enum.GuiState.Press
		v8:_UpdateState()
	end)
	voteButton2.Activated:Connect(function()
		v8:Clicked()
	end)
	v8:_UpdateState()
	return v8
end

local function EnsureCards(p)
	if #v4 > 0 then
		return
	end

	local difficultyVoteScreenV2Difficulties = p and p.DifficultyVoteScreenV2Difficulties

	if not difficultyVoteScreenV2Difficulties or #difficultyVoteScreenV2Difficulties == 0 then
		warn("DifficultyVoteScreenV2Handler: lobby type has no DifficultyVoteScreenV2Difficulties")
		return
	end

	for i, difficultyVoteScreenV2Difficulty in ipairs(difficultyVoteScreenV2Difficulties) do
		local newCard = NewCard(difficultyVoteScreenV2Difficulty, i)

		if not newCard then
			continue
		end

		v3[difficultyVoteScreenV2Difficulty] = newCard
		table.insert(v4, newCard)
	end
end

local function CancelTransition()
	for _, v8 in ipairs(tweens) do
		v8:Cancel()
	end

	for _, v8 in ipairs(threads) do
		task.cancel(v8)
	end

	tweens = {}
	threads = {}
end

local function PlayTransitionTween(p, p2, p3) -- 4 equivalent calls inferred from this helper
	local tween = TweenService:Create(p, p2, p3)
	table.insert(tweens, tween)
	tween:Play()
	return tween
end

local function DelayTransition(duration: number, fn) -- 1 equivalent call inferred from this helper
	if duration <= 0 then
		fn()
	else
		table.insert(threads, task.delay(duration, fn))
	end
end

local function TweenCardSize(state, tweenInfo7, udim5: UDim2) -- 1 equivalent call inferred from this helper
	if state.SizeTween then
		state.SizeTween:Cancel()
	end

	state.SizeTween = PlayTransitionTween(state.Button, tweenInfo7, { Size = udim5 }) -- inferred equivalent call
end

local function FadeIn()
	CancelTransition()
	difficultyVoteScreenV2.Visible = true
	difficultyVoteScreenV2.Position = position
	background.BackgroundTransparency = 1
	blurEffect.Size = 0
	blurEffect.Enabled = true
	PlayTransitionTween(background, tweenInfo2, { BackgroundTransparency = backgroundTransparency }) -- inferred equivalent call
	local tween = TweenService:Create(blurEffect, tweenInfo2, { Size = 20 })
	table.insert(tweens, tween)
	tween:Play()
	titleFrame.Position = position5

	local function fn()
		local tween2 = TweenService:Create(titleFrame, tweenInfo4, { Position = position2 })
		table.insert(tweens, tween2)
		tween2:Play()
	end

	table.insert(threads, task.delay(0.05, fn))

	for i, v8 in ipairs(v4) do
		v8.Button.Size = udim
		local v9 = (i - 1) * 0.07 + 0.15
		local v10 = v8

		local function fn2()
			local v11

			if v10.IsHovered then
				v11 = udim4
			elseif v10.IsSelected then
				v11 = udim3
			else
				v11 = udim2
			end

			TweenCardSize(v10, tweenInfo5, v11) -- inferred equivalent call
		end

		DelayTransition(v9, fn2) -- inferred equivalent call
	end

	voteFrame.Position = position6

	local function fn2()
		local tween2 = TweenService:Create(voteFrame, tweenInfo4, { Position = position3 })
		table.insert(tweens, tween2)
		tween2:Play()
	end

	table.insert(threads, task.delay(0.35, fn2))
end

local function FadeOut()
	CancelTransition()
	PlayTransitionTween(background, tweenInfo2, { BackgroundTransparency = 1 }).Completed:Connect(function(p) -- inferred equivalent call
		if p == Enum.PlaybackState.Completed and not v5 then
			difficultyVoteScreenV2.Visible = false
			blurEffect.Enabled = false
		end
	end)
	local tween = TweenService:Create(blurEffect, tweenInfo2, { Size = 0 })
	table.insert(tweens, tween)
	tween:Play()
	PlayTransitionTween(difficultyVoteScreenV2, tweenInfo6, { Position = position4 }) -- inferred equivalent call
end

function DifficultyVoteScreenV2Handler.DisplayScreen(p, p2: string?, _: string?)
	local lobbyType = workspace:GetAttribute("LobbyType")
	local v8 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)
	EnsureCards(v8)

	if v8 then
		titleTextLabel.Text = v8.DisplayName
	end

	v7 = p2

	if v6 then
		v6:Deselect()
	end

	v2:SelectionChanged()
	StateUpdate(p)
	v5 = true
	FadeIn()

	if v8 and v8.VotingScreenMusicName then
		votingScreenMusicName = v8.VotingScreenMusicName
	else
		votingScreenMusicName = "DifficultyVotingMusic"
	end

	SoundHandler.Play(votingScreenMusicName)
end

function DifficultyVoteScreenV2Handler.HideScreen()
	if not v5 then
		return
	end

	v5 = false
	FadeOut()

	if votingScreenMusicName then
		SoundHandler.Stop(votingScreenMusicName, 3)
	end
end

template.Visible = false
difficultyVoteScreenV2.Visible = false
blurEffect = Instance.new("BlurEffect")
blurEffect.Name = "DifficultyVoteScreenV2Blur"
blurEffect.Enabled = false
blurEffect.Size = 0
blurEffect.Parent = Lighting
v2 = NewVoteButton(voteButton)
statusTextLabel.Text = ""
event2:AttachCallback(function(p)
	if #v4 > 0 then
		StateUpdate(p)
	end
end)
event5:AttachCallback(function(_: string, p: string)
	Easy = p

	for _, v8 in ipairs(v4) do
		v8:UpdateRewards()
	end
end)
return DifficultyVoteScreenV2Handler