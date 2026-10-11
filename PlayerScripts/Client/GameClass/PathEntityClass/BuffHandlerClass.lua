local BuffHandlerClass = {}
BuffHandlerClass.__index = BuffHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local TowerBuffUtilities = require(common:WaitForChild("TowerBuffUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local VisualEffectHandler = require(script.Parent.Parent:WaitForChild("VisualEffectHandler"))

function BuffHandlerClass.New(character)
	return (setmetatable({ ActiveBuffs = {}, BuffsChanged = false, Character = character }, BuffHandlerClass))
end

function BuffHandlerClass:ApplyBuffData(p, flag: boolean)
	local hash = p.Hash
	local name = p.Name
	local towerBuffConfig = ResourceManager.GetTowerBuffConfig(name)

	if not towerBuffConfig then
		warn("Missing buff config")
		return
	end

	local customVisualEffectName = towerBuffConfig.CustomVisualEffectName
		or Enums.VisualEffects[towerBuffConfig.Type .. "Debuff"]
	local visualEffect

	if customVisualEffectName and not towerBuffConfig.NoVisualEffect then
		local v = {
			Name = customVisualEffectName,
			FollowPart = EntityUtilities.GetEffectFollowPart(
				self.Character,
				towerBuffConfig.EffectPositionOnHead,
				towerBuffConfig.EffectPositionAtFeet
			),
			IsContinuous = true,
			PlayUntilManuallyStopped = true
		}
		visualEffect = VisualEffectHandler.NewVisualEffect(v)
	end

	local v = {
		Hash = hash,
		Type = towerBuffConfig.Type,
		Amount = towerBuffConfig.Percentage,
		IsDebuff = towerBuffConfig.IsDebuff,
		VisualEffect = visualEffect
	}
	self.ActiveBuffs[hash] = v
	self.BuffsChanged = true

	if not flag and visualEffect then
		visualEffect:StopEarly(true)
	end
end

function BuffHandlerClass:RemoveBuffData(p)
	local hash = p.Hash
	local activeBuff = self.ActiveBuffs[hash]

	if not activeBuff then
		warn("Did not find buff to remove")
		return
	end

	if activeBuff.VisualEffect then
		activeBuff.VisualEffect:StopEarly()
	end

	self.ActiveBuffs[hash] = nil
	self.BuffsChanged = true
end

function BuffHandlerClass.GetStatMultipliers(p)
	return TowerBuffUtilities.GetStatMultipliers(p.ActiveBuffs)
end

function BuffHandlerClass.RemoveAllBuffs(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.VisualEffect then
			activeBuff.VisualEffect:StopEarly(true)
		end
	end
end

function BuffHandlerClass.IsOnFire(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.TowerBuffTypes.Burn then
			return true
		end
	end

	return false
end

return BuffHandlerClass