local AnimationClass = {}
AnimationClass.__index = AnimationClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local Utilities = require(common:WaitForChild("Utilities"))
local v = { Death = true, DeathBurn = true, DeathOverkill = true, DeathSpecial = true }
local v2 = { Spawn = true }
local TryGetInstanceFromPath = Utilities.TryGetInstanceFromPath
local TryReadChildValue = Utilities.TryReadChildValue

local function IsEnemyWithAbility(p: string, data) -- 2 equivalent calls inferred from this helper
	if p == "Enemy" and (data.IsBoss or data.IsMiniBoss or data.AbilityNames or data.SpawnAnimationTime) then
		return true
	end

	return false
end

local function GetRandomMultiplier(p: string, p2: string, data)
	if p2 == "Enemy" then
		if IsEnemyWithAbility("Enemy", data) or p ~= "Move" then -- inferred equivalent call
			return 1
		end

		return math.random(90, 110) / 100
	else
		if p2 == "Tower" then
			return 1
		elseif p2 == "PathEntity" then
			return 1
		elseif p2 == "StaticEntity" then
			return 1
		elseif p2 == "AttachmentEntity" then
			return 1
		elseif p2 == "MapEntity" then
			return 1
		end

		warn("Unknown entity type " .. tostring(p2))
		return 1
	end
end

