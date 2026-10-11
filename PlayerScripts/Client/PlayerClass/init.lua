local PlayerClass = {}
PlayerClass.__index = PlayerClass
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local PlayerWrapperUtilities = require(common:WaitForChild("PlayerWrapperUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local playerClasses = common:WaitForChild("PlayerClasses")
local StatsHandlerClass = require(playerClasses:WaitForChild("StatsHandlerClass"))
local UpgradeShopDataHandlerClass = require(script:WaitForChild("UpgradeShopDataHandlerClass"))
local event = NetworkingHandler.GetEvent("NewPlayerWrapper")
local event2 = NetworkingHandler.GetEvent("PlayerWrapperBasicDataUpdate")
local event3 = NetworkingHandler.GetEvent("PlayerInputTypeChanged")
local event4 = NetworkingHandler.GetEvent("UpgradeShopCreditsChanged")
local event5 = NetworkingHandler.GetEvent("UpgradeShopAllDataUpdate")
local event6 = NetworkingHandler.GetEvent("UpgradeShopDataUpdate")
local event7 = NetworkingHandler.GetEvent("UpgradeShopTowerReset")
local event8 = NetworkingHandler.GetEvent("TowerToEquippedCountMapChanged")
local v = NetworkingHandler.GetFunction("RequestTowerToEquippedCountMap")
local event9 = BindableHandler.GetEvent("LocalPlayerWrapperUpdated")
local event10 = BindableHandler.GetEvent("LastInputTypeChanged")
local event11 = BindableHandler.GetEvent("UpgradeShopCreditsChanged")
local event12 = BindableHandler.GetEvent("UpgradeShopChangedForPlayer")
local event13 = BindableHandler.GetEvent("SetDifficulty")
local LocalPlayer = Players.LocalPlayer
local v2 = nil
local v3 = {}
local _ = 1
local v4 = {}
local v5 = nil

local function NewPlayerWrapper(playerWrapperKey: string, basicData, towerToUpgradeTypeToActiveUpgradeData, isLocalPlayer: boolean?)
	local v6 = v3[playerWrapperKey]

	if not v6 then
		v6 = {
			Key = playerWrapperKey,
			IsLocalPlayer = isLocalPlayer,
			Name = nil,
			IsRealPlayer = false,
			Tester = false,
			Admin = false,
			InGroup = false,
			VIP = false,
			SpeedControl = false,
			TesterPanelAccess = false,
			AdminPanelAccess = false,
			UpgradeShopDataHandler = UpgradeShopDataHandlerClass.New(),
			Stats = isLocalPlayer and StatsHandlerClass.New(LocalPlayer.Name),
			LastInputType = Enum.UserInputType.Keyboard
		}
		setmetatable(v6, PlayerClass)
		v3[playerWrapperKey] = v6
	end

	if basicData then
		v6:HandleBasicDataUpdate(basicData)
	end

	if towerToUpgradeTypeToActiveUpgradeData then
		v6.UpgradeShopDataHandler:Initialize(towerToUpgradeTypeToActiveUpgradeData)
		event12:Fire(playerWrapperKey)
	end

	return v6
end

function PlayerClass.GetPlayerWrapper(p: string, flag: boolean?)
	local v6 = v3[p]

	if v6 or not flag then
		return v6
	end

	if p == PlayerWrapperUtilities.GetPlayerWrapperKey(LocalPlayer) then
		warn("PlayerClass.GetPlayerWrapper: Attempted to create local player wrapper through GetPlayerWrapper")
		return
	end

	v6 = v3[p]

	if not v6 then
		v6 = {
			Key = p,
			IsLocalPlayer = false,
			Name = nil,
			IsRealPlayer = false,
			Tester = false,
			Admin = false,
			InGroup = false,
			VIP = false,
			SpeedControl = false,
			TesterPanelAccess = false,
			AdminPanelAccess = false,
			UpgradeShopDataHandler = UpgradeShopDataHandlerClass.New(),
			Stats = false,
			LastInputType = Enum.UserInputType.Keyboard
		}
		setmetatable(v6, PlayerClass)
		v3[p] = v6
	end

	print("Created player wrapper locally for", p)
	return v6
end

function PlayerClass.GetLocalPlayerWrapper()
	return v2
end

function PlayerClass.LocalPlayerIsAdmin()
	return v2 and v2.Admin
end

function PlayerClass.LocalPlayerIsInGroup()
	return v2 and v2.InGroup
end

function PlayerClass.LocalPlayerIsVIP()
	return v2 and v2.VIP
end

function PlayerClass.LocalPlayerHasSpeedControl()
	return v2 and v2.SpeedControl
end

function PlayerClass.LocalPlayerHasTesterPanelAccess()
	return v2 and v2.TesterPanelAccess
end

function PlayerClass.LocalPlayerHasAdminPanelAccess()
	return v2 and v2.AdminPanelAccess
end

function PlayerClass.GetHighestPlayerCount()
	return workspace:GetAttribute("PlayerCount") or 1
end

function PlayerClass.GetUpgradeShopDataHandler(p)
	return p.UpgradeShopDataHandler
end

function PlayerClass.GetPlayerWrapperKey(p)
	return p.Key
end

function PlayerClass:LastInputTypeChanged(lastInputType)
	if not (Enums.UserInputTypes[lastInputType] and self.LastInputType ~= lastInputType) then
		return
	end

	self.LastInputType = lastInputType
	event3:FireServer(lastInputType)
end

function PlayerClass:HandleBasicDataUpdate(data)
	self.Name = data.Name
	self.IsRealPlayer = data.IsRealPlayer
	self.Tester = data.Tester
	self.Admin = data.Admin
	self.InGroup = data.InGroup
	self.VIP = data.VIP
	self.SpeedControl = data.SpeedControl
	self.TesterPanelAccess = data.TesterPanelAccess
	self.AdminPanelAccess = data.AdminPanelAccess

	if self.IsLocalPlayer then
		LocalPlayer:SetAttribute("VIP", data.VIP)
		event9:Fire()
	end
end

function PlayerClass:HandleUpgradeShopDataUpdate(p: string, p2: string, p3: number)
	self.UpgradeShopDataHandler:DataUpdate(p, p2, p3)
	event12:Fire(self.Key, p, p2)
end

function PlayerClass:HandleUpgradeShopTowerReset(p: string)
	self.UpgradeShopDataHandler:RefundForTower(p)
	event12:Fire(self.Key, p)
end

function PlayerClass:GetTowerTypeLimit(p: string)
	local towerConfig = ResourceManager.GetTowerConfig(p)
	assert(towerConfig, "Tower config not found for type " .. p)
	local limitMap = towerConfig.LimitMap
	local difficultyToLimitMapOverride = v5 and towerConfig.DifficultyToLimitMapOverride

	if difficultyToLimitMapOverride then
		limitMap = difficultyToLimitMapOverride[v5] or limitMap
	end

	if not limitMap then
		return
	end

	local v6 = v4[TeamUtilities.GetLocalPlayerTeamIndex()]
	return limitMap[math.clamp(v6 and v6[p] or 1, 1, #limitMap)]
end

function PlayerClass:TowerTypeLimitReached(p: string)
	local towerTypeLimit = self:GetTowerTypeLimit(p)

	if towerTypeLimit then
		return towerTypeLimit <= self.Stats:GetTowerTypeCount(p)
	end

	return false
end

local playerWrapperKey = PlayerWrapperUtilities.GetPlayerWrapperKey(LocalPlayer)
local v6 = v3[playerWrapperKey]

if not v6 then
	v6 = {
		Key = playerWrapperKey,
		IsLocalPlayer = true,
		Name = nil,
		IsRealPlayer = false,
		Tester = false,
		Admin = false,
		InGroup = false,
		VIP = false,
		SpeedControl = false,
		TesterPanelAccess = false,
		AdminPanelAccess = false,
		UpgradeShopDataHandler = UpgradeShopDataHandlerClass.New(),
		Stats = StatsHandlerClass.New(LocalPlayer.Name),
		LastInputType = Enum.UserInputType.Keyboard
	}
	setmetatable(v6, PlayerClass)
	v3[playerWrapperKey] = v6
end

v2 = v6
StatsHandlerClass.ClientInitialize()
v4 = v:InvokeServer()
event:AttachCallback(function(data, p: number)
	_ = p
	NewPlayerWrapper(data.PlayerWrapperKey, data.BasicData, data.TowerToUpgradeTypeToActiveUpgradeData)
end)
event2:AttachCallback(function(p: string, p2)
	local v7 = v3[p]

	if v7 then
		v7:HandleBasicDataUpdate(p2)
	else
		warn("PlayerWrapperBasicDataUpdateEvent: No player wrapper found")
	end
end)
event10:AttachCallback(function(p)
	if not v2 then
		return
	end

	v2:LastInputTypeChanged(p)
end)
event4:AttachCallback(function(p: number)
	if not v2 then
		warn("UpgradeShopCreditsChangedEvent: No local player wrapper")
		return
	end

	v2.UpgradeShopDataHandler:SetCredits(p)
	event11:Fire(p)
end)
event5:AttachCallback(function(p: string, p2)
	local v7 = v3[p]

	if not v7 then
		warn("UpgradeShopAllDataUpdateEvent: No player wrapper found")
		return
	end

	v7.UpgradeShopDataHandler:Initialize(p2)
	event12:Fire(p)
end)
event6:AttachCallback(function(p: string, p2: string, p3: string, p4: number)
	local v7 = v3[p]

	if v7 then
		v7:HandleUpgradeShopDataUpdate(p2, p3, p4)
	else
		warn("UpgradeShopDataUpdateEvent: No player wrapper found")
	end
end)
event7:AttachCallback(function(p: string, p2: string)
	local v7 = v3[p]

	if v7 then
		v7:HandleUpgradeShopTowerReset(p2)
	else
		warn("UpgradeShopTowerResetEvent: No player wrapper found")
	end
end)
event8:AttachCallback(function(p)
	v4 = p
end)
event13:AttachCallback(function(p: string)
	v5 = p
end)
return PlayerClass