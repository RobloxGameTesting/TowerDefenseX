local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
require(game.ReplicatedStorage.TDX_Shared.Common.Types)
local LobbyTypeUtilities = require(game.ReplicatedStorage.TDX_Shared.Common.LobbyTypeUtilities)
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local BattlePass = require(ReplicatedStorage.TDX_Shared.Modules.BattlePass)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local Lang = require(ReplicatedStorage.TDX_Shared.Modules.Lang)
local MapData = require(ReplicatedStorage.TDX_Shared.Common.MapData)
local PartyClient = require(ReplicatedFirst.Client.PartyClient)
local PVPHelper = require(ReplicatedFirst.Util.PVPHelper)
local Tabs = require(script.Parent.Frames.Tabs)
local SearchBarClass = require(ReplicatedStorage.TDX_Shared.Common.SearchBarClass)
local audioDeviceOutput = workspace.CurrentCamera:FindFirstChild("AudioDeviceOutput")
	or Instance.new("AudioDeviceOutput")
audioDeviceOutput.Name = "PartyVoiceOutput"
audioDeviceOutput.Parent = workspace.CurrentCamera
local PartyWindow = { ClassName = script.Name, ClassModule = script }
PartyWindow.__index = PartyWindow
local LocalPlayer = Players.LocalPlayer
local v = {
	RandomSimple = {
		Icon = "rbxassetid://129518193775876",
		Banner = "rbxassetid://127963629772992"
	},
	RandomEasy = { Icon = "rbxassetid://91771700366821", Banner = "rbxassetid://115918654973049" },
	RandomNormal = {
		Icon = "rbxassetid://124284988334820",
		Banner = "rbxassetid://108676215066428"
	},
	RandomHard = { Icon = "rbxassetid://95564200823200", Banner = "rbxassetid://109432327588909" },
	RandomImpossible = {
		Icon = "rbxassetid://73656444386682",
		Banner = "rbxassetid://126365557375624"
	}
}
local v2 = { Friends = 0, SimilarLevel = 1 }
local color = Color3.fromHex("D54143")
local v3 = {}
local mlgs = {
	LobbyTypeUtilities.LOBBY_TYPES.TBPart2,
	LobbyTypeUtilities.LOBBY_TYPES.Easy,
	LobbyTypeUtilities.LOBBY_TYPES.Intermediate,
	LobbyTypeUtilities.LOBBY_TYPES.Elite,
	LobbyTypeUtilities.LOBBY_TYPES.Expert,
	LobbyTypeUtilities.LOBBY_TYPES.NightmareWithMapVoting,
	LobbyTypeUtilities.LOBBY_TYPES.Endless,
	LobbyTypeUtilities.LOBBY_TYPES.Easter26Part1,
	LobbyTypeUtilities.LOBBY_TYPES.Easter26Part2,
	LobbyTypeUtilities.LOBBY_TYPES.Christmas25Part1,
	LobbyTypeUtilities.LOBBY_TYPES.Christmas25Part2,
	LobbyTypeUtilities.LOBBY_TYPES.Halloween2025,
	LobbyTypeUtilities.LOBBY_TYPES.TowerBattles,
	LobbyTypeUtilities.LOBBY_TYPES.Christmas24Part1,
	LobbyTypeUtilities.LOBBY_TYPES.Christmas24Part2,
	LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart1,
	LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart2,
	LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart3,
	LobbyTypeUtilities.LOBBY_TYPES.HalloweenPart4
}

if _G.APRIL_FOOLS_2026_EVENT_ENABLED then
	table.insert(mlgs, LobbyTypeUtilities.LOBBY_TYPES.MLG)
end

local v4 = {
	Modes = function(p)
		return not (p and p.RequiredBattlePass)
	end,
	Events = function(p)
		return p and p.RequiredBattlePass or p.DisplayName == "MLG"
	end
}
local v5 = {}

