local TheIlluminatiCustomCodeClass = {}
TheIlluminatiCustomCodeClass.__index = TheIlluminatiCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))

function TheIlluminatiCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		Stage1Instances = {},
		Stage2Instances = {},
		CurrentStage = 0,
		GoalStage = 1,
		PreviousAbilityName = nil,
		_TimingHelpers = {},
		_Wrappers = { DeathExplode = nil, Stage1Effects = nil, Stage2Effects = nil }
	}, TheIlluminatiCustomCodeClass))
end

function TheIlluminatiCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._Wrappers.Stage1Effects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.Stage2Effects = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)

	for _, descendant in pairs(characterModel:GetDescendants()) do
		if descendant:GetAttribute("Stage1") then
			table.insert(self.Stage1Instances, descendant)

			if descendant:IsA("ParticleEmitter") then
				self._Wrappers.Stage1Effects:Add(descendant, speedMultiplier)
			elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
				self._Wrappers.Stage1Effects:Add(descendant, speedMultiplier)
			end
		elseif descendant:GetAttribute("Stage2") then
			table.insert(self.Stage2Instances, descendant)

			if descendant:IsA("ParticleEmitter") then
				self._Wrappers.Stage2Effects:Add(descendant, speedMultiplier)
			elseif descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
				self._Wrappers.Stage2Effects:Add(descendant, speedMultiplier)
			end
		end
	end
end

local function ToggleInstances(items, enabled: boolean)
	for _, instance in pairs(items) do
		if instance:IsA("Beam") then
			instance.Enabled = enabled
		elseif instance:IsA("BasePart") then
			instance.Transparency = enabled and 0 or 1
		end
	end
end

function TheIlluminatiCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.CurrentStage ~= self.GoalStage then
		self.CurrentStage = self.GoalStage

		if self.CurrentStage == 1 then
			ToggleInstances(self.Stage1Instances, true)
			ToggleInstances(self.Stage2Instances, false)
			self._Wrappers.Stage1Effects:PlayAll()
			self._Wrappers.Stage2Effects:StopContinuous()
		elseif self.CurrentStage == 2 then
			ToggleInstances(self.Stage1Instances, false)
			ToggleInstances(self.Stage2Instances, true)
			self._Wrappers.Stage1Effects:StopContinuous()
			self._Wrappers.Stage2Effects:PlayAll()
		end
	end
end

function TheIlluminatiCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if previousAbilityName == Enums.EnemyAbilities.TheIlluminatiRage then
		self.GoalStage = 2
	end
end

function TheIlluminatiCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function TheIlluminatiCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function TheIlluminatiCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self._Wrappers.Stage1Effects:StopContinuous()
	self._Wrappers.Stage2Effects:StopContinuous()
	self._Wrappers.DeathExplode:PlayAll()
	self.Character:ExplodeParts(1)
end

function TheIlluminatiCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function TheIlluminatiCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return TheIlluminatiCustomCodeClass