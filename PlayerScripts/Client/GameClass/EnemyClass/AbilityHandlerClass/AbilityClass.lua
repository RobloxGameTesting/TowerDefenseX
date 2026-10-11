local AbilityClass = {}
AbilityClass.__index = AbilityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
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
local towerClass = parent:WaitForChild("TowerClass")
local pathEntityClass = parent:WaitForChild("PathEntityClass")
local mapEntityClass = parent:WaitForChild("MapEntityClass")
local VisualEffectHandler = require(parent:WaitForChild("VisualEffectHandler"))
local PlayerEffectHandler = require(parent:WaitForChild("PlayerEffectHandler"))
local MultiJumpHandlerClass = require(script.Parent:WaitForChild("MultiJumpHandlerClass"))
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

local function GetPlayerBeamTargetCharacter(targetPlayerName: string)
	local child = Players:FindFirstChild(targetPlayerName)
	local character = child and child.Character
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

	if character and humanoidRootPart then
		local head = character:FindFirstChild("Head")
		return {
			GetCharacterModel = function(self)
				return character
			end,
			GetHead = function(self)
				return head or humanoidRootPart
			end,
			GetTorso = function(self)
				return humanoidRootPart
			end,
			GetRealTorso = function(self)
				return humanoidRootPart
			end
		}
	else
		return nil
	end
end

local function GetSequenceIndexToWrappers(characterModel, enemyToTowerRangedDataSequence)
	local result = {}
	local result2 = {}

	for i, v in ipairs(enemyToTowerRangedDataSequence) do
		local effectParentInstanceName = v.EffectParentInstanceName

		if not effectParentInstanceName then
			continue
		end

		local v2 = Utilities.TryGetInstanceFromPath(characterModel, effectParentInstanceName)

		if v2 then
			result[i] = WrapperFactory.NewEmitterWrapper(v2, DEFAULT_SPEED_MULTIPLIER)
			result2[i] = WrapperFactory.NewSoundWrapper(v2, DEFAULT_SPEED_MULTIPLIER)
		else
			warn("Effect parent instance with name " .. effectParentInstanceName .. " not found")
		end
	end

	return result, result2
end

function AbilityClass.New(abilityHandler, name: string, config)
	local v = {
		Name = name,
		AbilityHandler = abilityHandler,
		Enemy = nil,
		Config = config,
		CustomCode = nil,
		CharacterModel = nil,
		AnimationName = config.AnimationName,
		SecondaryAnimationForKeyframeEventsName = config.SecondaryAnimationForKeyframeEventsName,
		AdditionalAnimationsForKeyframeEventsNames = config.AdditionalAnimationsForKeyframeEventsNames,
		IsBurst = config.BurstSize and config.BurstInterval,
		UseDelaysForHidingModels = config.IntroSwitchDelay ~= nil or config.OutroSwitchDelay ~= nil,
		EffectsStartDelay = config.EffectsStartDelay or config.Delay or 0,
		EffectsStopDelay = config.EffectsStopDelay or config.ExecutionTime or 0,
		ForcePlayEffectsOnAbilityUsedOnServer = config.ForcePlayEffectsOnAbilityUsedOnServer,
		ForcePlayAnimationOnClientside = config.ForcePlayAnimationOnClientside,
		NoRestartAnimationIfAlreadyPlaying = config.NoRestartAnimationIfAlreadyPlaying,
		StopAnimationDelay = config.StopAnimationDelay,
		DefaultEmitterWrapper = nil,
		DefaultSoundWrapper = nil,
		InstantEffectWrapper = nil,
		SequenceIndexToEmitterWrapperMap = nil,
		SequenceIndexToSoundWrapperMap = nil,
		CurrentSequenceIndex = 1,
		DelayRemaining = 0,
		ExecutionTimeRemaining = 0,
		Performed = false,
		CurrentTeleportData = nil,
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
		SequenceEffectsStartDelayRemaining = 0,
		SequenceEffectsStopDelayRemaining = 0,
		HasDefaultEffects = false,
		HasSequenceEffects = false,
		EffectsPlaying = false,
		SequenceEffectsPlaying = false,
		StopAnimationDelayRemaining = 0,
		AnimationStopped = true,
		ClientsideAnimationFinished = true,
		BeamEffects = nil,
		BeamsSetUp = false,
		BeamEffectsV2 = nil,
		BeamEffectsV2SetUp = false,
		PlayerBeamEffectsMap = nil,
		TargetEntity = nil,
		TargetIsTower = nil,
		TargetIsPathEntity = nil,
		TargetIsMapEntity = nil,
		AffectedEntities = nil,
		MultiJumpHandler = nil
	}

	if config.EnemyMultiJumpData then
		v.MultiJumpHandler = MultiJumpHandlerClass.New(config)
	end

	return (setmetatable(v, AbilityClass))
