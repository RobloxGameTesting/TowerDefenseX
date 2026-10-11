local UserInterfaceHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("ScalingHandler"))
local ChatHandlerClientside = require(common:WaitForChild("ChatHandlerClientside"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local LobbyTypeUtilities = require(common:WaitForChild("LobbyTypeUtilities"))
local PlayerClass = require(script.Parent:WaitForChild("PlayerClass"))
local TowersBar = require(script:WaitForChild("TowersBar"))
local PVPTowersBar = require(script:WaitForChild("PVPTowersBar"))
require(script:WaitForChild("InfoHandler"))
local GameInfoHandler = require(script:WaitForChild("GameInfoHandler"))
local PromptHandler = require(script:WaitForChild("PromptHandler"))
local TowerUIHandler = require(script:WaitForChild("TowerUIHandler"))
local GameOverScreenHandler = require(script:WaitForChild("GameOverScreenHandler"))
local MapVotingScreenHandler = require(script:WaitForChild("MapVotingScreenHandler"))
local DifficultyVoteScreenHandler = require(script:WaitForChild("DifficultyVoteScreenHandler"))
local DifficultyVoteScreenV2Handler = require(script:WaitForChild("DifficultyVoteScreenV2Handler"))
require(script:WaitForChild("SkipWaveVoteScreenHandler"))
require(script:WaitForChild("SpeedupVoteScreenHandler"))
local PlacementButtonsHandler = require(script:WaitForChild("PlacementButtonsHandler"))
require(script:WaitForChild("SettingsHandler"))
local SpeedChangeScreenHandler = require(script:WaitForChild("SpeedChangeScreenHandler"))
local TopNotificationHandler = require(script:WaitForChild("TopNotificationHandler"))
local SeizureWarningHandler = require(script:WaitForChild("SeizureWarningHandler"))
local PowerUpsScreenHandler = require(script:WaitForChild("PowerUpsScreenHandler"))
local CutsceneScreenHandler = require(script:WaitForChild("CutsceneScreenHandler"))
local LoadoutSelectionScreenHandler = require(script:WaitForChild("LoadoutSelectionScreenHandler"))
require(script:WaitForChild("CutsceneSkipVoteScreenHandler"))
local AbilityHotbarHandler = require(script:WaitForChild("AbilityHotbarHandler"))
require(script:WaitForChild("MapOverrideScreenHandler"))
require(script:WaitForChild("TempNotificationHandler"))
local TooltipHandler = require(script:WaitForChild("TooltipHandler"))
local UpgradeShopHandler = require(script:WaitForChild("UpgradeShopHandler"))
local SpectatorHandler = require(script:WaitForChild("SpectatorHandler"))
local AdminButtonHandler = require(script:WaitForChild("AdminButtonHandler"))
local TOWERS_BAR_COUNT = _G.TOWERS_BAR_COUNT
local SPECTATOR_ADMIN_BUTTONS = _G.SPECTATOR_ADMIN_BUTTONS
local isStudio = RunService:IsStudio()
local GameStates = Enums.GameStates
local event = NetworkingHandler.GetEvent("LoadoutChanged")
local v = NetworkingHandler.GetFunction("AdminPanelRequest")
local event2 = BindableHandler.GetEvent("ToggleAdminPanel")
local event3 = BindableHandler.GetEvent("SetDifficulty")
local event4 = BindableHandler.GetEvent("ScreenSizeChanged")
local event5 = BindableHandler.GetEvent("LoadoutChangedWithAdmin")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Interface = PlayerGui:WaitForChild("Interface")
local LowPriorityInterface = PlayerGui:WaitForChild("LowPriorityInterface")
local FirstPersonInterface = PlayerGui:WaitForChild("FirstPersonInterface")
local PreloadFrame = Interface:WaitForChild("PreloadFrame")
local TopAreaQueueFrame = Interface:WaitForChild("TopAreaQueueFrame")
local BlackoutFrame = Interface:WaitForChild("BlackoutFrame")
local WhiteoutFrame = Interface:FindFirstChild("WhiteoutFrame")
local BottomLeftButtons = Interface:WaitForChild("BottomLeftButtons")
local v2 = nil
local v3 = isStudio
local v4 = {}
local v5 = {}
local v6 = nil
local v7 = nil
local v8 = false
local v9 = false

local function IsPVPMode() -- 3 equivalent calls inferred from this helper
	return v6 ~= nil and v6.CustomGameInfoHandlerName == Enums.GameModes.PVP
end

local function Initialize()
	while not (LocalPlayer:GetAttribute("LoadoutLoaded") or LocalPlayer:GetAttribute("Spectator")) do
		task.wait(0.1)
	end

	if SpectatorHandler.IsSpectator() then
		if not v9 then
			v9 = true
			TopAreaQueueFrame.Position += UDim2.new(0, 0, 0, -GuiService:GetGuiInset().Y)
			SeizureWarningHandler.Initialize()
			SpectatorHandler.Initialize()
		end

		Interface.Enabled = true
		LowPriorityInterface.Enabled = true
		FirstPersonInterface.Enabled = false
	else
		local powerUpCount = LocalPlayer:GetAttribute("PowerUpCount")
		local attributes = {}
		local attributes2 = {}
		local v10 = {}
		local v11 = {}

		for i = 1, TOWERS_BAR_COUNT do
			attributes[i] = LocalPlayer:GetAttribute("LoadoutSlot" .. i)
		end

		for i = 1, powerUpCount do
			attributes2[i] = LocalPlayer:GetAttribute("PowerUpSlot" .. i)
		end

		for i = 1, TOWERS_BAR_COUNT do
			local v12 = attributes[i]

			if v12 and v12 ~= "" then
				v10[i] = v12
			end
		end

		for i = 1, powerUpCount do
			local v12 = attributes2[i]

			if v12 and v12 ~= "" then
				v11[i] = v12
			end
		end

		v4 = v10
		TowersBar.Initialize(v10)
		PVPTowersBar.Initialize()
		AbilityHotbarHandler.Initialize(v10)
		UpgradeShopHandler.Initialize(v10)
		PowerUpsScreenHandler.Initialize(powerUpCount, v11)
		task.spawn(function()
			PreloadFrame.Visible = true

			for _, child in pairs(PreloadFrame:GetChildren()) do
				if not child.IsLoaded then
					task.wait(0.1)
				end
			end

			PreloadFrame:Destroy()
		end)
		TopAreaQueueFrame.Position += UDim2.new(0, 0, 0, -GuiService:GetGuiInset().Y)
		v5 = {}

		for _, descendant in pairs(Interface:GetDescendants()) do
			local tutorialElementId = descendant:GetAttribute("TutorialElementId")

			if not tutorialElementId then
				continue
			end

			if not v5[tutorialElementId] then
				v5[tutorialElementId] = {}
			end

			table.insert(v5[tutorialElementId], descendant)
		end

		Interface.Enabled = true
		LowPriorityInterface.Enabled = true
		FirstPersonInterface.Enabled = false
		SeizureWarningHandler.Initialize()
		event:AttachCallback(function(flag: boolean?)
			if flag and isStudio then
				return
			end

			local attributes3 = {}

			for i = 1, TOWERS_BAR_COUNT do
				local attribute = LocalPlayer:GetAttribute("LoadoutSlot" .. i)

				if not attribute then
					continue
				end

				TowersBar.SetTower(i, attribute)

				if attribute ~= "" then
					attributes3[i] = attribute
				end
			end

			v4 = attributes3
			AbilityHotbarHandler.Initialize(attributes3)
			UpgradeShopHandler.Initialize(attributes3)
		end)
	end
end

local function DetectScreenSizeChange() -- 1 equivalent call inferred from this helper
	local absoluteSize = Interface.AbsoluteSize

	if v2 ~= absoluteSize then
		v2 = absoluteSize
		event4:Fire()
	end
end

local function GetDifficultyVoteScreenHandler() -- 2 equivalent calls inferred from this helper
	local lobbyType = workspace:GetAttribute("LobbyType")
	local v10 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)

	if v10 and v10.UseDifficultyVoteScreenV2 then
		return DifficultyVoteScreenV2Handler
	end

	return DifficultyVoteScreenHandler
end

function UserInterfaceHandler.SetState(p: string, p2: string, data)
	v7 = p2

	if p ~= p2 then
		if p == GameStates.MapVoting then
			SoundHandler.Play("EnemiesIncoming")
		elseif p == GameStates.DifficultyVoting then
			SoundHandler.Play("EnemiesIncoming")
		elseif p == GameStates.LoadoutSelection then
			SoundHandler.Play("EnemiesIncoming")
		elseif p == GameStates.EndScreen then
			SoundHandler.Play("EnemiesIncoming")
		end
	end

	if p2 ~= GameStates.Running then
		TowerUIHandler.Disable()
		local v10 = p2 ~= GameStates.DifficultyVoting and p2 ~= GameStates.MapVoting
		TowersBar.Disable(v10)
		PVPTowersBar.Disable(v10)
		PowerUpsScreenHandler.DisablePVP()
		PlacementButtonsHandler.Disable()
		UpgradeShopHandler.Hide()
	end

	if p2 ~= GameStates.MapVoting then
		MapVotingScreenHandler.Stop()
	end

	if p2 ~= GameStates.DifficultyVoting then
		GetDifficultyVoteScreenHandler().HideScreen() -- inferred equivalent call
	end

	if p2 ~= GameStates.LoadoutSelection then
		LoadoutSelectionScreenHandler.HideScreen(p2 == GameStates.Running)
	end

	if p2 ~= GameStates.Cutscene then
		CutsceneScreenHandler.HideScreen()
	end

	if p2 ~= GameStates.EndScreen then
		GameOverScreenHandler.HideScreen()
		BlackoutFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		BlackoutFrame.Visible = false

		if WhiteoutFrame then
			WhiteoutFrame.Visible = false
		end
	end

	if p2 == GameStates.Running then
		TowerUIHandler.Enable()
		TowersBar.Enable(true)

		if IsPVPMode() then -- inferred equivalent call
			PVPTowersBar.Enable(true)
			PowerUpsScreenHandler.EnablePVP(true)
		end

		PlacementButtonsHandler.Enable()
		TopNotificationHandler.Disable()
	elseif p2 == GameStates.MapVoting then
		MapVotingScreenHandler.Start(data.VoteStateData)
	elseif p2 == GameStates.DifficultyVoting then
		GetDifficultyVoteScreenHandler().DisplayScreen( -- inferred equivalent call
			data.VoteStateData,
			data.OverrideDifficulty,
			data.OverrideVotingScreenName
		)
	elseif p2 == GameStates.LoadoutSelection then
		LoadoutSelectionScreenHandler.ShowScreen(data.Difficulty, p == GameStates.DifficultyVoting)
	elseif p2 == GameStates.Cutscene then
		CutsceneScreenHandler.ShowScreen()
	elseif p2 == GameStates.EndScreen then
		GameOverScreenHandler.DisplayScreen(data)
		TopNotificationHandler.Display(data)
	end

	GameInfoHandler.SetState(p2)
	SpeedChangeScreenHandler.SetState(p2)
	UpgradeShopHandler.SetState(p2)
	SeizureWarningHandler.SetState(p2, data)
	SpectatorHandler.SetState(p2)

	if
		p2 == GameStates.Running
		or p2 == GameStates.MapVoting
		or p2 == GameStates.DifficultyVoting
		or p2 == GameStates.LoadoutSelection
	then
		GameInfoHandler.Enable(true)
	else
		GameInfoHandler.Disable(true)
	end
end

function UserInterfaceHandler.SelectTower(p)
	TowerUIHandler.Show(p)
end

function UserInterfaceHandler.DeselectTower()
	TowerUIHandler.Hide()
end

function UserInterfaceHandler.Update(p: number, p2: string, p3: number)
	DetectScreenSizeChange() -- inferred equivalent call
	local v10 = p * p3
	TowerUIHandler.Update()
	GameOverScreenHandler.Update(p)
	PromptHandler.Update(p)
	AbilityHotbarHandler.Update(p)
	UpgradeShopHandler.Update(p)
	TooltipHandler.Update()
	SpectatorHandler.Update(p)

	if p2 == GameStates.Running then
		if IsPVPMode() then -- inferred equivalent call
			PowerUpsScreenHandler.Disable()
		else
			PowerUpsScreenHandler.Enable()
		end
	else
		PowerUpsScreenHandler.Disable()
	end

	if
		p2 == GameStates.Running
		or p2 == GameStates.MapVoting
		or p2 == GameStates.DifficultyVoting
		or p2 == GameStates.LoadoutSelection
	then
		GameInfoHandler.Update(p, v10)
	end

	local localPlayerHasTesterPanelAccess = PlayerClass.LocalPlayerHasTesterPanelAccess()
	local localPlayerHasAdminPanelAccess = PlayerClass.LocalPlayerHasAdminPanelAccess()
	local v11 = isStudio or localPlayerHasTesterPanelAccess or localPlayerHasAdminPanelAccess

	if v11 then
		local isSpectator = SpectatorHandler.IsSpectator()

		for _, button in ipairs(BottomLeftButtons:GetChildren()) do
			if not button:IsA("ImageButton") then
				continue
			end

			local tester = button:GetAttribute("Tester")

			if button:GetAttribute("Admin") then
				button.Visible = localPlayerHasAdminPanelAccess
			elseif tester then
				button.Visible = localPlayerHasAdminPanelAccess or localPlayerHasTesterPanelAccess
			end

			if not isSpectator or SPECTATOR_ADMIN_BUTTONS[button.Name] then
				continue
			end

			button.Visible = false
		end
	end

	BottomLeftButtons.Visible = v3 and v11
	AdminButtonHandler.SetEnabled(v11)
end

function UserInterfaceHandler.AddBoss(p)
	GameInfoHandler.AddBoss(p)
end

function UserInterfaceHandler.RemoveBoss(p, flag: boolean?)
	GameInfoHandler.RemoveBoss(p, flag)
end

function UserInterfaceHandler.RefreshBossInfo()
	GameInfoHandler.RefreshBossInfo()
end

function UserInterfaceHandler.EnableTouchControls()
	PlacementButtonsHandler.EnableTouchControls()
end

function UserInterfaceHandler.DisableTouchControls()
	PlacementButtonsHandler.DisableTouchControls()
end

function UserInterfaceHandler.ToggleAdminPanel()
	v3 = not v3
end

function UserInterfaceHandler.Reset()
	Initialize()
end

function UserInterfaceHandler.GetTutorialElementsForElementId(p: string)
	return v5[p] or {}
end

function UserInterfaceHandler.HideAllTutorialElements()
	for _, v10 in pairs(v5) do
		for _, v11 in pairs(v10) do
			v11.Visible = false
		end
	end
end

function UserInterfaceHandler.ToggleFPSMode(flag: boolean)
	if flag then
		Interface.Enabled = false
		LowPriorityInterface.Enabled = false
		FirstPersonInterface.Enabled = true
		TowerUIHandler.FPSModeEnabled()
	else
		Interface.Enabled = true
		LowPriorityInterface.Enabled = true
		FirstPersonInterface.Enabled = false
	end
end

function UserInterfaceHandler.ToggleAdminHoverPanel(p, p2: string?)
	TooltipHandler.ToggleAdminHoverPanel(p, p2)
end

function UserInterfaceHandler.ToggleTowerUpgradeShop()
	UpgradeShopHandler.Toggle()
end

function UserInterfaceHandler.Initialize()
	if not v8 then
		Initialize()
		v8 = true
	end
end

local ViewportTesting = LowPriorityInterface:FindFirstChild("ViewportTesting")

if ViewportTesting then
	ViewportTesting:Destroy()
end

event3:AttachCallback(function(p: string)
	v6 = ResourceManager.GetWaveConfig(p)
	TowersBar.RefreshCosts()
	PVPTowersBar.RefreshCosts()

	if v7 == GameStates.Running and IsPVPMode() then -- inferred equivalent call
		PVPTowersBar.Enable(true)
		PowerUpsScreenHandler.EnablePVP(true)
	end
end)
event2:AttachCallback(function()
	UserInterfaceHandler.ToggleAdminPanel()
end)
event5:AttachCallback(function(p: number, p2: string)
	v4[p] = p2
	TowersBar.SetTower(p, p2)
	PVPTowersBar.SetTower(p, p2)
	AbilityHotbarHandler.Initialize(v4)
	UpgradeShopHandler.Initialize(v4)
end)
ChatHandlerClientside.AddOnIncomingMessageCallback(function(p)
	if p.TextSource.UserId ~= LocalPlayer.UserId then
		return
	end

	if p.Text == "/admin" then
		UserInterfaceHandler.ToggleAdminPanel()
	elseif p.Text == "/cash" then
		v:InvokeServer("Cash")
	end
end)
PlayerGui.ChildAdded:Connect(function(screenGui)
	if screenGui:IsA("ScreenGui") and screenGui.Name == "ChallengeProgressGui" then
		screenGui.DisplayOrder = 1
	end
end)
pcall(function()
	local challengeProgressGui = PlayerGui:FindFirstChild("ChallengeProgressGui")

	if challengeProgressGui and challengeProgressGui:IsA("ScreenGui") then
		challengeProgressGui.DisplayOrder = 1
	end
end)
return UserInterfaceHandler