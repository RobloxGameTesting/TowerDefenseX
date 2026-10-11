local VoidApexPredatorCustomCodeClass = {}
VoidApexPredatorCustomCodeClass.__index = VoidApexPredatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function VoidApexPredatorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathCoreHoldTimingHelper = nil, DeathTimingHelper = nil },
		_Wrappers = { DeathSFX = nil, DeathExplode = nil }
	}, VoidApexPredatorCustomCodeClass))
end

function VoidApexPredatorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self._Wrappers.DeathSFX = WrapperFactory.NewSoundWrapper(primaryPart, speedMultiplier)
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathCoreHoldTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2,
		Callback = function()
			local core = characterModel:FindFirstChild("Core")
			local coreDeath = characterModel:FindFirstChild("CoreDeath")

			if core and coreDeath then
				core.Transparency = 1
				coreDeath.Transparency = 0
			end
		end
	})
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 6.55,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(2)
		end
	})
end

function VoidApexPredatorCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function VoidApexPredatorCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function VoidApexPredatorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function VoidApexPredatorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function VoidApexPredatorCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self._Wrappers.DeathSFX:PlayAll()
	self._TimingHelpers.DeathCoreHoldTimingHelper:Start()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function VoidApexPredatorCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function VoidApexPredatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return VoidApexPredatorCustomCodeClass