end

function AbilityClass:SetEnemy(enemy)
	local config = self.Config
	local character = enemy.Character
	self.Enemy = enemy
	self.CharacterModel = character:GetCharacterModel()

	if self.MultiJumpHandler then
		self.MultiJumpHandler:SetEnemy(enemy, DEFAULT_SPEED_MULTIPLIER)
	end

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

	if config.EnemyToTowerRangedDataSequence then
		local sequenceIndexToEmitterWrapperMap, sequenceIndexToSoundWrapperMap = GetSequenceIndexToWrappers(
			self.CharacterModel,
			config.EnemyToTowerRangedDataSequence
		)
		self.SequenceIndexToEmitterWrapperMap = sequenceIndexToEmitterWrapperMap
		self.SequenceIndexToSoundWrapperMap = sequenceIndexToSoundWrapperMap
		self.HasSequenceEffects = true
	end

	local function SetUpKeyframeReachedEvent(p: string)
		local primaryAnimationHandler = character.PrimaryAnimationHandler
		local animation = primaryAnimationHandler and primaryAnimationHandler:GetAnimation(p)

		if animation then
			animation:SetUpKeyframeReachedEvent(function(p2: string)
				self:_KeyframeReached(p2)
			end)
		else
			warn("Couldn't find enemy ability animation", p)
		end
	end

	if self.AnimationName then
		SetUpKeyframeReachedEvent(self.AnimationName)
	end

	if self.SecondaryAnimationForKeyframeEventsName then
		SetUpKeyframeReachedEvent(self.SecondaryAnimationForKeyframeEventsName)
	end

	if self.AdditionalAnimationsForKeyframeEventsNames then
		for _, additionalAnimationsForKeyframeEventsName in pairs(self.AdditionalAnimationsForKeyframeEventsNames) do
			SetUpKeyframeReachedEvent(additionalAnimationsForKeyframeEventsName)
		end
	end
end

function AbilityClass:_KeyframeReached(p: string)
	if self.HasDefaultEffects then
		self.DefaultEmitterWrapper:PlayKeyframeTriggered(p)
		self.DefaultSoundWrapper:PlayKeyframeTriggered(p)
	end

	if self.HasSequenceEffects then
		local v = self.SequenceIndexToEmitterWrapperMap[self.CurrentSequenceIndex]
		local v2 = self.SequenceIndexToSoundWrapperMap[self.CurrentSequenceIndex]

		if v then
			v:PlayKeyframeTriggered(p)
		end

		if v2 then
			v2:PlayKeyframeTriggered(p)
		end
	end

	if self.CustomCode then
		self.CustomCode:AbilityAnimationKeyframeReached(self.Name, p)
	end
end

function AbilityClass:BeingUsed()
	return self.ExecutionTimeRemaining > 0
end

