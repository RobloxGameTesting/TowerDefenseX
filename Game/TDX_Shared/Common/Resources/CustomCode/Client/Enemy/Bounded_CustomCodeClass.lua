local BoundedCustomCodeClass = {}
BoundedCustomCodeClass.__index = BoundedCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))

function BoundedCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		TimerTimeLeft = 0,
		TimerTextLabel = nil,
		CurrentText = nil,
		_TimingHelpers = {},
		_Wrappers = {}
	}, BoundedCustomCodeClass))
end

function BoundedCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	self.TimerTimeLeft = ResourceManager.GetEnemyAbilityConfig(Enums.EnemyAbilities.BoundedTransition).StartingCooldown
	self.TimerTextLabel = Utilities.TryGetInstanceFromPath(characterModel, "Shackle>Timer>SurfaceGui>Frame>TextLabel")

	if not self.TimerTextLabel then
		warn("TimerTextLabel not found")
	end
end

function BoundedCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if self.TimerTimeLeft > 0 then
		self.TimerTimeLeft = math.max(0, self.TimerTimeLeft - p)
		local timerTimeLeft = math.round(self.TimerTimeLeft)

		if self.CurrentText ~= timerTimeLeft then
			self.CurrentText = timerTimeLeft
			self.TimerTextLabel.Text = timerTimeLeft
		end
	end
end

function BoundedCustomCodeClass.AbilityUsed(_, _: string) end

function BoundedCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function BoundedCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function BoundedCustomCodeClass.EnemyDestroyed(_, flag: boolean?, _: boolean?)
	if flag then
	end
end

function BoundedCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function BoundedCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return BoundedCustomCodeClass