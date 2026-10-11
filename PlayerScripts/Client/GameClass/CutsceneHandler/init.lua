local createVector = vector.create
local CutsceneHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("RunService")
local TweenService = game:GetService("TweenService")
game:GetService("SoundService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("WaveTypes"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local LobbyTypeUtilities = require(common:WaitForChild("LobbyTypeUtilities"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local CutsceneUtilities = require(common:WaitForChild("CutsceneUtilities"))
local parent = script.Parent.Parent
local CameraHandler = require(parent:WaitForChild("CameraHandler"))
local userInterfaceHandler = parent:WaitForChild("UserInterfaceHandler")
local CutsceneScreenHandler = require(userInterfaceHandler:WaitForChild("CutsceneScreenHandler"))
local InstanceControlHandler = require(script:WaitForChild("InstanceControlHandler"))
local CUTSCENE_FAST_FORWARD_TIME = _G.CUTSCENE_FAST_FORWARD_TIME
local DEBUG_CUTSCENE_CONTROLS = _G.DEBUG_CUTSCENE_CONTROLS
local _ = {
	Cutscene = "Cutscene",
	BlackScreen = "BlackScreen",
	BlackScreenFadeIn = "BlackScreenFadeIn",
	BlackScreenFadeOut = "BlackScreenFadeOut"
}
local cutscenes = workspace:WaitForChild("Game"):WaitForChild("Cutscenes")
local event = NetworkingHandler.GetEvent("CutsceneSmoothEnd")
local event2 = NetworkingHandler.GetEvent("DevCutsceneControlRequest")
local event3 = NetworkingHandler.GetEvent("DevCutsceneControl")
local v = nil
local v2 = nil
local v3 = nil
local v4 = {}
local v5 = {}
local v6 = nil
local v7 = false
local v8 = false
local v9 = nil
local v10 = nil

local function AdjustTimePassed(timePassed: number, serverTime: number) -- 1 equivalent call inferred from this helper
	return timePassed + Utilities.GetTimeOffset(serverTime)
end

local function GetSequenceElapsedTime() -- 1 equivalent call inferred from this helper
	if not (v and v9) then
		return nil
	end

	local total = 0

	for _, v11 in ipairs(v) do
		total += v11.TimeLeft
	end

	return v9 - total
end

local function GetSubtitlePlaybackTime(data, time: number)
	local segments = data.Segments

	if not segments then
		return time
	end

	local v11 = data.PlayAnimationOnInitialBlackFadeOut and 0 or data.InitialBlackFadeOutTime or 0

	for i, segment in ipairs(segments) do
		if segment.Start <= time and time < segment.End then
			return v11 + time - segment.Start
		end

		v11 += segment.End - segment.Start
		local blackTransition = CutsceneUtilities.GetBlackTransition(data, i)

		if blackTransition then
			v11 += blackTransition.Duration
		end
	end

	return nil
end

local function NewSubtitleData(cutsceneData, subtitleData)
	v4 = {}

	if not subtitleData then
		return
	end

	local v11 = (cutsceneData.InitialBlackFadeInTime or 0) + (cutsceneData.InitialBlackDuration or 0)

	for _, item in pairs(subtitleData) do
		local subtitlePlaybackTime = GetSubtitlePlaybackTime(cutsceneData, item.Time)

		if not subtitlePlaybackTime then
			continue
		end

		local v12 = {
			Name = item.Name,
			NameColor = item.NameColor,
			Text = item.Text,
			TextColor = item.TextColor,
			TimeLeftUntilPlay = subtitlePlaybackTime + v11,
			Started = false,
			Duration = item.Duration
		}
		table.insert(v4, v12)
	end
end

function CutsceneHandler.Start(data, flag: boolean?)
	if not data then
		warn("CutsceneHandler.Start: No CutsceneStateData provided.")
	end

	local sequenceName = data.SequenceName
	local adjustTimePassed = AdjustTimePassed(data.TimePassed, data.ServerTime) -- inferred equivalent call
	local cutsceneConfig = ResourceManager.GetCutsceneConfig(sequenceName)

	if not cutsceneConfig then
		return
	end

	v = {}
	v2 = 1
	v4 = {}
	v10 = sequenceName

	for _, cutsceneData in ipairs(cutsceneConfig) do
		if cutsceneData.InitialBlackFadeInTime then
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "BlackScreenFadeIn",
				TimeLeft = cutsceneData.InitialBlackFadeInTime
			})
		end

		if cutsceneData.InitialBlackDuration then
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "BlackScreen",
				TimeLeft = cutsceneData.InitialBlackDuration,
				InsertModel = cutsceneData.InsertModelDuringInitialBlack,
				InsertModelDelayLeft = cutsceneData.InsertModelDelay
			})
		end

		if cutsceneData.InitialBlackFadeOutTime then
			local v11 = cutsceneData.BlackScreenForEntireCutscene and "BlackScreen" or "BlackScreenFadeOut"
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = v11,
				TimeLeft = cutsceneData.InitialBlackFadeOutTime,
				PlayAnimation = cutsceneData.PlayAnimationOnInitialBlackFadeOut
			})
		end

		if cutsceneData.Segments then
			local segments = cutsceneData.Segments

			for i, timeLeft in ipairs(CutsceneUtilities.GetSegmentDurations(cutsceneData)) do
				local blackTransition = CutsceneUtilities.GetBlackTransition(cutsceneData, i - 1)
				local blackTransition2 = CutsceneUtilities.GetBlackTransition(cutsceneData, i)
				local v11

				if i > 1 then
					v11 = not blackTransition
				else
					v11 = false
				end

				local v12 = v
				local v13 = {
					CutsceneData = cutsceneData,
					Type = "Cutscene",
					TimeLeft = timeLeft,
					PlayAnimation = i == 1 and not cutsceneData.PlayAnimationOnInitialBlackFadeOut,
					SeekTime = 0,
					AudioFadeInTime = 0,
					AudioFadeOutTime = 0
				}
				local seekTime

				if v11 then
					seekTime = segments[i].Start
				end

				v13.SeekTime = seekTime
				v13.AudioFadeInTime = v11 and 0.2 or nil
				v13.AudioFadeOutTime = i < #segments and not blackTransition2 and 0.2 or nil
				table.insert(v12, v13)

				if not blackTransition2 then
					continue
				end

				table.insert(v, {
					CutsceneData = cutsceneData,
					Type = "BlackScreenFadeIn",
					TimeLeft = blackTransition2.FadeInTime,
					AudioFadeOutTime = blackTransition2.FadeInTime
				})
				table.insert(v, {
					CutsceneData = cutsceneData,
					Type = "BlackScreen",
					TimeLeft = blackTransition2.Duration
				})
				table.insert(v, {
					CutsceneData = cutsceneData,
					Type = "BlackScreenFadeOut",
					TimeLeft = blackTransition2.FadeOutTime,
					SeekTime = segments[i + 1].Start,
					AudioFadeInTime = blackTransition2.FadeOutTime
				})
			end
		else
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "Cutscene",
				TimeLeft = cutsceneData.Duration,
				PlayAnimation = not cutsceneData.PlayAnimationOnInitialBlackFadeOut
			})
		end

		if cutsceneData.EndingBlackFadeInTime then
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "BlackScreenFadeIn",
				TimeLeft = cutsceneData.EndingBlackFadeInTime
			})
		end

		if cutsceneData.EndingBlackDuration then
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "BlackScreen",
				TimeLeft = cutsceneData.EndingBlackDuration,
				RemoveModel = cutsceneData.RemoveModelDuringEndingBlack or false,
				RemoveModelDelayLeft = cutsceneData.RemoveModelDelay
			})
		end

		if cutsceneData.EndingBlackFadeOutTime then
			table.insert(v, {
				CutsceneData = cutsceneData,
				Type = "BlackScreenFadeOut",
				TimeLeft = cutsceneData.EndingBlackFadeOutTime
			})
		end
	end

	local total = 0

	for _, v11 in pairs(v) do
		total += v11.TimeLeft
	end

	v9 = total
	SoundHandler.StopAmbientPlaylistForTime(total)

	if flag then
		CutsceneScreenHandler.ShowBackground()
	end

	CutsceneHandler.Run(adjustTimePassed)