function AbilityClass:_GetTargetEntities(list)
	local module = require(towerClass)
	local module2 = require(pathEntityClass)
	local module3 = require(mapEntityClass)
	local module4 = require(enemyClass)
	local v = list[5]
	local targetIsTower = list[6]
	local targetIsPathEntity = list[7]
	local targetIsMapEntity = list[8]
	local v2 = {
		TargetEntity = nil,
		TargetIsTower = targetIsTower,
		TargetIsPathEntity = targetIsPathEntity,
		TargetIsMapEntity = targetIsMapEntity,
		TargetEntities = nil
	}

	if v then
		if targetIsMapEntity then
			v2.TargetEntity = module3.GetMapEntity(v)
		elseif targetIsTower then
			v2.TargetEntity = module.GetTower(v)
		elseif targetIsPathEntity then
			v2.TargetEntity = module2.GetPathEntity(v)
		else
			v2.TargetEntity = module4.GetEnemy(v)
		end
	end

	local v3 = list[9]
	local v4 = list[10]
	local v5 = list[11]
	local v6 = list[12]
	local targetEntities = {}

	if v3 then
		for _, v7 in pairs(v3) do
			local tower = module.GetTower(v7)

			if tower then
				table.insert(targetEntities, tower)
			end
		end
	end

	if v4 then
		for _, v7 in pairs(v4) do
			local pathEntity = module2.GetPathEntity(v7)

			if pathEntity then
				table.insert(targetEntities, pathEntity)
			end
		end
	end

	if v5 then
		for _, v7 in pairs(v5) do
			local enemy = module4.GetEnemy(v7)

			if enemy then
				table.insert(targetEntities, enemy)
			end
		end
	end

	if v6 then
		for _, v7 in pairs(v6) do
			local mapEntity = module3.GetMapEntity(v7)

			if mapEntity then
				table.insert(targetEntities, mapEntity)
			end
		end
	end

	v2.TargetEntities = targetEntities
	return v2
end

function AbilityClass:_GetTeleportData(list)
	local movementHandler = self.Enemy.MovementHandler
	local enemyTeleportData = self.Config.EnemyTeleportData

	if not enemyTeleportData then
		return
	end

	local v = list[13]
	local pathIndex = v[1]
	local pathPercentage = v[2]
	local goalPosition = v[3]
	return {
		PathIndex = pathIndex,
		PathPercentage = pathPercentage,
		GoalPosition = goalPosition,
		DeltaVector = goalPosition - movementHandler:GetRealCFrame().Position,
		TweenToGoal = enemyTeleportData.TweenToGoal or false,
		TweenStartDelayLeft = enemyTeleportData.TweenStartDelay or 0,
		TweenTimeLeft = enemyTeleportData.TweenTime or 0,
		TweenTotalTime = enemyTeleportData.TweenTime or 0,
		RemoveForceFaceOnStop = enemyTeleportData.RemoveForceFaceOnStop or false,
		JumpHeight = enemyTeleportData.JumpHeight
	}
end

