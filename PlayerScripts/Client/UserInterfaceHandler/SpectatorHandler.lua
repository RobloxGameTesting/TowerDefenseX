local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local parent = script.Parent.Parent
local CameraHandler = require(parent:WaitForChild("CameraHandler"))
local towerClass = parent:WaitForChild("GameClass"):WaitForChild("TowerClass")
local GameStates = Enums.GameStates
local rbxassetfontsfamiliesGothamSSmjson = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
local rbxassetfontsfamiliesGothamSSmjson2 = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
local color = Color3.fromRGB(18, 20, 26)
local color2 = Color3.fromRGB(38, 42, 52)
local color3 = Color3.fromRGB(70, 78, 96)
local color4 = Color3.fromRGB(200, 55, 55)
local color5 = Color3.new(1, 1, 1)
local color6 = Color3.fromRGB(185, 190, 205)
local v = {
	{ "Interface", "BottomBar" },
	{ "Interface", "AbilityHotbar" },
	{ "Interface", "PVPEnemiesBar" },
	{ "Interface", "UpgradeShopScreen" },
	{ "Interface", "LoadoutSelectionScreen" },
	{ "Interface", "MapVotingScreen" },
	{ "Interface", "MapOverrideScreen" },
	{ "Interface", "DifficultyVoteScreen" },
	{ "Interface", "DifficultyVoteScreenV2" },
	{ "Interface", "GameOverScreen" },
	{ "Interface", "SpeedChangeScreen" },
	{ "Interface", "SpeedChangeScreenOld" },
	{ "Interface", "TopAreaQueueFrame", "SkipWaveVoteScreen" },
	{ "Interface", "TopAreaQueueFrame", "SpeedupVoteScreen" },
	{ "Interface", "CutsceneScreen", "TopAreaQueueFrame", "SkipScreen" },
	{ "LowPriorityInterface", "LeftButtons", "SpeedupButton" },
	{ "LowPriorityInterface", "LeftButtons", "UpgradeShopButton" },
	{ "LowPriorityInterface", "LeftButtons", "PowerUps" },
	{ "LowPriorityInterface", "LeftButtons", "PowerUpsPVP" }
}
local event = NetworkingHandler.GetEvent("RequestTeleportToLobby")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local v2 = nil
local v3 = nil
local frame = nil
local textButton = nil
local v4 = {}
local v5 = ""
local v6 = 0
local v7 = nil
local flag = false
local flag2 = false

local function KeepHidden(guiObject) -- 1 equivalent call inferred from this helper
	guiObject.Visible = false
	guiObject:GetPropertyChangedSignal("Visible"):Connect(function()
		if guiObject.Visible then
			guiObject.Visible = false
		end
	end)
end

local function HidePlayerOnlyFrames()
	for _, list in ipairs(v) do
		local guiObject = PlayerGui

		for _, childName in ipairs(list) do
			guiObject = guiObject and guiObject:FindFirstChild(childName)
		end

		if guiObject and guiObject:IsA("GuiObject") then
			KeepHidden(guiObject) -- inferred equivalent call
		else
			warn(`SpectatorHandler: {table.concat(list, ".")} not found`)
		end
	end
end

local function GetPlayingPlayers()
	local result = {}

	for _, v8 in ipairs(Players:GetPlayers()) do
		if not v8:FindFirstChild("leaderstats") or v8:GetAttribute("Spectator") then
			continue
		end

		table.insert(result, v8)
	end

	table.sort(result, function(a, b)
		local pvpTeamIndex = a:GetAttribute("PVPTeamIndex") or 0
		local pvpTeamIndex2 = b:GetAttribute("PVPTeamIndex") or 0

		if pvpTeamIndex == pvpTeamIndex2 then
			return a.Name < b.Name
		end

		return pvpTeamIndex < pvpTeamIndex2
	end)
	return result
end

local function GetOwnerNameToTowerCountMap()
	local module = require(towerClass)
	local result = {}

	for _, v8 in pairs(module.GetTowers()) do
		local ownerName = v8.OwnerName

		if ownerName then
			result[ownerName] = (result[ownerName] or 0) + 1
		end
	end

	return result
end

local function NewTextLabel(name: string, fontFace, textSize: number, textColor: Color3) -- 4 equivalent calls inferred from this helper
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = name
	textLabel.BackgroundTransparency = 1
	textLabel.FontFace = fontFace
	textLabel.TextSize = textSize
	textLabel.TextColor3 = textColor
	textLabel.TextTruncate = Enum.TextTruncate.AtEnd
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	return textLabel
end

