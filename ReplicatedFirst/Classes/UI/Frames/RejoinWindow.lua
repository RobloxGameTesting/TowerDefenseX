local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("SoundHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local Enums = require(Common:WaitForChild("Enums"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Lang = require(TDX_Shared.Modules.Lang)
require(TDX_Shared.Modules.Util)
require(TDX_Shared.Client.Services.Data)
local Network = require(ReplicatedFirst.Client.Network)
local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local RejoinWindow = { ClassName = script.Name, ClassModule = script }
RejoinWindow.__index = RejoinWindow

function RejoinWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, RejoinWindow))
end

function RejoinWindow:Update()
	local rejoinGameJobId = LocalPlayer:GetAttribute("RejoinGameJobId")
	local rejoinGameState = LocalPlayer:GetAttribute("RejoinGameState")
	local rejoinGameMap = LocalPlayer:GetAttribute("RejoinGameMap")
	local rejoinGameMode = LocalPlayer:GetAttribute("RejoinGameMode")
	local rejoinGameWave = LocalPlayer:GetAttribute("RejoinGameWave")
	local v = not rejoinGameMap and "Unknown" or tostring(rejoinGameMap)

	if
		not rejoinGameState
		or rejoinGameState == Enums.GameStates.WaitingForFirstPlayer
		or rejoinGameState == Enums.GameStates.DifficultyVoting
	then
		rejoinGameMode = nil
		rejoinGameWave = nil
	end

	local v2

	if rejoinGameMode then
		local waveConfig = ResourceManager.GetWaveConfig(rejoinGameMode)
		v2 = not waveConfig and "Unknown" or tostring(waveConfig.DisplayName)
	else
		v2 = "Unknown"
	end

	local v3 = not rejoinGameWave and "N/A" or tostring(rejoinGameWave)
	local visible = rejoinGameJobId ~= nil
	local v4

	if self.Root.Visible == false then
		v4 = visible
	else
		v4 = false
	end

	if v4 then
		self.Root.Position = UDim2.new(0.5, 0, 0.55, 0)
		TweenService:Create(self.Root, tweenInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
	end

	self.MapTextLabel.Text = string.format("Map: %s", v)
	self.ModeTextLabel.Text = string.format("Mode: %s - Wave %s", v2, v3)
	self.Root.Visible = visible
end

function RejoinWindow:Init()
	self.RejoinButton = self.Root.Rejoin
	self.CancelButton = self.Root.Cancel
	self.StatusTextLabel = self.Root.StatusText
	self.MapTextLabel = self.Root.MapText
	self.ModeTextLabel = self.Root.ModeText
	local flag = false

	local function TransitionToStatusText() -- 2 equivalent calls inferred from this helper
		self.RejoinButton.Visible = false
		self.CancelButton.Visible = false
		self.StatusTextLabel.Text = Lang.Get(Lang.Strings.General.AttemptingToRejoin)
		self.StatusTextLabel.Visible = true
	end

	self.Cleaner:Add(LocalPlayer:GetAttributeChangedSignal("RejoinGameJobId"):Connect(function()
		self:Update()
	end))
	self.Cleaner:Add(self.RejoinButton.Activated:Connect(function()
		if flag then
			return
		end

		flag = true
		TransitionToStatusText() -- inferred equivalent call
		local v = Network.Invoke("RequestRejoinGame")

		if v == 0 then
			return
		end

		if v == 1 then
			self.StatusTextLabel.Text = Lang.Get(Lang.Strings.General.RejoinFailed)
		elseif v == 2 then
			self.StatusTextLabel.Text = Lang.Get(Lang.Strings.General.ServerNoExist)
		end
	end))
	self.Cleaner:Add(self.CancelButton.Activated:Connect(function()
		if flag then
			return
		end

		flag = true
		TransitionToStatusText() -- inferred equivalent call
		self.Root.Visible = false
		Network.Fire("RequestCancelRejoinGame")
	end))
	self:Update()
end

function RejoinWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { RejoinWindow }, LocalPlayer)
return RejoinWindow