end

function CutsceneHandler.End()
	v = nil
	v2 = 1
	v3 = nil
	v4 = {}
	v9 = nil
	v10 = nil
	v6 = nil
	v7 = false
	CutsceneScreenHandler.DebugSetAnimationTime(nil)
	CutsceneScreenHandler.DebugUpdateScrubber(nil)
	local v11 = next(v5) ~= nil

	for _, v12 in pairs(v5) do
		for _, sound in pairs(v12.Sounds) do
			sound:Destroy()
		end

		v12.Model:Destroy()
	end

	v5 = {}
	CameraHandler.Reset()
	MapHandler.ToggleGameForCutscene_Client(true)

	if v11 then
		MapHandler.EnableLightingEffects_Client()
		MapHandler.RemoveCutsceneLightingConfig_Client()
		InstanceControlHandler.AnimationStopped()
	end
end

local function InsertModel(p: string, p2: string?, flag: boolean?)
	local folder = ResourceManager.GetCutsceneModel(p)

	if not folder then
		return
	end

	if flag then
		folder:PivotTo(folder:GetPivot() - createVector(0, 200, 0))
	end

	folder.Parent = cutscenes
	local v11 = {
		Model = folder,
		AnimationHandlers = {},
		Sounds = {},
		SoundVolumes = {},
		InstanceControlDataTable = nil
	}

	if not flag then
		v5[p] = v11
		CameraHandler.SetCutscene(folder)
		MapHandler.DisableLightingEffects_Client()

		if folder:FindFirstChild("LightingData") then
			MapHandler.LoadCutsceneLightingConfig_Client(folder:FindFirstChild("LightingData"))
		end
	end

	local v12 = LightAnimationHandlerClass.New(folder, nil, true, true)
	table.insert(v11.AnimationHandlers, v12)
	local animatedObjects = folder:FindFirstChild("AnimatedObjects")

	if animatedObjects then
		for _, child in ipairs(animatedObjects:GetChildren()) do
			local v13 = LightAnimationHandlerClass.New(child, nil, true)
			table.insert(v11.AnimationHandlers, v13)
		end
	end

	if p2 then
		for _, animationHandler in pairs(v11.AnimationHandlers) do
			animationHandler:Play(p2, true, CUTSCENE_FAST_FORWARD_TIME)
		end
	end

	for _, sound in pairs(folder:GetDescendants()) do
		if not sound:IsA("Sound") then
			continue
		end

		table.insert(v11.Sounds, sound)
		v11.SoundVolumes[sound] = sound.Volume
	end

	local instanceControlData = not flag and folder:FindFirstChild("InstanceControlData")

	if instanceControlData then
		v11.InstanceControlDataTable = InstanceControlHandler.NewInstanceControlDataTable(folder, instanceControlData)
	end

	return v11
