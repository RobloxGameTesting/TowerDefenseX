local SoundHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
require(Common:WaitForChild("SoundDefinitions"))
local LobbyTypeUtilities = require(Common:WaitForChild("LobbyTypeUtilities"))
local isCoreGame = workspace:GetAttribute("IsCoreGame")
workspace:GetAttribute("IsLobby")
local isStudio = RunService:IsStudio()
local sounds = Common:WaitForChild("Resources"):WaitForChild("Sounds")

local function LoadSoundData()
	local result = {}
	local fullNames = {}
	local function Scan(sounds2)
		for _, moduleScript in ipairs(sounds2:GetChildren()) do
			if moduleScript:IsA("ModuleScript") then
				local module = require(moduleScript)

				for k, v in pairs(module) do
					assert(
						result[k] == nil,
						`Duplicate sound "{k}" in {moduleScript:GetFullName()} (already defined in {fullNames[k]})`
					)
					result[k] = v
					fullNames[k] = moduleScript:GetFullName()
				end
			else
				Scan(moduleScript)
			end
		end
	end

	Scan(sounds)
	return result
end

local loadSoundData = LoadSoundData()
local v = {}
local folder = Instance.new("Folder", workspace:WaitForChild("Game"))
local v2 = {}
local v3 = 0
local flag = false
local v4 = 0
local v5 = {}
local v6 = 0
local v7 = nil
local total = 0
local v8 = 0
local v9 = {}
local v10 = {}
local v11 = {}

local function IsMusicKept(soundName: string) -- 1 equivalent call inferred from this helper
	for _, v12 in pairs(v11) do
		if v12[soundName] then
			return true
		end
	end

	return false
end

local function MakeSoundInstance(name: string, data)
	local sound = Instance.new("Sound")
	sound.Name = name
	sound.SoundId = data.IsMusic and "" or data.AssetId
	sound.Volume = data.Volume or 0.35
	sound.Looped = data.Looped or false
	sound.Parent = folder

	if data.OverrideSoundGroup then
		GameSoundHandler.AddSoundToSoundGroup(sound, data.OverrideSoundGroup)
		return sound
	end

	if data.IsMusic then
		GameSoundHandler.AddSoundToSoundGroup(sound, "Music")
		return sound
	end

	GameSoundHandler.AddSoundToSoundGroup(sound, "UI")
	return sound
end

local function MakeSoundInstanceLayers(name: string, data)
	local result = {}

	for i = 1, data.LayerCount or 5 do
		result[i] = MakeSoundInstance(name, data)
	end

	return result
end

