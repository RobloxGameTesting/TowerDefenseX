local TBVoidCustomCodeClass = {}
TBVoidCustomCodeClass.__index = TBVoidCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))

function TBVoidCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		SpinningVFXWeld = nil,
		Config = nil,
		PreviousAbilityName = nil,
		_TimingHelpers = {},
		_Wrappers = {}
	}, TBVoidCustomCodeClass))
end

function TBVoidCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local primaryPart = self.CharacterModel.PrimaryPart
	self.ConversionVFXPartWeld = primaryPart:FindFirstChild("ConversionVFXPart")
	self.SummonVFXPartWeld = primaryPart:FindFirstChild("SummonVFX")
end

function TBVoidCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	if p > 0 then
		self.ConversionVFXPartWeld.C0 *= CFrame.Angles(p * 1.8, 0, 0)
		self.SummonVFXPartWeld.C0 *= CFrame.Angles(0, p * 1.8, 0)
	end
end

function TBVoidCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName

	if previousAbilityName == Enums.EnemyAbilities.CalamityRage then
		local speed = self.Config.Speed
		local movementSpeedIncrease = ResourceManager.GetEnemyAbilityConfig(Enums.EnemyAbilities.CalamityRage).MovementSpeedIncrease
			or 0
		self.Enemy.MovementHandler:SetCustomSpeedMultiplier((speed + movementSpeedIncrease) / speed)
	end
end

function TBVoidCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function TBVoidCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function TBVoidCustomCodeClass.EnemyDestroyed(_, flag: boolean?, flag2: boolean?)
	if flag or flag2 then
	end
end

function TBVoidCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function TBVoidCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return TBVoidCustomCodeClass