function AbilityClass:AbilityUsedOnServer(list)
	local enemy = self.Enemy
	local character = enemy.Character
	local config = self.Config
	local delayRemaining = list[2]
	local executionTimeRemaining = list[3]
	local currentSequenceIndex = list[4]
	local targetEntities = self:_GetTargetEntities(list)
	local teleportData = self:_GetTeleportData(list)
	self.DelayRemaining = delayRemaining
	self.ExecutionTimeRemaining = executionTimeRemaining
	self.Performed = false
	self.CurrentTeleportData = teleportData
	self.CurrentSequenceIndex = currentSequenceIndex
	self.TargetEntity = targetEntities.TargetEntity
	self.TargetIsTower = targetEntities.TargetIsTower
	self.TargetIsPathEntity = targetEntities.TargetIsPathEntity
	self.TargetIsMapEntity = targetEntities.TargetIsMapEntity
	self.AffectedEntities = targetEntities.TargetEntities
	self.TargetPlayerNames = list[15] or nil

	if self.UseDelaysForHidingModels then
		self.IntroSwitchDelayRemaining = config.IntroSwitchDelay
		self.OutroSwitchDelayRemaining = config.OutroSwitchDelay
	end

	self.EffectsStartDelayRemaining = self.EffectsStartDelay
	self.EffectsStopDelayRemaining = self.EffectsStopDelay
	local v = config.EnemyToTowerRangedDataSequence
		and config.EnemyToTowerRangedDataSequence[self.CurrentSequenceIndex]
		or config.EnemyToMapEntityRangedData

	if v then
		self.SequenceEffectsStartDelayRemaining = v.EffectsStartDelay or self.EffectsStartDelayRemaining
		self.SequenceEffectsStopDelayRemaining = v.EffectsStopDelay or self.EffectsStopDelayRemaining
		local beamEffectHandlingData = v.BeamEffectHandlingData

		if beamEffectHandlingData then
			self:_TriggerBeamEffects(beamEffectHandlingData, targetEntities.TargetEntity)
		end
	end

	local enemyToPlayerRangedData = config.EnemyToPlayerRangedData

	if enemyToPlayerRangedData and enemyToPlayerRangedData.BeamEffectHandlingData and self.TargetPlayerNames then
		for _, targetPlayerName in ipairs(self.TargetPlayerNames) do
			local playerBeamTargetCharacter = GetPlayerBeamTargetCharacter(targetPlayerName)

			if playerBeamTargetCharacter then
				self:_TriggerPlayerBeamEffects(
					targetPlayerName,
					enemyToPlayerRangedData.BeamEffectHandlingData,
					playerBeamTargetCharacter
				)
			end
		end
	end

	self:_HandleColorChange()

	if config.EnemyToTowerRangedDataSequence and self.IsBurst then
		self.BurstCount = 0
		self.BurstCompleted = false
	end

	if self.CustomCode then
		self.CustomCode:AbilityUsed(self.Name)
	end

	if self.DelayRemaining == 0 and self.ExecutionTimeRemaining == 0 then
		self:_PlayEffects(self.ForcePlayEffectsOnAbilityUsedOnServer)
	end

	if self.InstantEffectWrapper then
		self.InstantEffectWrapper:PlayAll()
	end

	if config.FaceTurretToTarget and targetEntities.TargetEntity then
		enemy:FaceTurretToTarget(targetEntities.TargetEntity, config.TurretIndex or 1)
	end

	if config.TriggerRotatingBarrels then
		character:TriggerRotatingBarrels(config.TriggerRotatingBarrelsTime)
	end

	if config.ToggleShieldModelForTime then
		character:ToggleShieldForTime(config.ToggleShieldModelForTime)
	end

	self:_HandleAnimationChanges()
	self:_HandleDestroyInstances()

	if self.ForcePlayAnimationOnClientside then
		local v2 = character.PrimaryAnimationHandler:GetState() == self.AnimationName

		if not (self.NoRestartAnimationIfAlreadyPlaying and v2) then
			enemy:SetAnimationState(self.AnimationName)
		end
	end

	if self.MultiJumpHandler then
		self.MultiJumpHandler:AbilityUsedOnServer(list)
	end

	local stopAnimationDelay = self.StopAnimationDelay
	self.StopAnimationDelayRemaining = stopAnimationDelay
		and stopAnimationDelay + delayRemaining + executionTimeRemaining
		or 0
	self.AnimationStopped = false
	self.ClientsideAnimationFinished = false
end

function AbilityClass:AbilityInterruptedOnServer(list)
	local executionTimeRemaining = list[2]
	self.DelayRemaining = 0
	self.ExecutionTimeRemaining = executionTimeRemaining
	self.Performed = true
	self.BurstCompleted = true
	self.TargetPlayerNames = nil
	self.EffectsStartDelayRemaining = 0
	self.EffectsStopDelayRemaining = 0
	self.SequenceEffectsStartDelayRemaining = 0
	self.SequenceEffectsStopDelayRemaining = 0
	self:_StopEffects(true)

	if self.HasSequenceEffects then
		self:_StopSequenceEffects(true)
	end

	if self.CustomCode and self.CustomCode.AbilityInterrupted then
		self.CustomCode:AbilityInterrupted(self.Name)
	end
end

