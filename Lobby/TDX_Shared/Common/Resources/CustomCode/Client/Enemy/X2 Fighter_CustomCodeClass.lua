local X2FighterCustomCodeClass = {}
X2FighterCustomCodeClass.__index = X2FighterCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("WrapperFactory"))
require(common:WaitForChild("TimingHelperClass"))
require(common:WaitForChild("MapHandler"))

function X2FighterCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		FlightTrails = {},
		_TimingHelpers = {},
		_Wrappers = { BeamEffects = nil }
	}, X2FighterCustomCodeClass))
end

function X2FighterCustomCodeClass:Initialize(enemy, config)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = self.Character:GetCharacterModel()
	self.AnimationHandler = self.Character.PrimaryAnimationHandler
	self.Config = config
	local _speedMultiplier = self.SpeedMultiplier
	local flightTrails = self.CharacterModel:FindFirstChild("FlightTrails")

	if flightTrails then
		for _, trail in pairs(flightTrails:GetDescendants()) do
			if trail:IsA("Trail") then
				table.insert(self.FlightTrails, trail)
			end
		end
	end
end

function X2FighterCustomCodeClass:Run_FromCharacter(p: number)
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Run(p)
	end
end

function X2FighterCustomCodeClass:AbilityUsed(previousAbilityName: string)
	self.PreviousAbilityName = previousAbilityName
end

function X2FighterCustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.X2FighterRage or p2 == Enums.EnemyAbilities.X2TrooperRage then
		if p3 == "TrailStart" then
			for _, flightTrail in pairs(p.FlightTrails) do
				flightTrail.Enabled = true
			end
		elseif p3 == "TrailStop" then
			for _, flightTrail in pairs(p.FlightTrails) do
				flightTrail.Enabled = false
			end
		end
	end
end

function X2FighterCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier

	for _, wrapper in pairs(self._Wrappers) do
		wrapper:SpeedMultiplierChanged(speedMultiplier)
	end
end

function X2FighterCustomCodeClass.EnemyDestroyed(_, flag: boolean?, flag2: boolean?)
	if flag or flag2 then
	end
end

function X2FighterCustomCodeClass:CharacterCleanedUp()
	for _, timingHelper in pairs(self._TimingHelpers) do
		timingHelper:Destroy()
	end
end

function X2FighterCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return X2FighterCustomCodeClass