local function createSuggestedPlayerList()
	for k in v5 do
		if k == nil or k.Parent == nil then
			v5[k] = nil
		end
	end

	local value = LocalPlayer:FindFirstChild("leaderstats")
		and LocalPlayer.leaderstats:FindFirstChild("Level")
		and LocalPlayer.leaderstats.Level.Value
		or 0
	local result = {}

	for _, v6 in Players:GetPlayers() do
		if v6 == LocalPlayer then
			continue
		end

		local v7 = not (v6:FindFirstChild("leaderstats") and v6.leaderstats:FindFirstChild("Level")) and 0
			or v6.leaderstats.Level.Value
			or 0
		local v8 = v5[v6]

		if v8 == nil then
			local success, result2 = pcall(LocalPlayer.IsFriendsWith, LocalPlayer, v6.UserId)
			v5[v6] = success and result2
		end

		if v8 then
			result[v6] = "Friends"
		elseif math.abs(value - v7) <= 20 then
			result[v6] = "SimilarLevel"
		end
	end

	return result
end

local function reparent(p, parent)
	p.Parent = parent
end

function PartyWindow.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		CurrentPlayerListButton = "Suggested",
		SuggestedList = {},
		VoiceUpdateConnections = {},
		InviteEntries = {},
		InviteEntriesStyle = nil
	}, PartyWindow))
end