function AnimationClass.New(name: string, entityClass: string, data, instance, animator, instance2, speedMultiplier: number, speed: number, isAttack: boolean?)
	local v3 = entityClass == "Tower"
	local track = animator:LoadAnimation(instance2)
	local triggeredSoundWrapper = nil
	local sound = TryReadChildValue(instance2, "SoundTrigger", nil)

	if typeof(sound) == "string" then
		sound = Utilities.TryGetInstanceFromPath(instance, sound)
	end

	if sound then
		triggeredSoundWrapper = WrapperFactory.NewSoundWrapper(nil, speedMultiplier)

		if sound:IsA("Sound") then
			triggeredSoundWrapper:AddSound(sound, speedMultiplier)
		else
			triggeredSoundWrapper:AddSoundsFrom(sound, speedMultiplier, nil, true)
		end
	end

	local keyframeTriggeredEffectsWrapper = nil
	local tryReadChildValue = TryReadChildValue(instance2, "KeyframeEffects", nil)

	if typeof(tryReadChildValue) == "string" then
		tryReadChildValue = Utilities.TryGetInstanceFromPath(instance, tryReadChildValue)

		if not tryReadChildValue then
			warn("Could not find KeyframeTriggeredEffects instance at " .. tostring(tryReadChildValue))
		end
	end

	if tryReadChildValue then
		keyframeTriggeredEffectsWrapper = WrapperFactory.NewEmitterAndSoundWrapper(tryReadChildValue, speedMultiplier)
		keyframeTriggeredEffectsWrapper:AddFrom(tryReadChildValue, speedMultiplier)
	end

	local isMovement = name == "Move" or TryReadChildValue(instance2, "IsMovement", false)
	local v4 = name == "Death"
	local footstepEffectInstanceNames = not v3

	if footstepEffectInstanceNames then
		if data.SetUpFootstepKeyframeReachedEventForAllAnimations or isMovement or v4 then
			footstepEffectInstanceNames = data.FootstepEffectInstanceNames
		else
			footstepEffectInstanceNames = v4
		end
	end

	local pauseOnFinish = (v[name] or TryReadChildValue(instance2, "PauseOnFinish", false))
		and not instance2:GetAttribute("NoPauseOnFinish")
	local pauseOnFirstFrame = TryReadChildValue(instance2, "PauseOnFirstFrame", false)
	local pauseOnLastFrame = TryReadChildValue(instance2, "PauseOnLastFrame", false)

	if v[name] then
		track.Looped = false
	end

	local overrideAnimationCalibratedSpeed = TryReadChildValue(instance2, "AnimationCalibratedSpeed", nil)
	local movementAnimationCalibrationMultiplier = 1

	if isMovement or overrideAnimationCalibratedSpeed then
		local v5 = overrideAnimationCalibratedSpeed
			or instance:GetAttribute("AnimationCalibratedSpeed")
			or data.AnimationCalibratedSpeed

		if v5 then
			movementAnimationCalibrationMultiplier = data.Speed / v5
		end

		movementAnimationCalibrationMultiplier = data.NoAdjustMovementAnimationSpeed and 1
			or movementAnimationCalibrationMultiplier
		track.Priority = Enum.AnimationPriority.Movement
	end

	local keyframeToHideInstancesMap = nil
	local keyframeToShowInstancesMap = nil

	local function ProcessHideShowPartConfig(instance3, flag: boolean)
		local v5 = flag and keyframeToHideInstancesMap or keyframeToShowInstancesMap

		for _, child in pairs(instance3:GetChildren()) do
			local value = child.Value
			local tryReadChildValue2 = TryReadChildValue(child, "KeyframeName", "__Instant")
			local tryGetInstanceFromPath = TryGetInstanceFromPath(instance, value)

			if tryGetInstanceFromPath then
				if not v5[tryReadChildValue2] then
					v5[tryReadChildValue2] = {}
				end

				table.insert(v5[tryReadChildValue2], tryGetInstanceFromPath)

				if not tryGetInstanceFromPath:GetAttribute("OriginalTransparency") then
					tryGetInstanceFromPath:SetAttribute("OriginalTransparency", 0)
				end
			else
				warn(`Animation [{name}] Could not find part at path {value}`)
			end
		end
	end

	local hideParts = instance2:FindFirstChild("HideParts")
	local showParts = instance2:FindFirstChild("ShowParts")

	if hideParts then
		keyframeToHideInstancesMap = {}
		ProcessHideShowPartConfig(hideParts, true)
	end

	if showParts then
		keyframeToShowInstancesMap = {}
		ProcessHideShowPartConfig(showParts, false)
	end

	local tryReadChildValue2 = TryReadChildValue(instance2, "PlayFadeTime", data.AnimationDefaultPlayFadeTime)
	local stopFadeTime = TryReadChildValue(instance2, "StopFadeTime", data.AnimationDefaultStopFadeTime)
	local playFadeTime = v2[name] and 0 or tryReadChildValue2
	local v5 = {
		EntityClass = entityClass,
		Name = name,
		AnimationHandler = nil,
		Track = track,
		AnimationTimeScale = TryReadChildValue(instance2, "TimeScale", data.AnimationTimeScale or 1),
		Weight = TryReadChildValue(instance2, "Weight", 1),
		PlayFadeTime = playFadeTime,
		StopFadeTime = stopFadeTime,
		StartingTimePosition = TryReadChildValue(instance2, "StartingTimePosition", nil),
		Reverse = TryReadChildValue(instance2, "Reverse", nil),
		IsMovement = isMovement,
		IsEnemyWithAbility = IsEnemyWithAbility(entityClass, data), -- inferred equivalent call
		NoUpgradeTransition = instance2:GetAttribute("NoUpgradeTransition") or false,
		OverrideAnimationCalibratedSpeed = overrideAnimationCalibratedSpeed,
		KeyframeTriggeredEffectsWrapper = keyframeTriggeredEffectsWrapper,
		PauseOnFinish = pauseOnFinish,
		PauseOnFirstFrame = pauseOnFirstFrame,
		PauseOnLastFrame = pauseOnLastFrame,
		NextAnimationState = TryReadChildValue(instance2, "NextAnimationState", nil),
		AlwaysInterrupt = TryReadChildValue(instance2, "AlwaysInterrupt", false),
		Additive = TryReadChildValue(instance2, "Additive", false),
		Duration = TryReadChildValue(instance2, "Duration", nil),
		TimeLeft = 0,
		TriggeredSoundWrapper = triggeredSoundWrapper,
		SetUpKeyframeReachedForAnimationTriggeredEffects = data.SetUpKeyframeReachedForAnimationTriggeredEffects,
		TriggerRotatingBarrels = TryReadChildValue(instance2, "TriggerRotatingBarrels", false),
		Character = nil,
		KeyframeToShowInstancesMap = keyframeToShowInstancesMap,
		KeyframeToHideInstancesMap = keyframeToHideInstancesMap,
		Paused = false,
		Speed = speed,
		SpeedMultiplier = speedMultiplier,
		RandomMultiplier = GetRandomMultiplier(name, entityClass, data),
		MovementAnimationCalibrationMultiplier = movementAnimationCalibrationMultiplier,
		Initialized = false,
		PlayAgainWhenFinished = false,
		IsAttack = isAttack,
		SetUpKeyframeReachedEventForAttack = data.SetUpKeyframeReachedEventForAttack,
		HasFootstepEffects = footstepEffectInstanceNames,
		HasWeightKeyframeEvents = TryReadChildValue(instance2, "HasWeightKeyframeEvents", false),
		KeyframeReachedEvent = nil,
		KeyframeReachedCallbacks = {},
		TrackStoppedEvent = nil
	}

	if isAttack then
		track.Looped = TryReadChildValue(instance2, "Looped", false)
	end

	return (setmetatable(v5, AnimationClass))
