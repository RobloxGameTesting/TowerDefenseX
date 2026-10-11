local ArtemisCustomCodeClass = {}
ArtemisCustomCodeClass.__index = ArtemisCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function ArtemisCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 3.55,
		DeathStartCFrame = nil,
		StartingHoverHeight = 0,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, ArtemisCustomCodeClass))
end

function ArtemisCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self.StartingHoverHeight = characterModel:GetAttribute("HoverHeight") or 0
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 3.55,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
			self.Character:ExplodeParts(2)
		end
	})
end

function ArtemisCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.DeathStarted then
		self.DeathTimeRemaining -= p
		local characterModel = self.CharacterModel
		local v = 1 - self.DeathTimeRemaining / 3.55
		characterModel:PivotTo(self.DeathStartCFrame - Vector3.new(0, v ^ 2 * self.StartingHoverHeight, 0))
	end
end

function ArtemisCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function ArtemisCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ArtemisCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ArtemisCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.DeathStarted = true
	self.DeathStartCFrame = self.CharacterModel:GetPivot()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function ArtemisCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function ArtemisCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return ArtemisCustomCodeClass