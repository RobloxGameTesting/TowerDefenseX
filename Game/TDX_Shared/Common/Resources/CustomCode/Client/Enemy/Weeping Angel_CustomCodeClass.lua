local WeepingAngelCustomCodeClass = {}
WeepingAngelCustomCodeClass.__index = WeepingAngelCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))

local function HideInstances(list)
	for _, instance in ipairs(list) do
		if instance:IsA("BasePart") then
			instance.Transparency = 1
			instance.CanQuery = false
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 1
		end
	end
end

local function ShowInstances(list)
	for _, instance in ipairs(list) do
		if instance:IsA("BasePart") then
			instance.Transparency = 0.05
			instance.CanQuery = true
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function WeepingAngelCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		MaxHealth = nil,
		Phase1Instances = nil,
		Phase2Instances = nil,
		_TimingHelpers = { TransitionTimingHelper = nil }
	}, WeepingAngelCustomCodeClass))
end

function WeepingAngelCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	self.MaxHealth = config.Health
	local parts = {}

	for _, part in pairs(characterModel:GetDescendants()) do
		if part:IsA("BasePart") and part:GetAttribute("Phase1") then
			table.insert(parts, part)
		end
	end

	self.Phase1Instances = parts
	local parts2 = {}

	for _, part in pairs(characterModel:GetDescendants()) do
		if part:IsA("BasePart") and part:GetAttribute("Phase2") then
			table.insert(parts2, part)
		end
	end

	self.Phase2Instances = parts2
	HideInstances(self.Phase2Instances)
	ShowInstances(self.Phase1Instances)
end

function WeepingAngelCustomCodeClass.Run_FromCharacter(_, _: number) end

function WeepingAngelCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.WeepingAngelTransition then
		self:_TriggerPhase2()
	end
end

function WeepingAngelCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function WeepingAngelCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function WeepingAngelCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function WeepingAngelCustomCodeClass.CharacterCleanedUp(_) end

function WeepingAngelCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function WeepingAngelCustomCodeClass:_TriggerPhase2()
	HideInstances(self.Phase1Instances)
	ShowInstances(self.Phase2Instances)
end

return WeepingAngelCustomCodeClass