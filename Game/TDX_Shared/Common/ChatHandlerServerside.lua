local MessagingService = game:GetService("MessagingService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local RankRoles = require(TDX_Shared.Common.RankRoles)
local GroupRankUtilities = require(TDX_Shared.Common.GroupRankUtilities)
local NetworkingHandler = require(TDX_Shared.Common.NetworkingHandler)
local ResourceManager = require(TDX_Shared.Common.ResourceManager)
local Shared = require(TDX_Shared.Modules.Shared)
local GroupRank = RankRoles.Developer.GroupRank
local v = { "bloxs%s*drop" }

local function FormatPlayerNames(players)
	if not players or #players == 0 then
		return "Someone"
	end

	local count = #players

	if count == 1 then
		return players[1]
	elseif count == 2 then
		return players[1] .. " and " .. players[2]
	end

	return table.concat(players, ", ", 1, count - 1) .. ", and " .. players[count]
end

TextChatService.DescendantAdded:Connect(function(textSource)
	if textSource:IsA("TextSource") then
		local playerByUserId = Players:GetPlayerByUserId(textSource.UserId)

		if playerByUserId and playerByUserId.AccountAge < 7 then
			task.defer(function()
				textSource.CanSend = false
			end)
		end
	end
end)
task.spawn(function()
	local rbxGeneral = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

	function rbxGeneral.ShouldDeliverCallback(p, p2)
		local text = p.Text:lower()

		for _, v2 in v do
			if not (text:match(v2) and p.TextSource.UserId ~= p2.UserId) then
				continue
			end

			p.TextSource.CanSend = false
			warn(`Blocking banned message from {p.TextSource.UserId}`)
			return false
		end

		return true
	end

	NetworkingHandler.CreateRemoteEvent("SendSystemChatMessage", true)
	MessagingService:SubscribeAsync("MatchVictory", function(p)
		local data = p.Data

		if not data.Difficulty then
			warn("MatchVictory message missing Difficulty field")
			return
		end

		local v2 = Shared.VICTORY_MESSAGE_POOLS[data.Difficulty]

		if not v2 or #v2 == 0 then
			warn(`No victory message pool configured for difficulty {data.Difficulty}`)
			return
		end

		local waveConfig = ResourceManager.GetWaveConfig(data.Difficulty)

		if not waveConfig then
			warn(`No waveconfig for difficulty {data.Difficulty}`)
			return
		end

		local displayNameShort = waveConfig.DisplayNameShort or waveConfig.DisplayName or data.Difficulty
		local v3 = v2[Random.new(p.Sent):NextInteger(1, #v2)]
		local formatted = `{FormatPlayerNames(data.Players)} {(not data.Players and 0 or #data.Players or 0) <= 1 and "has" or "have"} {v3} in {displayNameShort}.`
		local jsonEncode = HttpService:JSONEncode({
			Type = "MatchVictory",
			Difficulty = data.Difficulty
		})
		NetworkingHandler.GetEvent("SendSystemChatMessage"):FireAll(formatted, jsonEncode)
	end)
end)
return {
	PlayerJoined = function(instance, vip: boolean)
		task.spawn(function()
			local success, result = pcall(function()
				return GroupRankUtilities.GetRankInGroup(instance)
			end)

			if not success then
				return
			end

			instance:SetAttribute("RankInGroup", result)
			instance:SetAttribute("GroupRole", GroupRankUtilities.GetGroupRole(instance, result))
			instance:SetAttribute("VIP", vip)

			if GroupRank <= result then
				instance:SetAttribute("Developer", true)
			end
		end)
	end
}