end

local function RemoveModel(cutsceneData)
	if cutsceneData then
		local v11 = v5[cutsceneData.Name]

		if not v11 then
			return
		end

		if v11.Sounds then
			for _, sound in pairs(v11.Sounds) do
				sound:Destroy()
			end
		end

		v11.Model:Destroy()
		v5[cutsceneData.Name] = nil
	else
		for _, v11 in pairs(v5) do
			v11.Model:Destroy()
		end

		v5 = {}
	end

	CameraHandler.Reset()
	MapHandler.EnableLightingEffects_Client()
	MapHandler.RemoveCutsceneLightingConfig_Client()
	InstanceControlHandler.AnimationStopped()
end

local function PlayAnimations(cutsceneData, modelAnimationName: string?)
	local v11 = v5[cutsceneData.Name]

	if not v11 then
		warn("PlayAnimations: No CutsceneModelData found for", cutsceneData.Name)
		return
	end

	local v12 = cutsceneData.Segments and cutsceneData.Segments[1]
	local start

	if v12 then
		start = v12.Start
	else
		start = CUTSCENE_FAST_FORWARD_TIME
	end

	if not cutsceneData.NoAnimations then
		for _, animationHandler in pairs(v11.AnimationHandlers) do
			animationHandler:Play(modelAnimationName or "Animation", nil, start)
		end

		v6 = start or 0
	end

	for _, sound in pairs(v11.Sounds) do
		sound.Parent = cutscenes
		sound:Play()

		if start then
			sound.TimePosition = start
		end
	end

	InstanceControlHandler.AnimationStarted(start)
end

local function SeekModel(p, timePosition: number)
	for _, animationHandler in pairs(p.AnimationHandlers) do
		local animationTrack = animationHandler.CurrentState
			and animationHandler:GetAnimationTrack(animationHandler.CurrentState)

		if animationTrack and animationTrack.Length > 0 then
			animationTrack.TimePosition = math.min(timePosition, 0.999 * animationTrack.Length)
		end
	end

	for _, sound in pairs(p.Sounds) do
		if not sound.Playing then
			continue
		end

		if sound.TimeLength > 0 and sound.TimeLength <= timePosition then
			sound:Stop()
		else
			sound.TimePosition = timePosition
		end
	end
end

