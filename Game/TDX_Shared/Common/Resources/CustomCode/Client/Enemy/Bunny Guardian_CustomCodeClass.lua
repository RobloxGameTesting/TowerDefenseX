local BunnyGuardianCustomCodeClass = {}
BunnyGuardianCustomCodeClass.__index = BunnyGuardianCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))

function BunnyGuardianCustomCodeClass.New(speedMultiplier: number)
	return (setmetatable({
		SpeedMultiplier = speedMultiplier,
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		Config = nil,
		LanceTrail = nil
	}, BunnyGuardianCustomCodeClass))
end

function BunnyGuardianCustomCodeClass:Initialize(enemy, config)
	local characterModel = enemy.Character:GetCharacterModel()
	self.Enemy = enemy
	self.Character = enemy.Character
	self.CharacterModel = characterModel
	self.Config = config
	local lance = characterModel:FindFirstChild("Lance", true)
	local trail = lance and lance:FindFirstChildWhichIsA("Trail")

	if trail then
		trail.Enabled = false
		self.LanceTrail = trail
	end
end

function BunnyGuardianCustomCodeClass.Run_FromCharacter(_, _: number) end

function BunnyGuardianCustomCodeClass.AbilityUsed(_, _: string) end

function BunnyGuardianCustomCodeClass.AbilityAnimationKeyframeReached(p, p2: string, p3: string)
	if p2 == Enums.EnemyAbilities.BunnyGuardianSwing then
		if p3 == "SwingStart" then
			if p.LanceTrail then
				p.LanceTrail.Enabled = true
			end
		elseif p3 == "SwingStop" and p.LanceTrail then
			p.LanceTrail.Enabled = false
		end
	end
end

function BunnyGuardianCustomCodeClass:SpeedMultiplierChanged_FromCharacter(speedMultiplier: number)
	self.SpeedMultiplier = speedMultiplier
end

function BunnyGuardianCustomCodeClass.EnemyDestroyed(p, _: boolean?, _: boolean?)
	if p.LanceTrail then
		p.LanceTrail.Enabled = false
	end
end

function BunnyGuardianCustomCodeClass.CharacterCleanedUp(_) end

function BunnyGuardianCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return BunnyGuardianCustomCodeClass