local function NewSound(k, data)
	local assetId = data.AssetId
	local volume = data.Volume or 0.35
	local looped = data.Looped or false
	local layerCount = data.LayerCount or 5
	assert(k ~= nil, "SoundName missing")
	assert(assetId ~= nil, "Asset id missing for " .. k)
	local v12 = {
		SoundName = k,
		AssetId = assetId,
		Volume = volume,
		OriginalVolume = volume,
		Looped = looped,
		LayerCount = layerCount,
		IsMusic = data.IsMusic,
		IsBossMusic = data.IsBossMusic,
		IsAmbientMusic = data.IsAmbientMusic,
		DisableIfStudio = data.DisableIfStudio,
		Playing = false,
		LoopPlaying = false,
		StopTween = nil,
		CurrentSoundLayerIndex = 1,
		SoundLayers = MakeSoundInstanceLayers(k, data),
		GetNextSoundInstance = function(self)
			local soundLayer = self.SoundLayers[self.CurrentSoundLayerIndex]
			self.CurrentSoundLayerIndex += 1

			if self.CurrentSoundLayerIndex > self.LayerCount then
				self.CurrentSoundLayerIndex = 1
			end

			return soundLayer
		end,
		Play = function(self, p)
			if isStudio and self.DisableIfStudio then
				return
			end

			if self.StopTween then
				self.StopTween:Cancel()
			end

			local nextSoundInstance = self:GetNextSoundInstance()
			nextSoundInstance.Volume = p or self.Volume
			nextSoundInstance.TimePosition = 0
			self:Load()
			nextSoundInstance:Play()

			if self.Looped then
				self.LoopPlaying = true
			end

			if self.IsMusic and not (self.IsAmbientMusic or self.Playing) then
				v3 += 1
			end

			self.Playing = true
			return nextSoundInstance
		end,
		Stop = function(self, value: number)
			local soundLayer = self.SoundLayers[1]

			if not self.Playing then
				return
			end

			if value then
				self.StopTween = TweenService:Create(soundLayer, TweenInfo.new(value or 1), {
					Volume = 0
				})
				self.StopTween:Play()
				self.StopTween.Completed:Connect(function(p)
					if p ~= Enum.PlaybackState.Completed then
						return
					end

					soundLayer:Stop()
					self:Unload()
				end)
			else
				soundLayer:Stop()
				self:Unload()
			end

			if self.Looped then
				self.LoopPlaying = false
			end

			if self.IsMusic and not self.IsAmbientMusic then
				v3 -= 1
				v4 = math.max(v4, 3)
			end

			if self.IsBossMusic then
				v4 = math.max(v4, 10)
			end

			self.Playing = false
		end,
		Load = function(self)
			if not self.IsMusic then
				return
			end

			for _, soundLayer in ipairs(self.SoundLayers) do
				if soundLayer.SoundId ~= self.AssetId then
					soundLayer.SoundId = self.AssetId
				end
			end
		end,
		Unload = function(self)
			if self.IsMusic and not IsMusicKept(self.SoundName) then -- inferred equivalent call
				for _, soundLayer in ipairs(self.SoundLayers) do
					if soundLayer.IsPlaying then
						return
					end
				end

				for _, soundLayer in ipairs(self.SoundLayers) do
					soundLayer.SoundId = ""
				end
			end
		end,
		SetVolume = function(state, p)
			local volume2 = p or state.OriginalVolume
			state.Volume = volume2
			state.SoundLayers[1].Volume = volume2
		end
	}
	v2[k] = v12

	if v12.IsMusic then
		if not v12.IsAmbientMusic then
			for _, soundLayer in ipairs(v12.SoundLayers) do
				soundLayer.Ended:Connect(function()
					task.defer(v12.Unload, v12)
				end)
			end
		end
	else
		table.insert(v, v12.SoundLayers[1])
	end

	return v12
end

local function GetSoundByName(p: string) -- 3 equivalent calls inferred from this helper
	local v12 = v2[p]

	if not v12 then
		warn("Sound object not found for " .. p)
	end

	return v12
end

function SoundHandler.Play(value: string, p: number?)
	assert(value ~= nil, "SoundName not given")
	assert(typeof(value) == "string", "SoundName is not a string")
	local soundByName = GetSoundByName(value) -- inferred equivalent call

	if soundByName then
		return soundByName:Play(p)
	end

	return nil
end

