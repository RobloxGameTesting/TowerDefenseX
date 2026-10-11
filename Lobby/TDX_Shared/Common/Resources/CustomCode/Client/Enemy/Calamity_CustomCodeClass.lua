local CalamityCustomCodeClass = {}
CalamityCustomCodeClass.__index = CalamityCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))

function CalamityCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathTimingHelper = nil, DeathTimingHelper2 = nil },
		_Wrappers = { DeathPortal = nil }
	}, CalamityCustomCodeClass))
end

function CalamityCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local deathVFX = self.CharacterModel:FindFirstChild("DeathVFX")
	self._Wrappers.DeathPortal = WrapperFactory.NewEmitterAndSoundWrapper(deathVFX, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 0,
		Callback = function()
			self._Wrappers.DeathPortal:PlayAll()
		end
	})
	self._TimingHelpers.DeathTimingHelper2 = TimingHelperClass.New({
		TimeUntilCallback = 4.5,
		Callback = function()
			self._Wrappers.DeathPortal:StopContinuous()
		end
	})
end

function CalamityCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function CalamityCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if
		previousAbilityName == Enums.EnemyAbilities.CalamityRage
		or previousAbilityName == Enums.EnemyAbilities.NightmareCalamity1Rage
		or previousAbilityName == Enums.EnemyAbilities.NightmareCalamity2Rage
	then
		local speed = self.Config.Speed
		local movementSpeedIncrease = ResourceManager.GetEnemyAbilityConfig(Enums.EnemyAbilities.CalamityRage).MovementSpeedIncrease
			or 0
		self.Enemy.MovementHandler:SetCustomSpeedMultiplier((speed + movementSpeedIncrease) / speed)
	end
end

function CalamityCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function CalamityCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function CalamityCustomCodeClass:EnemyDestroyed(flag: boolean?, flag2: boolean?)
	if flag or flag2 then
		return
	end

	self._TimingHelpers.DeathTimingHelper:Start()
	self._TimingHelpers.DeathTimingHelper2:Start()
end

function CalamityCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function CalamityCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return CalamityCustomCodeClass