local BuffHandlerClass = {}
BuffHandlerClass.__index = BuffHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local TowerBuffUtilities = require(common:WaitForChild("TowerBuffUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local VisualEffectHandler = require(script.Parent.Parent:WaitForChild("VisualEffectHandler"))

function BuffHandlerClass.New(character, p: number?)
	return (setmetatable({
		ActiveBuffs = {},
		BuffsChanged = false,
		Character = character,
		EffectsScale = character:GetCharacterModel():GetAttribute("BuffEffectsScale") or p,
		CustomBuffs = {}
	}, BuffHandlerClass))
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
			PlayUntilManuallyStopped = true,
			Scale = self.EffectsScale
		}
		visualEffect = VisualEffectHandler.NewVisualEffect(v)
	end

	local v = {
		Name = name,
		Hash = hash,
		Type = towerBuffConfig.Type,
		Amount = towerBuffConfig.Percentage,
		IsDebuff = towerBuffConfig.IsDebuff,
		Config = towerBuffConfig,
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

function BuffHandlerClass:ApplyCustomBuffData(p)
	local buffType = p.BuffType
	local percentage = p.Percentage
	local customBuff = self.CustomBuffs[buffType]

	if not customBuff then
		customBuff = {}
		self.CustomBuffs[buffType] = customBuff
	end

	local v = customBuff[percentage]

	if v then
		v.Active = true
	else
		customBuff[percentage] = { TimeLeft = 0, Active = true }
	end

	self.BuffsChanged = true
end

function BuffHandlerClass:RemoveCustomBuffData(p)
	local buffType = p.BuffType
	local percentage = p.Percentage
	local customBuff = self.CustomBuffs[buffType]

	if not customBuff then
		return
	end

	local v = customBuff[percentage]

	if not v then
		return
	end

	v.Active = false
	self.BuffsChanged = true
end

function BuffHandlerClass.GetStatMultipliers(p)
	return TowerBuffUtilities.GetStatMultipliers(p.ActiveBuffs, p.CustomBuffs)
end

function BuffHandlerClass.RemoveAllBuffs(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.VisualEffect then
			activeBuff.VisualEffect:StopEarly(true)
		end
	end
end

function BuffHandlerClass:CharacterModelChanged()
	local character = self.Character
	self.EffectsScale = character:GetCharacterModel():GetAttribute("BuffEffectsScale") or self.EffectsScale

	for _, activeBuff in pairs(self.ActiveBuffs) do
		if not activeBuff.VisualEffect then
			continue
		end

		local config = activeBuff.Config
		local effectFollowPart = EntityUtilities.GetEffectFollowPart(
			character,
			config.EffectPositionOnHead,
			config.EffectPositionAtFeet
		)
		activeBuff.VisualEffect:SetFollowPart(effectFollowPart)
	end
end

function BuffHandlerClass.IsOnFire(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.TowerBuffTypes.Burn or activeBuff.Config.IsFireEffect then
			return true
		end
	end

	return false
end

function BuffHandlerClass.IsFrozen(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.TowerBuffTypes.Freeze then
			return true
		end
	end

	return false
end

function BuffHandlerClass.IsStunned(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.TowerBuffTypes.Stun then
			return true
		end
	end

	return false
end

function BuffHandlerClass.IsUbered(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.TowerBuffTypes.Uber then
			return true
		end
	end

	return false
end

function BuffHandlerClass:_GetHighestCustomBuffForType(p: string)
	local v = 0
	local customBuff = self.CustomBuffs[p]

	if customBuff then
		for k, v2 in pairs(customBuff) do
			if v2.Active and v < k then
				v = k
			end
		end
	end

	return v
end

function BuffHandlerClass:GetDiscount()
	return self:_GetHighestCustomBuffForType(Enums.TowerBuffTypes.Discount)
end

function BuffHandlerClass:GetSellback()
	return self:_GetHighestCustomBuffForType(Enums.TowerBuffTypes.Sellback)
end

return BuffHandlerClass