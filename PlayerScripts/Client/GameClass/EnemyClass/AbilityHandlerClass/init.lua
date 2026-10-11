local AbilityHandlerClass = {}
AbilityHandlerClass.__index = AbilityHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local AbilityClass = require(script:WaitForChild("AbilityClass"))

local function GetAbilityConfigs(items, p: string)
	local result = {}

	for _, name in pairs(items) do
		if typeof(name) ~= "string" then
			local enableDifficulties = name.EnableDifficulties
			local disableDifficulties = name.DisableDifficulties

			if
				enableDifficulties and not table.find(enableDifficulties, p)
				or disableDifficulties and table.find(disableDifficulties, p)
			then
				continue
			else
				name = name.Name
			end
		end

		result[name] = ResourceManager.GetEnemyAbilityConfig(name)
	end

	return result
end

function AbilityHandlerClass.New(p, p2, p3: string)
	local v = {
		Enemy = nil,
		AbilityConfigs = p and GetAbilityConfigs(p, p3),
		DeathAbilityConfigs = p2 and GetAbilityConfigs(p2, p3),
		Abilities = {},
		DeathAbilities = {},
		CurrentAbility = nil,
		CustomCode = nil
	}
	setmetatable(v, AbilityHandlerClass)
	v:_GenerateAbilities()
	return v
end

function AbilityHandlerClass:SetEnemy(enemy)
	self.Enemy = enemy

	for _, ability in pairs(self.Abilities) do
		ability:SetEnemy(enemy)
	end

	for _, deathAbility in pairs(self.DeathAbilities) do
		deathAbility:SetEnemy(enemy)
	end
end

function AbilityHandlerClass.AbilityUsed(p, list)
	local v = list[1]
	local v2 = p.Abilities[v] or p.DeathAbilities[v]

	if v2 then
		v2:AbilityUsedOnServer(list)
	else
		warn("Ability with name " .. tostring(v) .. " not found")
	end
end

function AbilityHandlerClass.AbilityInterrupted(p, list)
	local v = list[1]
	local v2 = p.Abilities[v] or p.DeathAbilities[v]

	if v2 then
		v2:AbilityInterruptedOnServer(list)
	else
		warn("Ability with name " .. tostring(v) .. " not found")
	end
end

function AbilityHandlerClass:Run(p: number)
	for _, ability in pairs(self.Abilities) do
		ability:Run(p)
	end

	for _, deathAbility in pairs(self.DeathAbilities) do
		deathAbility:Run(p)
	end
end

function AbilityHandlerClass.HasActiveContinuousAnimation(p)
	for _, ability in pairs(p.Abilities) do
		if ability.ForcePlayAnimationOnClientside and ability.ExecutionTimeRemaining > 0 then
			return true
		end
	end

	return false
end

function AbilityHandlerClass:Destroy()
	for _, ability in pairs(self.Abilities) do
		ability:Destroy()
	end

	for _, deathAbility in pairs(self.DeathAbilities) do
		deathAbility:Destroy()
	end
end

function AbilityHandlerClass:SetSpeedMultiplier(p: number)
	for _, ability in pairs(self.Abilities) do
		ability:SetSpeedMultiplier(p)
	end

	for _, deathAbility in pairs(self.DeathAbilities) do
		deathAbility:SetSpeedMultiplier(p)
	end
end

function AbilityHandlerClass:SetCustomCode(customCode)
	self.CustomCode = customCode

	for _, ability in pairs(self.Abilities) do
		ability:SetCustomCode(customCode)
	end

	for _, deathAbility in pairs(self.DeathAbilities) do
		deathAbility:SetCustomCode(customCode)
	end
end

function AbilityHandlerClass:_GenerateAbilities()
	local abilities = {}
	local deathAbilities = {}

	if self.AbilityConfigs then
		for k, abilityConfig in pairs(self.AbilityConfigs) do
			abilities[k] = AbilityClass.New(self, k, abilityConfig)
		end
	end

	if self.DeathAbilityConfigs then
		for k, deathAbilityConfig in pairs(self.DeathAbilityConfigs) do
			deathAbilities[k] = AbilityClass.New(self, k, deathAbilityConfig)
		end
	end

	self.Abilities = abilities
	self.DeathAbilities = deathAbilities
end

return AbilityHandlerClass