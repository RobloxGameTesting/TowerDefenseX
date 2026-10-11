local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Director = require(TDX_Shared.Modules.Director)
local RewardsHelper = require(TDX_Shared.Common.RewardsHelper)
local RewardMultipliers = require(TDX_Shared.Common.RewardMultipliers)
local ResourceManager = require(TDX_Shared.Common:WaitForChild("ResourceManager"))
local LobbyTypeUtilities = require(TDX_Shared.Common.LobbyTypeUtilities)
local Network = require(game.ReplicatedFirst.Client.Network)
local PVPHelper = require(game.ReplicatedFirst.Util.PVPHelper)
local SoundHandler = require(TDX_Shared.Common.SoundHandler)
local udim = UDim2.fromScale(0, 0.9)
local udim2 = UDim2.fromScale(0, 1)
local GameModeSelectionWindow = { ClassName = script.Name, ClassModule = script }
GameModeSelectionWindow.__index = GameModeSelectionWindow

function GameModeSelectionWindow.new(root)
	return (setmetatable({
		Root = root,
		SelectedDifficulty = nil,
		State = "Idle",
		CurrentView = "GameType",
		CardTweens = {},
		IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
	}, GameModeSelectionWindow))
end

function GameModeSelectionWindow:Init()
	local blurEffect = Instance.new("BlurEffect")
	blurEffect.Enabled = false
	blurEffect.Size = 20
	blurEffect.Name = "GameModeSelectionBlur"
	blurEffect.Parent = game:GetService("Lighting")
	self.BlurEffect = blurEffect
	self.Root.CancelButton.Activated:Connect(function()
		SoundHandler.Play("ClickDown")

		if self.CurrentView == "GameType" then
			self:Hide()
		else
			self:SetView("GameType")
		end
	end)
	self.Root.InputSinkButton.Activated:Connect(function()
		self:SetSelectedDifficulty(nil)
	end)

	for _, child in self.Root.GameTypeCards:GetChildren() do
		if not child:HasTag("ModeSelectionCard") then
			continue
		end

		self:SetupCardHover(child)
		local v = child
		child.Activated:Connect(function()
			if self.State ~= "Idle" then
				return
			end

			SoundHandler.Play("ClickDown")

			if v.Name == "Survival" then
				self:SetView("Difficulty")
			elseif v.Name == "PVP" then
				self:SetView("DifficultyPVP")
			elseif v.Name == "Events" then
				self:SetView("Events")
			end
		end)
	end

	local function setupDifficultyCard(child, _: boolean?)
		if not child:HasTag("ModeSelectionCard") then
			return
		end

		local name = child.Name
		local waveConfig = ResourceManager.GetWaveConfig(name)

		if waveConfig then
			if child:FindFirstChild("Rewards") then
				child.Rewards.Visible = false

				local function updateRewardLabels()
					if child.Rewards:FindFirstChild("Gold") and child.Rewards.Gold:FindFirstChild("Label") then
						child.Rewards.Gold.Label.Text = `+{math.floor(RewardMultipliers.Get("Gold") * RewardsHelper.GetMaximumWaveReward(waveConfig, "GoldReward"))}`
					end

					if child.Rewards:FindFirstChild("XP") and child.Rewards.XP:FindFirstChild("Label") then
						child.Rewards.XP.Label.Text = `+{math.round(RewardMultipliers.Get("XP") * RewardsHelper.GetMaximumWaveXPReward(waveConfig))}`
					end
				end

				updateRewardLabels()
				RewardMultipliers.GetChangedSignal("Gold"):Connect(updateRewardLabels)
				RewardMultipliers.GetChangedSignal("XP"):Connect(updateRewardLabels)
			end

			self:SetupCardHover(child)
			child.Activated:Connect(function()
				if self.State ~= "Idle" then
					return
				end

				SoundHandler.Play("ClickDown")

				if self.IsMobile then
					if self.SelectedDifficulty == name then
						self:StartSoloGame()
					else
						self:SetSelectedDifficulty(name)
					end
				else
					self:SetSelectedDifficulty(name)
					self:StartSoloGame()
				end
			end)
		else
			warn(`Could not find wave config for {name}. Destroying card.`)
			child:Destroy()
		end
	end

	for _, child in self.Root.DifficultyCards:GetChildren() do
		setupDifficultyCard(child)
	end

	if self.Root:FindFirstChild("DifficultyCardsPVP") then
		for _, child in self.Root.DifficultyCardsPVP:GetChildren() do
			setupDifficultyCard(child)
		end
	end

	local function setupEventCard(child)
		if not child:HasTag("ModeSelectionCard") then
			return
		end

		local name = child.Name
		local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(name)

		if lobbyTypeData then
			if lobbyTypeData.Disabled then
				child:Destroy()
				return
			end

			if child:FindFirstChild("Rewards") then
				child.Rewards.Visible = false
			end

			self:SetupCardHover(child)
			child.Activated:Connect(function()
				if self.State ~= "Idle" then
					return
				end

				SoundHandler.Play("ClickDown")

				if self.IsMobile then
					if self.SelectedDifficulty == name then
						self:StartSoloGame()
					else
						self:SetSelectedDifficulty(name)
					end
				else
					self:SetSelectedDifficulty(name)
					self:StartSoloGame()
				end
			end)
		else
			warn(`Could not find lobby type data for {name}`)
			child:Destroy()
		end
	end

	if self.Root:FindFirstChild("EventCards") then
		for _, child in self.Root.EventCards:GetChildren() do
			setupEventCard(child)
		end
	end

	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local dailyPVPRewardAvailable = localPlayer:GetAttribute("DailyPVPRewardAvailable")
	self.Root.GameTypeCards.PVP.DailyRewards.Visible = dailyPVPRewardAvailable
	self.Root.DifficultyCardsPVP.PVP_1V1.DailyRewards.Visible = dailyPVPRewardAvailable
	localPlayer:GetAttributeChangedSignal("DailyPVPRewardAvailable"):Connect(function()
		local dailyPVPRewardAvailable2 = localPlayer:GetAttribute("DailyPVPRewardAvailable")
		self.Root.GameTypeCards.PVP.DailyRewards.Visible = dailyPVPRewardAvailable2
		self.Root.DifficultyCardsPVP.PVP_1V1.DailyRewards.Visible = dailyPVPRewardAvailable2
	end)
