local CoalManCustomCodeClass = {}
CoalManCustomCodeClass.__index = CoalManCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

local function HideInstances(phase1Instances)
	for _, instance in ipairs(phase1Instances) do
		if instance:IsA("BasePart") then
			instance.Transparency = 1
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 1
		end
	end
end

local function ShowInstances(phase2Instances)
	for _, instance in ipairs(phase2Instances) do
		if instance:IsA("BasePart") then
			instance.Transparency = 0
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function CoalManCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		MaxHealth = nil,
		Phase1Instances = nil,
		Phase2Instances = nil
	}, CoalManCustomCodeClass))
end

function CoalManCustomCodeClass:Initialize(enemy, config)
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

	for _, part in pairs(characterModel:FindFirstChild("Phase2"):GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(parts2, part)
		end
	end

	self.Phase2Instances = parts2
end

function CoalManCustomCodeClass.Run_FromCharacter(_, _: number) end

function CoalManCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.CoalManDamaged then
		self:_TriggerPhase2()
	end
end

function CoalManCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function CoalManCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function CoalManCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function CoalManCustomCodeClass.CharacterCleanedUp(_) end

function CoalManCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function CoalManCustomCodeClass:_TriggerPhase2()
	ShowInstances(self.Phase2Instances)
	HideInstances(self.Phase1Instances)
	self.Character:OverrideAnimation("Move", "MoveFast")
end

return CoalManCustomCodeClass