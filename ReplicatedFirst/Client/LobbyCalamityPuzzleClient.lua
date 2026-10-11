local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Network = require(game.ReplicatedFirst.Client.Network)
local isStudio = RunService:IsStudio()

local function log(...)
	if isStudio then
		print("[PCPClient]", ...)
	end
end

local v = nil
local animator = nil
local Ambient = workspace:FindFirstChild("Ambient")
local track = nil
local track2 = nil
local flag = false

local function teleportToDestination(p: string)
	local thread = coroutine.running()
	local firstItem = Director.GetFirstItemFromClass(Director.Classes.FadeFrame)
	firstItem:FadeIn(0.5, function()
		local v2 = Network.Invoke("ClientRequestLocalTeleport", p)
		coroutine.resume(thread, v2)
		task.wait(0.5)
		firstItem:FadeOut(0.5)
	end)
	return coroutine.yield()
end

local function playDoorOpeningAnimation()
	local SoundHandler = require(game.ReplicatedStorage.TDX_Shared.Common:WaitForChild("SoundHandler"))

	if flag then
		return
	end

	flag = true
	track:Stop(0)
	track2:Play(0)
	track2.KeyframeReached:Connect(function(p: string)
		if p == "End" then
			track2:AdjustSpeed(0)
			track2.TimePosition = track2.Length - 0.001
			v.Trigger.Attachment.EnterDoorPrompt.Enabled = true
		end
	end)
	SoundHandler.Play("DoorOpen")
end

local function onPuzzleDataUpdated(lobbyPuzzle) -- 1 equivalent call inferred from this helper
	local translator = lobbyPuzzle.HasTranslator
		and workspace.Lobby.Event.nightmare.CrazyRoom:FindFirstChild("Translator")

	if translator then
		translator:Destroy()
	end
end

local LobbyCalamityPuzzleClient = {}

if not _G.LOBBY_PUZZLE_ENABLED then
	log("Disabled")
	return LobbyCalamityPuzzleClient
end

v = CollectionService:GetTagged("EvilDoor")[1]

if v then
	task.spawn(function()
		local GameSoundHandler = require(game.ReplicatedStorage.TDX_Shared.Components.GameSoundHandler)
		local animationController = v:WaitForChild("AnimationController")
		animator = Instance.new("Animator")
		animator.Parent = animationController
		track = animator:LoadAnimation(v.Animations.Close)
		track2 = animator:LoadAnimation(v.Animations.Open)
		GameSoundHandler.AddSoundToSoundGroup(Ambient, "Ambient")
		v.Trigger.Attachment.InvestigateDoorPrompt.Triggered:Connect(function()
			v.Trigger.Attachment.InvestigateDoorPrompt.Enabled = false
			playDoorOpeningAnimation()
		end)
		v.Trigger.Attachment.EnterDoorPrompt.Enabled = false
		v.Trigger.Attachment.EnterDoorPrompt.Triggered:Connect(function()
			if teleportToDestination("Room") then
				GameSoundHandler.MuteSoundGroup("Music")
				Ambient:Play()
			end
		end)
		workspace.Lobby.Event.nightmare.CrazyRoom.Door.Trigger.Attachment.EnterDoorPrompt.Triggered:Connect(function(_)
			if teleportToDestination("RoomExit") then
				GameSoundHandler.UnmuteSoundGroup("Music")
				Ambient:Stop()
			end
		end)
		track:Play(0, 1, 0)
		track:AdjustSpeed(0)
		track.TimePosition = 0
		local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
		Data.Updated:Connect(function(p: string)
			local translator = p == "LobbyPuzzle"
				and Data.Get("LobbyPuzzle").HasTranslator
				and workspace.Lobby.Event.nightmare.CrazyRoom:FindFirstChild("Translator")

			if translator then
				translator:Destroy()
			end
		end)
		onPuzzleDataUpdated(Data.Get("LobbyPuzzle")) -- inferred equivalent call
	end)
	return LobbyCalamityPuzzleClient
end

warn("Could not find door")
return LobbyCalamityPuzzleClient