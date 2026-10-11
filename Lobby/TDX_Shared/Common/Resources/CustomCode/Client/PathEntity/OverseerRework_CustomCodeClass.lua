local OverseerReworkCustomCodeClass = {}
OverseerReworkCustomCodeClass.__index = OverseerReworkCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local TimingHelperClass = require(common:WaitForChild("TimingHelperClass"))

function OverseerReworkCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		PreviousAbilityName = nil,
		LaserDecals = {},
		LaserDecalsOn = false,
		LaserDecalsTimeSinceToggle = 1e999,
		LaserDecalsCurrentTransparency = 1,
		_TimingHelpers = { DeathTimingHelper = nil },
		_Wrappers = { DeathEffects = nil }
	}, OverseerReworkCustomCodeClass))
end

function OverseerReworkCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local speedMultiplier = self.SpeedMultiplier
	local characterModel = self.CharacterModel
	local _primaryPart = characterModel.PrimaryPart
	local deathEffects = characterModel:FindFirstChild("DeathEffects")
	local laser = characterModel:FindFirstChild("Laser")

	for _, decal in pairs(laser:GetDescendants()) do
		if decal:IsA("Decal") then
			table.insert(self.LaserDecals, decal)
		end
	end

	self._Wrappers.DeathEffects = WrapperFactory.NewEmitterAndSoundWrapper(deathEffects, speedMultiplier)
	self._TimingHelpers.DeathTimingHelper = TimingHelperClass.New({
		TimeUntilCallback = 1,
		Callback = function()
			self._Wrappers.DeathEffects:PlayAll()
		end
	})
end

function OverseerReworkCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end

	self.LaserDecalsTimeSinceToggle += p
	local v

	if self.LaserDecalsOn then
		v = 1 - math.clamp(self.LaserDecalsTimeSinceToggle / 1, 0, 1)
	else
		v = math.clamp(self.LaserDecalsTimeSinceToggle / 1, 0, 1)
	end

	if v ~= self.LaserDecalsCurrentTransparency then
		self.LaserDecalsCurrentTransparency = v

		for _, laserDecal in pairs(self.LaserDecals) do
			laserDecal.Transparency = v
		end
	end
end

function OverseerReworkCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function OverseerReworkCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.PathEntityAbilities.OverseerLaser then
		if p2 == "Sigil" then
			self:_ToggleLaserDecals(true)
		elseif p2 == "Sigil_Stop" then
			self:_ToggleLaserDecals(false)
		end
	end
end

function OverseerReworkCustomCodeClass:_ToggleLaserDecals(laserDecalsOn: boolean)
	if self.LaserDecalsOn == laserDecalsOn then
		return
	end

	self.LaserDecalsOn = laserDecalsOn
	self.LaserDecalsTimeSinceToggle = 0
end

function OverseerReworkCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function OverseerReworkCustomCodeClass:PathEntityDestroyed(flag: boolean?, _: boolean?)
	if flag then
		return
	end

	self._TimingHelpers.DeathTimingHelper:Start()
end

function OverseerReworkCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function OverseerReworkCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return OverseerReworkCustomCodeClass