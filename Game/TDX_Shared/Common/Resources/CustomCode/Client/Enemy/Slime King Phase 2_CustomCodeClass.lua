local SlimeKingPhase2CustomCodeClass = {}
SlimeKingPhase2CustomCodeClass.__index = SlimeKingPhase2CustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function SlimeKingPhase2CustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { LegFallOff = nil },
		_Wrappers = {}
	}, SlimeKingPhase2CustomCodeClass))
end

function SlimeKingPhase2CustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	self._TimingHelpers.LegFallOff = TimingHelperClass.New({
		TimeUntilCallback = 0.45,
		Callback = function()
			for _, child in pairs(characterModel:GetChildren()) do
				if child:GetAttribute("IsLeg") then
					child:Destroy()
				end
			end
		end
	})
end

function SlimeKingPhase2CustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function SlimeKingPhase2CustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if
		previousAbilityName == Enums.EnemyAbilities.SlimeKingLoseLegs
		or previousAbilityName == Enums.EnemyAbilities.NightmareSlimeKingLoseLegs
	then
		self._TimingHelpers.LegFallOff:Start()
	end
end

function SlimeKingPhase2CustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function SlimeKingPhase2CustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function SlimeKingPhase2CustomCodeClass.EnemyDestroyed(_, flag: boolean?, _: boolean?)
	if flag then
	end
end

function SlimeKingPhase2CustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function SlimeKingPhase2CustomCodeClass.AnimationStateChanged(_, _: string, _) end

return SlimeKingPhase2CustomCodeClass