function PartyWindow:Init()
	self.Cleaner:Add(self.Root.topframe.squadtype.TextButton.MouseButton1Click:Connect(function()
		self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible = not self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible
		self.Root.topframe.squadtype.dropdownbutton.Image = self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible
			and "rbxassetid://136614282646459"
			or "rbxassetid://113802315398922"
	end))
	self.Cleaner:Add(self.Root.topframe.squadtype.dropdownbutton.MouseButton1Click:Connect(function()
		self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible = not self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible
		self.Root.topframe.squadtype.dropdownbutton.Image = self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible
			and "rbxassetid://136614282646459"
			or "rbxassetid://113802315398922"
	end))

	for k, v6 in { "solo", "duo", "trio", "quad" } do
		local v7 = k
		self.Cleaner:Add(self.Root.topframe.squadtype.dropdownbutton.dropdown.ImageLabel[v6].TextButton.MouseButton1Click:Connect(function()
			PartyClient.ChangeMaxPlayers(v7)
			self.Root.topframe.squadtype.dropdownbutton.dropdown.Visible = false
		end))
	end

	self.Cleaner:Add(self.Root.mapframe.changemap.MouseButton1Click:Connect(function()
		self:ShowMapPicker(self.MapPickerTabs:GetSelectedTab() or "Modes")
	end))
	self.Cleaner:Add(self.Root.leaveparty.MouseButton1Click:Connect(function()
		self.Root.leaveprompt.Visible = true
	end))
	self.Cleaner:Add(self.Root.leaveprompt.confirmation.cancel.MouseButton1Click:Connect(function()
		self.Root.leaveprompt.Visible = false
	end))
	self.Cleaner:Add(self.Root.leaveprompt.confirmation.leave.MouseButton1Click:Connect(function()
		self.Root.leaveprompt.Visible = false
		PartyClient.LeaveParty()
		self:Close()
	end))
	self.Cleaner:Add(self.Root.startgame.MouseButton1Click:Connect(function()
		local function startGame() -- 3 equivalent calls inferred from this helper
			PartyClient.StartGame()
			self:UpdateButtons()
		end

		local partyData = PartyClient.GetPartyData()

		if partyData.PartyType == "PVP" then
			if #partyData.Players < 2 then
				local remainingAbandonCooldown = PVPHelper.GetRemainingAbandonCooldown()

				if remainingAbandonCooldown > 0 then
					PVPHelper.ShowAbandonCooldownWarning(remainingAbandonCooldown)
					return
				end
			end

			local equippedBannedPVPTowers = PVPHelper.GetEquippedBannedPVPTowers()

			if #equippedBannedPVPTowers > 0 then
				PVPHelper.ShowBannedPVPTowerWarning(equippedBannedPVPTowers[1], function(p)
					if p then
						startGame() -- inferred equivalent call
					end
				end)
				return
			end

			startGame() -- inferred equivalent call
		else
			startGame() -- inferred equivalent call
		end
	end))
	self.Cleaner:Add(self.Root.ready.MouseButton1Click:Connect(function()
		if PartyClient.GetPartyData().PartyType ~= "PVP" then
			PartyClient.SetReadyState(true)
			return
		end

		local equippedBannedPVPTowers = PVPHelper.GetEquippedBannedPVPTowers()

		if #equippedBannedPVPTowers > 0 then
			PVPHelper.ShowBannedPVPTowerWarning(equippedBannedPVPTowers[1], function(p)
				if p then
					PartyClient.SetReadyState(true)
				end
			end)
		else
			PartyClient.SetReadyState(true)
		end
	end))
	self.Cleaner:Add(self.Root.unready.MouseButton1Click:Connect(function()
		PartyClient.SetReadyState(false)
	end))
	self.Cleaner:Add(self.Root.inviteframe.buttons.invitedsmall.TextButton.MouseButton1Click:Connect(function()
		self.CurrentPlayerListButton = "Invited"
		self:UpdateButtons()
		self:UpdatePlayerInviteList(self.CurrentPlayerListButton)
	end))
	self.Cleaner:Add(self.Root.inviteframe.buttons.suggested.TextButton.MouseButton1Click:Connect(function()
		self.CurrentPlayerListButton = "Suggested"
		self:UpdateButtons()
		self:UpdatePlayerInviteList(self.CurrentPlayerListButton)
	end))
	self.Cleaner:Add(self.Root.Close.MouseButton1Click:Connect(function()
		self:Minimise()
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input)
		if self.Root.Visible and input.KeyCode == Enum.KeyCode.ButtonB then
			self:Minimise()
		end
	end))
	self.Cleaner:Add(self.Root.cancel.MouseButton1Click:Connect(function()
		PartyClient.StopMatchmaking()
	end))
	local classObjectYields = Director.GetClassObjectYields(self.Root.topframe.Tabs, Tabs)
	classObjectYields.OnTabClicked:Connect(function(p)
		PartyClient.ChangePartyType(p)
	end)
	self.TopBarTabs = classObjectYields
	self.Cleaner:Add(PartyClient.PartyDataChanged:Connect(function(p)
		self:UpdateTopFrame()
		self:UpdateButtons()
		self:UpdateMap()

		if self.CurrentPlayerListButton == "Suggested" and p.Leader ~= LocalPlayer then
			self.CurrentPlayerListButton = "Invited"
		end

		self:UpdatePlayerList()
		self:UpdatePlayerInviteList(self.CurrentPlayerListButton)
		local textChannels = TextChatService:WaitForChild("TextChannels")

		for _, textChannel in textChannels:GetChildren() do
			if not (textChannel:IsA("TextChannel") and string.sub(textChannel.Name, 1, 3) ~= "RBX" and textChannel ~= p.TextChannel) then
				continue
			end

			textChannel.Parent = nil
			task.defer(reparent, textChannel, textChannels)
		end
	end))
	self.Cleaner:Add(PartyClient.PartyKickNotification:Connect(function()
		self.Root.Visible = false
	end))
	local now = tick()
	local now2 = tick()
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		local now3 = tick()

		if now3 - now > 1 then
			now = now3
			self:UpdatePlayerInviteList(self.CurrentPlayerListButton)
			self:UpdateTimer()
		end

		if now3 - now2 > 5 then
			now2 = now3
			self.SuggestedList = createSuggestedPlayerList()
		end
	end))
	self.MapPickerTabs = Director.GetClassObjectYields(self.Root.choosemap.mapframe.Tabs, Tabs)
	self.Cleaner:Add(self.MapPickerTabs.OnTabClicked:Connect(function(p: string)
		self:ShowMapPicker(p)
	end))
	self.MapPickerSearchBar = SearchBarClass.New({
		SearchBarGui = self.Root.choosemap.mapframe.Search,
		TextChangedCallback = function(value)
			local scrollingFrame = self.Root.choosemap.mapframe.ScrollingFrame
			local lower = value:lower()

			for _, frame in scrollingFrame:GetChildren() do
				if frame:IsA("Frame") and frame.Name ~= "template" then
					frame.Visible = #lower == 0
						or (string.find(string.lower(frame.Name), lower) or string.find(string.lower(frame.bg.mapdiff.Text), lower))
				end
			end

			scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.UIListLayout.AbsoluteContentSize.Y)
		end
	})
	self.Root.players.template.Visible = false
	self.Root.players.template.actions.Visible = false
	self.Root.inviteframe.lists.ScrollingFrame.template.Visible = false
	self:UpdateTopFrame()
	self:UpdateButtons()
	self:UpdateMap()
	self:UpdatePlayerList()
	self:UpdatePlayerInviteList(self.CurrentPlayerListButton)
	self.SuggestedList = createSuggestedPlayerList()
