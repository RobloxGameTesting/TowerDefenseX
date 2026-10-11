local AbilityHandlerClass = {}
AbilityHandlerClass.__index = AbilityHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("TowerUpgradeShopUtilities"))
local AbilityClass = require(script:WaitForChild("AbilityClass"))

local function MapAbilityConfigs(abilityConfigs, items)
	local result = {}

	if items then
		for _, item in pairs(items) do
			local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(item)

			if towerAbilityConfig then
				result[towerAbilityConfig.Name] = towerAbilityConfig
			end
		end
	end

	for _, item in pairs(abilityConfigs) do
		result[item.Name] = item
	end

	return result
end

local function GetIndexToNameMap(abilityConfigs, items)
	local names = {}

	if items then
		for _, item in pairs(items) do
			local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(item)

			if towerAbilityConfig then
				table.insert(names, towerAbilityConfig.Name)
			end
		end
	end

	for _, v in ipairs(abilityConfigs) do
		table.insert(names, v.Name)
	end

	return names
end

function AbilityHandlerClass.New(towerHash: number, data, manualAiming: boolean?, upgradeTypeToActiveUpgradeShopData, p: string?)
	local manualAimRetargetAbilityName = p or Enums.TowerAbilities.ManualAimRetarget
	local defaultAbilityNames = {}

	if manualAiming and not data.DisableManualAiming then
		table.insert(defaultAbilityNames, manualAimRetargetAbilityName)
	end

	if data.HasDirectControl then
		table.insert(defaultAbilityNames, Enums.TowerAbilities.DirectControl)
	end

	local v = {
		TowerHash = towerHash,
		ManualAiming = manualAiming,
		ManualAimRetargetAbilityName = manualAimRetargetAbilityName,
		AbilityConfigs = MapAbilityConfigs(data.AbilityConfigs, defaultAbilityNames),
		AbilityIndexToNameMap = GetIndexToNameMap(data.AbilityConfigs, defaultAbilityNames),
		DefaultAbilityNames = defaultAbilityNames,
		Abilities = {},
		Stunned = false,
		Disabled = false,
		ManualAimRetargetDisabled = false,
		Converted = false,
		CustomCode = nil,
		Tower = nil,
		UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData
	}
	setmetatable(v, AbilityHandlerClass)
	v:_GenerateAbilities()
	v:UpgradeShopDataChanged(upgradeTypeToActiveUpgradeShopData)
	return v
end

function AbilityHandlerClass.GetAbilityFromIndex(p, p2: number)
	return p.Abilities[p.AbilityIndexToNameMap[p2]]
end

function AbilityHandlerClass.GetAbilityConfigs(p)
	return p.AbilityConfigs
end

function AbilityHandlerClass:SetTower(tower)
	self.Tower = tower

	for _, ability in pairs(self.Abilities) do
		ability:SetTower(tower)
	end
end

function AbilityHandlerClass:AbilityUsedOnServer(list)
	local v = list[1]
	local ability = self.Abilities[v]

	if ability then
		ability:AbilityUsedOnServer(list)
		return ability
	end

	warn("Ability with name " .. tostring(v) .. " not found")
	return ability
end

function AbilityHandlerClass:AbilityCancelledOnServer(list)
	local v = list[1]
	local ability = self.Abilities[v]

	if ability then
		ability:AbilityCancelledOnServer(list)
	else
		warn("Ability with name " .. tostring(v) .. " not found")
	end
end

function AbilityHandlerClass.SetAnimationStateChanged(p, p2: string)
	for _, ability in pairs(p.Abilities) do
		if ability.SessionStartAnimationName and p2 == ability.SessionStartAnimationName then
			ability:SetSessionStarted()
		elseif ability.SessionEndAnimationName and p2 == ability.SessionEndAnimationName then
			ability:SetSessionEnded()
		end
	end
end

