local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local orderedDataStore = DataStoreService:GetOrderedDataStore("CheatGames")
local orderedDataStore2 = DataStoreService:GetOrderedDataStore("CheatRemotesFired")
local nameFromUserIdAsyncs = {}

local function GetNameFromUserId(key)
	if tonumber(key) and tonumber(key) < 0 then
		return "_TEST_" .. tostring((math.abs(key)))
	end

	local v = nameFromUserIdAsyncs[key]

	if v then
		return v
	end

	local nameFromUserIdAsync = nil
	local success, _ = pcall(function()
		nameFromUserIdAsync = Players:GetNameFromUserIdAsync(key)
	end)

	if not success then
		return "Loading..."
	end

	nameFromUserIdAsyncs[key] = nameFromUserIdAsync
	return nameFromUserIdAsync
end

local function DisplayPage(sortedAsync, _: number?)
	local currentPage = sortedAsync:GetCurrentPage()

	for i, v in ipairs(currentPage) do
		local key = v.key
		local nameFromUserId = GetNameFromUserId(key)
		local value = v.value
		print(`#{string.format("%03d", i)} - {nameFromUserId} ({key}): {value}`)
	end
end

local sortedAsync = orderedDataStore:GetSortedAsync(false, 100)
local sortedAsync2 = orderedDataStore2:GetSortedAsync(false, 100)
print("Cheat Games Leaderboard:")
DisplayPage(sortedAsync)
print("----------------------------")
print("Cheat Remotes Fired Leaderboard:")
DisplayPage(sortedAsync2)