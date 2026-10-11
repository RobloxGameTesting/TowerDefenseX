local RefreshSystem = {}
RefreshSystem.__index = RefreshSystem
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = ReplicatedStorage.Shared
local Libraries = Shared.Libraries
local Common = Shared.Common
local Utils = require(Common:WaitForChild("Utils"))
local SyncedTime = require(Libraries:WaitForChild("SyncedTime"))
SyncedTime.init()

function RefreshSystem.New(name, refreshTime, maxAvailableItems, allowDuplicates)
	local v = {
		Name = name,
		RefreshTime = refreshTime,
		AllowDuplicates = allowDuplicates,
		CurrentKey = nil,
		CurrentRNG = nil,
		PastCompletedRefreshes = {},
		MaxAvailableItems = maxAvailableItems
	}
	setmetatable(v, RefreshSystem)
	v.CurrentKey = v:GetCurrentTimeKey()
	v.PastCompletedRefreshes[v.CurrentKey] = true
	v.CurrentRNG = Random.new(v.CurrentKey)
	return v
end

function RefreshSystem:GetCurrentTimeKey()
	return (math.floor(SyncedTime.time() / self.RefreshTime))
end

function RefreshSystem:UpdateOnHeartbeat(p, p2)
	local currentTimeKey = self:GetCurrentTimeKey()

	if self.PastCompletedRefreshes[currentTimeKey] then
		return nil
	end

	self.PastCompletedRefreshes[currentTimeKey] = true
	self.CurrentRNG = Random.new(currentTimeKey)
	return (self:GenerateNewItems(p, p2))
end

function RefreshSystem:GenerateNewItems(p, p2)
	local selected

	if self.AllowDuplicates then
		selected = self:GenerateItemsWithDuplicates(p, p2)
	else
		selected = self:GenerateItemsNoDuplicates(p, p2)
	end

	print(selected)
	return selected
end

function RefreshSystem:GenerateItemsWithDuplicates(p, p2)
	local v = math.floor(self.MaxAvailableItems * 0.6)
	local result = {}

	for _ = 0, self.CurrentRNG:NextInteger(v, self.MaxAvailableItems) do
		local v2 = p[Utils.GetRandomWeightedItem(p, p2, self.CurrentRNG)]
		local v3 = v2[self.CurrentRNG:NextInteger(1, #v2)]

		if not result[v3.Name] then
			result[v3.Name] = 0
		end

		local name = v3.Name
		result[name] += 1
	end

	return result
end

function RefreshSystem:GenerateItemsNoDuplicates(p, p2)
	local copy = Utils.DeepCopy(p)
	local maxAvailableItems = self.MaxAvailableItems
	local count = 0
	local v = {}
	local v2 = {}

	for k, v3 in pairs(copy) do
		for _ in pairs(v3) do
			count += 1
			v[k] = (v[k] or 0) + 1
		end
	end

	if count < maxAvailableItems then
		error(`Not enough shops to generate minimum number of shops required. Num to generate: {maxAvailableItems}. Total Item Count: {count}`)
		return
	end

	local function SelectRandomItem()
		local v3 = nil

		while not v3 do
			v3 = Utils.GetRandomWeightedItem(copy, p2, self.CurrentRNG)

			if (v[v3] or 0) <= 0 then
				v3 = nil
			end
		end

		local v4 = copy[v3]
		local integer = self.CurrentRNG:NextInteger(1, #v4)
		local v5 = v4[integer]
		v[v3] -= 1
		table.remove(v4, integer)
		table.insert(v2, v5)
	end

	for _ = 1, maxAvailableItems do
		SelectRandomItem()
	end

	return v2
end

return RefreshSystem