end

function AnimationClass:InitializeWithCharacter(character)
	self.Character = character
end

function AnimationClass.HasAnimationCalibratedSpeed(p)
	return p.OverrideAnimationCalibratedSpeed
end

function AnimationClass:SetUpKeyframeReachedEvent(callback)
	if not self.KeyframeReachedEvent then
		self:_NewKeyframeReachedEvent()
	end

	table.insert(self.KeyframeReachedCallbacks, callback)
end

function AnimationClass:_NewKeyframeReachedEvent()
	self.KeyframeReachedEvent = self.Track.KeyframeReached:Connect(function(p: string)
		for _, keyframeReachedCallback in ipairs(self.KeyframeReachedCallbacks) do
			keyframeReachedCallback(p)
		end
	end)
end

function AnimationClass:_Initialize()
	self:SetSpeedMultiplier(self.SpeedMultiplier)
	local track = self.Track

	if track.Looped and not self.IsEnemyWithAbility then
		track.TimePosition = math.random(0, 100) / 100 * track.Length
	end

	if self.SetUpKeyframeReachedEventForAttack then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self.Character:AttackKeyframeReached(p)
		end)
	end

	if self.HasFootstepEffects then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self.Character:FootstepKeyframeReached(p)
		end)
	end

	if self.KeyframeToShowInstancesMap or self.KeyframeToHideInstancesMap then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self:_ProcessShowHideKeyframe(p)
		end)
	end

	if self.SetUpKeyframeReachedForAnimationTriggeredEffects and self.TriggeredSoundWrapper then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self.TriggeredSoundWrapper:PlayKeyframeTriggered(p)
		end)
	end

	if self.HasWeightKeyframeEvents then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self:_HandleWeightKeyframeEvent(p)
		end)
	end

	if self.KeyframeTriggeredEffectsWrapper then
		self:SetUpKeyframeReachedEvent(function(p: string)
			self.KeyframeTriggeredEffectsWrapper:PlayKeyframeTriggered(p)
		end)
	end

	self.Initialized = true
end

function AnimationClass:_HandleWeightKeyframeEvent(value: string)
	if not value:find("^Weight_") then
		return
	end

	local parts = value:split("_")
	local v3 = tonumber(parts[2])
	local v4 = tonumber(parts[3])

	if not v3 then
		warn("Invalid weight keyframe event: " .. value)
	elseif v4 then
		self.Track:AdjustWeight(v3, v4)
	else
		warn("Invalid weight keyframe event: " .. value)
	end
end

function AnimationClass:_ProcessShowHideKeyframe(p: string)
	local keyframeToShowInstancesMap = self.KeyframeToShowInstancesMap
	local keyframeToHideInstancesMap = self.KeyframeToHideInstancesMap

	if keyframeToShowInstancesMap then
		local v3 = keyframeToShowInstancesMap[p]

		if v3 then
			for _, v4 in ipairs(v3) do
				v4.Transparency = 0
				v4:SetAttribute("StealthMakeInvisible", false)
			end
		end
	end

	local v3 = keyframeToHideInstancesMap and keyframeToHideInstancesMap[p]

	if v3 then
		for _, v4 in ipairs(v3) do
			v4.Transparency = 1
			v4:SetAttribute("StealthMakeInvisible", true)
		end
	end
end

function AnimationClass.CanInterrupt(p)
	return p.AlwaysInterrupt
end

function AnimationClass:Run(p: number)
	if self.Duration and self.Track.IsPlaying then
		self.TimeLeft -= p

		if self.TimeLeft <= 0 and self.AnimationHandler then
			self.AnimationHandler:NotLoopedAnimationFinished(self)
		end
	end
end

