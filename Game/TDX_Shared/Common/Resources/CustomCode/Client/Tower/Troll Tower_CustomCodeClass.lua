local TrollTowerCustomCodeClass = {}
TrollTowerCustomCodeClass.__index = TrollTowerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function TrollTowerCustomCodeClass.New(_: number)
	return (setmetatable({ Tower = nil, Character = nil }, TrollTowerCustomCodeClass))
end

function TrollTowerCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
end

function TrollTowerCustomCodeClass.Run_FromCharacter(_, _: number) end

function TrollTowerCustomCodeClass.AbilityUsed(_, _) end

function TrollTowerCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function TrollTowerCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function TrollTowerCustomCodeClass.Upgraded(_, _) end

function TrollTowerCustomCodeClass.CharacterCleanedUp(_) end

function TrollTowerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function TrollTowerCustomCodeClass.Attacked(_, _, _: boolean?) end

function TrollTowerCustomCodeClass.Death(player)
	local character = player.Character
	local characterModel = character:GetCharacterModel()
	local primaryPart = characterModel.PrimaryPart
	local parts = {}

	for _, part in pairs(characterModel:GetDescendants()) do
		if part:IsA("BasePart") and part:GetAttribute("CanCollideOnDeath") then
			table.insert(parts, part)
		end
	end

	character:DestroyTorsoToRootWeld()
	local vector = Vector3.new(math.random(-25, 25), math.random(2, 5), math.random(-22, 22))
	local vector2 = Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0)

	for _, v in pairs(parts) do
		v.CanCollide = true
		local mass = v:GetMass()
		primaryPart:ApplyImpulse(1.5 * mass * vector)
		primaryPart:ApplyAngularImpulse(1.5 * mass * vector2)
	end
end

return TrollTowerCustomCodeClass