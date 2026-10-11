local ScarecrowCustomCodeClass = {}
ScarecrowCustomCodeClass.__index = ScarecrowCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function ScarecrowCustomCodeClass.New(_: number)
	return (setmetatable({ Tower = nil, Character = nil }, ScarecrowCustomCodeClass))
end

function ScarecrowCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
end

function ScarecrowCustomCodeClass.Run_FromCharacter(_, _: number) end

function ScarecrowCustomCodeClass.AbilityUsed(_, _) end

function ScarecrowCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function ScarecrowCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function ScarecrowCustomCodeClass.Upgraded(_, _) end

function ScarecrowCustomCodeClass.CharacterCleanedUp(_) end

function ScarecrowCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function ScarecrowCustomCodeClass.Attacked(_, _, _: boolean?) end

function ScarecrowCustomCodeClass.Death(player)
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
	local deathForceMultiplier = characterModel:GetAttribute("DeathForceMultiplier") or 1.5

	for _, v in pairs(parts) do
		v.CanCollide = true
		local mass = v:GetMass()
		primaryPart:ApplyImpulse(deathForceMultiplier * mass * vector)
		primaryPart:ApplyAngularImpulse(deathForceMultiplier * mass * vector2)
	end
end

return ScarecrowCustomCodeClass