end

function PartyWindow:ShowMapPicker(p: string)
	local scrollingFrame = self.Root.choosemap.mapframe.ScrollingFrame
	scrollingFrame.template.Visible = false

	for _, frame in scrollingFrame:GetChildren() do
		if frame:IsA("Frame") and frame.Name ~= "template" then
			frame:Destroy()
		end
	end

	for _, name in mlgs do
		local clone = scrollingFrame.template:Clone()
		local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(name)

		if not v4[p](lobbyTypeData) then
			continue
		end

		local displayName, mapName, icon

		if lobbyTypeData then
			displayName = lobbyTypeData.DisplayName
			mapName = lobbyTypeData.MapName
			icon = lobbyTypeData.Icon
		elseif string.sub(name, 1, 6) == "Random" then
			mapName = string.sub(name, 7)
			icon = v[name].Icon
			clone.bg.mapicon.random.Visible = true
			displayName = "Random"
		else
			local v6 = MapData[name]
			mapName = v6.Difficulty
			icon = v6.Image
			clone.bg.mapicon.ScaleType = Enum.ScaleType.Crop
			displayName = name
		end

		clone.Visible = true
		clone.Name = name
		clone.bg.new.Visible = v3[name] == true
		clone.bg.mapname.Text = displayName
		clone.bg.mapdiff.Text = mapName
		clone.bg.mapicon.Image = icon

		if lobbyTypeData and lobbyTypeData.RequiredBattlePass then
			clone.bg.BattlePass.Text = `{Lang.Get(BattlePass.GetPassData(lobbyTypeData.RequiredBattlePass).DisplayName)}`
			clone.bg.BattlePass.Visible = true
		end

		clone.Parent = scrollingFrame
		local v6 = name
		clone.bg.MouseButton1Click:Connect(function()
			PartyClient.ChangeMap(v6)
			self.Root.choosemap.Visible = false
		end)
	end

	scrollingFrame.CanvasPosition = Vector2.new(0, 0)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.UIListLayout.AbsoluteContentSize.Y)
	self.MapPickerTabs:SetSelectedTab(p)
	self.MapPickerSearchBar:Clear()
	self.Root.choosemap.Visible = true
end

function PartyWindow:ClearPlayerInviteList()
	for k, inviteEntry in self.InviteEntries do
		inviteEntry.Connection:Disconnect()
		inviteEntry.Frame:Destroy()
		self.InviteEntries[k] = nil
	end
end