end

function GameModeSelectionWindow:SetView(currentView: string)
	self.CurrentView = currentView
	self:SetSelectedDifficulty(nil)
	local v = self.Root:FindFirstChild("DifficultyCardsPVP") ~= nil
	local v2 = self.Root:FindFirstChild("EventCards") ~= nil

	if currentView == "GameType" then
		self.Root.GameTypeCards.Visible = true
		self.Root.DifficultyCards.Visible = false

		if v then
			self.Root.DifficultyCardsPVP.Visible = false
		end

		if v2 then
			self.Root.EventCards.Visible = false
		end

		self.Root.Title.MainTitle.Text = "Select Game Mode"
	elseif currentView == "Difficulty" then
		self.Root.GameTypeCards.Visible = false
		self.Root.DifficultyCards.Visible = true

		if v then
			self.Root.DifficultyCardsPVP.Visible = false
		end

		if v2 then
			self.Root.EventCards.Visible = false
		end

		self.Root.Title.MainTitle.Text = "Select Difficulty"
	elseif currentView == "DifficultyPVP" then
		self.Root.GameTypeCards.Visible = false
		self.Root.DifficultyCards.Visible = false

		if v then
			self.Root.DifficultyCardsPVP.Visible = true
		end

		if v2 then
			self.Root.EventCards.Visible = false
		end

		self.Root.Title.MainTitle.Text = "Select Match Size"
	elseif currentView == "Events" then
		self.Root.GameTypeCards.Visible = false
		self.Root.DifficultyCards.Visible = false

		if v then
			self.Root.DifficultyCardsPVP.Visible = false
		end

		if v2 then
			self.Root.EventCards.Visible = true
		end

		self.Root.Title.MainTitle.Text = "Select Event"
	end
end

function GameModeSelectionWindow:StartSoloGame()
	if not self.SelectedDifficulty then
		warn("Cannot start solo game - no difficulty is selected")
	elseif self.CurrentView == "DifficultyPVP" then
		self:Hide()
		local remainingAbandonCooldown = PVPHelper.GetRemainingAbandonCooldown()

		if remainingAbandonCooldown > 0 then
			PVPHelper.ShowAbandonCooldownWarning(remainingAbandonCooldown)
			return
		end

		local function startPVPMatchmaking() -- 2 equivalent calls inferred from this helper
			Network.Fire("ClientRequestPVPMatchmaking", self.SelectedDifficulty)

			for _, v in Director.GetItemsFromClass(Director.Classes.PartyMinimised) do
				v:Maximise()
			end
		end

		local equippedBannedPVPTowers = PVPHelper.GetEquippedBannedPVPTowers()

		if #equippedBannedPVPTowers > 0 then
			PVPHelper.ShowBannedPVPTowerWarning(equippedBannedPVPTowers[1], function(p)
				if p then
					startPVPMatchmaking() -- inferred equivalent call
				end
			end)
			return
		end

		startPVPMatchmaking() -- inferred equivalent call
	else
		if self.State ~= "Idle" then
			warn("Cannot start solo game - game is already loading")
			return
		end

		self.State = "Loading"
		self.Root.CancelButton.Visible = false
		local v = self.Root.DifficultyCards:FindFirstChild(self.SelectedDifficulty)
			or self.Root:FindFirstChild("DifficultyCardsPVP")
			and self.Root.DifficultyCardsPVP:FindFirstChild(self.SelectedDifficulty)
			or self.Root:FindFirstChild("EventCards") and self.Root.EventCards:FindFirstChild(self.SelectedDifficulty)

		if v and v:FindFirstChild("Loading") then
			v.Loading.Visible = true
		end

		if Network.Invoke("ClientRequestSoloGame", self.SelectedDifficulty) then
			print(`Started solo game for lobby type: {self.SelectedDifficulty}`)
			return
		end

		warn(`Failed to start solo game for lobby type: {self.SelectedDifficulty}`)
		self.State = "Idle"

		if v and v:FindFirstChild("Loading") then
			v.Loading.Visible = false
		end

		if v then
			v:SetAttribute("Selected", nil)
		end

		self.Root.CancelButton.Visible = true
		self:SetSelectedDifficulty(nil)
	end
