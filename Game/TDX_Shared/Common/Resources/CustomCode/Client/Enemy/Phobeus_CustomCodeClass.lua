local PhobeusCustomCodeClass = {}
PhobeusCustomCodeClass.__index = PhobeusCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function PhobeusCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil, DeathVFXContinuous = nil }
	}, PhobeusCustomCodeClass))
end

function PhobeusCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	local deathVFXContinuous = characterModel:FindFirstChild("DeathVFXContinuous")
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._Wrappers.DeathVFXContinuous = WrapperFactory.NewEmitterAndSoundWrapper(deathVFXContinuous, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 3.033,
		Callback = function()
			self._Wrappers.DeathVFXContinuous:StopContinuous()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(2)
		end
	})
end

function PhobeusCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function PhobeusCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function PhobeusCustomCodeClass.AbilityAnimationKeyframeReached(player, p: string, p2: string)
	if p == Enums.EnemyAbilities.PhobeusShieldStance then
		if p2 == "ShieldUp" then
			player.Character:ToggleShieldIfExists(true)
		elseif p2 == "ShieldDown" then
			player.Character:ToggleShieldIfExists(false)
		end
	end
end

function PhobeusCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function PhobeusCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	self.Character:ToggleShieldIfExists(false)

	if flag then
		return
	end

	self._Wrappers.DeathVFXContinuous:PlayAll()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function PhobeusCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function PhobeusCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return PhobeusCustomCodeClass