local function FadeSounds(p, flag: boolean, duration: number)
	local v11 = v5[p.Name]

	if not v11 then
		return
	end

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)

	for _, sound in pairs(v11.Sounds) do
		TweenService:Create(sound, tweenInfo, {
			Volume = not flag and 0 or v11.SoundVolumes[sound] or sound.Volume
		}):Play()
	end
end

local function SeekAnimations(cutsceneData, seekTime: number, audioFadeInTime: number) -- 1 equivalent call inferred from this helper
	local v11 = v5[cutsceneData.Name]

	if not v11 then
		return
	end

	SeekModel(v11, seekTime)
	InstanceControlHandler.AnimationStarted(seekTime)

	if v6 then
		v6 = seekTime
	end

	FadeSounds(cutsceneData, true, audioFadeInTime)
end

function CutsceneHandler.Run(p: number)
	if not v then
		return
	end

	local v11 = v7 and not v8 and 0 or p

	for _, v12 in pairs(v4) do
		if v12.Started then
			continue
		end

		v12.TimeLeftUntilPlay -= v11

		if not (v12.TimeLeftUntilPlay <= 0) then
			continue
		end

		CutsceneScreenHandler.WriteSubtitle(v12.Name, v12.NameColor, v12.Text, v12.TextColor, v12.Duration)
		v12.Started = true
	end

	while v11 > 0 do
		local v12 = v[v2]

		if not v12 then
			CutsceneHandler.End()
			return
		end

		local cutsceneData = v12.CutsceneData

		if v3 ~= cutsceneData then
			v3 = cutsceneData

			if cutsceneData then
				NewSubtitleData(cutsceneData, cutsceneData.SubtitleData)
			end
		end

		if not v12.Started then
			CutsceneScreenHandler.SetBackgroundColor(cutsceneData and cutsceneData.BlackScreenCustomColor or Color3.fromRGB(0, 0, 0))

			if v12.Type == "BlackScreen" then
				CutsceneScreenHandler.ShowBackground()
			elseif v12.Type == "BlackScreenFadeIn" then
				CutsceneScreenHandler.FadeInBackground(v12.TimeLeft)
			elseif v12.Type == "BlackScreenFadeOut" then
				CutsceneScreenHandler.FadeOutBackground(v12.TimeLeft)
			elseif v12.Type == "Cutscene" and cutsceneData and not cutsceneData.BlackScreenForEntireCutscene then
				CutsceneScreenHandler.HideBackground()
			end

			if v12.PlayAnimation then
				PlayAnimations(cutsceneData, cutsceneData.ModelAnimationName)
			end

			if v12.SeekTime then
				SeekAnimations(cutsceneData, v12.SeekTime, v12.AudioFadeInTime or 0) -- inferred equivalent call
			end

			v12.Started = true
		end

		if v12.InsertModel and not v12.InsertModelStarted then
			if cutsceneData and cutsceneData.HideMapDuringCutscene then
				MapHandler.ToggleGameForCutscene_Client(false)
			end

			if v12.InsertModelDelayLeft <= 0 or v12.InsertModelDelayLeft - v11 <= 0 then
				InsertModel(cutsceneData.Name, cutsceneData.ModelAnimationName, nil, cutsceneData.NoAnimations)
				v12.InsertModelStarted = true
			else
				v12.InsertModelDelayLeft -= v11
			end
		end

		if v12.RemoveModel and not v12.RemoveModelStarted then
			MapHandler.ToggleGameForCutscene_Client(true)

			if v12.RemoveModelDelayLeft <= 0 or v12.RemoveModelDelayLeft - v11 <= 0 then
				RemoveModel(cutsceneData)
				v12.RemoveModelStarted = true
			else
				v12.RemoveModelDelayLeft -= v11
			end
		end

		if v12.AudioFadeOutTime and not v12.AudioFadeOutStarted then
			local v13 = v12.TimeLeft - v11

			if v13 <= v12.AudioFadeOutTime then
				FadeSounds(cutsceneData, false, math.max(v13, 0))
				v12.AudioFadeOutStarted = true
			end
		end

		if v6 then
			v6 += math.min(v12.TimeLeft, v11)
		end

		if v11 < v12.TimeLeft then
			v12.TimeLeft -= v11
			v11 = 0
		else
			v11 -= v12.TimeLeft
			v12.TimeLeft = 0
			v2 += 1
		end

		local v13 = cutsceneData and v5[cutsceneData.Name]

		if not v13 then
			continue
		end

		local model = v13.Model
		local fov = model:FindFirstChild("FOV")

		if fov then
			local primaryPart = model.PrimaryPart
			local magnitude = (fov.Position - primaryPart.Position).Magnitude
			CameraHandler.SetFOV(magnitude)
		end

		local instanceControlDataTable = v13.InstanceControlDataTable

		if instanceControlDataTable then
			InstanceControlHandler.RunInstanceControlDataTable(instanceControlDataTable)
		end
	end

	CutsceneScreenHandler.DebugSetAnimationTime(v6, v7)

	if DEBUG_CUTSCENE_CONTROLS then
		CutsceneScreenHandler.DebugUpdateScrubber(GetSequenceElapsedTime(), v9, v7) -- inferred equivalent call
	end