function PartyWindow:UpdatePlayerInviteList(inviteEntriesStyle: string)
	local partyData = PartyClient.GetPartyData()
	local scrollingFrame = self.Root.inviteframe.lists.ScrollingFrame

	if self.InviteEntriesStyle ~= inviteEntriesStyle then
		self.InviteEntriesStyle = inviteEntriesStyle
		self:ClearPlayerInviteList()
	end

	local v6 = {}

	if inviteEntriesStyle == "Invited" then
		for childName, v7 in partyData.Invited do
			local child = Players:FindFirstChild(childName)

			if child == nil or table.find(partyData.Players, child) or child:GetAttribute("InParty") == true then
				continue
			end

			local inviteVisible

			if workspace:GetServerTimeNow() - v7.InvitedAt >= 10 then
				inviteVisible = v7.State == "Pending"
			else
				inviteVisible = false
			end

			local name = child.Name
			local v8 = {
				Player = child,
				ResultText = inviteVisible and "Timed out" or v7.State,
				IsError = v7.State == "Declined" or inviteVisible,
				InviteVisible = 0,
				LayoutOrder = 0
			}

			if partyData.Leader == LocalPlayer then
				if not inviteVisible then
					if v7.State == "Declined" then
						inviteVisible = v7.DeclineCount < 2
					else
						inviteVisible = false
					end
				end
			else
				inviteVisible = false
			end

			v8.InviteVisible = inviteVisible
			v6[name] = v8
		end
	elseif inviteEntriesStyle == "Suggested" then
		for k, v7 in self.SuggestedList do
			if partyData.Invited[k.Name] or k:GetAttribute("InParty") == true then
				continue
			end

			v6[k.Name] = {
				Player = k,
				ResultText = v7 == "SimilarLevel" and "Similar level" or v7,
				IsError = false,
				InviteVisible = partyData.Leader == LocalPlayer,
				InviteText = "Invite",
				LayoutOrder = v2[v7] or 0
			}
		end
	end

	for k, inviteEntry in self.InviteEntries do
		if v6[k] ~= nil then
			continue
		end

		inviteEntry.Connection:Disconnect()
		inviteEntry.Frame:Destroy()
		self.InviteEntries[k] = nil
	end

	local textColor3 = scrollingFrame.template.result.TextColor3

	for k, v7 in v6 do
		local inviteEntry = self.InviteEntries[k]

		if inviteEntry == nil then
			local clone = scrollingFrame.template:Clone()
			clone.Name = k
			clone.Visible = true
			clone.username.Text = k
			inviteEntry = { Frame = clone, Player = v7.Player }
			local v8 = k
			inviteEntry.Connection = clone.Folder.invite.MouseButton1Click:Connect(function()
				if inviteEntry.Player.Parent == nil then
					inviteEntry.Connection:Disconnect()
					clone:Destroy()
					self.InviteEntries[v8] = nil
				else
					PartyClient.InvitePlayer(inviteEntry.Player)
					clone.Folder.invite.Visible = false
				end
			end)
			self.InviteEntries[k] = inviteEntry
			clone.Parent = scrollingFrame
		end

		inviteEntry.Player = v7.Player
		local frame = inviteEntry.Frame
		frame.result.Text = v7.ResultText
		local result = frame.result
		local textColor

		if v7.IsError then
			textColor = color or textColor3
		else
			textColor = textColor3
		end

		result.TextColor3 = textColor
		frame.LayoutOrder = v7.LayoutOrder
		frame.Folder.invite.Visible = v7.InviteVisible

		if v7.InviteText then
			frame.Folder.invite.label.Text = v7.InviteText
		end
	end

	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, scrollingFrame.UIListLayout.AbsoluteContentSize.Y)
end

function PartyWindow:UpdateButtons()
	local partyData = PartyClient.GetPartyData()
	local visible = partyData.Leader == LocalPlayer
	local v6 = partyData.Ready[LocalPlayer.Name] == true
	local v7 = true

	for _, player in partyData.Players do
		if partyData.Ready[player.Name] or player == partyData.Leader then
			continue
		end

		v7 = false
		break
	end

	self.Root.inviteframe.buttons.invitedbig.Visible = not visible
	self.Root.inviteframe.buttons.invitedsmall.Visible = visible
	self.Root.inviteframe.buttons.suggested.Visible = visible
	local currentPlayerListButton = self.CurrentPlayerListButton
	local color2 = Color3.fromRGB(101, 135, 20)
	local color3 = Color3.fromRGB(180, 255, 0)
	local v8 = PartyClient.IsStartPending() and partyData.Matchmaking.State == "Inactive"
	local visible2 = partyData.Matchmaking.State == "Starting" or (partyData.Matchmaking.State == "Searching" or v8)
	local v9

	if partyData.PartyType == "PVP" then
		v9 = #partyData.Players > 2
	else
		v9 = false
	end

	self.Root.inviteframe.Visible = partyData.Matchmaking.State == "Inactive"
	self.Root.inviteframe.buttons.invitedbig.Frame.BackgroundColor3 = currentPlayerListButton == "Invited" and color3
		or color2
	self.Root.inviteframe.buttons.invitedsmall.Frame.BackgroundColor3 = currentPlayerListButton == "Invited"
		and color3
		or color2
	self.Root.inviteframe.buttons.suggested.Frame.BackgroundColor3 = currentPlayerListButton == "Suggested"
		and color3
		or color2
	self.Root.inviteframe.buttons.invitedbig.label.TextColor3 = currentPlayerListButton == "Invited" and color3
		or color2
	self.Root.inviteframe.buttons.invitedsmall.label.TextColor3 = currentPlayerListButton == "Invited" and color3
		or color2
	self.Root.inviteframe.buttons.suggested.label.TextColor3 = currentPlayerListButton == "Suggested" and color3
		or color2
	self.Root.startgame.Visible = not visible2 and not v9 and visible and v7
	self.Root.notready.Visible = not visible2 and not v9 and visible and not v7
	self.Root.ready.Visible = not (visible2 or v9 or visible or v6)
	self.Root.unready.Visible = not visible2 and not v9 and not visible and v6
	self.Root.toomany.Visible = not visible2 and v9
	local cancel = self.Root.cancel
	cancel.Visible = partyData.Matchmaking.State == "Searching" and visible
	self.Root.cancelinfo.Visible = visible2
	local v10 = partyData.Matchmaking.State == "Searching"

	if v8 then
		local count = #partyData.Players
		local v11

		if partyData.PartyType == "Party" or partyData.PartyType == "Matchmaking" and count == 4 then
			v11 = true
		elseif partyData.PartyType == "PVP" then
			v11 = count == 2
		else
			v11 = false
		end

		v10 = not v11
	end

	self.Root.cancelinfo.status.Text = v10 and "Finding a match..." or "Starting..."
	self:UpdateTimer()
	self.Root.leaveparty.Visible = not visible2
	local changemap = self.Root.mapframe.changemap

	if visible then
		if partyData.Matchmaking.State == "Inactive" then
			visible = partyData.PartyType ~= "PVP"
		else
			visible = false
		end
	end

	changemap.Visible = visible
	self.TopBarTabs:SetSelectedTab(partyData.PartyType)