function AbilityClass:Run(p: number)
	local enemy = self.Enemy
	local config = self.Config
	self.DelayRemaining = math.max(0, self.DelayRemaining - p)
	self.ExecutionTimeRemaining = math.max(0, self.ExecutionTimeRemaining - p)

	if
		self.ForcePlayAnimationOnClientside
		and not self.StopAnimationDelay
		and self.ExecutionTimeRemaining <= 0
		and not self.ClientsideAnimationFinished
	then
		enemy:SetAnimationState("Move")
		self.ClientsideAnimationFinished = true
	end

	if self.UseDelaysForHidingModels then
		self.IntroSwitchDelayRemaining = math.max(0, self.IntroSwitchDelayRemaining - p)
		self.OutroSwitchDelayRemaining = math.max(0, self.OutroSwitchDelayRemaining - p)
	end

	self.EffectsStartDelayRemaining = math.max(0, self.EffectsStartDelayRemaining - p)
	self.EffectsStopDelayRemaining = math.max(0, self.EffectsStopDelayRemaining - p)
	self.SequenceEffectsStartDelayRemaining = math.max(0, self.SequenceEffectsStartDelayRemaining - p)
	self.SequenceEffectsStopDelayRemaining = math.max(0, self.SequenceEffectsStopDelayRemaining - p)
	self:_UpdateEffects()
	self:_UpdateAbilityModels()
	self.StopAnimationDelayRemaining = math.max(0, self.StopAnimationDelayRemaining - p)

	if self.StopAnimationDelay and self.StopAnimationDelayRemaining <= 0 and not self.AnimationStopped then
		if enemy.Character.PrimaryAnimationHandler:GetState() == self.AnimationName then
			enemy:SetAnimationState("Move")
		end

		self.AnimationStopped = true
	end

	if
		self.DelayRemaining <= 0
		and config.EnemyToTowerRangedDataSequence
		and self.IsBurst
		and not self.BurstCompleted
	then
		self.BurstCount += 1

		if not config.EffectsOnlyOnInitialBurst or self.BurstCount == 1 then
			self:_PlayEffects(true)
			self:_PlaySequenceEffects(true)
		end

		self.CurrentSequenceIndex += 1

		if self.CurrentSequenceIndex > #config.EnemyToTowerRangedDataSequence then
			self.CurrentSequenceIndex = 1
		end

		if self.BurstCount < config.BurstSize then
			self.DelayRemaining = config.ClientBurstEffectsRespectCustomBurstDelayMap
				and config.CustomBurstDelayMap
				and config.CustomBurstDelayMap[self.BurstCount]
				or config.BurstInterval
		else
			self.BurstCompleted = true
		end
	end

	if self.DelayRemaining <= 0 and not self.Performed then
		if config.RemoveForceFaceOnExecution then
			enemy.MovementHandler:RemoveForceFacePosition()
		end

		if config.EnemyToPlayerRangedData and self.TargetPlayerNames then
			PlayerEffectHandler.Trigger(enemy, config.EnemyToPlayerRangedData, self.TargetPlayerNames)
		end

		self.Performed = true
	end

	if self.CurrentTeleportData then
		if self.ExecutionTimeRemaining > 0 then
			self:_RunTeleportData(p)
		else
			self:_StopTeleportData()
		end
	end

	if self.MultiJumpHandler then
		self.MultiJumpHandler:Run(p)
	end

	if self.BeamEffects then
		BeamEffectHelper.RunBeamEffects(p, self.BeamEffects)
	end

	if self.PlayerBeamEffectsMap then
		for _, v in pairs(self.PlayerBeamEffectsMap) do
			BeamEffectHelper.RunBeamEffects(p, v)
		end
	end

	self:_RunBeamEffectsV2(p)
end

function AbilityClass:_RunTeleportData(p: number)
	local movementHandler = self.Enemy.MovementHandler
	local currentTeleportData = self.CurrentTeleportData

	if not currentTeleportData.TweenToGoal then
		return
	end

	currentTeleportData.TweenStartDelayLeft = math.max(0, currentTeleportData.TweenStartDelayLeft - p)

	if currentTeleportData.TweenStartDelayLeft > 0 then
		return
	end

	currentTeleportData.TweenTimeLeft = math.max(0, currentTeleportData.TweenTimeLeft - p)
	local v = 1 - currentTeleportData.TweenTimeLeft / currentTeleportData.TweenTotalTime
	local v2 = currentTeleportData.DeltaVector * v

	if currentTeleportData.JumpHeight then
		v2 += Vector3.new(0, currentTeleportData.JumpHeight * math.sin(3.141592653589793 * v), 0)
	end

	if currentTeleportData.TweenTimeLeft > 0 then
		movementHandler:SetAbilityOffset(v2)
	else
		self:_StopTeleportData()
	end
end

function AbilityClass:_StopTeleportData()
	local enemy = self.Enemy
	local movementHandler = enemy.MovementHandler
	local currentTeleportData = self.CurrentTeleportData

	if currentTeleportData.RemoveForceFaceOnStop then
		self.Enemy.MovementHandler:RemoveForceFacePosition()
	end

	if not currentTeleportData.TweenToGoal then
		return
	end

	movementHandler:RemoveAbilityOffset()
	enemy:TeleportToPathIndexAndPercentage(currentTeleportData.PathIndex, currentTeleportData.PathPercentage)
	self.CurrentTeleportData = nil
