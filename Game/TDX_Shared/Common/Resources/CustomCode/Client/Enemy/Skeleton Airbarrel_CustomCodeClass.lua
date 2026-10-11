local SkeletonAirbarrelCustomCodeClass = {}
SkeletonAirbarrelCustomCodeClass.__index = SkeletonAirbarrelCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function SkeletonAirbarrelCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		DeathStarted = false,
		DeathTimeRemaining = 47 / 60,
		DeathStartCFrame = nil,
		StartingHoverHeight = 0,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathVFX = nil }
	}, SkeletonAirbarrelCustomCodeClass))
end

function SkeletonAirbarrelCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathVFXPart = characterModel:FindFirstChild("DeathVFXPart")
	self.StartingHoverHeight = characterModel:GetAttribute("HoverHeight") or 0
	self._Wrappers.DeathVFX = WrapperFactory.NewEmitterAndSoundWrapper(deathVFXPart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 47 / 60,
		Callback = function()
			self._Wrappers.DeathVFX:PlayAll()
		end
	})
end

function SkeletonAirbarrelCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.DeathStarted then
		self.DeathTimeRemaining -= p
		local characterModel = self.CharacterModel
		local v = math.clamp(1 - self.DeathTimeRemaining / (47 / 60), 0, 1)

		if self.DeathTimeRemaining <= 0 then
			return
		end

		local _ = 1 - (1 - v) * (1 - v)

		if v ~= 1 then
			local _ = 1 - math.pow(2, v * -10)
		end

		characterModel:PivotTo(self.DeathStartCFrame - Vector3.new(
			0,
			math.clamp(v * self.StartingHoverHeight, 0, self.StartingHoverHeight),
			0
		))
	end
end

function SkeletonAirbarrelCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function SkeletonAirbarrelCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function SkeletonAirbarrelCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function SkeletonAirbarrelCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.DeathStarted = true
	self.DeathStartCFrame = self.CharacterModel:GetPivot()
	self._TimingHelpers.DeathTimingHelper:Start()
end

function SkeletonAirbarrelCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function SkeletonAirbarrelCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return SkeletonAirbarrelCustomCodeClass