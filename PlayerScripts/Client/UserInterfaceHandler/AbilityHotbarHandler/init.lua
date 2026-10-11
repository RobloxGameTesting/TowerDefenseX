local AbilityHotbarHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local towerClass = script.Parent.Parent:WaitForChild("GameClass"):WaitForChild("TowerClass")
local AbilityHotbarRowClass = require(script:WaitForChild("AbilityHotbarRowClass"))
local LocalPlayer = Players.LocalPlayer
local v = {}
local v2 = {}
local v3 = {}

local function GetDistanceToAbilityParent(ability) -- 1 equivalent call inferred from this helper
	local character = LocalPlayer.Character

	if character and character.PrimaryPart then
		local position = ability.Tower:GetPosition()
		return (character.PrimaryPart.CFrame.Position - position).Magnitude
	else
		return 0
	end
end

local function RefreshAbilityHotbarData()
	local module = require(towerClass)
	local v4 = {}

	for _, closestTower in pairs(module.GetTowers()) do
		if not (closestTower.OwnedByLocalPlayer and closestTower:Alive()) then
			continue
		end

		local v5 = v[closestTower.Type] or 0
		local v6 = v4[v5]

		if not v6 then
			v6 = {}
			v4[v5] = v6
		end

		for _, ability in pairs(closestTower.AbilityHandler.Abilities) do
			if not ability:CanManuallyUse() then
				continue
			end

			local config = ability.Config
			local hotbarData = config.HotbarData
			local groupName = hotbarData and hotbarData.GroupName or config.Name
			local v7 = not hotbarData and 1 or hotbarData.Level or 1
			local v8 = v6[groupName]

			if not v8 then
				v8 = { LevelToAbilityDataMap = {}, Count = 0 }
				v6[groupName] = v8
			end

			local v9 = v8.LevelToAbilityDataMap[v7]

			if not v9 then
				v9 = {
					AvailableCount = 0,
					CooldownRemaining = 0,
					Config = config,
					ClosestDistance = 1e999,
					ClosestTower = nil,
					ClosestAbility = nil
				}
				v8.LevelToAbilityDataMap[v7] = v9
				v8.DisplayLevel = v8.DisplayLevel or hotbarData and hotbarData.Level ~= nil
				v8.Count += 1
			end

			if ability:CanUse() then
				v9.AvailableCount += 1
				local closestDistance = GetDistanceToAbilityParent(ability) -- inferred equivalent call

				if closestDistance < v9.ClosestDistance then
					v9.ClosestDistance = closestDistance
					v9.ClosestTower = closestTower
					v9.ClosestAbility = ability
				end
			else
				v9.CooldownRemaining = ability:GetCooldownRemaining()
				v9.IsStunned = ability:GetStunned()
				v9.IsDisabled = ability:GetDisabled()
				v9.IsConverted = ability:GetConverted()
				v9.IsRebuilding = ability:GetTowerRebuilding()
			end
		end
	end

	v2 = v4
end

function AbilityHotbarHandler.Initialize(items)
	v = {}

	for k, item in pairs(items) do
		v[item] = k
	end

	for _, v4 in pairs(v3) do
		v4:Destroy()
	end

	v3 = {}

	for k, item in pairs(items) do
		if item == "" then
			break
		else
			v3[k] = AbilityHotbarRowClass.New(k, item)
		end
	end
end

function AbilityHotbarHandler:Update()
	RefreshAbilityHotbarData()

	for k, v4 in pairs(v3) do
		local v5 = v2[k]

		if v5 then
			v4:Update(v5)
		else
			v4:Hide()
		end
	end
end

return AbilityHotbarHandler