function SoundHandler.PlayRandom(list, p: number?)
	local soundByName = GetSoundByName(list[math.random(1, #list)]) -- inferred equivalent call

	if soundByName then
		soundByName:Play(p)
	end
end

function SoundHandler.KeepMusicLoaded(p: string, options)
	local v12 = v11[p] or {}
	local v13 = {}

	for k in pairs(options or {}) do
		local v14 = v2[k]

		if not (v14 and v14.IsMusic) then
			continue
		end

		v13[k] = true
		v14:Load()
	end

	v11[p] = v13

	for k in pairs(v12) do
		if not v13[k] then
			v2[k]:Unload()
		end
	end
end

function SoundHandler.Stop(p: string, p2: number?)
	assert(p ~= nil, "SoundName not given")
	local soundByName = GetSoundByName(p) -- inferred equivalent call

	if soundByName then
		soundByName:Stop(p2)
	end
end

local function StopAmbientPlaylist(p: number?)
	if v5 then
		for _, v12 in ipairs(v5) do
			SoundHandler.Stop(v12, p)
			local v13 = v2[v12]

			if v13 then
				v13:Unload()
			end
		end
	end

	flag = false
	v6 = 0
	v7 = nil
	total = 0
	v8 = 0
end

local function StartAmbientTrack(p: number)
	local count = #v5

	for i = 0, count - 1 do
		local v12 = (p - 1 + i) % count + 1
		local v13 = v5[v12]

		if v10[v13] then
			continue
		end

		local v14 = SoundHandler.Play(v13)

		if v14 then
			v6 = v12
			v7 = v14
			total = 0
			v8 = 0
			return true
		else
			v10[v13] = true
		end
	end

	return false
end

local function AdvanceAmbientTrack() -- 3 equivalent calls inferred from this helper
	if StartAmbientTrack(v6 + 1) then
		return
	end

	flag = false
	v7 = nil
	v4 = 30
end

local function UnloadAmbientTrack(p: number)
	local v12 = v2[v5[p]]

	if v12 then
		v12:Unload()
	end
end

local function MarkAmbientTrackFailed(p: string) -- 1 equivalent call inferred from this helper
	local v12 = (v9[p] or 0) + 1
	v9[p] = v12

	if v12 >= 2 then
		v10[p] = true
		warn(`Ambient track "{p}" failed to load {v12} times - skipping it for the rest of the session`)
	else
		warn(`Ambient track "{p}" did not load in {10}s - moving on to the next one`)
	end
end

local function RunAmbientTrack(dt: number)
	if v8 > 0 then
		v8 -= dt

		if v8 <= 0 then
			AdvanceAmbientTrack() -- inferred equivalent call
		end
	else
		local v12 = v7

		if v12 then
			total += dt

			if v12.TimeLength <= 0 then
				if total >= 10 then
					v12:Stop()
					local v13 = v2[v5[v6]]

					if v13 then
						v13:Unload()
					end

					MarkAmbientTrackFailed(v5[v6]) -- inferred equivalent call
					AdvanceAmbientTrack() -- inferred equivalent call
				end
			elseif total >= 1 and not v12.IsPlaying then
				v7 = nil
				v8 = 3
				local v13 = v2[v5[v6]]

				if v13 then
					v13:Unload()
				end
			end
		else
			AdvanceAmbientTrack() -- inferred equivalent call
		end
	end
end

function SoundHandler.SetAmbientPlaylist(p, value: number?)
	if p == v5 then
		return
	end

	if v5 then
		StopAmbientPlaylist(value or 3)
		v4 = value or math.max(v4, 3)
	end

	v5 = p
end

function SoundHandler.StopAmbientPlaylistForTime(p: number)
	if flag then
		StopAmbientPlaylist(3)
	end

	v4 = p
end

function SoundHandler.Initialize()
	local lobbyType = workspace:GetAttribute("LobbyType")
	local v12 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)
	local v13 = {
		DifficultyVotingMusic = true,
		MapVoteMusic = true,
		VictoryMusic = true,
		DefeatMusic = true
	}

	for _, v14 in pairs(v12 or {}) do
		if type(v14) == "string" then
			v13[v14] = true
		end
	end

	SoundHandler.KeepMusicLoaded("LobbyType", v13)
	local MapHandler = isCoreGame and require(Common:FindFirstChild("MapHandler"))
	local v14 = MapHandler and MapHandler.GetAmbientSound()

	if v14 then
		v14.Looped = true
		GameSoundHandler.AddSoundToSoundGroup(v14, "Ambient")
		v14:Play()
	end
end

folder.Name = "SoundFolder"

for k, v12 in pairs(loadSoundData) do
	NewSound(k, v12)
end

task.spawn(function()
	local success, result = pcall(function()
		ContentProvider:PreloadAsync(v, function(_, _) end)
	end)

	if not success then
		warn("Some audio failed to load: " .. tostring(result))
	end
end)
RunService.Heartbeat:Connect(function(dt: number)
	if not v5 or #v5 <= 0 then
		return
	end

	if v3 > 0 then
		if flag then
			StopAmbientPlaylist(3)
		end
	else
		if flag then
			RunAmbientTrack(dt)
			return
		end

		v4 -= dt

		if v4 <= 0 then
			if StartAmbientTrack(math.random(1, #v5)) then
				flag = true
			else
				v4 = 30
			end
		end
	end
end)
return SoundHandler