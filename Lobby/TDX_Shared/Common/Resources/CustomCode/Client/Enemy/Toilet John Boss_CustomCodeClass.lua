local ToiletJohnBossCustomCodeClass = {}
ToiletJohnBossCustomCodeClass.__index = ToiletJohnBossCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))

function ToiletJohnBossCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		MinigunEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		_Wrappers = {}
	}, ToiletJohnBossCustomCodeClass))
end

function ToiletJohnBossCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local minigun = self.CharacterModel:FindFirstChild("Minigun")
	self.MinigunEffectWrapper:AddFrom(minigun, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.MinigunEffectWrapper)
end

function ToiletJohnBossCustomCodeClass.Run_FromCharacter(_, _: number) end

function ToiletJohnBossCustomCodeClass.AbilityUsed(_, _: string) end

function ToiletJohnBossCustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.ToiletJohnBossMinigun then
		if p3 == "Minigun" then
			p.MinigunEffectWrapper:PlayAll()
		elseif p3 == "Minigun_Stop" then
			p.MinigunEffectWrapper:StopContinuous()
		end
	end
end

function ToiletJohnBossCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function ToiletJohnBossCustomCodeClass.EnemyDestroyed(p, _: boolean?, flag: boolean?)
	if flag then
		return
	end

	p.MinigunEffectWrapper:StopContinuous()
end

function ToiletJohnBossCustomCodeClass.CharacterCleanedUp(_) end

function ToiletJohnBossCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return ToiletJohnBossCustomCodeClass