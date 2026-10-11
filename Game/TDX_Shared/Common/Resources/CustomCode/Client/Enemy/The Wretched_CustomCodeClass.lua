local TheWretchedCustomCodeClass = {}
TheWretchedCustomCodeClass.__index = TheWretchedCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
require(common:WaitForChild("Utilities"))
workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function TheWretchedCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, TheWretchedCustomCodeClass))
end

function TheWretchedCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local _primaryPart = self.CharacterModel.PrimaryPart
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 4.9,
		Callback = function() end
	})
end

function TheWretchedCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function TheWretchedCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function TheWretchedCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.EnemyAbilities.WretchTransition and p2 == "SeparateStage1" then
		self:_Stage2()
	end
end

function TheWretchedCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function TheWretchedCustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self._TimingHelpers.DeathTimingHelper:Start()
end

function TheWretchedCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function TheWretchedCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function TheWretchedCustomCodeClass:_Stage2()
	local character = self.Character
	local characterModel = self.CharacterModel
	local lastTime = os.clock()

	for _, part in pairs(characterModel:GetDescendants()) do
		if not (part:GetAttribute("Stage1") and part:IsA("BasePart")) then
			continue
		end

		local v = part
		task.spawn(function()
			if v:GetAttribute("Stage1Delay") then
				task.wait(v:GetAttribute("Stage1Delay"))
			end

			local transparency = v.Transparency

			while RunService.Heartbeat:Wait() do
				local v2 = os.clock() - lastTime
				local v3 = v2 / 0.6
				v.Transparency = transparency + (1 - transparency) * v3

				if not (v2 >= 0.6) then
					continue
				end

				v:Destroy()
				break
			end
		end)
	end

	character:OverrideAnimation("Move", "Move_Stage2")
end

return TheWretchedCustomCodeClass