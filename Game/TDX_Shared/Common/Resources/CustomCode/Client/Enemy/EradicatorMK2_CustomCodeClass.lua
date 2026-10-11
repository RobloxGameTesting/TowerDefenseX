local EradicatorMK2CustomCodeClass = {}
EradicatorMK2CustomCodeClass.__index = EradicatorMK2CustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function EradicatorMK2CustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		DamagedWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		LeftArmFallOffWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		RightArmFallOffWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		HeadFallOffWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		DeathScreamWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		MinigunEffectWrapper = WrapperFactory.NewEmitterAndSoundWrapper(nil, speedMultiplier),
		PreviousAbilityName = nil,
		ProjectileOrigins = {},
		DeathTimingHelpers = {},
		_Wrappers = {}
	}, EradicatorMK2CustomCodeClass))
end

function EradicatorMK2CustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
	local characterModel = self.CharacterModel
	self.Character:ForceSetUpStealthShimmerParts()
	local damagedSparksVFX = characterModel:FindFirstChild("DamagedSparksVFX")
	local death_LeftTorsoEffects = characterModel:FindFirstChild("Death_LeftTorsoEffects")
	local death_LeftArmEffects = characterModel:FindFirstChild("Death_LeftArmEffects")
	local death_RightTorsoEffects = characterModel:FindFirstChild("Death_RightTorsoEffects")
	local death_RightArmEffects = characterModel:FindFirstChild("Death_RightArmEffects")
	local death_Explosion = characterModel:FindFirstChild("Death_Explosion")
	local death_ScreamEffects = characterModel:FindFirstChild("Death_ScreamEffects")
	self.DamagedWrapper:AddFrom(damagedSparksVFX, self.SpeedMultiplier)
	self.LeftArmFallOffWrapper:AddFrom(death_LeftTorsoEffects, self.SpeedMultiplier)
	self.LeftArmFallOffWrapper:AddFrom(death_LeftArmEffects, self.SpeedMultiplier)
	self.RightArmFallOffWrapper:AddFrom(death_RightTorsoEffects, self.SpeedMultiplier)
	self.RightArmFallOffWrapper:AddFrom(death_RightArmEffects, self.SpeedMultiplier)
	self.HeadFallOffWrapper:AddFrom(death_Explosion, self.SpeedMultiplier)
	self.DeathScreamWrapper:AddFrom(death_ScreamEffects, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.DamagedWrapper)
	table.insert(self._Wrappers, self.LeftArmFallOffWrapper)
	table.insert(self._Wrappers, self.RightArmFallOffWrapper)
	table.insert(self._Wrappers, self.HeadFallOffWrapper)
	table.insert(self._Wrappers, self.DeathScreamWrapper)
	local rotaryGuns = characterModel:FindFirstChild("RotaryGuns")
	self.MinigunEffectWrapper:AddFrom(rotaryGuns, self.SpeedMultiplier)
	table.insert(self._Wrappers, self.MinigunEffectWrapper)
	local v = TimingHelperClass.New({
		TimeUntilCallback = 1.5833333333333335,
		Callback = function()
			self.LeftArmFallOffWrapper:PlayAll()
		end
	})
	local v2 = TimingHelperClass.New({
		TimeUntilCallback = 41 / 15,
		Callback = function()
			self.RightArmFallOffWrapper:PlayAll()
		end
	})
	local v3 = TimingHelperClass.New({
		TimeUntilCallback = 2.75,
		Callback = function()
			for _, descendant in pairs(characterModel:GetDescendants()) do
				if descendant:FindFirstChild("IsLeftArm") then
					descendant:Destroy()
				end
			end
		end
	})
	local v4 = TimingHelperClass.New({
		TimeUntilCallback = 43 / 12,
		Callback = function()
			for _, descendant in pairs(characterModel:GetDescendants()) do
				if descendant:FindFirstChild("IsRightArm") then
					descendant:Destroy()
				end
			end
		end
	})
	local v5 = TimingHelperClass.New({
		TimeUntilCallback = 5.35,
		Callback = function()
			self.HeadFallOffWrapper:PlayAll()
		end
	})
	local v6 = TimingHelperClass.New({
		TimeUntilCallback = 5.866666666666667,
		Callback = function()
			for _, descendant in pairs(characterModel:GetDescendants()) do
				if descendant:FindFirstChild("IsHead") then
					descendant:Destroy()
				end
			end
		end
	})
	local v7 = TimingHelperClass.New({
		TimeUntilCallback = 7,
		Callback = function()
			for _, wrapper in pairs(self._Wrappers) do
				wrapper:StopContinuous()
			end
		end
	})
	table.insert(self.DeathTimingHelpers, v)
	table.insert(self.DeathTimingHelpers, v2)
	table.insert(self.DeathTimingHelpers, v3)
	table.insert(self.DeathTimingHelpers, v4)
	table.insert(self.DeathTimingHelpers, v5)
	table.insert(self.DeathTimingHelpers, v6)
	table.insert(self.DeathTimingHelpers, v7)
end

function EradicatorMK2CustomCodeClass.Run_FromCharacter(p, p2: number)
	for _, deathTimingHelper in pairs(p.DeathTimingHelpers) do
		deathTimingHelper:Run(p2)
	end
end

function EradicatorMK2CustomCodeClass:AbilityUsed(previousAbilityName: string)
	if previousAbilityName == Enums.EnemyAbilities.EradicatorMK2Rage then
		self:_EnterDamagedState()
	end

	self.PreviousAbilityName = previousAbilityName
end

function EradicatorMK2CustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.EradicatorMK2Minigun then
		if p3 == "Minigun" then
			p.MinigunEffectWrapper:PlayAll()
		elseif p3 == "Minigun_Stop" then
			p.MinigunEffectWrapper:StopContinuous()
		end
	end
end

function EradicatorMK2CustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function EradicatorMK2CustomCodeClass.EnemyDestroyed(data, _: boolean?, flag: boolean?)
	if flag then
		return
	end

	for _, deathTimingHelper in pairs(data.DeathTimingHelpers) do
		deathTimingHelper:Start()
	end

	data.MinigunEffectWrapper:StopContinuous()
	data.DeathScreamWrapper:PlayAll()
end

function EradicatorMK2CustomCodeClass.CharacterCleanedUp(p)
	for _, deathTimingHelper in pairs(p.DeathTimingHelpers) do
		deathTimingHelper:Destroy()
	end

	for _, projectileOrigin in pairs(p.ProjectileOrigins) do
		projectileOrigin:Destroy()
	end
end

function EradicatorMK2CustomCodeClass.AnimationStateChanged(_, _: string, _) end

function EradicatorMK2CustomCodeClass:_EnterDamagedState()
	local plane0541 = self.CharacterModel:FindFirstChild("Plane.054-1")

	if plane0541 then
		plane0541.Transparency = 1
	else
		warn("Nose not found")
	end

	if self.DamagedWrapper then
		self.DamagedWrapper:PlayAll()
	end
end

return EradicatorMK2CustomCodeClass