end

local function DebugSetPaused(flag: boolean)
	v7 = flag

	for _, v11 in pairs(v5) do
		for _, animationHandler in pairs(v11.AnimationHandlers) do
			animationHandler:SetSpeedMultiplier(flag and 0 or 1)
		end

		for _, sound in pairs(v11.Sounds) do
			if flag then
				if sound.Playing then
					sound:Pause()
				end
			else
				sound:Resume()
			end
		end
	end

	CutsceneScreenHandler.DebugSetAnimationTime(v6, v7)
end

local function DebugSeekTo(timePassed: number)
	local sequenceName = v10

	if not sequenceName then
		return
	end

	local v11 = v7
	CutsceneHandler.End()
	v8 = true
	CutsceneHandler.Start({
		SequenceName = sequenceName,
		TimePassed = timePassed,
		ServerTime = workspace:GetServerTimeNow()
	})
	v8 = false

	if v6 then
		for _, v12 in pairs(v5) do
			SeekModel(v12, v6)
		end
	end

	if v11 then
		DebugSetPaused(true)
	end
end

event3:AttachCallback(function(p: string, timePassed: number?)
	if p == "Pause" then
		DebugSetPaused(true)
	elseif p == "Resume" then
		DebugSetPaused(false)
	elseif p == "Seek" and timePassed then
		DebugSeekTo(timePassed)
	end
end)

if DEBUG_CUTSCENE_CONTROLS then
	local UserInputService = game:GetService("UserInputService")
	UserInputService.InputBegan:Connect(function(input, gameProcessed: boolean)
		if gameProcessed or not v then
			return
		end

		if input.KeyCode == Enum.KeyCode.P then
			event2:FireServer(v7 and "Resume" or "Pause")
		end
	end)
end

event:AttachCallback(function()
	v = {}
	v2 = 1
	v4 = {}

	for _, v11 in pairs(v5) do
		for _, sound in pairs(v11.Sounds) do
			if not sound.Playing then
				continue
			end

			local tween = TweenService:Create(sound, TweenInfo.new(1), { Volume = 0 })
			tween:Play()
			local v12 = sound
			tween.Completed:Connect(function(p)
				if p ~= Enum.PlaybackState.Completed then
					return
				end

				v12:Stop()
			end)
		end
	end

	SoundHandler.StopAmbientPlaylistForTime(3)
	table.insert(v, { Type = "BlackScreenFadeIn", TimeLeft = 0.5 })
	table.insert(v, {
		Type = "BlackScreen",
		TimeLeft = 1.5,
		RemoveModel = true,
		RemoveModelDelayLeft = 0.75
	})
	table.insert(v, { Type = "BlackScreenFadeOut", TimeLeft = 0.5 })
end)
task.delay(1, function()
	local lobbyType = workspace:GetAttribute("LobbyType")

	if lobbyType then
		local lobbyTypeData = LobbyTypeUtilities.GetLobbyTypeData(lobbyType)

		if not lobbyTypeData then
			return
		end

		local preloadCutsceneNames = lobbyTypeData.PreloadCutsceneNames

		if not preloadCutsceneNames then
			return
		end

		for _, preloadCutsceneName in pairs(preloadCutsceneNames) do
			local insertModel = InsertModel(preloadCutsceneName, nil, true)

			if insertModel then
				for _, sound in pairs(insertModel.Sounds) do
					sound.PlaybackSpeed = 0.01
					sound.Volume = 0.001
					sound:Play()
				end

				task.delay(1, function()
					insertModel.Model:Destroy()
				end)
			end

			task.wait(math.random(1200, 2000) / 1000)
		end
	end
end)
cutscenes.Parent = workspace

if CUTSCENE_FAST_FORWARD_TIME == 0 then
	CUTSCENE_FAST_FORWARD_TIME = nil
end

return CutsceneHandler