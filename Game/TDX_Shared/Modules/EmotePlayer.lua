local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("EmoteTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Signal = require(TDX_Shared.Modules.Signal)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local RequestType = Enums.Emotes.RequestType
local LocalPlayer = Players.LocalPlayer
local EmotePlayer = {}
EmotePlayer.__index = EmotePlayer
local v = {
	PauseAnimation = function(p)
		p.CurrentTrack.Main:AdjustSpeed(0)
	end,
	ResumeAnimation = function(p)
		p.CurrentTrack.Main:AdjustSpeed(1)
	end
}

local function IsCharacterActive(instance) -- 3 equivalent calls inferred from this helper
	return instance ~= nil and instance.Health > 0 and instance:IsDescendantOf(workspace)
end

function EmotePlayer.new(emoteEvent)
	return (setmetatable({
		EmoteEvent = emoteEvent,
		AnimationEventCleaner = Cleaner.new(),
		EmoteEventCleaner = Cleaner.new(),
		CurrentTrack = nil,
		CurrentTrackStopped = nil,
		Humanoid = nil,
		CleaningUp = false,
		Stopped = Signal.new()
	}, EmotePlayer))
end

function EmotePlayer:Play(p: string)
	if self.CleaningUp then
		return
	end

	local v2 = EmoteAnimationsV2[EmoteVariants.Resolve(p, LocalPlayer.Character)]

	if not v2 then
		return
	end

	local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")

	if not humanoid then
		return
	end

	self.Humanoid = humanoid

	local function StopIfCharacterInactive()
		if self.CurrentTrack and not IsCharacterActive(humanoid) then -- inferred equivalent call
			self:Stop()
		end
	end

	self.EmoteEventCleaner:Add(humanoid.Died:Connect(StopIfCharacterInactive))
	self.EmoteEventCleaner:Add(humanoid.AncestryChanged:Connect(StopIfCharacterInactive))

	if v2.CleanupOnMovement then
		self.EmoteEventCleaner:Add(humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
			if not self.CurrentTrack then
				return
			end

			self:Stop()
		end))
	end

	local v3 = math.random(1, #v2.Animations)
	local track = humanoid:LoadAnimation(v2.Animations[v3])
	track.Priority = Enum.AnimationPriority.Movement
	local mainAnimationDelay = v2.MainAnimationDelay

	if mainAnimationDelay then
		task.delay(mainAnimationDelay, function()
			if self.CurrentTrack and self.CurrentTrack.Main == track then
				track:Play()
			end
		end)
	else
		track:Play()
	end

	local track2

	if #v2.StartAnimation > 0 then
		local v4 = math.random(1, #v2.StartAnimation)
		track2 = humanoid:LoadAnimation(v2.StartAnimation[v4])
		track2.Priority = Enum.AnimationPriority.Action
		track2:Play()
	end

	local track3

	if #v2.InteractAnimation > 0 then
		local v4 = math.random(1, #v2.InteractAnimation)
		track3 = humanoid:LoadAnimation(v2.InteractAnimation[v4])
		track3.Priority = Enum.AnimationPriority.Action3
	end

	local track4

	if #v2.EndAnimation > 0 then
		local v4 = math.random(1, #v2.EndAnimation)
		track4 = humanoid:LoadAnimation(v2.EndAnimation[v4])
		track4.Priority = Enum.AnimationPriority.Action4
	end

	local track5

	if #v2.MovingAnimation > 0 then
		local v4 = math.random(1, #v2.MovingAnimation)
		track5 = humanoid:LoadAnimation(v2.MovingAnimation[v4])
		track5.Priority = Enum.AnimationPriority.Action2
		track5:Play()
		track5:AdjustSpeed(0)
		self:_SetupMovingTrack(track5, humanoid, v2.MovingStudsPerLoop)
	end

	self.CurrentTrack = {
		Main = track,
		Start = track2,
		Interact = track3,
		End = track4,
		Moving = track5
	}
	local keyframeEventNames = v2.KeyframeEventNames

	if keyframeEventNames then
		self:_SetupKeyframeAnimationEvents(p, keyframeEventNames)
	end

	self.EmoteEvent:FireServer(RequestType.PlayEmote, p)
	self.CurrentTrackStopped = track.Stopped:Connect(function()
		self.Stopped:Fire()
	end)
end

function EmotePlayer:Stop()
	if self.CleaningUp or not self.CurrentTrack then
		return
	end

	self.CleaningUp = true

	if self.CurrentTrack.End and IsCharacterActive(self.Humanoid) then -- inferred equivalent call
		for _, v2 in self.CurrentTrack do
			v2:Stop()
		end

		local v2 = self.CurrentTrack.End
		v2:Play()

		while v2.IsPlaying do
			if not IsCharacterActive(self.Humanoid) then -- inferred equivalent call
				break
			end

			task.wait()
		end
	end

	self.AnimationEventCleaner:Clean()
	self.EmoteEventCleaner:Clean()

	for _, v2 in self.CurrentTrack do
		v2:Stop()
		v2:Destroy()
	end

	self.CurrentTrack = nil
	self.EmoteEvent:FireServer(RequestType.StopEmote)

	if self.CurrentTrackStopped then
		self.CurrentTrackStopped:Disconnect()
		self.CurrentTrackStopped = nil
	end

	self.CleaningUp = false
end

function EmotePlayer.PlayInteract(p)
	if p.CurrentTrack and p.CurrentTrack.Interact then
		p.CurrentTrack.Interact:Play()
	end
end

function EmotePlayer.IsPlaying(p)
	return p.CurrentTrack ~= nil
end

function EmotePlayer:_SetupMovingTrack(object, p, p2: number?)
	local rootPart = p.RootPart

	if not rootPart then
		return
	end

	local v2 = 0
	self.EmoteEventCleaner:Add(RunService.Heartbeat:Connect(function()
		local dot = rootPart.AssemblyLinearVelocity:Dot(rootPart.CFrame.LookVector)
		local v3 = math.abs(dot) < 0.5 and 0 or dot
		local v4

		if p2 then
			v4 = v3 * object.Length / p2
		else
			v4 = math.sign(v3)
		end

		local v5 = math.round(v4 / 0.25) * 0.25

		if v5 ~= v2 then
			v2 = v5
			object:AdjustSpeed(v5)
		end
	end))
end

function EmotePlayer:_SetupKeyframeAnimationEvents(p: string, p2)
	local all = p2.All

	local function KeyFrameAnimationRequest(p3: string)
		if v[p3] then
			v[p3](self)
		else
			self.EmoteEvent:FireServer(RequestType.KeyframeEvent, p, p3)
		end
	end

	local function ConnectEvents(object, items)
		for _, item in items do
			self.AnimationEventCleaner:Add(object:GetMarkerReachedSignal(item):Connect(KeyFrameAnimationRequest))
		end
	end

	for k, v2 in self.CurrentTrack do
		for k2, _ in v do
			self.AnimationEventCleaner:Add(v2:GetMarkerReachedSignal(k2):Connect(KeyFrameAnimationRequest))
		end

		local v3 = p2[k]

		if v3 then
			ConnectEvents(v2, v3)
		end

		if all then
			ConnectEvents(v2, all)
		end
	end
end

function EmotePlayer:Destroy()
	self.AnimationEventCleaner:Clean()
	self.EmoteEventCleaner:Clean()

	if self.CurrentTrackStopped then
		self.CurrentTrackStopped:Disconnect()
		self.CurrentTrackStopped = nil
	end
end

return EmotePlayer