function AnimationClass:Play(flag: boolean?, value: number?)
	self.Paused = false
	self.PlayAgainWhenFinished = false
	local timePosition = (value or 0) + (self.StartingTimePosition or 0)
	local finalTrackSpeed = self:_GetFinalTrackSpeed()
	local track = self.Track
	track:Play(flag and 0 or self.PlayFadeTime, self.Weight, finalTrackSpeed)

	if self.PauseOnFirstFrame then
		self:Pause(nil, true)
	elseif self.PauseOnLastFrame then
		self:Pause(true)
	end

	if not self.Initialized then
		self:_Initialize()
	end

	if self.IsAttack then
		self.Character:PlayAttackContinuousEffects()
	end

	if self.TriggeredSoundWrapper then
		self.TriggeredSoundWrapper:PlayAll(value, finalTrackSpeed)
	end

	if self.Duration then
		self.TimeLeft = self.Duration
	end

	if timePosition > 0 then
		track.TimePosition = timePosition
	end

	if self.KeyframeToShowInstancesMap or self.KeyframeToHideInstancesMap then
		self:_ProcessShowHideKeyframe("__Instant")
	end

	if self.TriggerRotatingBarrels then
		self.Character:TriggerRotatingBarrels()
	end
end

function AnimationClass:Stop()
	self.Track:Stop(self.StopFadeTime)

	if self.IsAttack then
		self.Character:StopAttackContinuousEffects()
	end

	if self.TriggeredSoundWrapper then
		self.TriggeredSoundWrapper:StopContinuous()
	end
end

function AnimationClass:Pause(flag: boolean?, flag2: boolean?)
	self.Paused = true
	local track = self.Track
	track:AdjustSpeed(0)

	if self.IsAttack then
		self.Character:StopAttackContinuousEffects()
	end

	if not track.IsPlaying then
		track:Play(0, self.Weight, 0)
	end

	if flag then
		track.TimePosition = 0.999 * track.Length
	elseif flag2 then
		track.TimePosition = 0
	end
end

function AnimationClass.GetTimePosition(p)
	return p.Track.TimePosition
end

function AnimationClass.SetTimePosition(p, timePosition: number)
	p.Track.TimePosition = timePosition
end

function AnimationClass:_GetFinalTrackSpeed()
	if self.Paused then
		return 0
	end

	local animationTimeScale = self.AnimationTimeScale
	local speed = self.Speed
	local speedMultiplier = self.SpeedMultiplier
	local randomMultiplier = self.RandomMultiplier
	local movementAnimationCalibrationMultiplier = self.MovementAnimationCalibrationMultiplier
	local v3 = self.Reverse and -1 or 1
	return animationTimeScale * speed * speedMultiplier * randomMultiplier * movementAnimationCalibrationMultiplier * v3
end

function AnimationClass:SetSpeedMultiplier(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	if self.TriggeredSoundWrapper then
		self.TriggeredSoundWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	if self.KeyframeTriggeredEffectsWrapper then
		self.KeyframeTriggeredEffectsWrapper:SpeedMultiplierChanged(speedMultiplier)
	end

	self.Track:AdjustSpeed(self:_GetFinalTrackSpeed())
end

function AnimationClass:SetAnimationSpeed(speed: number)
	self.Speed = speed
	self.Track:AdjustSpeed(self:_GetFinalTrackSpeed())
end

function AnimationClass:SetAnimationHandler(animationHandler)
	self.AnimationHandler = animationHandler
	local track = self.Track
	self.TrackStoppedEvent = track.Stopped:Connect(function()
		if not self.Paused then
			if self.PauseOnFinish then
				self:Pause(true)
			elseif not track.Looped and self.AnimationHandler and not self.Additive then
				self.AnimationHandler:NotLoopedAnimationFinished(self, self.PlayAgainWhenFinished)
			end
		end
	end)
end

function AnimationClass:SetPlayAgainWhenFinished()
	self.PlayAgainWhenFinished = true
end

function AnimationClass.IsLooped(p)
	return p.Track.Looped
end

function AnimationClass.IsPaused(p)
	return p.Paused
end

function AnimationClass.GetNextAnimationState(p)
	return p.NextAnimationState
end

function AnimationClass.IsAdditive(p)
	return p.Additive
end

function AnimationClass.SetPriority(p, priority: number)
	p.Track.Priority = priority
end

function AnimationClass.Destroy(p)
	local keyframeReachedEvent = p.KeyframeReachedEvent

	if keyframeReachedEvent then
		keyframeReachedEvent:Disconnect()
	end

	local trackStoppedEvent = p.TrackStoppedEvent

	if trackStoppedEvent then
		trackStoppedEvent:Disconnect()
	end
end

return AnimationClass