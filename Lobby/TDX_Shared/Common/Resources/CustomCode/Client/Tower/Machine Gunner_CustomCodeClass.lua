local MachineGunnerCustomCodeClass = {}
MachineGunnerCustomCodeClass.__index = MachineGunnerCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))

function MachineGunnerCustomCodeClass.New(_: number)
	return (setmetatable({ Tower = nil, Character = nil, HoldingGun = false }, MachineGunnerCustomCodeClass))
end

function MachineGunnerCustomCodeClass:Initialize(tower, _)
	self.Tower = tower
	self.Character = tower.Character
end

function MachineGunnerCustomCodeClass.Run_FromCharacter(_, _: number) end

function MachineGunnerCustomCodeClass.AbilityUsed(_, _) end

function MachineGunnerCustomCodeClass:AbilityAnimationKeyframeReached(p: string, p2: string)
	if p == Enums.TowerAbilities.MachineGunnerRedeploy then
		if p2 == "PickUp" then
			self.HoldingGun = true
		elseif p2 == "SetDown" then
			self.HoldingGun = false
		end
	end
end

function MachineGunnerCustomCodeClass.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function MachineGunnerCustomCodeClass.Upgraded(_, _) end

function MachineGunnerCustomCodeClass.CharacterCleanedUp(_) end

function MachineGunnerCustomCodeClass.AnimationStateChanged(_, _: string, _) end

function MachineGunnerCustomCodeClass.Attacked(_, _, _: boolean?) end

function MachineGunnerCustomCodeClass.Death(p)
	if p.HoldingGun then
		p.Tower:SetAnimationState("HoldingDeath", true)
	else
		p.Tower:SetAnimationState("TurretDeath", true)
	end
end

return MachineGunnerCustomCodeClass