local GeneralCelgarCustomCodeClass = {}
GeneralCelgarCustomCodeClass.__index = GeneralCelgarCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))

function GeneralCelgarCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		AnimationHandler = nil,
		Config = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = {}
	}, GeneralCelgarCustomCodeClass))
end

function GeneralCelgarCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local _primaryPart = self.CharacterModel.PrimaryPart
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 2.3,
		Callback = function() end
	})
end

function GeneralCelgarCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function GeneralCelgarCustomCodeClass.AbilityUsed(_, _: string) end

function GeneralCelgarCustomCodeClass.AbilityAnimationKeyframeReached(player, p: string, p2: string)
	if p == Enums.EnemyAbilities.GeneralCelgarAxeThrow then
		if p2 == "AxeRelease" then
			player.Character:HideModelWithName("AxeMesh")
		elseif p2 == "AxeCatch" then
			player.Character:ShowModelWithName("AxeMesh")
		end
	end
end

function GeneralCelgarCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function GeneralCelgarCustomCodeClass:EnemyDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self.Character:ShowModelWithName("AxeMesh")
	self._TimingHelpers.DeathTimingHelper:Start()
end

function GeneralCelgarCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function GeneralCelgarCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function GeneralCelgarCustomCodeClass._StartLaserSweep(_) end

function GeneralCelgarCustomCodeClass._StopLaserSweep(_) end

return GeneralCelgarCustomCodeClass