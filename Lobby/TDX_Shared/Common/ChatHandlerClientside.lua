local ChatHandlerClientside = {}
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local RankRoles = require(ReplicatedStorage.TDX_Shared.Common.RankRoles)
local NetworkingHandler = require(game.ReplicatedStorage.TDX_Shared.Common.NetworkingHandler)
local RewardMultipliers = require(ReplicatedStorage.TDX_Shared.Common.RewardMultipliers)
local Client = ReplicatedFirst:FindFirstChild("Client")
local partyClient = Client and Client:FindFirstChild("PartyClient")
local v = nil

if partyClient then
	local success, result = pcall(require, partyClient)

	if success then
		v = result
	end
end

local v2 = utf8.char(57345)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromHex("#7D0FE3")
local color3 = Color3.fromRGB(255, 0, 0)
local v3 = {}

local function Color3ToHex(color4: Color3) -- 3 equivalent calls inferred from this helper
	return string.format("#%02X%02X%02X", color4.R * 255, color4.G * 255, color4.B * 255)
end

local function FontColor(p: string, color4: Color3) -- 7 equivalent calls inferred from this helper
	return "<font color='" .. Color3ToHex(color4) .. "'>" .. p .. "</font>" -- inferred equivalent call
end

function ChatHandlerClientside.AddOnIncomingMessageCallback(callback)
	table.insert(v3, callback)
end

TextChatService.OnIncomingMessage = function(data)
	local textChatMessageProperties = Instance.new("TextChatMessageProperties")
	local playerByUserId = data.TextSource and Players:GetPlayerByUserId(data.TextSource.UserId)

	if playerByUserId then
		local groupRole = playerByUserId:GetAttribute("GroupRole")
		local vip = playerByUserId:GetAttribute("VIP")
		local dailyStreak = playerByUserId:GetAttribute("DailyStreak")

		if playerByUserId.MembershipType == Enum.MembershipType.Premium then
			textChatMessageProperties.PrefixText ..= FontColor(v2, color) -- inferred equivalent call
		end

		if dailyStreak and dailyStreak > 0 then
			textChatMessageProperties.PrefixText ..= FontColor(`[{dailyStreak}] `, color3) -- inferred equivalent call
		end

		local v4 = v and v.GetPartyData()

		if
			v4
			and v4.Players
			and table.find(v4.Players, playerByUserId) ~= nil
			and playerByUserId ~= Players.LocalPlayer
		then
			textChatMessageProperties.PrefixText ..= "<font color='" .. Color3ToHex(color2) .. "'>[PARTY] </font>" -- inferred equivalent call
		end

		local rankRole = RankRoles[groupRole]

		if rankRole then
			textChatMessageProperties.PrefixText ..= FontColor(`[{rankRole.TagText}]` .. " ", rankRole.TagColor) -- inferred equivalent call
			textChatMessageProperties.Text = FontColor(data.Text, rankRole.TextColor) -- inferred equivalent call
		elseif vip then
			textChatMessageProperties.PrefixText ..= "<font color='" .. Color3ToHex(Shared.VIP_TAG_COLOR) .. "'>[VIP] </font>" -- inferred equivalent call
			textChatMessageProperties.Text = FontColor(data.Text, Shared.VIP_TEXT_COLOR) -- inferred equivalent call
		end

		textChatMessageProperties.PrefixText ..= data.PrefixText

		if data.Status == Enum.TextChatMessageStatus.Success then
			for _, v5 in ipairs(v3) do
				v5(data)
			end

			return textChatMessageProperties
		end
	elseif data.TextSource == nil and data.Metadata then
		local success, result = pcall(function()
			return HttpService:JSONDecode(data.Metadata)
		end)

		if success then
			if result.Type == "MatchVictory" then
				local difficulty = result.Difficulty
				local v4 = Shared.VICTORY_MESSAGE_COLORS[difficulty] or Color3.new(1, 1, 1)
				textChatMessageProperties.Text = FontColor(data.Text, v4) -- inferred equivalent call
				return textChatMessageProperties
			elseif result.Type == "RewardMultiplier" then
				local definition = RewardMultipliers.Definitions[result.Multiplier]
				local chatColor = definition and definition.ChatColor or Color3.new(1, 1, 1)
				textChatMessageProperties.Text = FontColor(data.Text, chatColor) -- inferred equivalent call
				return textChatMessageProperties
			else
				warn(`Unknown system message type: {result.Type}`)
			end
		end
	end

	return textChatMessageProperties
end

local RBXGeneral = TextChatService.TextChannels.RBXGeneral

local function DisplaySystemMessage(p: string, p2: string?)
	RBXGeneral:DisplaySystemMessage("[Server] " .. p, p2)
end

NetworkingHandler.GetEvent("SendSystemChatMessage"):AttachCallback(DisplaySystemMessage)
return ChatHandlerClientside