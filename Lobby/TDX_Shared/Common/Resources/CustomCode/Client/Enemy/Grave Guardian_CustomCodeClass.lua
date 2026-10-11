local GraveGuardianCustomCodeClass = {}
GraveGuardianCustomCodeClass.__index = GraveGuardianCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))

function GraveGuardianCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		AnimationHandler = nil,
		Config = nil,
		_TimingHelpers = {},
		_Wrappers = {}
	}, GraveGuardianCustomCodeClass))
end

function GraveGuardianCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local _primaryPart = self.CharacterModel.PrimaryPart
	self.Character:HideModelWithName("ForceField")
end

function GraveGuardianCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function GraveGuardianCustomCodeClass.AbilityUsed(_, _: string) end

function GraveGuardianCustomCodeClass.AbilityAnimationKeyframeReached(player, p: string, p2: string)
	if p == Enums.EnemyAbilities.GraveGuardianTomahawkThrow then
		if p2 == "TomahawkRelease" then
			player.Character:HideModelWithName("GraveGuardianTomahawk")
		elseif p2 == "TomahawkReturn" then
			player.Character:ShowModelWithName("GraveGuardianTomahawk")
		end
	elseif p == Enums.EnemyAbilities.GraveGuardianShieldCharge then
		if p2 == "ShieldUp" then
			player.Character:ShowModelWithName("ForceField")
		elseif p2 == "ShieldDown" then
			player.Character:HideModelWithName("ForceField")
		end
	end
end

function GraveGuardianCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function GraveGuardianCustomCodeClass.EnemyDestroyed(player, flag: boolean?, _: boolean?)
	if flag then
		return
	end

	player.Character:ShowModelWithName("GraveGuardianTomahawk")
	player.Character:HideModelWithName("ForceField")
end

function GraveGuardianCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function GraveGuardianCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return GraveGuardianCustomCodeClass