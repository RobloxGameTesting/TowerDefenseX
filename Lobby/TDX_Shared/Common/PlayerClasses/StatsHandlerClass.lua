local StatsHandlerClass = {}
StatsHandlerClass.__index = StatsHandlerClass
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
require(common:WaitForChild("ResourceManager"))
local isServer = RunService:IsServer()
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = {}
local v7 = nil
local maximumTowerCountPerPlayer = 0

function StatsHandlerClass.New(playerName: string)
	local v8 = {
		Cash = 0,
		TowerCount = 0,
		TowerCountMap = {},
		Damage = 0,
		Kills = 0,
		PowerUps = {},
		CashChanged = true,
		TowerCountChanged = true,
		DamageChanged = true,
		KillsChanged = true,
		PowerUpsChanged = true,
		StartingCashGiven = false,
		PlayerName = playerName,
		LastReplicationTime = 0
	}
	table.insert(v6, (setmetatable(v8, StatsHandlerClass)))

	if not isServer and playerName == Players.LocalPlayer.Name then
		v7 = v8
	end

	return v8
end

function StatsHandlerClass:Replicate(flag: boolean?)
	if not isServer then
		error("Stats replication should only be performed on server")
	end

	if flag or os.clock() - self.LastReplicationTime > 0.0001 then
		self.LastReplicationTime = os.clock()
		local child = Players:FindFirstChild(self.PlayerName)

		if child then
			if flag or self.CashChanged then
				self.CashChanged = false
				v:FireTo(child, self.Cash)
			end

			if flag or self.TowerCountChanged then
				self.TowerCountChanged = false
				v2:FireTo(child, self.TowerCount)
			end

			if flag or self.DamageChanged then
				self.DamageChanged = false
				v3:FireTo(child, self.Damage)
			end

			if flag or self.KillsChanged then
				self.KillsChanged = false
				v4:FireTo(child, self.Kills)
			end

			if flag or self.PowerUpsChanged then
				self.PowerUpsChanged = false
				v5:FireTo(child, self.PowerUps)
			end
		end
	end
end

function StatsHandlerClass.IsStartingCashGiven(p)
	return p.StartingCashGiven
end

function StatsHandlerClass:SetStartingCashGiven(startingCashGiven)
	self.StartingCashGiven = startingCashGiven
end

function StatsHandlerClass.GetCash(p)
	return p.Cash
end

function StatsHandlerClass:SetCash(cash: number)
	self.Cash = cash
	self.CashChanged = true
end

function StatsHandlerClass:GiveCash(p: number)
	self.Cash += p
	self.CashChanged = true
end

function StatsHandlerClass:SpendCash(p: number)
	self.Cash -= p
	self.CashChanged = true
end

function StatsHandlerClass.HasCash(p, p2: number)
	return p2 <= p.Cash
end

function StatsHandlerClass:TowerAdded(p: string)
	if isServer then
		self.TowerCount += 1
		self.TowerCountChanged = true
	end

	if not self.TowerCountMap[p] then
		self.TowerCountMap[p] = 0
	end

	self.TowerCountMap[p] += 1
end

function StatsHandlerClass:TowerRemoved(p: string)
	if isServer then
		self.TowerCount -= 1
		self.TowerCountChanged = true
	end

	self.TowerCountMap[p] -= 1
end

function StatsHandlerClass.GetTowerTypeCount(p, p2: string)
	return p.TowerCountMap[p2] or 0
end

function StatsHandlerClass.GetMaxTowerCount(_)
	if isServer then
		warn("StatsHandlerClass:GetMaxTowerCount() should not be called on the server!")
	end

	return maximumTowerCountPerPlayer
end

function StatsHandlerClass.MaxTowersReached(p)
	if isServer then
		warn("StatsHandlerClass:MaxTowersReached() should not be called on the server!")
	end

	local towerCount = p.TowerCount
	return maximumTowerCountPerPlayer <= towerCount
