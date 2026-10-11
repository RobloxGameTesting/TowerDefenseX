local Smasher9xCustomCodeClass = {}
Smasher9xCustomCodeClass.__index = Smasher9xCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

local function HideInstances(phase1Instances)
	for _, instance in ipairs(phase1Instances) do
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
			instance.Transparency = 0
			instance.CanQuery = true
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function Smasher9xCustomCodeClass.New(speedMultiplier: number)
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
	}, Smasher9xCustomCodeClass))
end

function Smasher9xCustomCodeClass:Initialize(enemy, config)
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
	self._TimingHelpers.TransitionTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1 / 3,
		Callback = function()
			self:_TriggerPhase2()
		end
	})
end

function Smasher9xCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function Smasher9xCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.Smasher9xRageTransition then
		self._TimingHelpers.TransitionTimingHelper:Start()
	end
end

function Smasher9xCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function Smasher9xCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function Smasher9xCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function Smasher9xCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function Smasher9xCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function Smasher9xCustomCodeClass:_TriggerPhase2()
	HideInstances(self.Phase1Instances)
end

return Smasher9xCustomCodeClass