function AbilityHandlerClass:LevelStatsChanged(data)
	local defaultAbilityNames = {}

	if self.ManualAiming and not data.DisableManualAiming then
		table.insert(defaultAbilityNames, self.ManualAimRetargetAbilityName)
	end

	if data.HasDirectControl then
		table.insert(defaultAbilityNames, Enums.TowerAbilities.DirectControl)
	end

	self.DefaultAbilityNames = defaultAbilityNames
	self.AbilityConfigs = MapAbilityConfigs(data.AbilityConfigs, self.DefaultAbilityNames)
	self.AbilityIndexToNameMap = GetIndexToNameMap(data.AbilityConfigs, self.DefaultAbilityNames)
	self:_GenerateAbilities()
end

function AbilityHandlerClass:UpgradeShopDataChanged(upgradeTypeToActiveUpgradeShopData)
	self.UpgradeTypeToActiveUpgradeShopData = upgradeTypeToActiveUpgradeShopData

	for _, ability in pairs(self.Abilities) do
		ability:UpgradeShopDataChanged(upgradeTypeToActiveUpgradeShopData)
	end
end

function AbilityHandlerClass.GetAbility(p, p2: string)
	return p.Abilities[p2]
end

function AbilityHandlerClass.UseAbility(p, p2: number)
	local ability = p.Abilities[p.AbilityIndexToNameMap[p2]]

	if ability then
		ability:Use()
	else
		warn("No ability at index " .. tostring(p2))
	end
end

function AbilityHandlerClass:SetStunned(stunned: boolean)
	for _, ability in pairs(self.Abilities) do
		ability:SetStunned(stunned)
	end

	self.Stunned = stunned
end

function AbilityHandlerClass:SetDisabled(disabled: boolean)
	for _, ability in pairs(self.Abilities) do
		ability:SetDisabled(disabled)
	end

	self.Disabled = disabled
end

function AbilityHandlerClass:SetManualAimRetargetDisabled(manualAimRetargetDisabled: boolean)
	self.ManualAimRetargetDisabled = manualAimRetargetDisabled
	local ability = self.Abilities[self.ManualAimRetargetAbilityName]

	if ability then
		ability:SetModeDisabled(manualAimRetargetDisabled)
	end
end

function AbilityHandlerClass:SetConverted(converted: boolean)
	for _, ability in pairs(self.Abilities) do
		ability:SetConverted(converted)
	end

	self.Converted = converted
end

function AbilityHandlerClass:Run(p: number)
	for _, ability in pairs(self.Abilities) do
		ability:Run(p)
	end
end

function AbilityHandlerClass:SetSpeedMultiplier(p: number)
	for _, ability in pairs(self.Abilities) do
		ability:SetSpeedMultiplier(p)
	end
end

function AbilityHandlerClass:SetCustomCode(customCode)
	self.CustomCode = customCode

	for _, ability in pairs(self.Abilities) do
		ability:SetCustomCode(customCode)
	end
end

function AbilityHandlerClass:StopEffects()
	for _, ability in pairs(self.Abilities) do
		ability:StopEffects()
	end
end

function AbilityHandlerClass:_GenerateAbilities()
	local abilities = {}

	for _, ability in pairs(self.Abilities) do
		ability:Destroy()
	end

	for i, v in ipairs(self.AbilityIndexToNameMap) do
		local abilityConfig = self.AbilityConfigs[v]
		local ability = self.Abilities[self.AbilityIndexToNameMap[i]]
		local v2

		if ability and ability:GetName() == abilityConfig.Name then
			v2 = ability:GetCooldownRemaining()
		end

		abilities[v] = AbilityClass.New(i, self.TowerHash, abilityConfig, v2, self.UpgradeTypeToActiveUpgradeShopData)
	end

	for _, v in pairs(abilities) do
		v:SetStunned(self.Stunned)
		v:SetDisabled(self.Disabled)
		v:SetConverted(self.Converted)
		v.Tower = self.Tower
	end

	local v = abilities[self.ManualAimRetargetAbilityName]

	if v then
		v:SetModeDisabled(self.ManualAimRetargetDisabled)
	end

	self.Abilities = abilities
end

function AbilityHandlerClass.CanUpgrade(p)
	for _, ability in pairs(p.Abilities) do
		if ability:BeingUsed() and ability.BlockUpgradesWhileActive then
			return false
		end
	end

	return true
end

return AbilityHandlerClass