end

function StatsHandlerClass:IncreaseDamage(p: number)
	self.Damage += p
	self.DamageChanged = true
end

function StatsHandlerClass:IncrementKills()
	self.Kills += 1
	self.KillsChanged = true
end

function StatsHandlerClass:PowerUpUsed(p: string, value: number?)
	if not isServer then
		error("StatsHandlerClass:PowerUpUsed() is not allowed on the client!")
	end

	if not self.PowerUps[p] then
		self.PowerUps[p] = { NumUsed = 0, LastUsedTime = 0 }
	end

	self.PowerUps[p].NumUsed += 1
	self.PowerUps[p].LastUsedTime = value or 0
	self.PowerUpsChanged = true
end

function StatsHandlerClass.GetPowerUpStats(p, p2: string)
	return p.PowerUps[p2]
end

function StatsHandlerClass:SetPowerUpStatsFromRewindData(powerUps)
	self.PowerUps = powerUps
	self.PowerUpsChanged = true
end

function StatsHandlerClass.GetPowerUpsStatsRewindData(p)
	return Utilities.DeepCopyTable(p.PowerUps)
end

function StatsHandlerClass:ResetPowerUpStats()
	self.PowerUps = {}
	self.PowerUpsChanged = true
end

if isServer then
	v = NetworkingHandler.CreateRemoteEvent("UpdateCash", true)
	v2 = NetworkingHandler.CreateRemoteEvent("UpdateTowerCount", true)
	v3 = NetworkingHandler.CreateRemoteEvent("UpdateDamage", true)
	v4 = NetworkingHandler.CreateRemoteEvent("UpdateKills", true)
	v5 = NetworkingHandler.CreateRemoteEvent("UpdatePowerUpStats", true)

	function StatsHandlerClass.ServerReplicate()
		if not isServer then
			error("Stats replication should only be performed on server")
		end

		for _, v8 in pairs(v6) do
			v8:Replicate()
		end
	end
else
	function StatsHandlerClass.ClientInitialize()
		local event = BindableHandler.GetEvent("CashChanged")
		local event2 = BindableHandler.GetEvent("TowerCountChanged")
		local event3 = BindableHandler.GetEvent("PowerUpStatsChanged")
		local event4 = BindableHandler.GetEvent("InfoHandlerReady")
		NetworkingHandler.GetEvent("UpdateCash"):AttachCallback(function(cash: number)
			v7.Cash = cash
			event:Fire(cash)
		end)
		NetworkingHandler.GetEvent("UpdateTowerCount"):AttachCallback(function(towerCount: number)
			v7.TowerCount = towerCount
			event2:Fire(towerCount, maximumTowerCountPerPlayer)
		end)
		NetworkingHandler.GetEvent("UpdateDamage"):AttachCallback(function(damage: number)
			v7.Damage = damage
		end)
		NetworkingHandler.GetEvent("UpdateKills"):AttachCallback(function(kills: number)
			v7.Kills = kills
		end)
		NetworkingHandler.GetEvent("UpdatePowerUpStats"):AttachCallback(function(powerUps)
			v7.PowerUps = powerUps
			event3:Fire(powerUps)
		end)
		event4:AttachCallback(function()
			event:Fire(v7.Cash)
			event2:Fire(v7.TowerCount, maximumTowerCountPerPlayer)
		end)
		local localPlayer = Players.LocalPlayer
		maximumTowerCountPerPlayer = localPlayer:GetAttribute("MaximumTowerCountPerPlayer") or 0
		localPlayer:GetAttributeChangedSignal("MaximumTowerCountPerPlayer"):Connect(function()
			maximumTowerCountPerPlayer = localPlayer:GetAttribute("MaximumTowerCountPerPlayer") or 0
			event2:Fire(v7.TowerCount, maximumTowerCountPerPlayer)
		end)
	end
end

return StatsHandlerClass