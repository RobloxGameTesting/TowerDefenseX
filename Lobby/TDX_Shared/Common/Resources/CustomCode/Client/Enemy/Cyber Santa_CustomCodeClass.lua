local CyberSantaCustomCodeClass = {}
CyberSantaCustomCodeClass.__index = CyberSantaCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))

local function GetInstances(folder)
	local descendants = {}

	for _, descendant in ipairs(folder:GetDescendants()) do
		if descendant:IsA("BasePart") or descendant:IsA("Decal") then
			table.insert(descendants, descendant)
		end
	end

	return descendants
end

local function HideInstances(list)
	for _, instance in ipairs(list) do
		if instance:IsA("BasePart") then
			instance.Transparency = 1
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 1
		end
	end
end

local function ShowInstances(list)
	for _, instance in ipairs(list) do
		if instance:IsA("BasePart") then
			instance.Transparency = 0
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function CyberSantaCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		MaxHealth = nil,
		Phase1Instances = nil,
		Phase2Instances = nil,
		Phase3Instances = nil,
		Phase2Triggered = false,
		Phase3Triggered = false,
		DamagedWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		_Wrappers = {}
	}, CyberSantaCustomCodeClass))
end

function CyberSantaCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	self.MaxHealth = config.Health
	self.Phase1Instances = GetInstances(characterModel:FindFirstChild("Phase1"))
	self.Phase2Instances = GetInstances(characterModel:FindFirstChild("Phase2"))
	self.Phase3Instances = GetInstances(characterModel:FindFirstChild("Phase3"))
	local damagedVFX = characterModel:FindFirstChild("DamagedVFX")
	self.DamagedWrapper:AddFrom(damagedVFX, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.DamagedWrapper)
end

function CyberSantaCustomCodeClass:Run_FromCharacter(_: number)
	local health = self.Enemy.HealthHandler:GetHealth()

	if not self.Phase2Triggered and health <= self.MaxHealth * (2 / 3) then
		self:_TriggerPhase2()
	end

	if not self.Phase3Triggered and health <= self.MaxHealth * (1 / 3) then
		self:_TriggerPhase3()
	end
end

function CyberSantaCustomCodeClass.AbilityUsed(_, _: string) end

function CyberSantaCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function CyberSantaCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function CyberSantaCustomCodeClass.EnemyDestroyed(p, _: boolean?, _: boolean?)
	if p.DamagedWrapper then
		p.DamagedWrapper:StopContinuous()
	end
end

function CyberSantaCustomCodeClass.CharacterCleanedUp(_) end

function CyberSantaCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function CyberSantaCustomCodeClass:_TriggerPhase2()
	self.Phase2Triggered = true
	ShowInstances(self.Phase2Instances)
	ShowInstances(self.Phase3Instances)
	HideInstances(self.Phase1Instances)

	if self.DamagedWrapper then
		self.DamagedWrapper:PlayAll()
	end
end

function CyberSantaCustomCodeClass:_TriggerPhase3()
	self.Phase3Triggered = true
	HideInstances(self.Phase3Instances)
	self.Character:OverrideAnimation("Move", "DamagedMove")

	if self.DamagedWrapper then
		self.DamagedWrapper:PlayAll()
	end
end

return CyberSantaCustomCodeClass