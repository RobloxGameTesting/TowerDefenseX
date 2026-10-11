local VoidCrystalCustomCodeClass = {}
VoidCrystalCustomCodeClass.__index = VoidCrystalCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")

function VoidCrystalCustomCodeClass.New(_: number)
	return (setmetatable({
		Enemy = nil,
		Character = nil,
		CharacterModel = nil,
		RootPart = nil,
		BaseScale = 1,
		GrowTime = 0,
		Elapsed = 0,
		CurrentAlpha = 0.05,
		Growing = false,
		PulseTemplate = nil,
		Pulses = {},
		TimeToNextPulse = 0
	}, VoidCrystalCustomCodeClass))
end

function VoidCrystalCustomCodeClass:_ApplyScale(currentAlpha: number)
	self.CurrentAlpha = currentAlpha

	if self.CharacterModel.Parent then
		self.CharacterModel:ScaleTo(self.BaseScale * currentAlpha)
	end
end

function VoidCrystalCustomCodeClass:_RandomPulseInterval()
	return 1 + math.random() * 0
end

function VoidCrystalCustomCodeClass:_BuildPulseTemplate(instance)
	local clone = instance:Clone()

	for _, descendant in pairs(clone:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = true
			descendant.CanCollide = false
			descendant.CanTouch = false
			descendant.CanQuery = false
			descendant.Massless = true
		elseif descendant:IsA("JointInstance") then
			descendant:Destroy()
		end
	end

	self.PulseTemplate = clone
end

function VoidCrystalCustomCodeClass:_SpawnPulse()
	if not (self.PulseTemplate and self.RootPart.Parent) then
		return
	end

	local startScale = self.BaseScale * self.CurrentAlpha
	local clone = self.PulseTemplate:Clone()
	clone.Name = "VoidCrystalPulse"
	clone:PivotTo(self.RootPart.CFrame)
	clone:ScaleTo(startScale)
	clone.Parent = raycastIgnore
	local parts = {}

	for _, part in pairs(Utilities.GetAllBasepartDescendants(clone)) do
		table.insert(parts, { Part = part, Transparency = part.Transparency })
	end

	table.insert(self.Pulses, { Model = clone, Parts = parts, Elapsed = 0, StartScale = startScale })
end

function VoidCrystalCustomCodeClass:_RunPulses(p: number)
	for i = #self.Pulses, 1, -1 do
		local puls = self.Pulses[i]
		puls.Elapsed += p
		local v = puls.Elapsed / 1

		if v >= 1 or not puls.Model.Parent then
			puls.Model:Destroy()
			table.remove(self.Pulses, i)
		else
			puls.Model:ScaleTo(puls.StartScale * (1 + 1.4 * v))
			local v2 = v ^ 0.45

			for _, part in pairs(puls.Parts) do
				part.Part.Transparency = part.Transparency + (1 - part.Transparency) * v2
			end
		end
	end
end

function VoidCrystalCustomCodeClass:_ClearPulses()
	for _, puls in pairs(self.Pulses) do
		puls.Model:Destroy()
	end

	table.clear(self.Pulses)
end

function VoidCrystalCustomCodeClass:_FinishGrowing()
	self.Growing = false
	self:_ApplyScale(1)
end

function VoidCrystalCustomCodeClass:Initialize(enemy, p)
	self.Enemy = enemy
	self.Character = enemy.Character
	self.GrowTime = p.SpawnAnimationTime or 0

	if self.GrowTime <= 0 then
		return
	end

	local characterModel = self.Character:GetCharacterModel()

	if not characterModel then
		warn("Void Crystal custom code could not resolve the character model")
		return
	end

	self.CharacterModel = characterModel
	self.RootPart = characterModel.PrimaryPart
	self.BaseScale = characterModel:GetScale()
	self:_BuildPulseTemplate(characterModel)
	self.Growing = true
	self.TimeToNextPulse = self:_RandomPulseInterval()
	self:_ApplyScale(0.05)
end

function VoidCrystalCustomCodeClass:Run_FromCharacter(p: number)
	self:_RunPulses(p)

	if not self.Growing then
		return
	end

	self.Elapsed += p

	if self.Elapsed >= self.GrowTime then
		self:_FinishGrowing()
		return
	end

	self:_ApplyScale(0.05 + 0.95 * (self.Elapsed / self.GrowTime) ^ 0.6)
	self.TimeToNextPulse -= p

	if self.TimeToNextPulse <= 0 then
		self:_SpawnPulse()
		self.TimeToNextPulse = self:_RandomPulseInterval()
	end
end

function VoidCrystalCustomCodeClass.AbilityUsed(_, _: string) end

function VoidCrystalCustomCodeClass.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function VoidCrystalCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function VoidCrystalCustomCodeClass:EnemyDestroyed(_: boolean?, _: boolean?)
	if self.Growing then
		self:_FinishGrowing()
	end

	self:_ClearPulses()
end

function VoidCrystalCustomCodeClass:CharacterCleanedUp()
	self.Growing = false
	self:_ClearPulses()

	if self.PulseTemplate then
		self.PulseTemplate:Destroy()
		self.PulseTemplate = nil
	end
end

function VoidCrystalCustomCodeClass.AnimationStateChanged(_, _: string, _) end

return VoidCrystalCustomCodeClass