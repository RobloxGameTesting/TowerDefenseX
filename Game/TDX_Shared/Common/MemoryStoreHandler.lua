local MemoryStoreHandler = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemoryStoreService = game:GetService("MemoryStoreService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local isStudio = RunService:IsStudio()
local JobId = game.JobId
local isCoreGame = workspace:GetAttribute("IsCoreGame")
workspace:GetAttribute("IsLobby")
local v = { [Enums.GameStates.EndScreen] = true }
local success, result = pcall(function()
	return MemoryStoreService:GetSortedMap("GameStatus")
end)
local success2, result2 = pcall(function()
	return MemoryStoreService:GetSortedMap("PlayerStatus")
end)
local success3, result3 = pcall(function()
	return MemoryStoreService:GetSortedMap("SpectatorStatus")
end)
local v2 = 0
local v3 = {}
local v4 = false

local function GetUserIdKey(p: number) -- 2 equivalent calls inferred from this helper
	return "Status_" .. tostring(p)
end

local function GetPlayerKey(p)
	return GetUserIdKey(p.UserId) -- inferred equivalent call
end

local function GetSpectatorKey(p: number) -- 2 equivalent calls inferred from this helper
	return "Spectate_" .. tostring(p)
end

local function CoreGame_UpdateGameStatus(gameState: string, map: string, mode: string, wave: number, reservedServerAccessCode: string)
	if v4 or isStudio then
		return
	end

	local v5 = {
		GameState = gameState,
		Map = map,
		Mode = mode,
		Wave = wave,
		ReservedServerAccessCode = reservedServerAccessCode
	}
	local success4, result4 = pcall(function()
		if success then
			result:SetAsync(JobId, v5, 45)
		end
	end)

	if not success4 then
		warn("Memorystore: Failed to update game status: " .. result4)
	end
end

local function CoreGame_UpdatePlayerStatus(p: string)
	if v4 or isStudio then
		return
	end

	local v5 = { LastGameJobId = JobId }
	local success4, result4 = pcall(function()
		if success2 then
			result2:SetAsync(p, v5, 600)
		end
	end)

	if not success4 then
		warn("Memorystore: Failed to update player status: " .. result4)
	end
end

local function CoreGame_RemoveGameStatus() -- 1 equivalent call inferred from this helper
	local success4, result4 = pcall(function()
		if success then
			result:RemoveAsync(JobId)
		end
	end)

	if not success4 then
		warn("Memorystore: Failed to remove game status: " .. result4)
	end
end

local function CoreGame_ShuttingDown()
	v4 = true
	CoreGame_RemoveGameStatus() -- inferred equivalent call
end

function MemoryStoreHandler.CoreGame_Run(p: number, p2: string, p3: string, p4: string, p5: number, items, p6: string)
	v2 -= p

	if v2 <= 0 then
		task.spawn(CoreGame_UpdateGameStatus, p2, p3, p4, p5, p6)
		v2 = 15
	end

	for _, item in pairs(items) do
		local v5 = "Status_" .. tostring(item.UserId)
		local v6 = (v3[v5] or 0) - p

		if v6 <= 0 then
			task.spawn(CoreGame_UpdatePlayerStatus, v5)
			v6 = 60
		end

		v3[v5] = v6
	end
end

function MemoryStoreHandler.CoreGame_GameStateChanged(p: string, p2: string, p3: string, p4: number, _, p5: string)
	task.spawn(CoreGame_UpdateGameStatus, p, p2, p3, p4, p5)
	v2 = 15
end

if isCoreGame then
	game:BindToClose(CoreGame_ShuttingDown)
end

function MemoryStoreHandler.Lobby_TryGetPlayerLastGameDataAsync(p)
	return MemoryStoreHandler.Lobby_TryGetLastGameDataForUserIdAsync(p.UserId)
end

function MemoryStoreHandler.Lobby_TryGetLastGameDataForUserIdAsync(p: number)
	local userIdKey = GetUserIdKey(p) -- inferred equivalent call
	local async = nil
	local success4, result4 = pcall(function()
		async = result2:GetAsync(userIdKey)
	end)

	if not success4 then
		warn("Memorystore: Failed to get player status for " .. userIdKey .. ": " .. result4)
		return
	end

	if not async then
		return
	end

	local lastGameJobId = async.LastGameJobId

	if not lastGameJobId then
		return
	end

	local async2 = nil
	local success5, result5 = pcall(function()
		async2 = result:GetAsync(lastGameJobId)
	end)

	if not success5 then
		warn("Memorystore: Failed to get game status for " .. lastGameJobId .. ": " .. result5)
		return
	end

	if not async2 then
		return
	end

	local gameState = async2.GameState

	if not gameState then
		return
	end

	if v[gameState] then
		return
	else
		return lastGameJobId, async2
	end
end

function MemoryStoreHandler.Lobby_MarkSpectatorAsync(p: number, p2: string)
	local success4, result4 = pcall(function()
		if success3 then
			result3:SetAsync(GetSpectatorKey(p), p2, 120) -- inferred equivalent call
		end
	end)

	if not success4 then
		warn("Memorystore: Failed to set spectator status: " .. result4)
	end

	return success4
end

function MemoryStoreHandler.CoreGame_GetSpectatorTargetJobIdAsync(p: number)
	local async = nil
	local success4, result4 = pcall(function()
		if success3 then
			async = result3:GetAsync(GetSpectatorKey(p)) -- inferred equivalent call
		end
	end)

	if success4 then
		return async
	end

	warn("Memorystore: Failed to get spectator status: " .. result4)
	return nil
end

function MemoryStoreHandler.Lobby_ClearPlayerStatus(p)
	local v5 = "Status_" .. tostring(p.UserId)
	local success4, result4 = pcall(function()
		result2:RemoveAsync(v5)
	end)

	if not success4 then
		warn("Memorystore: Failed to remove player status: " .. result4)
	end
end

if JobId and JobId ~= "" then
	return MemoryStoreHandler
end

math.randomseed(os.time())
JobId = "test_key" .. math.random(1, 1000000)

if not isStudio then
	warn("JOB_ID was nil or empty, overriding to " .. JobId)
end

return MemoryStoreHandler