end

function AbilityClass:Destroy()
	self:_StopEffects()

	if self.HasSequenceEffects then
		self:_StopSequenceEffects(true)
	end

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

	if self.PlayerBeamEffectsMap then
		for _, v in pairs(self.PlayerBeamEffectsMap) do
			BeamEffectHelper.StopBeamEffects(v)
		end
	end
end

function AbilityClass.SetSpeedMultiplier(data, p: number)
	local hasDefaultEffects = data.HasDefaultEffects

	if data.HasSequenceEffects then
		for _, v in pairs(data.SequenceIndexToEmitterWrapperMap) do
			v:SpeedMultiplierChanged(p)
		end

		for _, v in pairs(data.SequenceIndexToSoundWrapperMap) do
			v:SpeedMultiplierChanged(p)
		end
	end

	if hasDefaultEffects then
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

	if data.PlayerBeamEffectsMap then
		for _, v in pairs(data.PlayerBeamEffectsMap) do
			BeamEffectHelper.SpeedMultiplierChanged(p, v)
		end
	end

	if data.MultiJumpHandler then
		data.MultiJumpHandler:SpeedMultiplierChanged(p)
	end
end

function AbilityClass:SetCustomCode(customCode)
	self.CustomCode = customCode
end

function AbilityClass:_HandleColorChange()
	local config = self.Config
	local changeColorPartsColor

	if config.ChangeColorPartsColor then
		changeColorPartsColor = config.ChangeColorPartsColor
	end

	if config.EnemyToTowerRangedDataSequence then
		local v = config.EnemyToTowerRangedDataSequence[self.CurrentSequenceIndex]

		if v and v.ChangeColorPartsColor then
			changeColorPartsColor = v.ChangeColorPartsColor
		end
	end

	if changeColorPartsColor then
		self.Enemy.Character:SetChangeColorPartsColor(changeColorPartsColor, self.DelayRemaining)
	end
end

function AbilityClass:_UpdateEffects()
	local config = self.Config

	if config.EnemyToTowerRangedDataSequence and self.IsBurst then
		if self.EffectsStopDelayRemaining <= 0 and not config.PlayEffectsUntilDeath then
			self:_StopEffects()
		end

		if
			self.HasSequenceEffects
			and self.SequenceEffectsStopDelayRemaining <= 0
			and not config.PlayEffectsUntilDeath
		then
			self:_StopSequenceEffects()
		end
	else
		if self.EffectsStopDelayRemaining <= 0 then
			if config.PlayEffectsUntilDeath then
				return
			else
				self:_StopEffects()
			end
		elseif self.EffectsStartDelayRemaining <= 0 then
			self:_PlayEffects()
		end

		if self.HasSequenceEffects then
			if self.SequenceEffectsStopDelayRemaining <= 0 then
				if config.PlayEffectsUntilDeath then
					return
				end

				self:_StopSequenceEffects()
			elseif self.SequenceEffectsStartDelayRemaining <= 0 then
				self:_PlaySequenceEffects()
			end
		end
	end
end

function AbilityClass:_StopEffects(flag: boolean?)
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

	if flag then
		if hasDefaultEffects then
			defaultSoundWrapper:FadeOutPlayingTriggeredSounds()
		end

		local instantEffectWrapper = self.InstantEffectWrapper

		if instantEffectWrapper then
			instantEffectWrapper:StopContinuous()
			instantEffectWrapper:FadeOutPlayingTriggeredSounds()
		end
	end
end

function AbilityClass:_PlayEffects(flag: boolean?)
	local _character = self.Enemy.Character
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

function AbilityClass:_StopSequenceEffects(flag: boolean?)
	local v = self.SequenceIndexToEmitterWrapperMap[self.CurrentSequenceIndex]
	local v2 = self.SequenceIndexToSoundWrapperMap[self.CurrentSequenceIndex]

	if self.SequenceEffectsPlaying then
		if v then
			v:StopContinuous()
		end

		if v2 then
			v2:StopContinuous()

			if flag then
				v2:FadeOutPlayingTriggeredSounds()
			end
		end

		self.SequenceEffectsPlaying = false
	end
end

