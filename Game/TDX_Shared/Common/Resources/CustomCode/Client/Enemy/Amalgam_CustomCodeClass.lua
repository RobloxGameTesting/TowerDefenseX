local AmalgamCustomCodeClass = {}
AmalgamCustomCodeClass.__index = AmalgamCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function AmalgamCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Petrified = false,
		LavaParts = nil
	}, AmalgamCustomCodeClass))
end

function AmalgamCustomCodeClass:Initialize(enemy, _)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	local parts = {}

	for _, part in pairs(characterModel:GetDescendants()) do
		if part:IsA("BasePart") and part:FindFirstChild("LavaPart") then
			table.insert(parts, part)
		end
	end

	self.LavaParts = parts
end

function AmalgamCustomCodeClass:Run_FromCharacter(_: number)
	local enemy = self.Enemy

	if not self.Petrified and enemy.OnSecondLife then
		self:_TriggerPetrified()
	end
end

function AmalgamCustomCodeClass.AbilityUsed(_, _: string) end

function AmalgamCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function AmalgamCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function AmalgamCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function AmalgamCustomCodeClass.CharacterCleanedUp(_) end

function AmalgamCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function AmalgamCustomCodeClass:_TriggerPetrified()
	self.Petrified = true

	if self.Character.EmitterWrapper then
		self.Character.EmitterWrapper:StopContinuous()
	end

	if self.Character.SoundWrapper then
		self.Character.SoundWrapper:StopContinuous()
	end

	for _, lavaPart in pairs(self.LavaParts) do
		TweenService:Create(lavaPart, TweenInfo.new(1), { Transparency = 1 }):Play()
	end
end

return AmalgamCustomCodeClass