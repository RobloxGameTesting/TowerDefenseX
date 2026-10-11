local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PartyClient = require(ReplicatedFirst.Client.PartyClient)
local MapData = require(ReplicatedStorage.TDX_Shared.Common.MapData)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local LobbyTypeUtilities = require(ReplicatedStorage.TDX_Shared.Common.LobbyTypeUtilities)
local LocalPlayer = Players.LocalPlayer
local PartyMinimised = { ClassName = script.Name, ClassModule = script }
PartyMinimised.__index = PartyMinimised

function PartyMinimised.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, PartyMinimised))
end

function PartyMinimised:Init()
	self.Cleaner:Add(self.Root.Close.MouseButton1Click:Connect(function()
		self.Root.confirmation.Visible = true
	end))
	self.Cleaner:Add(self.Root.confirmation.cancel.MouseButton1Click:Connect(function()
		self.Root.confirmation.Visible = false
	end))
	self.Cleaner:Add(self.Root.confirmation.leave.MouseButton1Click:Connect(function()
		PartyClient.LeaveParty()
		self.Root.Visible = false
	end))
	self.Cleaner:Add(PartyClient.PartyDataChanged:Connect(function()
		self:Update()
	end))
	self.Cleaner:Add(self.Root.back.MouseButton1Click:Connect(function()
		self.Root.Visible = false

		for _, v in Director.GetItemsFromClass(Director.Classes.PartyWindow) do
			v:Maximise()
		end
	end))
	self.Cleaner:Add(self.Root.back.MouseEnter:Connect(function()
		local partyData = PartyClient.GetPartyData()

		if partyData.Matchmaking.State ~= "Searching" and partyData.Matchmaking.State ~= "Starting" then
			self.Root.BackgroundTransparency = 0
		end
	end))
	self.Cleaner:Add(self.Root.back.MouseLeave:Connect(function()
		local partyData = PartyClient.GetPartyData()

		if partyData.Matchmaking.State ~= "Searching" and partyData.Matchmaking.State ~= "Starting" then
			self.Root.BackgroundTransparency = 0.5
		end
	end))
	self.Cleaner:Add(self.Root.ready.MouseButton1Click:Connect(function()
		PartyClient.SetReadyState(true)
	end))
	self.Cleaner:Add(self.Root.unready.MouseButton1Click:Connect(function()
		PartyClient.SetReadyState(false)
	end))
	self.Cleaner:Add(self.Root.partyready.MouseButton1Click:Connect(function()
		PartyClient.StartGame()
	end))
	self:Update()
end

function PartyMinimised:Update()
	local partyData = PartyClient.GetPartyData()
	local v = partyData.Leader == LocalPlayer
	local v2 = true

	for _, player in partyData.Players do
		if partyData.Ready[player.Name] or player == partyData.Leader then
			continue
		end

		v2 = false
		break
	end

	local difficulty = nil
	local map = partyData.Map
	local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(map)

	if lobbyTypeData then
		map = lobbyTypeData.MapName
	elseif string.sub(map, 1, 6) == "Random" then
		difficulty = string.sub(map, 7)
		map = "Random"
	else
		difficulty = MapData[map].Difficulty
	end

	local visible2 = partyData.Matchmaking.State == "Searching" or partyData.Matchmaking.State == "Starting"
	self.Root.Close.Visible = not visible2
	self.Root.ready.Visible = not (visible2 or v or partyData.Ready[LocalPlayer.Name])
	self.Root.unready.Visible = not visible2 and not v and partyData.Ready[LocalPlayer.Name]
	self.Root.partyready.Visible = not visible2 and v and v2
	self.Root.partynotready.Visible = not visible2 and v and not v2
	self.Root.BackgroundTransparency = visible2 and 0 or 0.5
	self.Root.BackgroundColor3 = visible2 and Color3.fromHex("3F5211") or Color3.new(0, 0, 0)
	self.Root.UIStroke.Color = visible2 and Color3.fromHex("B4FF00") or Color3.new(1, 1, 1)
	self.Root.activestate.Visible = visible2
	self.Root.activestate.Text = partyData.Matchmaking.State == "Searching" and "Finding a match..." or "Starting..."
	self.Root.stack.mainframe.partytype.Text = partyData.PartyType == "Party" and "PARTY" or "MATCHMAKING"
	self.Root.stack.mainframe.info.Text = `{#partyData.Players} member{#partyData.Players > 1 and "s" or ""}`

	if lobbyTypeData then
		self.Root.stack.mapdiff.info.Text = `{lobbyTypeData.DisplayName}`
	else
		self.Root.stack.mapdiff.info.Text = `{map} - {difficulty}`
	end

	local firstItem = Director.GetFirstItemFromClass(Director.Classes.PartyWindow)
	local visible = firstItem and firstItem.Root.Visible or false

	if partyData.Matchmaking.State ~= "Inactive" and not visible then
		self:Maximise()
	elseif #partyData.Players <= 1 and not visible2 then
		self.Root.Visible = false
	end
end

function PartyMinimised:Maximise()
	local partyData = PartyClient.GetPartyData()
	local v = partyData and partyData.Matchmaking.State ~= "Inactive"

	if partyData and (#partyData.Players > 1 or v) then
		self.Root.Visible = true
		self.Root.confirmation.Visible = false
	end
end

function PartyMinimised.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { PartyMinimised }, LocalPlayer)
return PartyMinimised