function AbilityClass:_PlaySequenceEffects(flag: boolean?)
	local v = self.SequenceIndexToEmitterWrapperMap[self.CurrentSequenceIndex]
	local v2 = self.SequenceIndexToSoundWrapperMap[self.CurrentSequenceIndex]

	if not self.SequenceEffectsPlaying or flag then
		if v then
			v:PlayAll()
		end

		if v2 then
			v2:PlayAll()
		end

		self.SequenceEffectsPlaying = true
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

local function BeamEffectsSetSpent(items) -- 1 equivalent call inferred from this helper
	for _, item in pairs(items) do
		if item.Destroyed or item.TimeUntilDestroy then
			return true
		end
	end

	return false
end

function AbilityClass:_TriggerPlayerBeamEffects(p: string, p2, p3)
	self.PlayerBeamEffectsMap = self.PlayerBeamEffectsMap or {}
	local v = self.PlayerBeamEffectsMap[p]

	if v and BeamEffectsSetSpent(v) then -- inferred equivalent call
		for _, v2 in pairs(v) do
			if v2.Destroyed or not v2.ParentInstance then
				continue
			end

			v2.ParentInstance:Destroy()
			v2.Destroyed = true
		end

		v = nil
	end

	if not v then
		v = BeamEffectHelper.NewBeamEffects(self.CharacterModel, p2, DEFAULT_SPEED_MULTIPLIER)
		self.PlayerBeamEffectsMap[p] = v
	end

	if v then
		BeamEffectHelper.StartBeamEffects(v, self.DelayRemaining, nil, nil, p3)
	end
end

function AbilityClass:_HandleAffectedEntityEffects()
	local config = self.Config
	local affectedEntityEffectData = config.AffectedEntityEffectData

	if not affectedEntityEffectData then
		return
	end

	local _targetEntity = self.TargetEntity
	local _targetIsTower = self.TargetIsTower
	local _targetIsPathEntity = self.TargetIsPathEntity
	local _targetIsMapEntity = self.TargetIsMapEntity
	local affectedEntities = self.AffectedEntities
	local enemy = self.Enemy

	for i, affectedEntity in ipairs(affectedEntities) do
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
				affectedEntityEffectData.TryRestartExistingBeam,
				affectedEntityEffectData.AlternateBeamsPerTarget,
				i
			)
		end

		if affectedEntityEffectData.RenderDebugPart then
			Utilities.RenderPartBetweenPoints(
				enemy.Character:GetRealTorso().Position,
				position or torso.Position,
				affectedEntityEffectData.RenderDebugPartColor,
				0.1,
				affectedEntityEffectData.RenderDebugPartDuration or config.ExecutionTime
			)
		end
	end
end

function AbilityClass:_HandleBeamEffectsV2(list, p, flag: boolean?, flag2: boolean?, p2: number?)
	local v

	if flag2 and #list > 1 then
		v = (p2 - 1) % #list + 1
	end

	if not self.BeamEffectsV2SetUp then
		self.BeamEffectsV2 = {}
		self.BeamEffectsV2SetUp = true
	end

	local flag3 = false

	if flag then
		local v2 = nil

		for _, v3 in pairs(self.BeamEffectsV2) do
			local v4 = v3[1]

			if not (v4 and v4.On and v4.TrackCharacter == p) then
				continue
			end

			v2 = v3
			break
		end

		if v2 then
			BeamEffectHelper.StartBeamEffects(v2, nil, nil, nil, p, true, nil, v)
		else
			flag3 = true
		end
	else
		flag3 = true
	end

	if flag3 then
		local beamEffects = BeamEffectHelper.NewBeamEffects(self.CharacterModel, list, DEFAULT_SPEED_MULTIPLIER)
		self.BeamEffectsV2[os.clock()] = beamEffects
		BeamEffectHelper.StartBeamEffects(beamEffects, nil, nil, nil, p, nil, nil, v)
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

function AbilityClass:_HandleAnimationChanges()
	local config = self.Config

	if config.ReplaceAnimationMap then
		local character = self.Enemy.Character

		for k, v in pairs(config.ReplaceAnimationMap) do
			character:OverrideAnimation(k, v)
		end
	end
end

function AbilityClass:_HandleDestroyInstances()
	local config = self.Config

	if config.DestroyInstanceNames then
		local characterModel = self.Enemy.Character:GetCharacterModel()

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