local EvilGasToiletCustomCodeClass = {}
EvilGasToiletCustomCodeClass.__index = EvilGasToiletCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))

function EvilGasToiletCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		MinigunEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		_Wrappers = {}
	}, EvilGasToiletCustomCodeClass))
end

function EvilGasToiletCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local spray = self.CharacterModel:FindFirstChild("Spray")
	self.MinigunEffectWrapper:AddFrom(spray, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.MinigunEffectWrapper)
end

function EvilGasToiletCustomCodeClass.Run_FromCharacter(_, _: number) end

function EvilGasToiletCustomCodeClass.AbilityUsed(_, _: string) end

function EvilGasToiletCustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.EvilGasToiletSpray then
		if p3 == "Minigun" then
			p.MinigunEffectWrapper:PlayAll()
		elseif p3 == "Minigun_Stop" then
			p.MinigunEffectWrapper:StopContinuous()
		end
	end
end

function EvilGasToiletCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EvilGasToiletCustomCodeClass.EnemyDestroyed(p, _: boolean?, flag: boolean?)
	if flag then
		return
	end

	p.MinigunEffectWrapper:StopContinuous()
end

function EvilGasToiletCustomCodeClass.CharacterCleanedUp(_) end

function EvilGasToiletCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return EvilGasToiletCustomCodeClass