local function AddCorner(parent2, p: number) -- 4 equivalent calls inferred from this helper
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, p)
	uiCorner.Parent = parent2
end

local function ToggleFollow(p) -- 1 equivalent call inferred from this helper
	if CameraHandler.GetFollowedPlayer() == p then
		CameraHandler.SetFollowedPlayer(nil)
	else
		CameraHandler.SetFollowedPlayer(p)
	end

	SoundHandler.Play("ClickTower")
end

local function NewPlayerCard(player, layoutOrder: number)
	local textButton2 = Instance.new("TextButton")
	textButton2.Name = player.Name
	textButton2.Text = ""
	textButton2.AutoButtonColor = true
	textButton2.BackgroundColor3 = color2
	textButton2.Size = UDim2.fromOffset(150, 44)
	textButton2.LayoutOrder = layoutOrder
	AddCorner(textButton2, 6) -- inferred equivalent call
	local uiStroke = Instance.new("UIStroke")
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.Color = color5
	uiStroke.Thickness = 2
	uiStroke.Enabled = false
	uiStroke.Parent = textButton2
	local frame2 = Instance.new("Frame")
	frame2.Name = "TeamStrip"
	frame2.BorderSizePixel = 0
	frame2.Position = UDim2.fromOffset(6, 8)
	frame2.Size = UDim2.new(0, 3, 1, -16)
	frame2.Parent = textButton2
	AddCorner(frame2, 2) -- inferred equivalent call
	local nameLabel = NewTextLabel("PlayerName", rbxassetfontsfamiliesGothamSSmjson, 14, color5) -- inferred equivalent call
	nameLabel.Position = UDim2.fromOffset(15, 6)
	nameLabel.Size = UDim2.new(1, -21, 0, 16)
	nameLabel.Text = player.DisplayName
	nameLabel.Parent = textButton2
	local infoLabel = NewTextLabel("Info", rbxassetfontsfamiliesGothamSSmjson2, 12, color6) -- inferred equivalent call
	infoLabel.Position = UDim2.fromOffset(15, 24)
	infoLabel.Size = UDim2.new(1, -21, 0, 14)
	infoLabel.Parent = textButton2
	textButton2.Activated:Connect(function()
		ToggleFollow(player) -- inferred equivalent call
	end)
	textButton2.Parent = frame
	return {
		Player = player,
		Button = textButton2,
		Stroke = uiStroke,
		TeamStrip = frame2,
		NameLabel = nameLabel,
		InfoLabel = infoLabel
	}
end

local function RebuildPlayerCards(list)
	for _, v8 in ipairs(v4) do
		v8.Button:Destroy()
	end

	v4 = {}

	for i, v8 in ipairs(list) do
		table.insert(v4, (NewPlayerCard(v8, i)))
	end
end

local function GetStatusText() -- 1 equivalent call inferred from this helper
	if v7 == GameStates.EndScreen then
		return "MATCH OVER"
	end

	local followedPlayer = CameraHandler.GetFollowedPlayer()

	if followedPlayer then
		return `FOLLOWING {string.upper(followedPlayer.DisplayName)}`
	end

	return "CLICK A PLAYER TO FOLLOW THEM"
end

local function Refresh()
	local playingPlayers = GetPlayingPlayers()
	local names = {}

	for _, v8 in ipairs(playingPlayers) do
		table.insert(names, v8.Name)
	end

	local joined = table.concat(names, "\0")

	if joined ~= v5 then
		v5 = joined
		RebuildPlayerCards(playingPlayers)
	end

	local followedPlayer = CameraHandler.GetFollowedPlayer()

	if followedPlayer and followedPlayer.Parent ~= Players then
		CameraHandler.SetFollowedPlayer(nil)
		followedPlayer = nil
	end

	local ownerNameToTowerCountMap = GetOwnerNameToTowerCountMap()

	for _, v8 in ipairs(v4) do
		local player = v8.Player
		local leaderstats = player:FindFirstChild("leaderstats")
		local cash = leaderstats and leaderstats:FindFirstChild("Cash")
		local value = cash and cash.Value or 0
		local v9 = ownerNameToTowerCountMap[player.Name] or 0
		local team = player.Team
		v8.InfoLabel.Text = `${value}  ·  {v9} {v9 == 1 and "tower" or "towers"}`
		v8.TeamStrip.Visible = team ~= nil
		v8.TeamStrip.BackgroundColor3 = team and team.TeamColor.Color or color5
		local enabled = followedPlayer == player
		v8.Stroke.Enabled = enabled
		v8.Button.BackgroundColor3 = enabled and color3 or color2
	end

	v3.Text = GetStatusText() -- inferred equivalent call
