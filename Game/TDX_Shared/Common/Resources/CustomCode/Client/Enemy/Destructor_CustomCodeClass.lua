local DestructorCustomCodeClass = {}
DestructorCustomCodeClass.__index = DestructorCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
local Utilities = require(common:WaitForChild("Utilities"))
workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function DestructorCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		_TimingHelpers = {},
		_Wrappers = {}
	}, DestructorCustomCodeClass))
end

function DestructorCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.Config = config
end

function DestructorCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function DestructorCustomCodeClass:AbilityUsed(p: string)
	if p == Enums.EnemyAbilities.DestructorRage then
		self:_EnterDamagedState()
	end
end

function DestructorCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function DestructorCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function DestructorCustomCodeClass.EnemyDestroyed(_, _: boolean?, _: boolean?) end

function DestructorCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function DestructorCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function DestructorCustomCodeClass:_EnterDamagedState()
	local config = self.Config
	local v = Utilities.TryGetInstanceFromPath(self.CharacterModel, config.FootstepEffectInstanceNames)

	if not v then
		warn("Missing footstep SFX parent")
		return
	end

	local footstep = v:FindFirstChild("Footstep")
	local footstepDamaged = v:FindFirstChild("FootstepDamaged")

	if footstep and footstepDamaged then
		footstep.SoundId = footstepDamaged.SoundId
	else
		warn("Missing footstep SFX")
	end
end

return DestructorCustomCodeClass