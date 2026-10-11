local LightAnimationHandlerClass = {}
LightAnimationHandlerClass.__index = LightAnimationHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))

local function GetInternalAnimations(parent, animator, flag: boolean?, flag2: boolean?)
	local animations = parent:FindFirstChild("Animations")

	if animations then
		local result = {}

		for _, animation in ipairs(animations:GetChildren()) do
			if not animation:IsA("Animation") then
				continue
			end

			local v = {
				Animation = animation,
				AnimationTrack = animator:LoadAnimation(animation),
				PauseOnFinish = flag2 or animation:GetAttribute("PauseOnFinish"),
				NextState = animation:GetAttribute("NextState"),
				TimeScale = animation:GetAttribute("TimeScale"),
				PlayFadeTime = animation:GetAttribute("PlayFadeTime"),
				StopFadeTime = animation:GetAttribute("StopFadeTime"),
				TrackStoppedEvent = nil,
				TrackFinishedCallback = nil
			}
			result[animation.Name] = v
		end

		return result
	else
		if not flag then
			warn("No Animations folder found in character model", parent.Name)
		end

		return {}
	end
end

function LightAnimationHandlerClass.New(parent, value: number?, pauseOnFinish: boolean?, flag: boolean?)
	local speedMultiplier = value or 1
	local animationController = Instance.new("AnimationController", parent)
	local animator = Instance.new("Animator", animationController)
	local internalAnimations = GetInternalAnimations(parent, animator, flag, pauseOnFinish)
	local v = {
		CharacterModel = parent,
		SpeedMultiplier = speedMultiplier,
		EmitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(parent, speedMultiplier),
		Animator = animator,
		InternalAnimations = internalAnimations,
		PauseOnFinish = pauseOnFinish,
		TrackStoppedEvents = {},
		CurrentState = nil
	}
	setmetatable(v, LightAnimationHandlerClass)

	for _, v2 in pairs(internalAnimations) do
		v2.AnimationTrack.KeyframeReached:Connect(function(p: string)
			v.EmitterAndSoundWrapper:PlayKeyframeTriggered(p)
		end)

		if v2.NextState or v2.PauseOnFinish then
			v:_SetUpTrackStoppedEvent(v2)
		end
	end

	return v
end

function LightAnimationHandlerClass:Play(currentState: string, flag: boolean?, timePosition: number?)
	local internalAnimation = self.InternalAnimations[currentState]

	if not internalAnimation then
		warn("No animation track found for state", currentState)
		return
	end

	self.CurrentState = currentState

	if not internalAnimation.Animation:GetAttribute("Additive") then
		for _, internalAnimation2 in pairs(self.InternalAnimations) do
			if internalAnimation2 ~= internalAnimation then
				internalAnimation2.AnimationTrack:Stop(internalAnimation2.StopFadeTime or 0)
			end
		end
	end

	local animationTrack = internalAnimation.AnimationTrack
	local v = (self.SpeedMultiplier or 1) * (internalAnimation.TimeScale or 1)

	if flag then
		if not animationTrack.IsPlaying then
			animationTrack:Play(0, 1, v)
		end

		animationTrack:AdjustSpeed(0)
		animationTrack.TimePosition = 0
	else
		animationTrack:Play(internalAnimation.PlayFadeTime or 0, 1, v)

		if timePosition then
			animationTrack.TimePosition = timePosition
		end
	end
end

function LightAnimationHandlerClass.PauseAdditiveAnimations(p)
	for _, internalAnimation in pairs(p.InternalAnimations) do
		if internalAnimation.Animation:GetAttribute("Additive") and internalAnimation.AnimationTrack.IsPlaying then
			internalAnimation.AnimationTrack:AdjustSpeed(0)
		end
	end
end

function LightAnimationHandlerClass:SetSpeedMultiplier(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, internalAnimation in pairs(self.InternalAnimations) do
		internalAnimation.AnimationTrack:AdjustSpeed(speedMultiplier)
	end

	self.EmitterAndSoundWrapper:SpeedMultiplierChanged(speedMultiplier)
end

function LightAnimationHandlerClass.GetAnimationTrack(p, p2: string)
	local internalAnimation = p.InternalAnimations[p2]
	return internalAnimation and internalAnimation.AnimationTrack
end

function LightAnimationHandlerClass:SetTrackFinishedCallback(p: string, trackFinishedCallback)
	local internalAnimation = self.InternalAnimations[p]

	if not internalAnimation then
		warn("No animation track found for state", p)
		return
	end

	self:_SetUpTrackStoppedEvent(internalAnimation)
	internalAnimation.TrackFinishedCallback = trackFinishedCallback
end

function LightAnimationHandlerClass:_SetUpTrackStoppedEvent(state)
	if state.TrackStoppedEvent then
		return
	end

	local animationTrack = state.AnimationTrack
	state.TrackStoppedEvent = animationTrack.Stopped:Connect(function()
		if self.CurrentState ~= animationTrack.Name then
			return
		end

		if state.TrackFinishedCallback then
			state.TrackFinishedCallback()
		end

		if state.PauseOnFinish then
			if not animationTrack.IsPlaying then
				animationTrack:Play(0, 1, self.SpeedMultiplier or nil)
			end

			animationTrack:AdjustSpeed(0)
			animationTrack.TimePosition = 0.999 * animationTrack.Length
		elseif state.NextState then
			self:Play(state.NextState)
		end
	end)
	table.insert(self.TrackStoppedEvents, state.TrackStoppedEvent)
end

return LightAnimationHandlerClass