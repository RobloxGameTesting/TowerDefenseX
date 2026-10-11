local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local Signal = require(ReplicatedStorage.TDX_Shared.Modules.Signal)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local LobbyTypeUtilities = require(ReplicatedStorage.TDX_Shared.Common.LobbyTypeUtilities)
local LocalPlayer = Players.LocalPlayer
local v = {
	Id = "N/A",
	Leader = 0,
	MaxPlayers = 4,
	PartyType = "Matchmaking",
	Players = 0,
	Ready = 0,
	Map = 0,
	Invited = 0,
	Matchmaking = 0
}
v.Leader = LocalPlayer
v.Players = { LocalPlayer }
v.Ready = { [LocalPlayer.Name] = false }
v.Map = LobbyTypeUtilities.LOBBY_TYPES.Easter26Part2
v.Invited = {}
v.Matchmaking = { State = "Inactive", Timestamp = workspace:GetServerTimeNow() }
local flag = false
local count = 0
local PartyClient = {
	PartyDataChanged = Signal.new(),
	PartyKickNotification = Signal.new(),
	GetPartyData = function()
		return v
	end,
	IsStartPending = function()
		return flag
	end,
	ChangeMaxPlayers = function(p: number)
		Network.Fire("ClientChangePartyMaxPlayersRequest", p)
	end,
	LeaveParty = function()
		Network.Fire("ClientLeavePartyRequest")
	end,
	CloseParty = function()
		Network.Fire("ClientClosePartyRequest")
	end
}

function PartyClient.StartGame()
	if flag then
		return
	end

	flag = true
	count += 1
	local v2 = count
	Network.Fire("ClientStartGameRequest")
	task.delay(5, function()
		if flag and count == v2 then
			flag = false
			PartyClient.PartyDataChanged:Fire(v)
		end
	end)
end

function PartyClient.SetReadyState(flag2: boolean)
	Network.Fire("ClientSetPartyReadyStateRequest", flag2)
end

function PartyClient.StopMatchmaking()
	Network.Fire("ClientStopMatchmakingRequest")
end

function PartyClient.ChangePartyType(p: string)
	Network.Fire("ClientChangePartyTypeRequest", p)
end

function PartyClient.ChangeMap(p: string)
	Network.Fire("ClientChangePartyMapRequest", p)
end

function PartyClient.InvitePlayer(p)
	Network.Fire("ClientInviteToPartyRequest", p)
end

function PartyClient.KickPlayer(p)
	Network.Fire("ClientKickPartyMemberRequest", p)
end

function PartyClient.ChangeLeader(p)
	Network.Fire("ClientChangePartyLeaderRequest", p)
end

Network.HookEvent("PartyDataUpdate", function(p)
	v = p
	flag = false
	PartyClient.PartyDataChanged:Fire(v)
end)
Network.HookEvent("PartyKickNotification", function()
	PartyClient.PartyKickNotification:Fire()
end)
return PartyClient