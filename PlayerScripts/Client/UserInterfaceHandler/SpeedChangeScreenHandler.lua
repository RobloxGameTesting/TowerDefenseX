local SpeedChangeScreenHandler = {}
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local Enums = require(Common:WaitForChild("Enums"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local Lang = require(TDX_Shared.Modules.Lang)
local PlayerClass = require(script.Parent.Parent:WaitForChild("PlayerClass"))
local SPEED_CONTROL_GAMEPASS_ID = _G.SPEED_CONTROL_GAMEPASS_ID
local SPEED_CONTROL_COOLDOWN = _G.SPEED_CONTROL_COOLDOWN
local SPEED_CONTROL_VOTE_COOLDOWN = _G.SPEED_CONTROL_VOTE_COOLDOWN
local color = Color3.fromRGB(180, 255, 0)
local color2 = Color3.fromRGB(113, 113, 113)
local color3 = Color3.fromRGB(168, 38, 38)
local event = NetworkingHandler.GetEvent("GamepassPurchased")
local event2 = NetworkingHandler.GetEvent("SoloToggleSpeedControl")
local event3 = NetworkingHandler.GetEvent("SpeedControlToggled")
local event4 = NetworkingHandler.GetEvent("SpeedControlVoteStateUpdate")
local event5 = NetworkingHandler.GetEvent("StartSpeedControlVoteRequest")
local event6 = NetworkingHandler.GetEvent("StopSpeedControlVoteRequest")
local event7 = BindableHandler.GetEvent("SetSpeedMultiplier")
local event8 = BindableHandler.GetEvent("LocalPlayerWrapperUpdated")
local event9 = BindableHandler.GetEvent("ErrorPrompt")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local speedChangeScreen = PlayerGui:WaitForChild("Interface"):WaitForChild("SpeedChangeScreen")
local notOwned = speedChangeScreen:WaitForChild("NotOwned")
local owned = speedChangeScreen:WaitForChild("Owned")
local default = owned:WaitForChild("Default")
local active = owned:WaitForChild("Active")
local buyButton = notOwned:WaitForChild("Content"):WaitForChild("BuyButton")
local activate = default:WaitForChild("Speed"):WaitForChild("Activate")
local activate2 = default:WaitForChild("Slow"):WaitForChild("Activate")
local button = active:WaitForChild("Content"):WaitForChild("Button")
local slow = active:WaitForChild("Content"):WaitForChild("Slow")
local speed = active:WaitForChild("Content"):WaitForChild("Speed")
local button2 = PlayerGui:WaitForChild("LowPriorityInterface"):WaitForChild("LeftButtons"):WaitForChild("SpeedupButton"):WaitForChild("Button")
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = 0
local flag = true
local DifficultyVoting = Enums.GameStates.DifficultyVoting
local votingActive = false
local v6 = false

local function NewBuyGamepassButtonHandler()
	local hovered = buyButton:FindFirstChild("Hovered")
	local owned2 = buyButton:FindFirstChild("Owned")
	local text = buyButton:FindFirstChild("Text")
	local v7 = {
		Hovered = false,
		GamepassOwned = false,
		Hover = function(self)
			self.Hovered = true
			self:UpdateState()
		end,
		Unhover = function(self)
			self.Hovered = false
			self:UpdateState()
		end,
		SetGamepassOwned = function(self, gamepassOwned: boolean)
			self.GamepassOwned = gamepassOwned
			self:UpdateState()
		end,
		IsSoloChanged = function(self)
			self:UpdateState()
		end,
		UpdateState = function(self)
			if flag or self.GamepassOwned then
				hovered.ImageTransparency = 1
				owned2.ImageTransparency = 0
			else
				if self.Hovered then
					hovered.ImageTransparency = 0
				else
					hovered.ImageTransparency = 1
				end

				owned2.ImageTransparency = 1
			end

			if flag or self.GamepassOwned then
				text.Text = Lang.Get(Lang.Strings.Shop.Owned)
			else
				text.Text = Lang.Get(Lang.Strings.Shop.BuyNow)
			end
		end,
		Activated = function(self)
			if not self.GamepassOwned then
				SoundHandler.Play("ShopSelectOption")
				MarketplaceService:PromptGamePassPurchase(LocalPlayer, SPEED_CONTROL_GAMEPASS_ID)
			end
		end
	}
	buyButton.MouseEnter:Connect(function()
		v7:Hover()
	end)
	buyButton.MouseLeave:Connect(function()
		v7:Unhover()
	end)
	buyButton.Activated:Connect(function()
		v7:Activated()
	end)
	v7:UpdateState()
	return v7
end

local function NewActivateButtonHandler(activate3, flag2: boolean)
	local background = activate3:FindFirstChild("Background")
	local textLabel = activate3:FindFirstChild("TextLabel")
	local v7 = {
		GamepassOwned = false,
		CooldownActive = false,
		IsActive = function(_)
			return false
		end,
		SetGamepassOwned = function(self, gamepassOwned: boolean)
			self.GamepassOwned = gamepassOwned
			self:UpdateState()
		end,
		Disable = function(self)
			self.Enabled = false
			self:UpdateState()
		end,
		NoLongerSolo = function(self)
			self:UpdateState()
		end,
		GameStateChanged = function(self)
			self:UpdateState()
		end,
		UpdateState = function(self)
			local cooldownActive = self.CooldownActive
			local isButtonEnabled = self:_IsButtonEnabled()

			if isButtonEnabled then
				textLabel.TextColor3 = color
				background.BackgroundColor3 = Color3.fromRGB(49, 70, 1)
				activate3.BackgroundColor3 = color
				activate3.Interactable = true
			else
				textLabel.TextColor3 = color2
				background.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
				activate3.BackgroundColor3 = color2
				activate3.Interactable = false
			end

			if cooldownActive then
				self:UpdateTimerText()
			elseif isButtonEnabled then
				textLabel.Text = "Activate"
			else
				textLabel.Text = "Disabled"
			end
		end,
		Activated = function(self)
			if not self:_IsButtonEnabled() or v5 > 0 then
				return
			end

			if workspace:GetAttribute("IsTutorial") then
				event9:Fire("Cannot use speed control in tutorial!")
				return
			end

			if workspace:GetAttribute("SpeedBoostLocked") then
				event9:Fire("Game speed locked to 1X this wave!")
				return
			end

			if workspace:GetAttribute("SpeedControlDisabled") then
				event9:Fire("Speed control is disabled in this mode!")
				return
			end

			if flag then
				SoundHandler.Play("SettingOn")
				v5 = SPEED_CONTROL_COOLDOWN
				event2:FireServer(true, flag2)
			else
				event5:FireServer(flag2)
				SoundHandler.Play("SettingOn")
			end

			self:UpdateState()
		end,
		_IsButtonEnabled = function(self)
			local cooldownActive = self.CooldownActive
			return DifficultyVoting == Enums.GameStates.Running and not votingActive and not cooldownActive
		end,
		UpdateTimerText = function(self)
			if DifficultyVoting == Enums.GameStates.Running and not votingActive then
				textLabel.Text = tostring((math.ceil(v5)))
			end
		end,
		Run = function(self, _: number)
			if v5 > 0 then
				self:UpdateTimerText()

				if not self.CooldownActive then
					self.CooldownActive = true
					self:UpdateState()
				end
			elseif self.CooldownActive then
				self.CooldownActive = false
				self:UpdateState()
			end
		end
	}
	activate3.Activated:Connect(function()
		v7:Activated()
	end)
	v7:UpdateState()
	return v7
end

local function NewDeactivateButtonHandler(button3)
	local background = button3:FindFirstChild("Background")
	local textLabel = button3:FindFirstChild("TextLabel")
	local v7 = {
		CooldownActive = false,
		Disable = function(self)
			self.Enabled = false
			self:UpdateState()
		end,
		NoLongerSolo = function(self)
			self:UpdateState()
		end,
		GameStateChanged = function(self)
			self:UpdateState()
		end,
		UpdateState = function(self)
			local cooldownActive = self.CooldownActive
			local isButtonEnabled = self:_IsButtonEnabled()

			if isButtonEnabled then
				textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				background.BackgroundColor3 = Color3.fromRGB(50, 33, 34)
				button3.BackgroundColor3 = color3
				button3.Interactable = true
			else
				textLabel.TextColor3 = color2
				background.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
				button3.BackgroundColor3 = color2
				button3.Interactable = false
			end

			if cooldownActive then
				self:UpdateTimerText()
			elseif isButtonEnabled then
				textLabel.Text = "Deactivate"
			elseif votingActive then
				textLabel.Text = "Voting active"
			else
				textLabel.Text = "Disabled"
			end
		end,
		Activated = function(self)
			if not self:_IsButtonEnabled() or v5 > 0 then
				return
			end

			if flag then
				SoundHandler.Play("SettingOff")
				v5 = SPEED_CONTROL_COOLDOWN
				event2:FireServer(false)
			else
				event6:FireServer()
				SoundHandler.Play("SettingOn")
			end

			self:UpdateState()
		end,
		_IsButtonEnabled = function(self)
			local cooldownActive = self.CooldownActive
			return DifficultyVoting == Enums.GameStates.Running and not votingActive and v6 and not cooldownActive
		end,
		UpdateTimerText = function(self)
			if DifficultyVoting == Enums.GameStates.Running and not votingActive then
				textLabel.Text = tostring((math.ceil(v5)))
			end
		end,
		Run = function(self, _: number)
			if v5 > 0 then
				self:UpdateTimerText()

				if not self.CooldownActive then
					self.CooldownActive = true
					self:UpdateState()
				end
			elseif self.CooldownActive then
				self.CooldownActive = false
				self:UpdateState()
			end
		end
	}
	button3.Activated:Connect(function()
		v7:Activated()
	end)
	v7:UpdateState()
	return v7
end

local function GamepassStatusChanged() -- 6 equivalent calls inferred from this helper
	local localPlayerHasSpeedControl = PlayerClass.LocalPlayerHasSpeedControl()
	local visible = v6 or flag or localPlayerHasSpeedControl
	notOwned.Visible = not visible
	owned.Visible = visible
	v:SetGamepassOwned(localPlayerHasSpeedControl)
	v2:SetGamepassOwned(localPlayerHasSpeedControl)
	v3:SetGamepassOwned(localPlayerHasSpeedControl)
end

local function MoreThanOnePlayerOccured()
	if flag then
		flag = false
		v2:NoLongerSolo()
		v3:NoLongerSolo()
		v4:NoLongerSolo()
		GamepassStatusChanged() -- inferred equivalent call
	end
end

local function ToggleActiveState(flag2: boolean) -- 3 equivalent calls inferred from this helper
	default.Visible = false
	active.Visible = true

	if flag2 then
		speed.Visible = true
		slow.Visible = false
	else
		speed.Visible = false
		slow.Visible = true
	end
end

local function ToggleInactiveState(flag2: boolean) -- 2 equivalent calls inferred from this helper
	default.Visible = true
	active.Visible = false

	if flag2 then
	end

	speed.Visible = false
	slow.Visible = false
end

function SpeedChangeScreenHandler.SetState(p: string)
	DifficultyVoting = p
	v2:GameStateChanged()
	v3:GameStateChanged()
	v4:GameStateChanged()
end

v = NewBuyGamepassButtonHandler()
v2 = NewActivateButtonHandler(activate, true)
v3 = NewActivateButtonHandler(activate2, false)
v4 = NewDeactivateButtonHandler(button)
GamepassStatusChanged() -- inferred equivalent call
event8:AttachCallback(function()
	GamepassStatusChanged() -- inferred equivalent call
end)
button2.Activated:Connect(function()
	speedChangeScreen.Visible = not speedChangeScreen.Visible
end)
event:AttachCallback(function(p: string, p2: number)
	if p ~= LocalPlayer.Name then
		return
	end

	if p2 == SPEED_CONTROL_GAMEPASS_ID then
		GamepassStatusChanged() -- inferred equivalent call
		SoundHandler.Play("GamepassPurchaseSuccess")
	end
end)
RunService.Heartbeat:Connect(function(dt)
	if PlayerClass.GetHighestPlayerCount() > 1 and flag then
		flag = false
		v2:NoLongerSolo()
		v3:NoLongerSolo()
		v4:NoLongerSolo()
		GamepassStatusChanged() -- inferred equivalent call
	end

	v5 -= dt
	v2:Run(dt)
	v3:Run(dt)
	v4:Run(dt)
end)
event7:AttachCallback(function(_: number)
	v2:UpdateState()
	v3:UpdateState()
end)
event3:AttachCallback(function(flag2: boolean, flag3: boolean)
	if v6 ~= flag2 then
		if flag2 then
			ToggleActiveState(flag3) -- inferred equivalent call
		else
			ToggleInactiveState(flag3) -- inferred equivalent call
		end
	end

	v6 = flag2
	v2:UpdateState()
	v3:UpdateState()
	v4:UpdateState()
	GamepassStatusChanged() -- inferred equivalent call
end)
event4:AttachCallback(function(p)
	votingActive = p.VotingActive

	if votingActive then
		ToggleActiveState(p.ForSpeedup) -- inferred equivalent call
	else
		if v6 then
			ToggleActiveState(p.ForSpeedup) -- inferred equivalent call
		else
			ToggleInactiveState(p.ForSpeedup) -- inferred equivalent call
		end

		v5 = SPEED_CONTROL_VOTE_COOLDOWN
	end

	v2:UpdateState()
	v3:UpdateState()
	v4:UpdateState()
end)
return SpeedChangeScreenHandler