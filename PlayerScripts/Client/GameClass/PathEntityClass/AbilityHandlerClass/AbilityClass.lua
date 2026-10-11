local AbilityClass = {}
AbilityClass.__index = AbilityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local AbilityUtilities = require(common:WaitForChild("AbilityUtilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local BeamEffectHelper = require(common:WaitForChild("BeamEffectHelper"))
local Utilities = require(common:WaitForChild("Utilities"))
local parent = script.Parent.Parent.Parent
local enemyClass = parent:WaitForChild("EnemyClass")
local VisualEffectHandler = require(parent:WaitForChild("VisualEffectHandler"))
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

function AbilityClass.New(abilityHandler, name: string, config)
	return (setmetatable({
		Name = name,
		AbilityHandler = abilityHandler,
		PathEntity = nil,
		Config = config,
		CustomCode = nil,
		CharacterModel = nil,
		AnimationName = config.AnimationName,
		IsBurst = config.BurstSize and config.BurstInterval,
		UseDelaysForHidingModels = config.IntroSwitchDelay ~= nil or config.OutroSwitchDelay ~= nil,
		EffectsStartDelay = config.EffectsStartDelay or config.Delay or 0,
		EffectsStopDelay = config.EffectsStopDelay or config.ExecutionTime or 0,
		DefaultEmitterWrapper = nil,
		DefaultSoundWrapper = nil,
		InstantEffectWrapper = nil,
		DelayRemaining = 0,
		ExecutionTimeRemaining = 0,
		Performed = false,
		BurstCount = 0,
		BurstCompleted = true,
		IntroSwitchDelayRemaining = 0,
		OutroSwitchDelayRemaining = 0,
		HideWhenActiveModel = nil,
		HasShowWhenActiveModels = false,
		HideModelVisible = true,
		ShowModelVisible = true,
		HideModelTransparancyMap = {},
		ShowModelTransparancyMap = {},
		EffectsStartDelayRemaining = 0,
		EffectsStopDelayRemaining = 0,
		HasDefaultEffects = false,
		EffectsPlaying = false,
		BeamEffects = nil,
		BeamsSetUp = false,
		BeamEffectsV2 = nil,
		BeamEffectsV2SetUp = false,
		TargetEntity = nil,
		AffectedEntities = nil
	}, AbilityClass))
end

function AbilityClass:SetPathEntity(pathEntity)
	local config = self.Config
	local character = pathEntity.Character
	self.PathEntity = pathEntity
	self.CharacterModel = character:GetCharacterModel()
	local hiddenWhenBeingUsedModelName = config.HiddenWhenBeingUsedModelName
	local shownWhenBeingUsedModelNames = config.ShownWhenBeingUsedModelNames

	if hiddenWhenBeingUsedModelName then
		local folder = self.CharacterModel:FindFirstChild(hiddenWhenBeingUsedModelName)

		if folder then
			self.HideWhenActiveModel = folder

			for _, part in pairs(folder:GetDescendants()) do
				if not part:IsA("BasePart") then
					continue
				end

				self.HideModelTransparancyMap[part] = part.Transparency
				part:SetAttribute("NoStealthShimmer", false)
			end
		else
			warn("Did not find child with name " .. hiddenWhenBeingUsedModelName)
		end
	end

	if shownWhenBeingUsedModelNames then
		for _, childName in pairs(shownWhenBeingUsedModelNames) do
			local folder = self.CharacterModel:FindFirstChild(childName)

			if folder then
				self.HasShowWhenActiveModels = true

				for _, part in pairs(folder:GetDescendants()) do
					if not part:IsA("BasePart") then
						continue
					end

					self.ShowModelTransparancyMap[part] = part.Transparency
					part:SetAttribute("NoStealthShimmer", true)
				end
			else
				warn("Did not find child with name " .. childName)
			end
		end
	end

	local autoHandledEffectInstances, v = AbilityUtilities.GetAutoHandledEffectInstances(self.CharacterModel, config)

	if config.EffectParentInstanceNames or autoHandledEffectInstances then
		self.DefaultEmitterWrapper = WrapperFactory.NewEmitterWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		self.DefaultSoundWrapper = WrapperFactory.NewSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		self.HasDefaultEffects = true

		if config.EffectParentInstanceNames then
			for _, effectParentInstanceName in pairs(config.EffectParentInstanceNames) do
				local v2 = Utilities.TryGetInstanceFromPath(self.CharacterModel, effectParentInstanceName)

				if v2 then
					self.DefaultEmitterWrapper:AddEmittersFrom(v2, DEFAULT_SPEED_MULTIPLIER)
					self.DefaultSoundWrapper:AddSoundsFrom(v2, DEFAULT_SPEED_MULTIPLIER)
				else
					warn("Didn't find instance with name " .. effectParentInstanceName)
				end
			end
		end

		if autoHandledEffectInstances then
			self.DefaultEmitterWrapper:AddEmittersFrom(autoHandledEffectInstances, DEFAULT_SPEED_MULTIPLIER)
			self.DefaultSoundWrapper:AddSoundsFrom(autoHandledEffectInstances, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	if config.InstantPlayEffectParentInstanceNames or #v > 0 then
		self.InstantEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		if config.InstantPlayEffectParentInstanceNames then
			for _, instantPlayEffectParentInstanceName in pairs(config.InstantPlayEffectParentInstanceNames) do
				local v2 = Utilities.TryGetInstanceFromPath(self.CharacterModel, instantPlayEffectParentInstanceName)

				if v2 then
					self.InstantEffectWrapper:AddFrom(v2, DEFAULT_SPEED_MULTIPLIER)
				else
					warn("Didn't find instance with name " .. instantPlayEffectParentInstanceName)
				end
			end
		end

		for _, v2 in ipairs(v) do
			self.InstantEffectWrapper:AddFrom(v2, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	local function SetUpKeyframeReachedEvent(animationName: string)
		local primaryAnimationHandler = character.PrimaryAnimationHandler
		local animation = primaryAnimationHandler and primaryAnimationHandler:GetAnimation(animationName)

		if animation then
			animation:SetUpKeyframeReachedEvent(function(p: string)
				self:_KeyframeReached(p)
			end)
		else
			warn("Couldn't find enemy ability animation", animationName)
		end
	end

	if self.AnimationName then
		SetUpKeyframeReachedEvent(self.AnimationName)
	end
end

function AbilityClass:_KeyframeReached(p: string)
	if self.HasDefaultEffects then
		self.DefaultEmitterWrapper:PlayKeyframeTriggered(p)
		self.DefaultSoundWrapper:PlayKeyframeTriggered(p)
	end

	if self.CustomCode then
		self.CustomCode:AbilityAnimationKeyframeReached(self.Name, p)
	end
end

function AbilityClass:BeingUsed()
	return self.ExecutionTimeRemaining > 0
end

function AbilityClass:_GetTargetEntities(list)
	local module = require(enemyClass)
	local v = list[4]
	local v2 = { TargetEntity = nil, TargetEntities = nil }

	if v then
		v2.TargetEntity = module.GetEnemy(v)
	end

	local v3 = list[5]
	local enemies = {}

	if v3 then
		for _, v4 in pairs(v3) do
			local enemy = module.GetEnemy(v4)

			if enemy then
				table.insert(enemies, enemy)
			end
		end
	end

	v2.TargetEntities = enemies
	return v2
end

function AbilityClass:AbilityUsedOnServer(list)
	local pathEntity = self.PathEntity
	local character = pathEntity.Character
	local config = self.Config
	local delayRemaining = list[2]
	local executionTimeRemaining = list[3]
	local targetEntities = self:_GetTargetEntities(list)
	self.DelayRemaining = delayRemaining
	self.ExecutionTimeRemaining = executionTimeRemaining
	self.Performed = false
	self.TargetEntity = targetEntities.TargetEntity
	self.TargetIsTower = targetEntities.TargetIsTower
	self.TargetIsPathEntity = targetEntities.TargetIsPathEntity
	self.TargetIsMapEntity = targetEntities.TargetIsMapEntity
	self.AffectedEntities = targetEntities.TargetEntities

	if self.UseDelaysForHidingModels then
		self.IntroSwitchDelayRemaining = config.IntroSwitchDelay
		self.OutroSwitchDelayRemaining = config.OutroSwitchDelay
	end

	self.EffectsStartDelayRemaining = self.EffectsStartDelay
	self.EffectsStopDelayRemaining = self.EffectsStopDelay
	local pathEntityToEnemyRangedData = config.PathEntityToEnemyRangedData
	local beamEffectHandlingData = pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.BeamEffectHandlingData

	if beamEffectHandlingData then
		self:_TriggerBeamEffects(beamEffectHandlingData, targetEntities.TargetEntity)
	end

	if config.PathEntityToEnemyRangedData and self.IsBurst then
		self.BurstCount = 0
		self.BurstCompleted = false
	end

	if self.DelayRemaining == 0 and self.ExecutionTimeRemaining == 0 then
		self:_PlayEffects()
	end

	if self.InstantEffectWrapper then
		self.InstantEffectWrapper:PlayAll()
	end

	if config.FaceTurretToTarget and targetEntities.TargetEntity then
		pathEntity:FaceTurretToTarget(targetEntities.TargetEntity, config.TurretIndex or 1)
	end

	if config.TriggerRotatingBarrels then
		character:TriggerRotatingBarrels(config.TriggerRotatingBarrelsTime)
	end

	if config.ToggleShieldModelForTime then
		character:ToggleShieldForTime(config.ToggleShieldModelForTime)
	end

	self:_HandleDestroyInstances()
end

function AbilityClass:Run(p: number)
	local config = self.Config
	self.DelayRemaining = math.max(0, self.DelayRemaining - p)
	self.ExecutionTimeRemaining = math.max(0, self.ExecutionTimeRemaining - p)

	if self.UseDelaysForHidingModels then
		self.IntroSwitchDelayRemaining = math.max(0, self.IntroSwitchDelayRemaining - p)
		self.OutroSwitchDelayRemaining = math.max(0, self.OutroSwitchDelayRemaining - p)
	end

	self.EffectsStartDelayRemaining = math.max(0, self.EffectsStartDelayRemaining - p)
	self.EffectsStopDelayRemaining = math.max(0, self.EffectsStopDelayRemaining - p)
	self:_UpdateEffects()
	self:_UpdateAbilityModels()

	if self.CustomCode then
		self.CustomCode:AbilityUsed(self.Name)
	end

	if self.DelayRemaining <= 0 and config.PathEntityToEnemyRangedData and self.IsBurst and not self.BurstCompleted then
		self.BurstCount += 1

		if not config.EffectsOnlyOnInitialBurst or self.BurstCount == 1 then
			self:_PlayEffects(true)
		end

		if self.BurstCount < config.BurstSize then
			self.DelayRemaining = config.BurstInterval
		else
			self.BurstCompleted = true
		end
	end

	if self.DelayRemaining <= 0 and not self.Performed then
		if config.RemoveForceFaceOnExecution then
			self.PathEntity.MovementHandler:RemoveForceFacePosition()
		end

		self.Performed = true
	end

	if self.BeamEffects then
		BeamEffectHelper.RunBeamEffects(p, self.BeamEffects)
	end

	self:_RunBeamEffectsV2(p)
end

function AbilityClass:Destroy()
	self:_StopEffects()
	local hasDefaultEffects = self.HasDefaultEffects
	local defaultEmitterWrapper = self.DefaultEmitterWrapper
	local defaultSoundWrapper = self.DefaultSoundWrapper
	local instantEffectWrapper = self.InstantEffectWrapper

	if hasDefaultEffects then
		defaultEmitterWrapper:StopContinuous()
		defaultSoundWrapper:StopContinuous()
		defaultSoundWrapper:FadeOutPlayingTriggeredSounds()
	end

	if instantEffectWrapper then
		instantEffectWrapper:StopContinuous()
		instantEffectWrapper:FadeOutPlayingTriggeredSounds()
	end

	if self.BeamEffects then
		BeamEffectHelper.StopBeamEffects(self.BeamEffects)
	end

	if self.BeamEffectsV2 then
		for _, v in pairs(self.BeamEffectsV2) do
			BeamEffectHelper.StopBeamEffects(v)
		end
	end
end

function AbilityClass.SetSpeedMultiplier(data, p: number)
	if data.HasDefaultEffects then
		data.DefaultEmitterWrapper:SpeedMultiplierChanged(p)
		data.DefaultSoundWrapper:SpeedMultiplierChanged(p)
	end

	if data.InstantEffectWrapper then
		data.InstantEffectWrapper:SpeedMultiplierChanged(p)
	end

	if data.BeamEffects then
		BeamEffectHelper.SpeedMultiplierChanged(p, data.BeamEffects)
	end

	if data.BeamEffectsV2 then
		for _, v in pairs(data.BeamEffectsV2) do
			BeamEffectHelper.SpeedMultiplierChanged(p, v)
		end
	end
end

function AbilityClass:SetCustomCode(customCode)
	self.CustomCode = customCode
end

function AbilityClass:_UpdateEffects()
	local config = self.Config

	if self.EffectsStopDelayRemaining <= 0 then
		if config.PlayEffectsUntilDeath then
			return
		end

		self:_StopEffects()
	elseif self.EffectsStartDelayRemaining <= 0 then
		self:_PlayEffects()
	end
end

function AbilityClass:_StopEffects()
	local hasDefaultEffects = self.HasDefaultEffects
	local defaultEmitterWrapper = self.DefaultEmitterWrapper
	local defaultSoundWrapper = self.DefaultSoundWrapper

	if self.EffectsPlaying then
		if hasDefaultEffects then
			defaultEmitterWrapper:StopContinuous()
			defaultSoundWrapper:StopContinuous()
		end

		self.EffectsPlaying = false
	end
end

function AbilityClass:_PlayEffects(flag: boolean?)
	local _character = self.PathEntity.Character
	local _config = self.Config
	local hasDefaultEffects = self.HasDefaultEffects
	local defaultEmitterWrapper = self.DefaultEmitterWrapper
	local defaultSoundWrapper = self.DefaultSoundWrapper

	if not self.EffectsPlaying or flag then
		if hasDefaultEffects then
			defaultEmitterWrapper:PlayAll()
			defaultSoundWrapper:PlayAll()
		end

		self:_HandleAffectedEntityEffects()
		self.EffectsPlaying = true
	end
end

function AbilityClass:_UpdateAbilityModels()
	if self.UseDelaysForHidingModels then
		if self.OutroSwitchDelayRemaining <= 0 then
			self:_ShowIdleState()
		elseif self.IntroSwitchDelayRemaining <= 0 then
			self:_ShowActiveState()
		end
	elseif self:BeingUsed() then
		self:_ShowActiveState()
	else
		self:_ShowIdleState()
	end
end

function AbilityClass:_ShowActiveState()
	if self.HideModelVisible and self.HideWhenActiveModel then
		for k, _ in pairs(self.HideModelTransparancyMap) do
			k.Transparency = 1
			k:SetAttribute("NoStealthShimmer", true)
		end

		self.HideModelVisible = false
	end

	if not self.ShowModelVisible and self.HasShowWhenActiveModels then
		for k, transparency in pairs(self.ShowModelTransparancyMap) do
			k.Transparency = transparency
			k:SetAttribute("NoStealthShimmer", false)
		end

		self.ShowModelVisible = true
	end
end

function AbilityClass:_ShowIdleState()
	if not self.HideModelVisible and self.HideWhenActiveModel then
		for k, transparency in pairs(self.HideModelTransparancyMap) do
			k.Transparency = transparency
			k:SetAttribute("NoStealthShimmer", false)
		end

		self.HideModelVisible = true
	end

	if self.ShowModelVisible and self.HasShowWhenActiveModels then
		for k, _ in pairs(self.ShowModelTransparancyMap) do
			k.Transparency = 1
			k:SetAttribute("NoStealthShimmer", true)
		end

		self.ShowModelVisible = false
	end
end

function AbilityClass:_TriggerBeamEffects(p, player)
	if not player then
		return
	end

	if not self.BeamsSetUp then
		self.BeamEffects = BeamEffectHelper.NewBeamEffects(self.CharacterModel, p, DEFAULT_SPEED_MULTIPLIER)
		self.BeamsSetUp = true
	end

	BeamEffectHelper.StartBeamEffects(self.BeamEffects, self.DelayRemaining, nil, nil, player.Character)
end

function AbilityClass:_HandleAffectedEntityEffects()
	local config = self.Config
	local affectedEntityEffectData = config.AffectedEntityEffectData

	if not affectedEntityEffectData then
		return
	end

	local _targetEntity = self.TargetEntity
	local affectedEntities = self.AffectedEntities
	local pathEntity = self.PathEntity

	for _, affectedEntity in pairs(affectedEntities) do
		local isAirUnit = affectedEntity:GetIsAirUnit()
		local character = affectedEntity.Character
		local position = nil
		local effectStationary = affectedEntityEffectData.EffectStationary
		local torso

		if affectedEntityEffectData.EffectPositionAtFeet and not isAirUnit then
			torso = character:GetTorso()
		elseif affectedEntityEffectData.EffectPositionOnHead then
			torso = character:GetHead()
		else
			torso = character:GetRealTorso()
		end

		if affectedEntityEffectData.EffectStationary then
			position = torso.Position
		end

		if affectedEntityEffectData.EffectName then
			local v = {
				Name = affectedEntityEffectData.EffectName,
				Position = effectStationary and position,
				FollowPart = not effectStationary and torso
			}
			VisualEffectHandler.NewVisualEffect(v)
		end

		local beamEffectHandlingData = affectedEntityEffectData.BeamEffectHandlingData

		if beamEffectHandlingData then
			self:_HandleBeamEffectsV2(
				beamEffectHandlingData,
				character,
				affectedEntityEffectData.TryRestartExistingBeam
			)
		end

		if affectedEntityEffectData.RenderDebugPart then
			Utilities.RenderPartBetweenPoints(
				pathEntity.Character:GetRealTorso().Position,
				position or torso.Position,
				affectedEntityEffectData.RenderDebugPartColor,
				0.1,
				affectedEntityEffectData.RenderDebugPartDuration or config.ExecutionTime
			)
		end
	end
end

function AbilityClass:_HandleBeamEffectsV2(p, p2, flag: boolean?)
	if not self.BeamEffectsV2SetUp then
		self.BeamEffectsV2 = {}
		self.BeamEffectsV2SetUp = true
	end

	local flag2 = false

	if flag then
		local v = nil

		for _, v2 in pairs(self.BeamEffectsV2) do
			if not (v2[1] and v2[1].On) then
				continue
			end

			v = v2
			break
		end

		if v then
			BeamEffectHelper.StartBeamEffects(v, nil, nil, nil, p2, true)
		else
			flag2 = true
		end
	else
		flag2 = true
	end

	if flag2 then
		local beamEffects = BeamEffectHelper.NewBeamEffects(self.CharacterModel, p, DEFAULT_SPEED_MULTIPLIER)
		self.BeamEffectsV2[os.clock()] = beamEffects
		BeamEffectHelper.StartBeamEffects(beamEffects, nil, nil, nil, p2)
	end
end

function AbilityClass:_RunBeamEffectsV2(p: number)
	if not self.BeamEffectsV2 then
		return
	end

	for k, v in pairs(self.BeamEffectsV2) do
		BeamEffectHelper.RunBeamEffects(p, v)

		if BeamEffectHelper.ReadyToCleanUp(v) then
			self.BeamEffectsV2[k] = nil
		end
	end
end

function AbilityClass:_HandleDestroyInstances()
	local config = self.Config

	if config.DestroyInstanceNames then
		local characterModel = self.PathEntity.Character:GetCharacterModel()

		for _, destroyInstanceName in pairs(config.DestroyInstanceNames) do
			local v = Utilities.TryGetInstanceFromPath(characterModel, destroyInstanceName)

			if v then
				v:Destroy()
			else
				warn("Didn't find instance with name " .. destroyInstanceName)
			end
		end
	end
end

event:AttachCallback(function(p: number)
	DEFAULT_SPEED_MULTIPLIER = p
end)
return AbilityClass