local AerialJuggernautCustomCodeClass = {}
AerialJuggernautCustomCodeClass.__index = AerialJuggernautCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function AerialJuggernautCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 0.7000000000000001,
		DeathStartCFrame = nil,
		StartingHoverHeight = 0,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, AerialJuggernautCustomCodeClass))
end

function AerialJuggernautCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self.StartingHoverHeight = (characterModel:GetAttribute("HoverHeight") or 0) + 2
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 0.7000000000000001,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(1)
		end
	})
end

function AerialJuggernautCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.DeathStarted then
		self.DeathTimeRemaining -= p
		local characterModel = self.CharacterModel
		local v = 1 - self.DeathTimeRemaining / 0.7000000000000001
		characterModel:PivotTo(self.DeathStartCFrame - Vector3.new(0, v ^ 2 * self.StartingHoverHeight, 0))
	end
end

function AerialJuggernautCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function AerialJuggernautCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function AerialJuggernautCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function AerialJuggernautCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.DeathStarted = true
	self.DeathStartCFrame = self.CharacterModel:GetPivot()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function AerialJuggernautCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function AerialJuggernautCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return AerialJuggernautCustomCodeClass