local AbilityClass = {}
AbilityClass.__index = AbilityClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local AbilityUtilities = require(common:WaitForChild("AbilityUtilities"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local BeamEffectHelper = require(common:WaitForChild("BeamEffectHelper"))
local Utilities = require(common:WaitForChild("Utilities"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local parent = script.Parent.Parent.Parent.Parent
local towerClass = parent:WaitForChild("GameClass"):WaitForChild("TowerClass")
local userInputHandler = parent:WaitForChild("UserInputHandler")
local JumpAbilityHandlerClass = require(script.Parent:WaitForChild("JumpAbilityHandlerClass"))
local DEV_MAX_ABILITY_COOLDOWN = RunService:IsStudio() and _G.DEV_MAX_ABILITY_COOLDOWN or 1e999
local v = NetworkingHandler.GetFunction("TowerUseAbilityRequest")
local v2 = NetworkingHandler.GetFunction("RotateTower")
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local event2 = BindableHandler.GetEvent("ErrorPrompt")
local LocalPlayer = Players.LocalPlayer
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

function AbilityClass.New(p: number, towerHash: number, config, p2: number?, upgradeTypeToActiveUpgradeShopData)
	local v3 = not upgradeTypeToActiveUpgradeShopData and 1
		or TowerUpgradeShopUtilities.GetAmount(
			upgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.AbilityCooldowns
		)
		or 1
	local jumpAbilityHandler = config.TowerAbilityJumpData and JumpAbilityHandlerClass.New(config)
	local v4 = {
		Index = p,
		TowerHash = towerHash,
		Tower = nil,
		CharacterModel = nil,
		CustomCode = nil,
		FaceTargetPosition = config.FaceTargetPosition,
		NoFaceTargetTower = config.NoFaceTargetTower,
		TurretIndex = config.TurretIndex,
		IsDirectControl = config.ToggleDirectControl,
		IsManualAimRetargeting = config.IsManualAimRetarget == true,
		IsManualAimAtPath = config.IsManualAimAtPath,
		IsManualAimAtTower = config.IsManualAimAtTower,
		IsManualAimAtEnemy = config.IsManualAimAtEnemy,
		IsManualAimAtGround = config.IsManualAimAtGround,
		IsManualAimAtGroundDirectional = config.IsManualAimAtGroundDirectional,
		StrikeZoneLength = config.StrikeZoneLength,
		StrikeZoneWidth = config.StrikeZoneWidth,
		IsManualRotation = config.IsManualRotation,
		IsManualRelocation = config.IsManualRelocation,
		ManualAimInfiniteRange = config.ManualAimInfiniteRange,
		ManualAimCustomRange = config.ManualAimCustomRange,
		ManualAimTargetMustBeHealable = config.ManualAimTargetMustBeHealable,
		ManualAimRespectMinMaxHeight = config.ManualAimRespectMinMaxHeight,
		BeamEffectHandlingData = config.BeamEffectHandlingData,
		EffectsForOwnerOnly = config.EffectsForOwnerOnly,
		Config = config,
		Name = config.Name,
		AnimationName = config.AnimationName,
		SessionStartAnimationName = config.SessionStartAnimationName,
		SessionEndAnimationName = config.SessionEndAnimationName,
		InAnimationSession = false,
		SecondaryAnimationForKeyframeEventsName = config.SecondaryAnimationForKeyframeEventsName,
		AdditionalAnimationsForKeyframeEventsNames = config.AdditionalAnimationsForKeyframeEventsNames,
		CancelAnimationWhenAbilityDone = config.CancelAnimationWhenAbilityDone,
		DisplayName = config.DisplayName,
		Passive = config.Passive,
		CustomTriggered = config.CustomTriggered,
		CanUseWhileStunned = config.CanUseWhileStunned,
		Cooldown = config.Cooldown,
		CooldownPausedWhileActive = config.CooldownPausedWhileActive,
		Icon = config.Icon,
		Description = config.Description,
		ProjectileHitData = config.ProjectileHitData,
		BlockUpgradesWhileActive = config.BlockUpgradesWhileActive,
		CustomTriggeredPowerUpName = config.CustomTriggeredPowerUpName,
		CustomTriggeredPowerUpData = config.CustomTriggeredPowerUpData,
		DefaultEmitterAndSoundWrapper = nil,
		InstantEffectWrapper = nil,
		EffectsStartDelayRemaining = 0,
		EffectsStopDelayRemaining = 0,
		HasDefaultEffects = false,
		EffectsPlaying = false,
		UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData,
		TowerAbilityJumpData = config.TowerAbilityJumpData,
		JumpAbilityHandler = jumpAbilityHandler,
		Active = false,
		UseRequestInFlight = false,
		DelayRemaining = 0,
		ExecutionTimeRemaining = 0,
		CooldownRemaining = math.min(p2 or config.StartingCooldown * v3, DEV_MAX_ABILITY_COOLDOWN),
		Stunned = false,
		Disabled = false,
		ModeDisabled = false,
		Converted = false,
		Destroyed = false,
		TargetTower = nil,
		BeamEffects = nil,
		BeamsSetUp = false,
		RandomEffectWrappers = {}
	}
	setmetatable(v4, AbilityClass)

	if jumpAbilityHandler then
		jumpAbilityHandler:SetParentAbility(v4)
	end

	return v4
end

function AbilityClass:SetTower(tower)
	local config = self.Config
	local character = tower.Character
	local characterModel = character:GetCharacterModel()
	local autoHandledEffectInstances, v3 = AbilityUtilities.GetAutoHandledEffectInstances(characterModel, config)

	if config.EffectParentInstanceNames or autoHandledEffectInstances then
		self.DefaultEmitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)
		self.HasDefaultEffects = true

		if config.EffectParentInstanceNames then
			for _, effectParentInstanceName in pairs(config.EffectParentInstanceNames) do
				local v4 = Utilities.TryGetInstanceFromPath(characterModel, effectParentInstanceName)

				if v4 then
					self.DefaultEmitterAndSoundWrapper:AddFrom(v4, DEFAULT_SPEED_MULTIPLIER)
				else
					warn("Didn't find instance with name " .. effectParentInstanceName)
				end
			end
		end

		if autoHandledEffectInstances then
			self.DefaultEmitterAndSoundWrapper:AddFrom(autoHandledEffectInstances, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	if config.InstantPlayEffectParentInstanceNames or #v3 > 0 then
		self.InstantEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, DEFAULT_SPEED_MULTIPLIER)

		if config.InstantPlayEffectParentInstanceNames then
			for _, instantPlayEffectParentInstanceName in pairs(config.InstantPlayEffectParentInstanceNames) do
				local v4 = Utilities.TryGetInstanceFromPath(characterModel, instantPlayEffectParentInstanceName)

				if v4 then
					self.InstantEffectWrapper:AddFrom(v4, DEFAULT_SPEED_MULTIPLIER)
				else
					warn("Didn't find instance with name " .. instantPlayEffectParentInstanceName)
				end
			end
		end

		for _, v4 in ipairs(v3) do
			self.InstantEffectWrapper:AddFrom(v4, DEFAULT_SPEED_MULTIPLIER)
		end
	end

	local function SetUpKeyframeReachedEvent(p: string)
		local primaryAnimationHandler = character.PrimaryAnimationHandler
		local animation = primaryAnimationHandler and primaryAnimationHandler:GetAnimation(p)

		if animation then
			animation:SetUpKeyframeReachedEvent(function(p2: string)
				self:_KeyframeReached(p2)
			end)
		else
			warn("Couldn't find tower ability animation", p)
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

	self.Tower = tower
	self.CharacterModel = characterModel

	if self.JumpAbilityHandler then
		self.JumpAbilityHandler:SetTower(tower)
	end

	local randomEffects = characterModel:FindFirstChild("RandomEffects")

	if config.RandomEffects and randomEffects then
		local all = randomEffects:FindFirstChild("_All")
		self.RandomEffectWrappers = {}

		for k in pairs(config.RandomEffects) do
			local child = randomEffects:FindFirstChild((tostring(k)))

			if not child then
				continue
			end

			local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(child, DEFAULT_SPEED_MULTIPLIER)

			if all then
				emitterAndSoundWrapper:AddFrom(all, DEFAULT_SPEED_MULTIPLIER)
			end

			self.RandomEffectWrappers[k] = emitterAndSoundWrapper
		end
	end
end

function AbilityClass:SetCustomCode(customCode)
	self.CustomCode = customCode
end

function AbilityClass:UpgradeShopDataChanged(upgradeTypeToActiveUpgradeShopData)
	self.UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData
end

function AbilityClass:_KeyframeReached(p: string)
	if self.DefaultEmitterAndSoundWrapper and self:_ShouldPlayEffects() then
		self.DefaultEmitterAndSoundWrapper:PlayKeyframeTriggered(p)
	end

	if self.CustomCode then
		self.CustomCode:AbilityAnimationKeyframeReached(self.Name, p)
	end
end

function AbilityClass:AbilityUsedOnServer(list)
	local config = self.Config

	if self.SessionStartAnimationName then
		self.AnimationName = config.AnimationName
	end

	local delayRemaining = list[2]
	local executionTimeRemaining = list[3]
	local targetTower = list[4]
	local v3 = list[5]
	local v4 = list[6]

	if targetTower == 0 then
		targetTower = nil
	end

	if targetTower then
		local module = require(towerClass)
		targetTower = module.GetTower(targetTower)
	end

	self.TargetTower = targetTower

	if delayRemaining then
		self.DelayRemaining = delayRemaining
		self.ExecutionTimeRemaining = executionTimeRemaining
	end

	if self.TargetTower and not self.NoFaceTargetTower then
		self.Tower:FaceTower(self.TargetTower, self.TurretIndex)
	elseif self.FaceTargetPosition and v3 then
		self.Tower:FacePosition(v3, self.TurretIndex)
	end

	self.EffectsStartDelayRemaining = config.EffectsStartDelay or 0
	self.EffectsStopDelayRemaining = config.EffectsStopDelay or config.ExecutionTime

	if self.DelayRemaining == 0 and self.ExecutionTimeRemaining == 0 then
		self:_PlayEffects()
	end

	if self.InstantEffectWrapper then
		self.InstantEffectWrapper:PlayAll()
	end

	if self.BeamEffectHandlingData and self.TargetTower then
		self:_TriggerBeamEffects(self.BeamEffectHandlingData, self.TargetTower)
	end

	local v5 = self.RandomEffectWrappers and v4 and self.RandomEffectWrappers[v4]

	if v5 then
		v5:PlayAll()
	end

	if self.JumpAbilityHandler then
		self.JumpAbilityHandler:Start(v3)
	end
end

function AbilityClass:AbilityCancelledOnServer(_)
	self.InAnimationSession = false

	if self.SessionStartAnimationName then
		self.AnimationName = self.Config.AnimationName
	end

	self.DelayRemaining = 0
	self.ExecutionTimeRemaining = 0

	if self.BeamEffects then
		BeamEffectHelper.StopBeamEffects(self.BeamEffects)
	end

	if self.AnimationName then
		self.Tower:CancelAnimationStateIfEquals(self.AnimationName)
	end

	if self.SessionStartAnimationName then
		self.Tower:CancelAnimationStateIfEquals(self.SessionStartAnimationName)
	end

	if self.SessionEndAnimationName then
		self.Tower:CancelAnimationStateIfEquals(self.SessionEndAnimationName)
	end

	self:_StopEffects()
end

function AbilityClass:SetSessionStarted()
	self.InAnimationSession = true

	if self.SessionStartAnimationName then
		self.AnimationName = self.SessionStartAnimationName
	end
end

function AbilityClass:SetSessionEnded()
	self.InAnimationSession = false

	if self.SessionStartAnimationName then
		self.AnimationName = self.Config.AnimationName
	end
end

function AbilityClass.GetName(p)
	return p.Name
end

function AbilityClass.GetAnimationName(p)
	return p.AnimationName
end

function AbilityClass.GetTotalCooldown(p)
	return p.Cooldown
end

function AbilityClass.GetCooldownRemaining(p)
	return p.CooldownRemaining
end

function AbilityClass:GetStunned()
	return self.Stunned and not self.CanUseWhileStunned
end

function AbilityClass.GetDisabled(p)
	return p.Disabled or p.ModeDisabled
end

function AbilityClass.GetConverted(p)
	return p.Converted
end

function AbilityClass:GetTowerRebuilding()
	return not self.Tower:Alive()
end

function AbilityClass:SetStunned(stunned: boolean)
	self.Stunned = stunned
end

function AbilityClass:SetDisabled(disabled: boolean)
	self.Disabled = disabled
end

function AbilityClass:SetModeDisabled(modeDisabled: boolean)
	self.ModeDisabled = modeDisabled
end

function AbilityClass:SetConverted(converted: boolean)
	self.Converted = converted
end

function AbilityClass:CanUse(flag: boolean?)
	return not (self:GetStunned() or self:GetTowerRebuilding())
		and not (self.Disabled or self.ModeDisabled or self.Converted or self.UseRequestInFlight)
		and (flag or not (self.CooldownRemaining > 0))
		and true
		or false
end

function AbilityClass:_InvokeUseRequest(...)
	local v3 = table.pack(...)
	self.UseRequestInFlight = true
	local success, result, cooldownRemaining, v4 = pcall(function()
		return v:InvokeServer(self.TowerHash, self.Index, table.unpack(v3, 1, v3.n))
	end)
	self.UseRequestInFlight = false

	if not success then
		warn("Ability use request failed:", result)
		return nil
	end

	if v4 then
		event2:Fire("Ability Error: " .. v4)
	end

	if result then
		self.CooldownRemaining = cooldownRemaining
	end

	return result
end

function AbilityClass:Use(flag: boolean?)
	if not self:CanUse(true) then
		return
	end

	if self.IsManualAimRetargeting then
		local module = require(userInputHandler)
		module.BeginManualAimRetargeting(self.Tower, self)
	elseif self.IsManualAimAtPath or self.IsManualAimAtGround then
		local module = require(userInputHandler)
		module.BeginManualAimAbility(self.Tower, self)
	elseif self.IsManualAimAtGroundDirectional then
		local module = require(userInputHandler)
		module.BeginManualAimGroundDirectionalAbility(self.Tower, self)
	elseif self.IsManualRelocation then
		local module = require(userInputHandler)
		module.BeginManualRelocationAbility(self.Tower, self)
	elseif self.IsManualAimAtTower then
		local module = require(userInputHandler)
		module.BeginManualAimAtTowerAbility(self.Tower, self)
	elseif self.IsManualAimAtEnemy then
		warn("Manual aim at enemy is not implemented in UserInputHandler yet")
	elseif self.IsManualRotation then
		local module = require(userInputHandler)
		module.BeginManualTowerRotation(self.Tower, self)
	else
		if not self.IsDirectControl then
			return self:_InvokeUseRequest(nil, nil, nil, flag)
		end

		local module = require(userInputHandler)
		module.BeginTowerDirectControl(self.Tower)
	end

	return nil
end

function AbilityClass:_AimingFinishedCallback(vector: Vector3)
	if not self:CanUse(true) then
		return
	end

	self:_InvokeUseRequest(vector)
end

function AbilityClass:_AimingAtGroundDirectionalFinishedCallback(vector: Vector3, p: number)
	if not self:CanUse(true) then
		return
	end

	self:_InvokeUseRequest(vector, nil, nil, nil, p)
end

function AbilityClass:_AimingAtTowerFinishedCallback(object)
	if not self:CanUse(true) then
		return
	end

	if object and object:Alive() then
		self:_InvokeUseRequest(nil, object.Hash)
	else
		warn("Aiming at tower that is dead or doesn't exist")
	end
end

function AbilityClass:_AimingAtEnemyFinishedCallback(object, flag: boolean?)
	if not self:CanUse(true) then
		return
	end

	if object and object:Alive() then
		return self:_InvokeUseRequest(nil, nil, object.Hash, flag)
	end

	warn("Aiming at enemy that is dead or doesn't exist")
end

function AbilityClass:_RotationFinishedCallback(cframe: CFrame)
	if not self:CanUse(true) then
		return
	end

	local v3, cooldownRemaining, v4 = v2:InvokeServer(self.TowerHash, self.Index, cframe)

	if v4 then
		event2:Fire("Ability Error: " .. v4)
	end

	if v3 then
		self.CooldownRemaining = cooldownRemaining
	else
		self.CooldownRemaining = 0
	end
end

function AbilityClass:BeginCooldown()
	local v3 = not self.UpgradeTypeToActiveUpgradeShopData and 1
		or TowerUpgradeShopUtilities.GetAmount(
			self.UpgradeTypeToActiveUpgradeShopData,
			Enums.TowerUpgradeShopTypes.AbilityCooldowns
		)
		or 1
	self.CooldownRemaining = math.min(self.Cooldown * v3, DEV_MAX_ABILITY_COOLDOWN)
end

function AbilityClass:Run(p: number)
	if self.JumpAbilityHandler then
		self.JumpAbilityHandler:Run(p)
	end

	if not (self:GetStunned() or self.Disabled or self.Converted or self.Active and self.CooldownPausedWhileActive) then
		self.CooldownRemaining = math.max(0, self.CooldownRemaining - p)
	end

	self.ExecutionTimeRemaining = math.max(0, self.ExecutionTimeRemaining - p)
	self.EffectsStartDelayRemaining = math.max(0, self.EffectsStartDelayRemaining - p)
	self.EffectsStopDelayRemaining = math.max(0, self.EffectsStopDelayRemaining - p)
	self:_UpdateEffects()

	if
		self.Active
		and self.ExecutionTimeRemaining <= 0
		and self.CancelAnimationWhenAbilityDone
		and self.AnimationName
	then
		self.Tower:CancelAnimationStateIfEquals(self.AnimationName)
	end

	if self.BeamEffects then
		BeamEffectHelper.RunBeamEffects(p, self.BeamEffects)
	end

	self.Active = self.ExecutionTimeRemaining > 0
end

function AbilityClass:StopEffects()
	self.EffectsStopDelayRemaining = 0
end

function AbilityClass:_UpdateEffects()
	if self.EffectsStopDelayRemaining <= 0 then
		self:_StopEffects()
	elseif self.EffectsStartDelayRemaining <= 0 then
		self:_PlayEffects()
	end
end

function AbilityClass:_StopEffects()
	local hasDefaultEffects = self.HasDefaultEffects
	local defaultEmitterAndSoundWrapper = self.DefaultEmitterAndSoundWrapper

	if self.EffectsPlaying then
		if hasDefaultEffects then
			defaultEmitterAndSoundWrapper:StopContinuous()
		end

		self.EffectsPlaying = false
	end

	if self.InstantEffectWrapper then
		self.InstantEffectWrapper:StopContinuous()
		self.InstantEffectWrapper:FadeOutPlayingTriggeredSounds()
	end
end

function AbilityClass:_PlayEffects(flag: boolean?)
	if not self:_ShouldPlayEffects() then
		return
	end

	local hasDefaultEffects = self.HasDefaultEffects
	local defaultEmitterAndSoundWrapper = self.DefaultEmitterAndSoundWrapper

	if not self.EffectsPlaying or flag then
		if hasDefaultEffects then
			defaultEmitterAndSoundWrapper:PlayAll()
		end

		self.EffectsPlaying = true
	end
end

function AbilityClass.SetSpeedMultiplier(data, p: number)
	if data.DefaultEmitterAndSoundWrapper then
		data.DefaultEmitterAndSoundWrapper:SpeedMultiplierChanged(p)
	end

	if data.InstantEffectWrapper then
		data.InstantEffectWrapper:SpeedMultiplierChanged(p)
	end

	if data.BeamEffects then
		BeamEffectHelper.SpeedMultiplierChanged(p, data.BeamEffects)
	end
end

function AbilityClass.CanManuallyUse(p)
	return not (p.Passive or p.CustomTriggered)
end

function AbilityClass.BeingUsed(p)
	return p.ExecutionTimeRemaining > 0
end

function AbilityClass:Destroy()
	self:_StopEffects()
	self.Destroyed = true

	if self.BeamEffects then
		BeamEffectHelper.StopBeamEffects(self.BeamEffects)
	end
end

function AbilityClass:_TriggerBeamEffects(p, player)
	if not player then
		return
	end

	local realTorso = player.Character:GetRealTorso()

	if not realTorso then
		return
	end

	local position = realTorso.Position

	if not self.BeamsSetUp then
		self.BeamEffects = BeamEffectHelper.NewBeamEffects(self.CharacterModel, p, DEFAULT_SPEED_MULTIPLIER)
		self.BeamsSetUp = true
	end

	BeamEffectHelper.StartBeamEffects(self.BeamEffects, self.DelayRemaining, self.ExecutionTimeRemaining, position)
end

function AbilityClass:_ShouldPlayEffects()
	return not self.EffectsForOwnerOnly or self.Tower.OwnerName == LocalPlayer.Name
end

event:AttachCallback(function(p: number)
	DEFAULT_SPEED_MULTIPLIER = p
end)
return AbilityClass