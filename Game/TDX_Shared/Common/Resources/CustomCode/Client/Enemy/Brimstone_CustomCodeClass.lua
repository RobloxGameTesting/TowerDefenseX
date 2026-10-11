local BrimstoneCustomCodeClass = {}
BrimstoneCustomCodeClass.__index = BrimstoneCustomCodeClass
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

local function ShowInstances(phase2Instances)
	for _, instance in ipairs(phase2Instances) do
		if instance:IsA("BasePart") then
			instance.Transparency = 0
			instance.CanQuery = true
			instance:SetAttribute("OriginalTransparency", instance.Transparency)
		elseif instance:IsA("Decal") then
			instance.Transparency = 0
		end
	end
end

function BrimstoneCustomCodeClass.New(speedMultiplier: number)
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
	}, BrimstoneCustomCodeClass))
end

function BrimstoneCustomCodeClass:Initialize(enemy, config)
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
	local phase2 = characterModel:FindFirstChild("Phase2")

	if phase2 then
		for _, part in pairs(phase2:GetDescendants()) do
			if part:IsA("BasePart") then
				table.insert(parts2, part)
			end
		end
	end

	self.Phase2Instances = parts2
	self._TimingHelpers.TransitionTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1,
		Callback = function()
			self:_TriggerPhase2()
		end
	})
end

function BrimstoneCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function BrimstoneCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.BrimstoneTransition then
		self._TimingHelpers.TransitionTimingHelper:Start()
	end
end

function BrimstoneCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function BrimstoneCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function BrimstoneCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function BrimstoneCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function BrimstoneCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function BrimstoneCustomCodeClass:_TriggerPhase2()
	ShowInstances(self.Phase2Instances)
	HideInstances(self.Phase1Instances)
end

return BrimstoneCustomCodeClass