end

function PartyWindow:UpdateTimer()
	local partyData = PartyClient.GetPartyData()
	local v6 = partyData.Matchmaking.State == "Inactive" and 0
		or math.max(workspace:GetServerTimeNow() - partyData.Matchmaking.Timestamp, 0)
	self.Root.cancelinfo.timer.Text = `{string.format("%.2d", v6 // 60)}:{string.format("%.2d", v6 % 60)}`
end

function PartyWindow:UpdateMap()
	local partyData = PartyClient.GetPartyData()
	local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(partyData.Map)
	local v6 = MapData[partyData.Map]

	if lobbyTypeData then
		self.Root.mapframe.mapname.Text = lobbyTypeData.DisplayName
		self.Root.mapframe.mapdiff.Text = lobbyTypeData.MapName
		self.Root.mapframe.mapicon.Image = lobbyTypeData.MapIcon
		self.Root.mapframe.mapicon.random.Visible = false
	elseif v6 then
		self.Root.mapframe.mapname.Text = v6.DisplayName or partyData.Map
		self.Root.mapframe.mapdiff.Text = v6.Difficulty
		self.Root.mapframe.mapicon.Image = v6.Image
		self.Root.mapframe.mapicon.random.Visible = false
	elseif v[partyData.Map] then
		self.Root.mapframe.mapicon.random.Visible = true
		self.Root.mapframe.mapname.Text = "Random"
		self.Root.mapframe.mapdiff.Text = string.sub(partyData.Map, 7)
		self.Root.mapframe.mapicon.Image = v[partyData.Map].Banner
	end
end

function PartyWindow:UpdateTopFrame()
	local partyData = PartyClient.GetPartyData()
	local topframe = self.Root.topframe
	local v6 = partyData.MaxPlayers - #partyData.Players

	if partyData.PartyType == "Matchmaking" then
		topframe.info.Text = `We will match you with {v6} other player{v6 > 1 and "s" or ""} of similar skill level`
	elseif partyData.PartyType == "Party" then
		topframe.info.Text = "Play with only the people you invite to your party"
	elseif partyData.PartyType == "PVP" then
		topframe.info.Text = "Play 1v1 against another player"
	else
		topframe.info.Text = ""
	end
end

