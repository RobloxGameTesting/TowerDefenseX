local ZeusCustomCodeClass = {}
ZeusCustomCodeClass.__index = ZeusCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function ZeusCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 2.5,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathVFX = nil, DeathVFXContinuous = nil }
	}, ZeusCustomCodeClass))
end

function ZeusCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathVFX = characterModel:FindFirstChild("DeathVFX")
	local deathVFXContinuous = characterModel:FindFirstChild("DeathVFXContinuous")
	self._Wrappers.DeathVFX = WrapperFactory.NewEmitterAndSoundWrapper(deathVFX, speedMultiplier)
	self._Wrappers.DeathVFXContinuous = WrapperFactory.NewEmitterAndSoundWrapper(deathVFXContinuous, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.5,
		Callback = function()
			self._Wrappers.DeathVFXContinuous:StopContinuous()
			self._Wrappers.DeathVFX:PlayAll()
		end
	})
end

function ZeusCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function ZeusCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function ZeusCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ZeusCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ZeusCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self._Wrappers.DeathVFXContinuous:PlayAll()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function ZeusCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function ZeusCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return ZeusCustomCodeClass