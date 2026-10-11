local createVector = vector.create
local CorruptedApexPredatorCustomCodeClass = {}
CorruptedApexPredatorCustomCodeClass.__index = CorruptedApexPredatorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))

function CorruptedApexPredatorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathExplode = nil }
	}, CorruptedApexPredatorCustomCodeClass))
end

function CorruptedApexPredatorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathExplodePart = characterModel:FindFirstChild("DeathExplodePart")
	self._Wrappers.DeathExplode = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier)
	self._Wrappers.DeathExplode:AddFrom(deathExplodePart, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 5.117,
		Callback = function()
			self._Wrappers.DeathExplode:PlayAll()
		end
	})
end

function CorruptedApexPredatorCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function CorruptedApexPredatorCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function CorruptedApexPredatorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function CorruptedApexPredatorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function CorruptedApexPredatorCustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	self._TimingHelpers.DeathTimingHelper:Start()
	self:_DropCross()
end

function CorruptedApexPredatorCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function CorruptedApexPredatorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function CorruptedApexPredatorCustomCodeClass:_DropCross()
	local characterModel = self.CharacterModel
	local primaryPart = characterModel.PrimaryPart
	local v = Utilities.TryGetInstanceFromPath(characterModel, "LowerRightArm>Cross")
	local v2 = Utilities.TryGetInstanceFromPath(characterModel, "Cross>Cross")

	if v then
		v.Enabled = false
	end

	if v2 then
		v2.CanCollide = true
		local unit = (v2.Position - primaryPart.Position + createVector(0, 1.5, 0)).Unit
		local mass = v2:GetMass()
		v2:ApplyImpulse(30 * unit * mass)
	end
end

return CorruptedApexPredatorCustomCodeClass