function PartyWindow:UpdatePlayerList()
	local partyData = PartyClient.GetPartyData()
	local v6 = partyData.Leader == LocalPlayer

	for _, frame in self.Root.players:GetChildren() do
		if frame:IsA("Frame") and frame.Name ~= "template" then
			frame:Destroy()
		end
	end

	for _, voiceUpdateConnection in self.VoiceUpdateConnections do
		voiceUpdateConnection:Disconnect()
	end

	table.clear(self.VoiceUpdateConnections)

	for _, v7 in Players:GetPlayers() do
		local index

		if partyData == nil or partyData.Players == nil then
			index = false
		else
			index = table.find(partyData.Players, v7)
		end

		local audioEmitter = v7.Character and v7.Character:FindFirstAncestorOfClass("AudioEmitter")

		if not audioEmitter then
			continue
		end

		local wire = audioEmitter:FindFirstChildOfClass("Wire")

		if not wire then
			continue
		end

		if index then
			audioEmitter = audioDeviceOutput or audioEmitter
		end

		if wire.TargetInstance ~= audioEmitter then
			wire.TargetInstance = audioEmitter
		end
	end

	local v7 = partyData.Matchmaking.State == "Searching" or partyData.Matchmaking.State == "Starting"

	for _, player in partyData.Players do
		local clone = self.Root.players.template:Clone()
		clone.Visible = true
		clone.Name = player.Name
		clone.user.namestack.username.Text = player.Name
		clone.user.ready.Visible = partyData.Ready[player.Name] or v7 or false
		clone.user.level.Text = "LVL ?"

		if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Level") then
			clone.user.level.Text = "LVL " .. player.leaderstats.Level.Value
		end

		clone.user.leader.Visible = partyData.Leader == player
		clone.icon.Image = "http://www.roblox.com/thumbs/avatar.ashx?x=352&y=352&format=png&username=" .. player.Name
		clone.actions.kick.Visible = v6 and player ~= LocalPlayer
		clone.actions.leader.Visible = v6 and player ~= LocalPlayer

		if v6 and player ~= LocalPlayer then
			local v8 = player
			clone.actions.kick.MouseButton1Click:Connect(function()
				clone.actions.Visible = false
				PartyClient.KickPlayer(v8)
			end)
			local v9 = player
			clone.actions.leader.MouseButton1Click:Connect(function()
				clone.actions.Visible = false
				PartyClient.ChangeLeader(v9)
			end)
		end

		local v8 = player
		clone.actions.loadout.MouseButton1Click:Connect(function()
			clone.actions.Visible = false
			self:Minimise()

			for _, v9 in Director.GetItemsFromClass(Director.Classes.LoadoutWindow) do
				v9.Root.Visible = true
				v9:Update(v8)
			end
		end)
		clone.TextButton.MouseButton1Click:Connect(function()
			clone.actions.Visible = not clone.actions.Visible
		end)
		clone.TextButton.MouseEnter:Connect(function()
			if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
				return
			end

			clone.actions.Visible = true
		end)
		clone.TextButton.MouseLeave:Connect(function()
			if UserInputService:GetLastInputType() == Enum.UserInputType.Touch then
				return
			end

			clone.actions.Visible = false
		end)
		local audioDeviceInput = player:FindFirstChild("AudioDeviceInput")

		if audioDeviceInput then
			clone.user.namestack.micopen.Visible = audioDeviceInput.Active
			clone.user.namestack.micmuted.Visible = not audioDeviceInput.Active
			table.insert(
				self.VoiceUpdateConnections,
				audioDeviceInput:GetPropertyChangedSignal("Active"):Connect(function()
					self:UpdatePlayerList()
				end)
			)
		else
			clone.user.namestack.micopen.Visible = false
			clone.user.namestack.micmuted.Visible = false
		end

		clone.Parent = self.Root.players
	end
end

function PartyWindow:Minimise()
	self.Root.Visible = false
	local partyData = PartyClient.GetPartyData()

	if
		partyData
		and partyData.Leader == LocalPlayer
		and #partyData.Players == 1
		and partyData.Matchmaking.State == "Inactive"
	then
		PartyClient.CloseParty()
	end

	for _, v6 in Director.GetItemsFromClass(Director.Classes.PartyMinimised) do
		v6:Maximise()
	end
end

function PartyWindow:Maximise()
	self.Root.Visible = true
end

function PartyWindow:Close()
	self.Root.Visible = false
end

function PartyWindow:Destroy()
	self:ClearPlayerInviteList()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { PartyWindow }, game.Players)
return PartyWindow