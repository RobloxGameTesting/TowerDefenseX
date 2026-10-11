local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local Enums = require(Common:WaitForChild("Enums"))
local RankRoles = require(Common:WaitForChild("RankRoles"))
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local Data

if RunService:IsServer() then
	Data = require(ServerScriptService.Server.Data)
else
	Data = nil
end

local RequestType = Enums.Emotes.RequestType
local miscResource = ResourceManager.GetMiscResource("EmoteModels", true)
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "EmoteEvent"
remoteEvent.Parent = ReplicatedStorage

local function HandlePlayEmote(player, character, humanoid, ...)
	local v = ...

	if type(v) ~= "string" then
		warn(`[Emote] Invalid EmoteName type from {player.Name}`)
		return
	end

	local v2 = EmoteAnimationsV2[v]

	if not v2 then
		warn(`[Emote] Missing emote data: {v} from {player.Name}`)
		return
	end

	local v3 = (player:GetAttribute("RankInGroup") or 0) >= RankRoles.Programmer.GroupRank
	local canAlwaysPlay = v2.CanAlwaysPlay

	if not (_G.DEBUG_EMOTE_TESTING or v3 or canAlwaysPlay) then
		local emotes = Data.Get(player, "Emotes")

		if not (emotes and table.find(emotes, v)) then
			warn(`[Emote] Emote not equipped: {v} from {player.Name}`)
			return
		end
	end

	local v4 = EmoteAnimationsV2[EmoteVariants.Resolve(v, character)]
	local emoteSoundData = v4.EmoteSoundData

	if emoteSoundData then
		local sound = Instance.new("Sound")
		sound:SetAttribute("__GroupName", emoteSoundData.SoundGroup or "Emotes")
		sound:AddTag("SoundFix")
		sound:AddTag("EmoteSound")
		sound.SoundId = "rbxassetid://" .. emoteSoundData.SoundId
		sound.RollOffMaxDistance = emoteSoundData.RollOffMaxDistance or 50
		sound.Volume = 0
		sound:SetAttribute("Volume", emoteSoundData.Volume or 0.2)
		sound.Looped = emoteSoundData.Looped == nil or emoteSoundData.Looped
		sound.Name = "EmoteSound"
		sound.Parent = character.PrimaryPart
		sound:Play()
	end

	local modelNames = v4.ModelNames

	if modelNames then
		EmoteUtilities.AttachEmoteModels(character, modelNames)

		for _, childName in modelNames do
			local child = miscResource:FindFirstChild(childName)

			if child then
				local hipHeight = child:GetAttribute("HipHeight")

				if hipHeight and humanoid then
					humanoid:SetAttribute("OriginalHipHeight", humanoid.HipHeight)
					humanoid.HipHeight = hipHeight
				end
			end

			local serverModelCallback = v4.ServerModelCallback

			if not (serverModelCallback and serverModelCallback[childName]) then
				continue
			end

			local child2 = character:FindFirstChild(childName)

			if child2 then
				pcall(serverModelCallback[childName], child2)
			end
		end
	end

	if v4.IsPartner then
		local folder = Instance.new("Folder")
		folder.Name = "EmotePartner"
		folder:SetAttribute("EmoteName", v)
		folder.Parent = character
	end
end

local function HandleStopEmote(_, character) -- 2 equivalent calls inferred from this helper
	EmoteUtilities.RemoveEmoteSound(character)
	EmoteUtilities.RemoveEmoteGear(character)
	EmoteUtilities.ResetHumanoidHipHeight(character)
end

local function HandleKeyframeEvent(player, character, ...)
	local v, v2 = ...

	if type(v) ~= "string" or type(v2) ~= "string" then
		warn(`[Emote] Invalid KeyframeEvent args from {player.Name}`)
		return
	end

	local v3 = EmoteAnimationsV2[EmoteVariants.Resolve(v, character)]

	if not v3 then
		warn(`[Emote] Missing emote data: {v} from {player.Name}`)
	elseif v3.ServerKeyframeHandler then
		local modelNames = v3.ModelNames
		local v4 = {}

		if modelNames then
			for _, childName in modelNames do
				v4[childName] = character:FindFirstChild(childName)
					or EmoteUtilities.GetLeftBehindEmoteModel(player, childName)
			end
		end

		v3.ServerKeyframeHandler(v2, v4)
	end
end

remoteEvent.OnServerEvent:Connect(function(player, value: string, ...)
	if type(value) ~= "string" then
		warn(`[Emote] Invalid Request type from {player.Name}`)
		return
	end

	local character = player.Character

	if not character then
		return
	end

	local humanoid = character:FindFirstChild("Humanoid")

	if value == RequestType.PlayEmote then
		HandleStopEmote(nil, character) -- inferred equivalent call
		HandlePlayEmote(player, character, humanoid, ...)
	elseif value == RequestType.StopEmote then
		HandleStopEmote(nil, character) -- inferred equivalent call
	elseif value == RequestType.KeyframeEvent then
		HandleKeyframeEvent(player, character, ...)
	end
end)
return {}