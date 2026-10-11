local MetaServer = { Metadata = nil }
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MemoryStoreService = game:GetService("MemoryStoreService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local metadata = {
	Metadata = {
		Map = _G.DEV_MAP_NAME,
		MapDifficulty = Enums.MapDifficulties.Easy,
		PlayerNameList = nil,
		OverrideExpectedPlayerCount = nil,
		LobbyType = nil
	},
	AccessCode = ""
}
local isStudio = RunService:IsStudio()
local sortedMap = not isStudio and MemoryStoreService:GetSortedMap("MetaServers")
local flag = false
local flag2 = false

function MetaServer.StoreMetadata(accessCode: string, p: string, metadata2)
	local success, result = pcall(function()
		sortedMap:SetAsync(p, { AccessCode = accessCode, Metadata = metadata2 }, 180)
	end)

	if not success then
		warn("MetaServer::StoreMetadata threw an error,", result)
	end
end

function MetaServer.ReserveServerWithData(p: number, metadata2)
	local v = nil
	local success, result = pcall(function()
		local reserveServer, v2 = TeleportService:ReserveServer(p)
		sortedMap:SetAsync(v2, { AccessCode = reserveServer, Metadata = metadata2 }, 180)
		v = reserveServer
	end)

	if success then
		return v
	end

	warn("MetaServer::ReserveServerWithData threw an error,", result)
	return false
end

function MetaServer.GetServerMetadata()
	if isStudio or (game.PrivateServerId == "" or game.PrivateServerOwnerId ~= 0) then
		return metadata
	end

	if flag2 then
		return MetaServer.Metadata
	end

	if flag then
		repeat
			task.wait(0.5)
		until not flag

		return MetaServer.Metadata
	else
		flag = true
		local v = 3

		while v > 0 and not pcall(function()
			MetaServer.Metadata = sortedMap:GetAsync(game.PrivateServerId)
		end) do
			v -= 1
			task.wait(1)
		end

		flag2 = true
		flag = false

		if not MetaServer.Metadata then
			MetaServer.Metadata = metadata
		end

		return MetaServer.Metadata
	end
end

return MetaServer