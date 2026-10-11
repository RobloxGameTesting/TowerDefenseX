local AbilityHandlerClass = {}
AbilityHandlerClass.__index = AbilityHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local AbilityClass = require(script:WaitForChild("AbilityClass"))

local function GetAbilityConfigs(items)
	local result = {}

	for _, item in pairs(items) do
		result[item] = ResourceManager.GetPathEntityAbilityConfig(item)
	end

	return result
end

function AbilityHandlerClass.New(p)
	local v = {
		PathEntity = nil,
		AbilityConfigs = p and GetAbilityConfigs(p),
		Abilities = {},
		CurrentAbility = nil,
		CustomCode = nil
	}
	setmetatable(v, AbilityHandlerClass)
	v:_GenerateAbilities()
	return v
end

function AbilityHandlerClass:SetPathEntity(pathEntity)
	self.PathEntity = pathEntity

	for _, ability in pairs(self.Abilities) do
		ability:SetPathEntity(pathEntity)
	end
end

function AbilityHandlerClass.AbilityUsed(p, list)
	local v = list[1]
	local ability = p.Abilities[v]

	if ability then
		ability:AbilityUsedOnServer(list)
	else
		warn("Ability with name " .. tostring(v) .. " not found")
	end
end

function AbilityHandlerClass:Run(p: number)
	for _, ability in pairs(self.Abilities) do
		ability:Run(p)
	end
end

function AbilityHandlerClass:Destroy()
	for _, ability in pairs(self.Abilities) do
		ability:Destroy()
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

function AbilityHandlerClass:_GenerateAbilities()
	local abilities = {}

	if self.AbilityConfigs then
		for k, abilityConfig in pairs(self.AbilityConfigs) do
			abilities[k] = AbilityClass.New(self, k, abilityConfig)
		end
	end

	self.Abilities = abilities
end

return AbilityHandlerClass