end

function GameModeSelectionWindow:SetSelectedDifficulty(selectedDifficulty: string?)
	local v = self.SelectedDifficulty ~= nil
		and (self.Root.DifficultyCards:FindFirstChild(self.SelectedDifficulty) or self.Root:FindFirstChild("DifficultyCardsPVP") and self.Root.DifficultyCardsPVP:FindFirstChild(self.SelectedDifficulty) or self.Root:FindFirstChild("EventCards") and self.Root.EventCards:FindFirstChild(self.SelectedDifficulty))

	if v then
		v:SetAttribute("Selected", false)
		self:UpdateCardState(v)

		if self.CardTweens[v] then
			self.CardTweens[v]:Cancel()
		end

		self.CardTweens[v] = TweenService:Create(v, TweenInfo.new(0.2), { Size = udim })
		self.CardTweens[v]:Play()
	end

	self.SelectedDifficulty = selectedDifficulty

	if selectedDifficulty then
		local v2 = self.Root.DifficultyCards:FindFirstChild(selectedDifficulty)
			or self.Root:FindFirstChild("DifficultyCardsPVP")
			and self.Root.DifficultyCardsPVP:FindFirstChild(selectedDifficulty)
			or self.Root:FindFirstChild("EventCards") and self.Root.EventCards:FindFirstChild(selectedDifficulty)

		if v2 then
			v2:SetAttribute("Selected", true)
			self:UpdateCardState(v2)
		end

		if self.IsMobile then
			self.Root.Title.MainTitle.Text = "Click again to confirm"
		end
	elseif self.CurrentView == "Difficulty" then
		self.Root.Title.MainTitle.Text = "Select Difficulty"
	elseif self.CurrentView == "DifficultyPVP" then
		self.Root.Title.MainTitle.Text = "Select a match size"
	elseif self.CurrentView == "Events" then
		self.Root.Title.MainTitle.Text = "Select Event"
	else
		self.Root.Title.MainTitle.Text = "Select Game Mode"
	end
end

function GameModeSelectionWindow:SetupCardHover(instance)
	instance:GetPropertyChangedSignal("GuiState"):Connect(function()
		if instance.GuiState == Enum.GuiState.Hover then
			if self.CardTweens[instance] then
				self.CardTweens[instance]:Cancel()
			end

			self.CardTweens[instance] = TweenService:Create(instance, TweenInfo.new(0.2), {
				Size = udim2
			})
			self.CardTweens[instance]:Play()
		elseif instance.GuiState == Enum.GuiState.Idle then
			if self.CardTweens[instance] then
				self.CardTweens[instance]:Cancel()
			end

			if not instance:GetAttribute("Selected") then
				self.CardTweens[instance] = TweenService:Create(instance, TweenInfo.new(0.2), {
					Size = udim
				})
				self.CardTweens[instance]:Play()
			end
		end

		self:UpdateCardState(instance)
	end)
end

function GameModeSelectionWindow:UpdateCardState(instance)
	local selected = instance:GetAttribute("Selected")
		or instance.GuiState == Enum.GuiState.Hover
		or instance.GuiState == Enum.GuiState.Press

	if instance:FindFirstChild("UIStroke") then
		instance.UIStroke.Enabled = selected
	end

	local v = self.Root:FindFirstChild("EventCards") and instance.Parent == self.Root.EventCards
	local rewards = instance:FindFirstChild("Rewards")

	if rewards then
		rewards.Visible = not v and selected
	end
end

function GameModeSelectionWindow:Destroy() end

function GameModeSelectionWindow:Show()
	self.Root.Parent.Enabled = true
	self.Root.Parent.Parent.GUI.Enabled = false
	self.Root.Visible = true
	self.BlurEffect.Enabled = true
	GuiService.TouchControlsEnabled = false
	self:SetView("GameType")
end

function GameModeSelectionWindow:Hide()
	self.Root.Parent.Enabled = false
	self.Root.Parent.Parent.GUI.Enabled = true
	self.Root.Visible = false
	self.BlurEffect.Enabled = false
	GuiService.TouchControlsEnabled = true
end

Director.Register(script.Name, { GameModeSelectionWindow }, game.Players)
return GameModeSelectionWindow