end

local function Leave()
	if flag then
		return
	end

	flag = true
	textButton.Text = "LEAVING..."
	event:FireServer()
	task.delay(10, function()
		flag = false
		textButton.Text = "LEAVE"
	end)
end

local function CreateInterface()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SpectatorInterface"
	screenGui.ResetOnSpawn = false
	screenGui.DisplayOrder = 2
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local frame2 = Instance.new("Frame")
	frame2.Name = "Panel"
	frame2.AnchorPoint = Vector2.new(0.5, 1)
	frame2.Position = UDim2.new(0.5, 0, 1, -12)
	frame2.AutomaticSize = Enum.AutomaticSize.XY
	frame2.BackgroundColor3 = color
	frame2.BackgroundTransparency = 0.2
	frame2.Parent = screenGui
	AddCorner(frame2, 10) -- inferred equivalent call
	local uiPadding = Instance.new("UIPadding")
	uiPadding.PaddingTop = UDim.new(0, 8)
	uiPadding.PaddingBottom = UDim.new(0, 8)
	uiPadding.PaddingLeft = UDim.new(0, 8)
	uiPadding.PaddingRight = UDim.new(0, 8)
	uiPadding.Parent = frame2
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Vertical
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Padding = UDim.new(0, 6)
	uiListLayout.Parent = frame2
	local frame3 = Instance.new("Frame")
	frame3.Name = "Header"
	frame3.BackgroundTransparency = 1
	frame3.AutomaticSize = Enum.AutomaticSize.X
	frame3.Size = UDim2.fromOffset(0, 16)
	frame3.LayoutOrder = 1
	frame3.Parent = frame2
	local uiListLayout2 = Instance.new("UIListLayout")
	uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center
	uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout2.Padding = UDim.new(0, 8)
	uiListLayout2.Parent = frame3
	local newTextLabel = NewTextLabel("Title", rbxassetfontsfamiliesGothamSSmjson, 14, color5) -- inferred equivalent call
	newTextLabel.AutomaticSize = Enum.AutomaticSize.X
	newTextLabel.Size = UDim2.fromOffset(0, 16)
	newTextLabel.Text = "SPECTATING"
	newTextLabel.LayoutOrder = 1
	newTextLabel.Parent = frame3
	v3 = NewTextLabel("Status", rbxassetfontsfamiliesGothamSSmjson2, 12, color6) -- inferred equivalent call
	v3.AutomaticSize = Enum.AutomaticSize.X
	v3.Size = UDim2.fromOffset(0, 16)
	v3.TextTruncate = Enum.TextTruncate.None
	v3.LayoutOrder = 2
	v3.Parent = frame3
	frame = Instance.new("Frame")
	frame.Name = "Cards"
	frame.BackgroundTransparency = 1
	frame.AutomaticSize = Enum.AutomaticSize.X
	frame.Size = UDim2.fromOffset(0, 44)
	frame.LayoutOrder = 2
	frame.Parent = frame2
	local uiListLayout3 = Instance.new("UIListLayout")
	uiListLayout3.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout3.Padding = UDim.new(0, 6)
	uiListLayout3.Parent = frame
	textButton = Instance.new("TextButton")
	textButton.Name = "LeaveButton"
	textButton.BackgroundColor3 = color4
	textButton.Size = UDim2.fromOffset(84, 44)
	textButton.LayoutOrder = 1000000
	textButton.FontFace = rbxassetfontsfamiliesGothamSSmjson
	textButton.TextSize = 14
	textButton.TextColor3 = color5
	textButton.Text = "LEAVE"
	textButton.Parent = frame
	AddCorner(textButton, 6) -- inferred equivalent call
	textButton.Activated:Connect(Leave)
	screenGui.Parent = PlayerGui
	return screenGui
end

local SpectatorHandler = {}

function SpectatorHandler.IsSpectator()
	return LocalPlayer:GetAttribute("Spectator") == true
end

function SpectatorHandler.Initialize()
	if flag2 then
		return
	end

	flag2 = true
	HidePlayerOnlyFrames()
	v2 = CreateInterface()
	Refresh()
end

function SpectatorHandler.SetState(p: string)
	v7 = p
end

function SpectatorHandler.Update(p: number)
	if not v2 then
		return
	end

	v6 -= p

	if v6 <= 0 then
		v6 = 0.25
		Refresh()
	end
end

return SpectatorHandler