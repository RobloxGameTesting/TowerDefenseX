local TeamUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Utilities"))
local isServer = RunService:IsServer()
local PVP_TEAM_NAMES = _G.PVP_TEAM_NAMES
local PVP_TEAM_COLORS = _G.PVP_TEAM_COLORS
local SPECTATOR_TEAM_NAME = _G.SPECTATOR_TEAM_NAME
local SPECTATOR_TEAM_COLOR = _G.SPECTATOR_TEAM_COLOR
local v = {}
local v2 = nil

function TeamUtilities:AssignTeam(pvpTeamIndex: number)
	if not isServer then
		return
	end

	local team = v[pvpTeamIndex]

	if not team then
		team = Instance.new("Team")
		team.Name = PVP_TEAM_NAMES[pvpTeamIndex]
		team.TeamColor = BrickColor.new(PVP_TEAM_COLORS[pvpTeamIndex])
		team.AutoAssignable = false
		team.Parent = Teams
		v[pvpTeamIndex] = team
	end

	self.Team = team
	self:SetAttribute("PVPTeamIndex", pvpTeamIndex)
end

function TeamUtilities:AssignSpectatorTeam()
	if not isServer then
		return
	end

	local team = v2

	if not team then
		team = Instance.new("Team")
		team.Name = SPECTATOR_TEAM_NAME
		team.TeamColor = BrickColor.new(SPECTATOR_TEAM_COLOR)
		team.AutoAssignable = false
		team.Parent = Teams
		v2 = team
	end

	self.Team = team
end

function TeamUtilities.PlayerLeft(p)
	if not isServer or not v2 or p.Team ~= v2 then
		return
	end

	for _, v3 in v2:GetPlayers() do
		if v3 ~= p then
			return
		end
	end

	v2:Destroy()
	v2 = nil
end

function TeamUtilities.GetLocalPlayerTeamIndex()
	if isServer then
		warn("GetLocalPlayerTeamIndex should not be called on the server")
		return 1
	end

	local localPlayer = Players.LocalPlayer

	if localPlayer then
		return localPlayer:GetAttribute("PVPTeamIndex") or 1
	end

	warn("LocalPlayer not found")
	return 1
end

function TeamUtilities.GetTeamColor(p: number)
	local v3 = PVP_TEAM_COLORS[p]

	if v3 then
		return BrickColor.new(v3)
	end

	warn("Invalid PVPTeamIndex: " .. tostring(p))
	return BrickColor.new("White")
end

return TeamUtilities