local VoteHandlerClass = {}
VoteHandlerClass.__index = VoteHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))

local function CreateVoteMap(options) -- 1 equivalent call inferred from this helper
	local result = {}

	for _, item in pairs(options) do
		result[item] = 0
	end

	return result
end

function VoteHandlerClass.New(data)
	local v = {
		Options = data.Options,
		VoteMap = CreateVoteMap(data.Options), -- inferred equivalent call
		DefaultOption = data.DefaultOption,
		OptionThresholdMap = data.OptionThresholdMap,
		PlayerVoteMap = {},
		PlayerNames = data.PlayerNames,
		TimeLeft = data.Duration or 1e999,
		EndIfAllVoted = data.EndIfAllVoted,
		UseAdjustedDeltaTime = data.UseAdjustedDeltaTime,
		VoterCount = Utilities.GetKeyCount(data.PlayerNames),
		VoterCountChanged = true
	}
	return (setmetatable(v, VoteHandlerClass))
end

function VoteHandlerClass.GetVoterCount(p)
	return p.VoterCount
end

function VoteHandlerClass:AddToVoters(p: string)
	if not table.find(self.PlayerNames, p) then
		table.insert(self.PlayerNames, p)
		self.VoterCount += 1
		self.VoterCountChanged = true
	end
end

function VoteHandlerClass:RemoveFromVoters(p: string)
	local index = table.find(self.PlayerNames, p)

	if not index then
		return
	end

	table.remove(self.PlayerNames, index)
	local v = self.PlayerVoteMap[p]

	if v ~= nil then
		self.VoteMap[v] -= 1
	end

	self.VoterCount -= 1
	self.VoterCountChanged = true
end

function VoteHandlerClass:Run(p: number, p2: number)
	if self.UseAdjustedDeltaTime then
		self.TimeLeft -= p2
	else
		self.TimeLeft -= p
	end
end

function VoteHandlerClass.GetTimeLeft(p)
	return p.TimeLeft
end

function VoteHandlerClass.Completed(data)
	if data.TimeLeft <= 0 then
		return true
	end

	if data.EndIfAllVoted then
		local count = 0

		for _, _ in pairs(data.PlayerVoteMap) do
			count += 1
		end

		if data.VoterCount <= count then
			return true
		end
	end

	if data.OptionThresholdMap then
		for k, v in pairs(data.OptionThresholdMap) do
			if v <= data.VoteMap[k] then
				return true
			end
		end
	end

	return false
end

function VoteHandlerClass.CastVote(p, p2: string, p3)
	local v = p.PlayerVoteMap[p2]

	if v ~= nil then
		p.VoteMap[v] -= 1
	end

	if p.VoteMap[p3] == nil then
		print(`{p2} voted for an invalid option: {p3}`)
		return
	end

	p.PlayerVoteMap[p2] = p3
	p.VoteMap[p3] += 1
end

function VoteHandlerClass.GetResult(data)
	local defaultOption = data.DefaultOption
	local v = 0

	for k, v2 in pairs(data.VoteMap) do
		local v3 = v2 > 0 and v2 == v and table.find(data.Options, k) < table.find(data.Options, defaultOption)

		if not (v < v2 or v3) then
			continue
		end

		defaultOption = k
		v = v2
	end

	return defaultOption
end

function VoteHandlerClass.GetVoteMap(p)
	return p.VoteMap
end

function VoteHandlerClass.GetPlayerVoteMap(p)
	return p.PlayerVoteMap
end

return VoteHandlerClass