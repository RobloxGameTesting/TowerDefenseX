local BuffHandlerClass = {}
BuffHandlerClass.__index = BuffHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local EnemyBuffUtilities = require(common:WaitForChild("EnemyBuffUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local VisualEffectHandler = require(script.Parent.Parent:WaitForChild("VisualEffectHandler"))
local v = {
	[Enums.EnemyBuffs.CombatDroneSpotterSpeedDebuffL1] = true,
	[Enums.EnemyBuffs.CombatDroneSpotterSpeedDebuffL2] = true
}

function BuffHandlerClass.New(character, isAirUnit: boolean, flag: boolean)
	return (setmetatable({
		ActiveBuffs = {},
		BuffsChanged = false,
		IsAirUnit = isAirUnit,
		IsBoss = flag,
		Character = character,
		OverrideMovementAnimationName = nil
	}, BuffHandlerClass))
end

function BuffHandlerClass:ApplyBuffData(p, flag: boolean)
	local hash = p.Hash
	local name = p.Name
	local enemyBuffConfig = ResourceManager.GetEnemyBuffConfig(name)

	if not enemyBuffConfig then
		warn("Missing buff config")
		return
	end

	local customVisualEffectName = enemyBuffConfig.CustomVisualEffectName
		or Enums.VisualEffects[enemyBuffConfig.Type .. "Debuff"]
	local visualEffect

	if customVisualEffectName and not enemyBuffConfig.NoVisualEffect then
		local effectFollowPart = EntityUtilities.GetEffectFollowPart(
			self.Character,
			enemyBuffConfig.EffectPositionOnHead,
			enemyBuffConfig.EffectPositionAtFeet
		)
		local scale

		if enemyBuffConfig.DynamicallyScaleVFX then
			scale = EnemyBuffUtilities.GetVFXScaleForModel(self.Character:GetCharacterModel())
		end

		visualEffect = VisualEffectHandler.NewVisualEffect({
			Name = customVisualEffectName,
			FollowPart = effectFollowPart,
			IsContinuous = true,
			PlayUntilManuallyStopped = true,
			Scale = scale
		})
	end

	local v2 = {
		Hash = hash,
		Name = name,
		Type = enemyBuffConfig.Type,
		Amount = self.IsBoss and enemyBuffConfig.BossPercentage or enemyBuffConfig.Percentage,
		IsDebuff = enemyBuffConfig.IsDebuff,
		VisualEffect = visualEffect,
		PlayBurnEffects = enemyBuffConfig.PlayBurnEffects,
		OverrideMovementAnimationName = enemyBuffConfig.OverrideMovementAnimationName,
		NoReactivateVisualEffect = enemyBuffConfig.NoReactivateVisualEffect
	}
	self.ActiveBuffs[hash] = v2
	self.BuffsChanged = true
	self:_RecalculateOverrideMovementAnimationName()

	if not flag and visualEffect then
		visualEffect:StopEarly(true)
	end
end

function BuffHandlerClass:RemoveBuffData(p)
	local hash = p.Hash
	local activeBuff = self.ActiveBuffs[hash]

	if not activeBuff then
		print("Did not find buff to remove")
		return
	end

	if activeBuff.VisualEffect then
		activeBuff.VisualEffect:StopEarly()
	end

	self.ActiveBuffs[hash] = nil
	self.BuffsChanged = true
	self:_RecalculateOverrideMovementAnimationName()
end

function BuffHandlerClass.RefreshBuffData(p, p2)
	local hash = p2.Hash
	local activeBuff = p.ActiveBuffs[hash]

	if not activeBuff then
		print("Did not find buff to refresh")
	elseif activeBuff.VisualEffect and not activeBuff.NoReactivateVisualEffect then
		activeBuff.VisualEffect:Reactivate()
	end
end

function BuffHandlerClass.GetStatMultipliers(p)
	return EnemyBuffUtilities.GetStatMultipliers(p.ActiveBuffs)
end

function BuffHandlerClass.RemoveAllBuffs(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.VisualEffect then
			activeBuff.VisualEffect:StopEarly(true)
		end
	end
end

function BuffHandlerClass:SetAirUnit(isAirUnit: boolean)
	self.IsAirUnit = isAirUnit
end

function BuffHandlerClass.GetOverrideMovementAnimationName(p)
	return p.OverrideMovementAnimationName
end

function BuffHandlerClass:_RecalculateOverrideMovementAnimationName()
	for _, activeBuff in pairs(self.ActiveBuffs) do
		if not activeBuff.OverrideMovementAnimationName then
			continue
		end

		self.OverrideMovementAnimationName = activeBuff.OverrideMovementAnimationName
		return
	end

	self.OverrideMovementAnimationName = nil
end

function BuffHandlerClass.IsOnFire(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.PlayBurnEffects then
			return true
		end
	end

	return false
end

function BuffHandlerClass.IsFrozen(_) end

function BuffHandlerClass.IsStunned(_) end

function BuffHandlerClass.IsSpotted(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if v[activeBuff.Name] then
			return true
		end
	end

	return false
end

function BuffHandlerClass.IsUbered(p)
	for _, activeBuff in pairs(p.ActiveBuffs) do
		if activeBuff.Type == Enums.EnemyBuffTypes.Uber then
			return true
		end
	end

	return false
end

return BuffHandlerClass