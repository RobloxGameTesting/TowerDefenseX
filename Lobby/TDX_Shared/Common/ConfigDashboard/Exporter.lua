local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Schema = require(common:WaitForChild("ConfigDashboard"):WaitForChild("Schema"))
local Enums = require(common:WaitForChild("Enums"))
local PVPEconomyConfig = require(common:WaitForChild("PVPEconomyConfig"))
local resources = common:WaitForChild("Resources")
local enemies = resources:WaitForChild("Enemies")
local configs = enemies:WaitForChild("Configs")
local abilities = enemies:WaitForChild("Abilities")
local towerBuffs = resources:WaitForChild("TowerBuffs")
local enemyBuffs = resources:WaitForChild("EnemyBuffs")
local towers = resources:WaitForChild("Towers")
local configs2 = towers:WaitForChild("Configs")
local abilities2 = towers:WaitForChild("Abilities")
local configs3 = resources:WaitForChild("PathEntities"):WaitForChild("Configs")
local configs4 = resources:WaitForChild("StaticEntities"):WaitForChild("Configs")
local configs5 = resources:WaitForChild("MapEntities"):WaitForChild("Configs")
local Exporter = {}

local function DamageTypeList()
	local damageTypes = {}

	for _, damageType in pairs(Enums.DamageTypes) do
		if typeof(damageType) == "string" then
			table.insert(damageTypes, damageType)
		end
	end

	table.sort(damageTypes)
	return damageTypes
end

local function DifficultyList()
	local difficulties = {}

	for _, difficulty in pairs(Enums.Difficulties) do
		if typeof(difficulty) == "string" then
			table.insert(difficulties, difficulty)
		end
	end

	table.sort(difficulties)
	return difficulties
end

local function ResistanceSection()
	local result = {}

	for _, name in ipairs((DamageTypeList())) do
		table.insert(result, {
			Name = name,
			Type = Schema.DamageReductionValue.Type,
			Min = Schema.DamageReductionValue.Min,
			Max = Schema.DamageReductionValue.Max,
			Optional = Schema.DamageReductionValue.Optional
		})
	end

	return result
end

local function BuildGroupMap(instance)
	local result = {}

	for _, folder in pairs(instance:GetChildren()) do
		if folder:IsA("Folder") then
			for _, child in pairs(folder:GetChildren()) do
				result[child.Name] = folder.Name
			end
		else
			result[folder.Name] = ""
		end
	end

	return result
end

local function ParseAttackNames(result: string)
	local result2 = {}
	local match = result:match("AttackData%s*=%s*{(.-)}")

	if not match then
		return result2
	end

	local count = 0

	for k in (match .. ","):gmatch("(.-),") do
		local v = k:gsub("%-%-[^\n]*", ""):gsub("%s", "")

		if v == "" then
			continue
		end

		count += 1

		if v:match("^[%a_][%w_]*$") then
			result2[tostring(count)] = v
		end
	end

	return result2
end

local function BuildAttackLabels(configs6, list, callback)
	local result = {}

	local function Process(moduleScript)
		if not moduleScript:IsA("ModuleScript") then
			return
		end

		local success, result2 = pcall(function()
			return moduleScript.Source
		end)

		if success and typeof(result2) == "string" and result2 ~= "" then
			local parseAttackNames = ParseAttackNames(result2)

			if next(parseAttackNames) then
				result[moduleScript.Name] = parseAttackNames
			end
		end
	end

	for _, folder in pairs(configs6:GetChildren()) do
		if folder:IsA("Folder") then
			for _, child in pairs(folder:GetChildren()) do
				Process(child)
			end
		else
			Process(folder)
		end
	end

	for _, v in ipairs(list) do
		local v2 = callback(v)

		if not (typeof(v2) == "table" and typeof(v2.AttackData) == "table") then
			continue
		end

		for i, v3 in ipairs(v2.AttackData) do
			if not (typeof(v3) == "table" and typeof(v3.Description) == "string" and v3.Description ~= "") then
				continue
			end

			result[v] = result[v] or {}
			result[v][tostring(i)] = v3.Description
		end
	end

	return result
end

local function SanitizeValue(value) -- 3 equivalent calls inferred from this helper
	if typeof(value) ~= "number" then
		return value
	end

	if value == 1e999 then
		return "Infinity"
	elseif value == -1e999 then
		return "-Infinity"
	end

	if value ~= value then
		return nil
	end

	return value
end

local function ExtractFields(p, items)
	local result = {}

	for k, item in pairs(items) do
		local joined = p[k]

		if joined == nil then
			continue
		end

		if item.ReadOnly and item.Type == "string" and typeof(joined) == "table" then
			joined = table.concat(joined, ", ")
		end

		joined = SanitizeValue(joined) -- inferred equivalent call
		result[k] = joined
	end

	return result
end

local function ExtractAttackList(p)
	if typeof(p) ~= "table" or typeof(p.AttackData) ~= "table" then
		return nil
	end

	local result = {}

	for i, v in ipairs(p.AttackData) do
		result[tostring(i)] = ExtractFields(v, Schema.AttackData)
	end

	return result
end

local function ExtractSpawnEntries(list)
	if typeof(list) ~= "table" then
		return nil
	end

	local result = {}

	for i, v in ipairs(list) do
		result[tostring(i)] = ExtractFields(v, Schema.SpawnPathEntity)
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractRemoveSpawnNames(removeSpawnPathEntityNames)
	if typeof(removeSpawnPathEntityNames) ~= "table" then
		return nil
	end

	local result = {}

	for i, v in ipairs(removeSpawnPathEntityNames) do
		if typeof(v) == "string" then
			result[tostring(i)] = v
		end
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractResistances(enemyConfig)
	local result = {}

	if typeof(enemyConfig.DamageReductionTable) ~= "table" then
		return result
	end

	for _, v in ipairs(enemyConfig.DamageReductionTable) do
		if not (typeof(v) == "table" and typeof(v.DamageType) == "string" and typeof(v.DamageReduction) == "number") then
			continue
		end

		local damageType = v.DamageType
		result[damageType] = SanitizeValue(v.DamageReduction) -- inferred equivalent call
	end

	return result
end

local function ExtractAdditionalStatsMap(enemyConfig)
	if typeof(enemyConfig.PlayerCountToAdditionalStatsMap) ~= "table" then
		return nil
	end

	local result = {}

	for k, v in pairs(enemyConfig.PlayerCountToAdditionalStatsMap) do
		if typeof(v) == "table" then
			result[tostring(k)] = ExtractFields(v, Schema.EnemyAdditionalStats)
		end
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractPrimaryAbilityNames(enemyConfig)
	local names = {}
	local v = {}

	if typeof(enemyConfig.AbilityNames) ~= "table" then
		return names
	end

	for _, name in ipairs(enemyConfig.AbilityNames) do
		if typeof(name) ~= "string" then
			if typeof(name) == "table" and typeof(name.Name) == "string" then
				name = name.Name
			else
				name = nil
			end
		end

		if not name or v[name] then
			continue
		end

		v[name] = true
		table.insert(names, name)
	end

	return names
end

local function ExtractAbilityStatOverridesMap(enemyConfig)
	if typeof(enemyConfig.DifficultyToAbilityStatOverridesMap) ~= "table" then
		return nil
	end

	local result = {}

	for k, v in pairs(enemyConfig.DifficultyToAbilityStatOverridesMap) do
		if typeof(v) ~= "table" then
			continue
		end

		local v2 = {}

		for k2, v3 in pairs(v) do
			if typeof(v3) == "table" then
				v2[k2] = ExtractFields(v3, Schema.EnemyAbilityStatOverrides)
			end
		end

		if next(v2) ~= nil then
			result[k] = v2
		end
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractDeathSpawnList(enemyConfig)
	if typeof(enemyConfig) ~= "table" or typeof(enemyConfig.DeathSpawnData) ~= "table" then
		return nil
	end

	local result = {}

	for i, v in ipairs(enemyConfig.DeathSpawnData) do
		if typeof(v) ~= "table" then
			continue
		end

		local extractFields = ExtractFields(v, Schema.EnemyDeathSpawn)

		if typeof(v.EnemyTypeChanceMap) == "table" then
			local enemyTypeChanceMap = {}

			for k, v2 in pairs(v.EnemyTypeChanceMap) do
				if not (typeof(k) == "string" and typeof(v2) == "number") then
					continue
				end

				v2 = SanitizeValue(v2) -- inferred equivalent call
				enemyTypeChanceMap[k] = v2
			end

			extractFields.EnemyTypeChanceMap = enemyTypeChanceMap
		end

		result[tostring(i)] = extractFields
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractEnemies()
	local result = {}
	local result2 = {}

	for _, v in ipairs(ResourceManager.GetEnemyConfigNames()) do
		local enemyConfig = ResourceManager.GetEnemyConfig(v)

		if not enemyConfig then
			continue
		end

		local extractFields = ExtractFields(enemyConfig, Schema.Enemy)

		if enemyConfig.IsPVP then
			result[v] = true

			for k, v2 in pairs((ExtractFields(enemyConfig, Schema.EnemyPVP))) do
				extractFields[k] = v2
			end
		end

		local attackData = ExtractAttackList(enemyConfig)

		if attackData then
			extractFields.AttackData = attackData
		end

		local deathSpawnData = ExtractDeathSpawnList(enemyConfig)

		if deathSpawnData then
			extractFields.DeathSpawnData = deathSpawnData
		end

		extractFields.DamageReductions = ExtractResistances(enemyConfig)
		local playerCountToAdditionalStatsMap = ExtractAdditionalStatsMap(enemyConfig)

		if playerCountToAdditionalStatsMap then
			extractFields.PlayerCountToAdditionalStatsMap = playerCountToAdditionalStatsMap
		end

		local extractAbilityStatOverridesMap = ExtractAbilityStatOverridesMap(enemyConfig)
		local difficultyToAbilityStatOverridesMap = extractAbilityStatOverridesMap == nil
			and #ExtractPrimaryAbilityNames(enemyConfig) > 0
			and {}
			or extractAbilityStatOverridesMap

		if difficultyToAbilityStatOverridesMap then
			extractFields.DifficultyToAbilityStatOverridesMap = difficultyToAbilityStatOverridesMap
		end

		result2[v] = extractFields
	end

	return result2, result
end

local function ExtractPathEntities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetPathEntityConfigNames()) do
		local pathEntityConfig = ResourceManager.GetPathEntityConfig(v)

		if not pathEntityConfig then
			continue
		end

		local extractFields = ExtractFields(pathEntityConfig, Schema.PathEntity)
		local attackData = ExtractAttackList(pathEntityConfig)

		if attackData then
			extractFields.AttackData = attackData
		end

		result[v] = extractFields
	end

	return result
end

local function ExtractStaticEntities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetStaticEntityConfigNames()) do
		local staticEntityConfig = ResourceManager.GetStaticEntityConfig(v)

		if not staticEntityConfig then
			continue
		end

		local extractFields = ExtractFields(staticEntityConfig, Schema.StaticEntity)

		if typeof(staticEntityConfig.HitData) == "table" then
			extractFields.HitData = ExtractFields(staticEntityConfig.HitData, Schema.AbilityProjectileHit)
		end

		if typeof(staticEntityConfig.MultiHealData) == "table" then
			extractFields.MultiHealData = ExtractFields(staticEntityConfig.MultiHealData, Schema.MultiHealData)
		end

		local attackData = ExtractAttackList(staticEntityConfig)

		if attackData then
			extractFields.AttackData = attackData
		end

		result[v] = extractFields
	end

	return result
end

local function ExtractMapEntityStatOverrideMap(mapEntityConfig)
	local result = {}

	if typeof(mapEntityConfig.DifficultyToStatOverrideMap) ~= "table" then
		return result
	end

	for k, v in pairs(mapEntityConfig.DifficultyToStatOverrideMap) do
		if not (typeof(k) == "string" and typeof(v) == "table") then
			continue
		end

		result[k] = ExtractFields(v, Schema.MapEntityStatOverrides)
	end

	return result
end

local function ExtractMapEntities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetMapEntityConfigNames()) do
		local mapEntityConfig = ResourceManager.GetMapEntityConfig(v)

		if not mapEntityConfig then
			continue
		end

		local extractFields = ExtractFields(mapEntityConfig, Schema.MapEntity)
		local attackData = ExtractAttackList(mapEntityConfig)

		if attackData then
			extractFields.AttackData = attackData
		end

		extractFields.DifficultyToStatOverrideMap = ExtractMapEntityStatOverrideMap(mapEntityConfig)
		result[v] = extractFields
	end

	return result
end

local function ExtractMapEntityLivesMaps()
	local result = {}

	for _, v in ipairs(ResourceManager.GetMapConfigNames()) do
		local mapConfig = ResourceManager.GetMapConfig(v)
		local mapEntitiesSpawnData = mapConfig and mapConfig.MapEntitiesSpawnData

		if typeof(mapEntitiesSpawnData) ~= "table" then
			continue
		end

		for _, v2 in pairs(mapEntitiesSpawnData) do
			local newMapEntityData = v2 and v2.NewMapEntityData

			if not (typeof(newMapEntityData) == "table" and newMapEntityData.UseForLives and typeof(newMapEntityData.Type) == "string") then
				continue
			end

			local v3 = result[newMapEntityData.Type]

			if not v3 then
				v3 = {}
				result[newMapEntityData.Type] = v3
			end

			if not table.find(v3, v) then
				table.insert(v3, v)
			end
		end
	end

	for _, list in pairs(result) do
		table.sort(list)
	end

	return result
end

local function ExtractWaveStartingLivesOverrides()
	local result = {}

	for _, v in ipairs(ResourceManager.GetWaveConfigNames()) do
		local waveConfig = ResourceManager.GetWaveConfig(v)
		local startingLivesOverriddenBy = waveConfig and waveConfig.StartingLivesOverriddenBy

		if typeof(startingLivesOverriddenBy) ~= "table" then
			continue
		end

		local v2 = {}

		for _, v3 in ipairs(startingLivesOverriddenBy) do
			if typeof(v3) == "string" and v3 ~= "" then
				table.insert(v2, v3)
			end
		end

		if #v2 > 0 then
			result[v] = v2
		end
	end

	return result
end

local function MergeSections(...)
	local result = {}

	for _, v in ipairs({ ... }) do
		for k, v2 in pairs(v) do
			result[k] = v2
		end
	end

	return result
end

local function OrderedSection(p, list)
	local result = {}

	for _, name in ipairs(list) do
		local v = p[name]

		if v then
			table.insert(result, {
				Name = name,
				Type = v.Type,
				Min = v.Min,
				Max = v.Max,
				Optional = v.Optional,
				ReadOnly = v.ReadOnly,
				Note = v.Note
			})
		end
	end

	return result
end

local function ExtractNode(p, p2)
	local result = not p2.Fields and {} or ExtractFields(p, p2.Fields) or {}

	for k, v in pairs(p2.Children or {}) do
		local field = v.Field
		local v2 = field and p[field]

		if typeof(v2) ~= "table" then
			continue
		end

		if v.List then
			local v3 = {}

			for i, v4 in ipairs(v2) do
				v3[tostring(i)] = ExtractNode(v4, v)
			end

			result[k] = v3
		else
			result[k] = ExtractNode(v2, v)
		end
	end

	return result
end

local function ExtractAbilities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetEnemyAbilityConfigNames()) do
		local enemyAbilityConfig = ResourceManager.GetEnemyAbilityConfig(v)

		if enemyAbilityConfig then
			result[v] = ExtractNode(enemyAbilityConfig, Schema.AbilityShape)
		end
	end

	return result
end

local function ExtractPathEntityAbilities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetPathEntityAbilityConfigNames()) do
		local pathEntityAbilityConfig = ResourceManager.GetPathEntityAbilityConfig(v)

		if pathEntityAbilityConfig then
			result[v] = ExtractNode(pathEntityAbilityConfig, Schema.PathEntityAbilityShape)
		end
	end

	return result
end

local function CollectFieldNames(p, items, p2) -- 2 equivalent calls inferred from this helper
	if typeof(p) ~= "table" then
		return
	end

	for k in pairs(items) do
		if p[k] ~= nil then
			p2[k] = true
		end
	end
end

local function SetToSortedList(items)
	local result = {}

	for k in pairs(items) do
		table.insert(result, k)
	end

	table.sort(result)
	return result
end

local function ExtractLimitMap(towerConfig)
	local result = {}

	if typeof(towerConfig.LimitMap) == "table" then
		for i, v in ipairs(towerConfig.LimitMap) do
			result[tostring(i)] = v
		end
	end

	return result
end

local function ExtractDifficultyLimitMapOverride(towerConfig)
	local result = {}

	if typeof(towerConfig.DifficultyToLimitMapOverride) ~= "table" then
		return result
	end

	for k, v in pairs(towerConfig.DifficultyToLimitMapOverride) do
		if not (typeof(k) == "string" and typeof(v) == "table") then
			continue
		end

		local v2 = {}

		for i, v3 in ipairs(v) do
			v2[tostring(i)] = v3
		end

		result[k] = v2
	end

	return result
end

local function ExtractTowers()
	local result = {}
	local result2 = {}

	for _, v in ipairs(ResourceManager.GetTowerConfigNames()) do
		local towerConfig = ResourceManager.GetTowerConfig(v)
		local upgradePathData = towerConfig and towerConfig.UpgradePathData

		if not (typeof(upgradePathData) == "table" and typeof(upgradePathData.BaseLevelData) == "table") then
			continue
		end

		local extractFields = ExtractFields(upgradePathData, Schema.TowerTop)

		for k, v2 in pairs((ExtractFields(towerConfig, Schema.TowerConfigTop))) do
			extractFields[k] = v2
		end

		extractFields.LimitMap = ExtractLimitMap(towerConfig)
		extractFields.DifficultyToLimitMapOverride = ExtractDifficultyLimitMapOverride(towerConfig)
		extractFields.Base = ExtractFields(upgradePathData.BaseLevelData, Schema.TowerBaseStats)
		local spawnPathEntityData = ExtractSpawnEntries(upgradePathData.BaseLevelData.SpawnPathEntityData)

		if spawnPathEntityData then
			extractFields.Base.SpawnPathEntityData = spawnPathEntityData
		end

		if typeof(upgradePathData.BaseLevelData.BurnEffectStats) == "table" then
			extractFields.Base.BurnEffectStats = ExtractFields(
				upgradePathData.BaseLevelData.BurnEffectStats,
				Schema.TowerBurnEffect
			)
		end

		if typeof(upgradePathData.BaseLevelData.ApplyBurnStats) == "table" then
			extractFields.Base.ApplyBurnStats = ExtractFields(
				upgradePathData.BaseLevelData.ApplyBurnStats,
				Schema.TowerApplyBurn
			)
		end

		local v2 = {}
		local v3 = {}

		for _, v4 in ipairs(Schema.TowerCoreBase) do
			v2[v4] = true
		end

		for _, v4 in ipairs(Schema.TowerCoreUpgrade) do
			v3[v4] = true
		end

		CollectFieldNames(upgradePathData.BaseLevelData, Schema.TowerBaseStats, v2) -- inferred equivalent call

		local function ExtractPath(list)
			if typeof(list) ~= "table" then
				return nil
			end

			local result3 = {}

			for i, v4 in ipairs(list) do
				local extractFields2 = ExtractFields(v4, Schema.TowerUpgradeStats)
				local addSpawnPathEntityData = ExtractSpawnEntries(v4.AddSpawnPathEntityData)

				if addSpawnPathEntityData then
					extractFields2.AddSpawnPathEntityData = addSpawnPathEntityData
				end

				local removeSpawnPathEntityNames = ExtractRemoveSpawnNames(v4.RemoveSpawnPathEntityNames)

				if removeSpawnPathEntityNames then
					extractFields2.RemoveSpawnPathEntityNames = removeSpawnPathEntityNames
				end

				if typeof(v4.BurnEffectStats) == "table" then
					extractFields2.BurnEffectStats = ExtractFields(v4.BurnEffectStats, Schema.TowerBurnEffect)
				end

				if typeof(v4.ApplyBurnStats) == "table" then
					extractFields2.ApplyBurnStats = ExtractFields(v4.ApplyBurnStats, Schema.TowerApplyBurn)
				end

				result3[tostring(i)] = extractFields2
				CollectFieldNames(v4, Schema.TowerUpgradeStats, v3) -- inferred equivalent call
			end

			return result3
		end

		local path = ExtractPath(upgradePathData.Path1Data)

		if path then
			extractFields.Path1 = path
		end

		local path2 = ExtractPath(upgradePathData.Path2Data)

		if path2 then
			extractFields.Path2 = path2
		end

		local towerForcedUpgradeField = Schema.TowerForcedUpgradeFields[v]

		if towerForcedUpgradeField then
			for _, v4 in ipairs(towerForcedUpgradeField) do
				v3[v4] = true
			end
		end

		result[v] = extractFields
		result2[v] = { Base = SetToSortedList(v2), Upgrade = SetToSortedList(v3) }
	end

	return result, result2
end

local function ExtractTowerAbilities()
	local result = {}

	for _, v in ipairs(ResourceManager.GetTowerAbilityConfigNames()) do
		local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(v)

		if not towerAbilityConfig then
			continue
		end

		local extractFields = ExtractFields(towerAbilityConfig, Schema.TowerAbility)

		if typeof(towerAbilityConfig.ProjectileHitData) == "table" then
			extractFields.ProjectileHitData = ExtractFields(
				towerAbilityConfig.ProjectileHitData,
				Schema.AbilityProjectileHit
			)
		end

		if typeof(towerAbilityConfig.MainAttackOverrideData) == "table" then
			extractFields.MainAttackOverrideData = ExtractFields(
				towerAbilityConfig.MainAttackOverrideData,
				Schema.TowerAbilityMainAttack
			)
		end

		if typeof(towerAbilityConfig.ApplyBurnStats) == "table" then
			extractFields.ApplyBurnStats = ExtractFields(towerAbilityConfig.ApplyBurnStats, Schema.TowerApplyBurn)
		end

		for k, v2 in pairs((ExtractNode(towerAbilityConfig, Schema.TowerAbilityShape))) do
			extractFields[k] = v2
		end

		result[v] = extractFields
	end

	return result
end

local function ExtractTowerAbilityNames(upgradePathData)
	local result = {}
	local v = {}
	local v2 = {}

	local function Collect(abilityNames, p: string)
		if typeof(abilityNames) ~= "table" then
			return
		end

		for _, v3 in ipairs(abilityNames) do
			if typeof(v3) ~= "string" then
				continue
			end

			if not v[v3] then
				v[v3] = true
				table.insert(result, v3)
				v2[v3] = {}
			end

			table.insert(v2[v3], p)
		end
	end

	local function CollectPath(list, p: string)
		if typeof(list) ~= "table" then
			return
		end

		for i, v3 in ipairs(list) do
			if typeof(v3) == "table" then
				Collect(v3.AbilityNames, `{p} L{i}`)
			end
		end
	end

	if typeof(upgradePathData) == "table" then
		if typeof(upgradePathData.BaseLevelData) == "table" then
			Collect(upgradePathData.BaseLevelData.AbilityNames, "Base")
		end

		CollectPath(upgradePathData.Path1Data, "Path 1")
		CollectPath(upgradePathData.Path2Data, "Path 2")
	end

	local result2 = {}

	for k, list in pairs(v2) do
		result2[k] = table.concat(list, ", ")
	end

	return result, result2
end

local function ExtractPowerUps(list, callback)
	local result = {}

	for _, v in ipairs(list) do
		local v2 = callback(v)

		if typeof(v2) ~= "table" then
			continue
		end

		local extractFields = ExtractFields(v2, Schema.PowerUp)

		if typeof(v2.Attacks) == "table" then
			local attacks = {}

			for k, attack in pairs(v2.Attacks) do
				if typeof(attack) == "table" then
					attacks[k] = ExtractFields(attack, Schema.PowerUpAttack)
				end
			end

			if next(attacks) then
				extractFields.Attacks = attacks
			end
		end

		result[v] = extractFields
	end

	return result
end

local function ExtractConfigs(list, callback, p)
	local result = {}

	for _, v in ipairs(list) do
		local v2 = callback(v)

		if v2 then
			result[v] = ExtractFields(v2, p)
		end
	end

	return result
end

local function ExtractStartingCashMap(p)
	local result = {}

	if typeof(p.PlayerCountToStartingCashMap) == "table" then
		for i, v in ipairs(p.PlayerCountToStartingCashMap) do
			result[tostring(i)] = v
		end
	end

	return result
end

local function ExtractCashPerDamageMap(p)
	if typeof(p.CashPerDamageData) ~= "table" then
		return nil
	end

	local result = {}

	for k, v in pairs(p.CashPerDamageData) do
		if typeof(v) == "table" then
			result[tostring(k)] = ExtractFields(v, Schema.WaveCashPerDamage)
		end
	end

	if next(result) == nil then
		return nil
	end

	return result
end

local function ExtractTowerCostMultipliers(p)
	local result = {}

	if typeof(p.TowerCostMultiplierMap) ~= "table" then
		return result
	end

	for k, v in pairs(p.TowerCostMultiplierMap) do
		if not (typeof(k) == "string" and typeof(v) == "number") then
			continue
		end

		result[k] = v
	end

	return result
end

local function ExtractWaveConfig(waveConfig)
	local extractFields = ExtractFields(waveConfig, Schema.WaveTop)
	extractFields.PlayerCountToStartingCashMap = ExtractStartingCashMap(waveConfig)
	extractFields.CashPerDamageData = ExtractCashPerDamageMap(waveConfig)
	extractFields.TowerCostMultiplierMap = ExtractTowerCostMultipliers(waveConfig)
	local waves = {}

	for k, v in pairs(waveConfig.Waves or {}) do
		local extractFields2 = ExtractFields(v, Schema.WaveEntry)
		local spawnSequences = {}

		for i, v2 in ipairs(v.SpawnSequences or {}) do
			spawnSequences[tostring(i)] = ExtractFields(v2, Schema.Sequence)
		end

		extractFields2.SpawnSequences = spawnSequences
		waves[tostring(k)] = extractFields2
	end

	extractFields.Waves = waves
	return extractFields
end

local function ExtractWaves()
	local result = {}

	for _, v in ipairs(ResourceManager.GetWaveConfigNames()) do
		local waveConfig = ResourceManager.GetWaveConfig(v)

		if waveConfig then
			result[v] = ExtractWaveConfig(waveConfig)
		end
	end

	return result
end

local function ExtractAbilityNames(p)
	local names = {}
	local v = {}

	local function Collect(list)
		if typeof(list) ~= "table" then
			return
		end

		for _, name in ipairs(list) do
			if typeof(name) ~= "string" then
				if typeof(name) == "table" and typeof(name.Name) == "string" then
					name = name.Name
				else
					name = nil
				end
			end

			if not name or v[name] then
				continue
			end

			v[name] = true
			table.insert(names, name)
		end
	end

	Collect(p.AbilityNames)
	Collect(p.DeathAbilityNames)
	return names
end

local function ExtractEnemyAbilityOptions()
	local result = {}

	for _, v in ipairs(ResourceManager.GetEnemyConfigNames()) do
		local enemyConfig = ResourceManager.GetEnemyConfig(v)

		if not enemyConfig then
			continue
		end

		local extractPrimaryAbilityNames = ExtractPrimaryAbilityNames(enemyConfig)

		if #extractPrimaryAbilityNames > 0 then
			result[v] = extractPrimaryAbilityNames
		end
	end

	return result
end

local v = { TowerBuffNames = true, TowerBuffName = true }
local v2 = { EnemyBuffNames = true, EnemyBuffName = true, SelfEnemyBuffNames = true }

local function ExtractAbilityBuffs(p)
	local v3 = {}
	local v4 = {}
	local v5 = {}
	local v6 = {}
	local v7 = {}

	local function Add(item, list, p2)
		if typeof(item) == "string" then
			if not p2[item] then
				p2[item] = true
				table.insert(list, item)
			end
		elseif typeof(item) == "table" then
			for _, item2 in ipairs(item) do
				if typeof(item2) ~= "string" or p2[item2] then
					continue
				end

				p2[item2] = true
				table.insert(list, item2)
			end
		end
	end

	local function Walk(items)
		if typeof(items) ~= "table" or v7[items] then
			return
		end

		v7[items] = true

		for k, item in pairs(items) do
			if v[k] then
				Add(item, v3, v5)
			elseif v2[k] then
				Add(item, v4, v6)
			elseif typeof(item) == "table" then
				Walk(item)
			end
		end
	end

	Walk(p)
	return v3, v4
end

local v3 = { PathEntityType = true }
local v4 = { StaticEntityType = true, SpawnStaticEntityName = true }
local v5 = { SpawnStaticEntityData = true }
local v6 = { SpawnPathEntityData = true, SpawnPathEntities = true }
local v7 = { Name = true, StaticEntityType = true }
local v8 = { Name = true, PathEntityType = true }

local function ExtractSpawnedEntities(p)
	local v9 = {}
	local v10 = {}
	local v11 = {}
	local v12 = {}
	local v13 = {}

	local function Add(value, list, p2) -- 4 equivalent calls inferred from this helper
		if typeof(value) == "string" and not p2[value] then
			p2[value] = true
			table.insert(list, value)
		end
	end

	local function CollectNamed(item, items, list, p2)
		if typeof(item) ~= "table" then
			return
		end

		for k in pairs(items) do
			Add(item[k], list, p2) -- inferred equivalent call
		end

		for _, v14 in ipairs(item) do
			if typeof(v14) ~= "table" then
				continue
			end

			for k in pairs(items) do
				Add(v14[k], list, p2) -- inferred equivalent call
			end
		end
	end

	local function Walk(items)
		if typeof(items) ~= "table" or v13[items] then
			return
		end

		v13[items] = true

		for k, item in pairs(items) do
			if v3[k] then
				Add(item, v9, v11) -- inferred equivalent call
			elseif v4[k] then
				Add(item, v10, v12) -- inferred equivalent call
			elseif v5[k] then
				CollectNamed(item, v7, v10, v12)
			elseif v6[k] then
				CollectNamed(item, v8, v9, v11)
			elseif typeof(item) == "table" then
				Walk(item)
			end
		end
	end

	Walk(p)
	return v9, v10
end

local function ExtractTowerSpawnChanges(upgradePathData)
	local v9 = {}

	if typeof(upgradePathData) ~= "table" then
		return v9
	end

	local function SpawnNames(list)
		local pathEntityTypes = {}

		if typeof(list) ~= "table" then
			return pathEntityTypes
		end

		for _, v10 in ipairs(list) do
			if not (typeof(v10) == "table" and typeof(v10.PathEntityType) == "string") then
				continue
			end

			table.insert(pathEntityTypes, v10.PathEntityType)
		end

		return pathEntityTypes
	end

	local function NameList(list)
		local result = {}

		if typeof(list) == "table" then
			for _, v10 in ipairs(list) do
				if typeof(v10) == "string" then
					table.insert(result, v10)
				end
			end
		end

		return result
	end

	local function AddEntry(location: string, p, p2)
		local add = SpawnNames(p)
		local remove = NameList(p2)

		if #add == 0 and #remove == 0 then
			return
		end

		local v10 = { Location = location }

		if #add > 0 then
			v10.Add = add
		end

		if #remove > 0 then
			v10.Remove = remove
		end

		table.insert(v9, v10)
	end

	local baseLevelData = upgradePathData.BaseLevelData

	if typeof(baseLevelData) == "table" then
		AddEntry("Base", baseLevelData.SpawnPathEntityData, nil)
	end

	local function ProcessPath(list, p: string)
		if typeof(list) ~= "table" then
			return
		end

		for i, v10 in ipairs(list) do
			if typeof(v10) == "table" then
				AddEntry(`{p} L{i}`, v10.AddSpawnPathEntityData, v10.RemoveSpawnPathEntityNames)
			end
		end
	end

	ProcessPath(upgradePathData.Path1Data, "Path 1")
	ProcessPath(upgradePathData.Path2Data, "Path 2")
	return v9
end

local function ExtractRelations()
	local enemyAbilities = {}

	for _, v9 in ipairs(ResourceManager.GetEnemyConfigNames()) do
		local enemyConfig = ResourceManager.GetEnemyConfig(v9)

		if not enemyConfig then
			continue
		end

		local extractAbilityNames = ExtractAbilityNames(enemyConfig)

		if #extractAbilityNames > 0 then
			enemyAbilities[v9] = extractAbilityNames
		end
	end

	local pathEntityAbilities = {}

	for _, v9 in ipairs(ResourceManager.GetPathEntityConfigNames()) do
		local pathEntityConfig = ResourceManager.GetPathEntityConfig(v9)

		if not pathEntityConfig then
			continue
		end

		local extractAbilityNames = ExtractAbilityNames(pathEntityConfig)

		if #extractAbilityNames > 0 then
			pathEntityAbilities[v9] = extractAbilityNames
		end
	end

	local abilityTowerBuffs = {}
	local abilityEnemyBuffs = {}
	local abilityPathEntities = {}
	local abilityStaticEntities = {}

	for _, v9 in ipairs(ResourceManager.GetEnemyAbilityConfigNames()) do
		local enemyAbilityConfig = ResourceManager.GetEnemyAbilityConfig(v9)

		if not enemyAbilityConfig then
			continue
		end

		local v10, v11 = ExtractAbilityBuffs(enemyAbilityConfig)

		if #v10 > 0 then
			abilityTowerBuffs[v9] = v10
		end

		if #v11 > 0 then
			abilityEnemyBuffs[v9] = v11
		end

		local v12, v13 = ExtractSpawnedEntities(enemyAbilityConfig)

		if #v12 > 0 then
			abilityPathEntities[v9] = v12
		end

		if #v13 > 0 then
			abilityStaticEntities[v9] = v13
		end
	end

	local towerAbilities = {}
	local towerAbilityLevels = {}
	local towerSpawnChanges = {}
	local towerStaticEntities = {}

	for _, v9 in ipairs(ResourceManager.GetTowerConfigNames()) do
		local towerConfig = ResourceManager.GetTowerConfig(v9)

		if not towerConfig then
			continue
		end

		local v10, v11 = ExtractTowerAbilityNames(towerConfig.UpgradePathData)

		if #v10 > 0 then
			towerAbilities[v9] = v10
			towerAbilityLevels[v9] = v11
		end

		local extractTowerSpawnChanges = ExtractTowerSpawnChanges(towerConfig.UpgradePathData)

		if #extractTowerSpawnChanges > 0 then
			towerSpawnChanges[v9] = extractTowerSpawnChanges
		end

		local _, v12 = ExtractSpawnedEntities(towerConfig)

		if #v12 > 0 then
			towerStaticEntities[v9] = v12
		end
	end

	local towerAbilityTowerBuffs = {}
	local towerAbilityEnemyBuffs = {}
	local towerAbilityPathEntities = {}
	local towerAbilityStaticEntities = {}

	for _, v9 in ipairs(ResourceManager.GetTowerAbilityConfigNames()) do
		local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(v9)

		if not towerAbilityConfig then
			continue
		end

		local v10, v11 = ExtractAbilityBuffs(towerAbilityConfig)

		if #v10 > 0 then
			towerAbilityTowerBuffs[v9] = v10
		end

		if #v11 > 0 then
			towerAbilityEnemyBuffs[v9] = v11
		end

		local v12, v13 = ExtractSpawnedEntities(towerAbilityConfig)

		if #v12 > 0 then
			towerAbilityPathEntities[v9] = v12
		end

		if #v13 > 0 then
			towerAbilityStaticEntities[v9] = v13
		end
	end

	local powerUpTowerBuffs = {}
	local powerUpEnemyBuffs = {}

	local function ScanPowerUpBuffs(list, callback)
		for _, v9 in ipairs(list) do
			local v10 = callback(v9)

			if not v10 then
				continue
			end

			local v11, v12 = ExtractAbilityBuffs(v10)

			if #v11 > 0 then
				powerUpTowerBuffs[v9] = v11
			end

			if #v12 > 0 then
				powerUpEnemyBuffs[v9] = v12
			end
		end
	end

	ScanPowerUpBuffs(ResourceManager.GetRegularPowerUpConfigNames(), ResourceManager.GetRegularPowerUpConfig)
	ScanPowerUpBuffs(ResourceManager.GetCustomPowerUpConfigNames(), ResourceManager.GetCustomPowerUpConfig)
	return {
		EnemyAbilities = enemyAbilities,
		PathEntityAbilities = pathEntityAbilities,
		WaveStartingLivesOverrides = ExtractWaveStartingLivesOverrides(),
		MapEntityLivesMaps = ExtractMapEntityLivesMaps(),
		AbilityTowerBuffs = abilityTowerBuffs,
		AbilityEnemyBuffs = abilityEnemyBuffs,
		PowerUpTowerBuffs = powerUpTowerBuffs,
		PowerUpEnemyBuffs = powerUpEnemyBuffs,
		AbilityPathEntities = abilityPathEntities,
		AbilityStaticEntities = abilityStaticEntities,
		TowerAbilities = towerAbilities,
		TowerAbilityLevels = towerAbilityLevels,
		TowerSpawnChanges = towerSpawnChanges,
		TowerStaticEntities = towerStaticEntities,
		TowerAbilityTowerBuffs = towerAbilityTowerBuffs,
		TowerAbilityEnemyBuffs = towerAbilityEnemyBuffs,
		TowerAbilityPathEntities = towerAbilityPathEntities,
		TowerAbilityStaticEntities = towerAbilityStaticEntities
	}
end

function Exporter.BuildSnapshot()
	local enemies2, pvpEnemies = ExtractEnemies()
	local towers2, towerFields = ExtractTowers()
	local flatFieldMap = Schema.FlatFieldMap()

	for _, v9 in ipairs((DamageTypeList())) do
		if flatFieldMap[v9] == nil then
			flatFieldMap[v9] = {
				Type = Schema.DamageReductionValue.Type,
				Min = Schema.DamageReductionValue.Min,
				Max = Schema.DamageReductionValue.Max
			}
		end
	end

	for i = 1, 4 do
		local v9 = tostring(i)

		if flatFieldMap[v9] == nil then
			flatFieldMap[v9] = {
				Type = Schema.TowerLimitValue.Type,
				Min = Schema.TowerLimitValue.Min,
				Max = Schema.TowerLimitValue.Max
			}
		end
	end

	return {
		Version = 47,
		FieldSchema = flatFieldMap,
		SectionSchema = {
			Enemy = OrderedSection(Schema.Enemy, {
				"Speed",
				"Health",
				"Shield",
				"BodyHeat",
				"BodyHeatRegenerationRate",
				"ThawTime",
				"FrozenMaximumTime",
				"FrozenDebounceTime",
				"BaseDamageMultiplier",
				"BaseDamageOverride",
				"InstantLossIfReachEnd",
				"StunResistance",
				"SuperStunResistance",
				"StealthDetection",
				"KnockbackResistance",
				"NoCash",
				"AlwaysStealthed",
				"IsBoss",
				"IsMiniBoss"
			}),
			EnemyResistances = ResistanceSection(),
			EnemyAdditionalStats = OrderedSection(Schema.EnemyAdditionalStats, { "Health", "Shield" }),
			EnemyDeathSpawn = OrderedSection(Schema.EnemyDeathSpawn, {
				"EnemyType",
				"Count",
				"Delay",
				"MaxSpawnOffsetStuds",
				"OnlyBackwardsOffset",
				"PathStudsOffset",
				"ExactPosition",
				"NoSpawnTween",
				"NoCash",
				"Stealth",
				"StaticEntityType",
				"StaticEntityLifetime"
			}),
			EnemyAbilityStatOverrides = OrderedSection(Schema.EnemyAbilityStatOverrides, {
				"Disabled",
				"Cooldown",
				"StartingCooldown",
				"CooldownVariance",
				"StartingCooldownVariance",
				"DamageMultiplier",
				"HealAmountMultiplier"
			}),
			AbilityTowerInstantKill = OrderedSection(Schema.AbilityTowerInstantKill, {
				"InstantKillType",
				"TowerType",
				"TargetEMPVulnerableUnits",
				"Count"
			}),
			AbilityRangedData = OrderedSection(Schema.AbilityRangedData, {
				"Range",
				"MinimumRange",
				"ArcSpreadAngle",
				"MinimumTargetsInRange",
				"TargetMinimumValue",
				"HitAllTargetsInRange",
				"TargetMostExpensiveTower",
				"TargetWeakestTower",
				"TargetRandomTower",
				"TargetHighestRangeTower"
			}),
			EnemyPVP = OrderedSection(Schema.EnemyPVP, {
				"SendCost",
				"UnlockWave",
				"BuildDuration",
				"BuildCooldown",
				"PVPCashPerDamageMultiplier",
				"SendEco"
			}),
			Economy = OrderedSection(Schema.Economy, Schema.EconomyOrder),
			Ability = OrderedSection(Schema.Ability, {
				"EnabledDifficulties",
				"Cooldown",
				"StartingCooldown",
				"CooldownVariance",
				"StartingCooldownVariance",
				"Delay",
				"ExecutionTime",
				"BurstSize",
				"BurstInterval"
			}),
			AbilityRadiusEffect = OrderedSection(Schema.AbilityRadiusEffect, {
				"MinimumRange",
				"MaximumRange",
				"HitPercentage",
				"MinimumTargets",
				"MaximumTargets"
			}),
			AbilityHealData = OrderedSection(Schema.AbilityHealData, {
				"OverrideMaxHealth",
				"OverrideMaxShield",
				"HealAmount",
				"ShieldGain",
				"ShieldCap",
				"ShieldGainPercentageOfTargetMaxHealth",
				"Delay"
			}),
			TowerBuff = OrderedSection(Schema.TowerBuff, {
				"Type",
				"IsDebuff",
				"Percentage",
				"Time",
				"DamagePerSecond",
				"DamagePercentagePerSecond",
				"HealPerSecond",
				"InstantHealAmount",
				"RemoveIfHealedForTime",
				"IgnoreStunImmunity"
			}),
			EnemyBuff = OrderedSection(Schema.EnemyBuff, {
				"Type",
				"IsDebuff",
				"Percentage",
				"BossPercentage",
				"Time",
				"DamagePerSecond",
				"HealPerSecond"
			}),
			WaveTop = OrderedSection(Schema.WaveTop, {
				"StartingCash",
				"StartingLives",
				"SetUpTime",
				"DefaultXPPerWavePassed"
			}),
			WaveCashPerDamage = OrderedSection(Schema.WaveCashPerDamage, { "CashPerDamage", "CashPerDamageShared" }),
			WaveEntry = OrderedSection(Schema.WaveEntry, {
				"CashBonus",
				"OverrideXP",
				"CustomWaveTime",
				"CashMultiplierOverride"
			}),
			Sequence = OrderedSection(Schema.Sequence, {
				"StartDelay",
				"EnemyType",
				"Count",
				"Interval",
				"Stealth",
				"AdditionalSpeedBoostMultiplier",
				"AdditionalHealthMultiplier",
				"AdditionalShieldMultiplier"
			}),
			TowerTop = OrderedSection(MergeSections(Schema.TowerTop, Schema.TowerConfigTop), {
				"OnePathOnly",
				"PathLockLevel",
				"EMPVulnerable"
			}),
			TowerBase = OrderedSection(Schema.TowerBaseStats, Schema.TowerBaseStatsOrder),
			TowerUpgrade = OrderedSection(Schema.TowerUpgradeStats, Schema.TowerUpgradeStatsOrder),
			SpawnPathEntity = OrderedSection(Schema.SpawnPathEntity, Schema.SpawnPathEntityOrder),
			SpawnRemoveName = { Type = Schema.SpawnRemoveName.Type },
			TowerBurnEffect = OrderedSection(Schema.TowerBurnEffect, Schema.TowerBurnEffectOrder),
			TowerApplyBurn = OrderedSection(Schema.TowerApplyBurn, Schema.TowerApplyBurnOrder),
			TowerAbility = OrderedSection(Schema.TowerAbility, {
				"Cooldown",
				"StartingCooldown",
				"Delay",
				"ExecutionTime",
				"BurstSize",
				"BurstInterval",
				"EffectRadius",
				"RadiusDamage",
				"RadiusDamageMaximumTargets",
				"HealPercentage",
				"HealAmount",
				"EnemyDamage",
				"BodyHeatReduction",
				"ContinuousForTime",
				"ContinuousReloadTime",
				"RevealTime",
				"TowerBuffOverrideTime",
				"EnableTowerAttackDuration",
				"CannotUseAfterAttackForSeconds",
				"ManualAimCustomRange",
				"MainAttackOverrideDataDuration"
			}),
			TowerAbilityMainAttack = OrderedSection(Schema.TowerAbilityMainAttack, {
				"Damage",
				"DamageType",
				"ReloadTime",
				"Range",
				"IsSplash",
				"SplashRadius"
			}),
			AttackData = OrderedSection(Schema.AttackData, Schema.AttackDataOrder),
			PathEntity = OrderedSection(Schema.PathEntity, { "Speed", "Health", "CollisionResistance" }),
			PathEntityAbility = OrderedSection(Schema.Ability, {
				"Cooldown",
				"StartingCooldown",
				"CooldownVariance",
				"StartingCooldownVariance",
				"Delay",
				"ExecutionTime",
				"BurstSize",
				"BurstInterval"
			}),
			PathEntityAbilityRanged = OrderedSection(Schema.PathEntityAbilityRanged, {
				"CanTargetAir",
				"Range",
				"MinimumRange",
				"Damage",
				"DamageType"
			}),
			PathEntityAbilityRadius = OrderedSection(Schema.PathEntityAbilityRadius, {
				"MinimumRange",
				"MaximumRange",
				"HitPercentage",
				"MinimumTargets",
				"MaximumTargets",
				"Damage",
				"DamageType"
			}),
			AbilitySpawnEnemy = OrderedSection(Schema.AbilitySpawnEnemy, Schema.AbilitySpawnEnemyOrder),
			PathEntityAbilitySpawn = OrderedSection(Schema.PathEntityAbilitySpawn, {
				"PathEntityType",
				"Count",
				"SpawnDelay",
				"StaggerMaxDelay",
				"MaxSpawnOffsetStuds",
				"FavorSpawningBehindParent",
				"FavorSpawningInFrontOfParent",
				"PathPercentageLowerBound",
				"PathPercentageUpperBound"
			}),
			StaticEntity = OrderedSection(Schema.StaticEntity, { "Lifetime" }),
			MapEntity = OrderedSection(Schema.MapEntity, Schema.MapEntityOrder),
			MapEntityStatOverrides = OrderedSection(Schema.MapEntityStatOverrides, { "Health" }),
			StaticEntityHit = OrderedSection(Schema.AbilityProjectileHit, {
				"Damage",
				"DamagePercentage",
				"DamageMultiplier",
				"SplashRadius"
			}),
			StaticEntityMultiHeal = OrderedSection(Schema.MultiHealData, {
				"MaximumTargets",
				"HealAmountPerTarget",
				"ReloadTime",
				"CanTargetParentTower"
			}),
			TowerAbilityHit = OrderedSection(Schema.AbilityProjectileHit, {
				"Damage",
				"DamagePercentage",
				"DamageMultiplier",
				"SplashRadius"
			}),
			PowerUp = OrderedSection(Schema.PowerUp, Schema.PowerUpOrder),
			PowerUpAttack = OrderedSection(Schema.PowerUpAttack, Schema.PowerUpAttackOrder)
		},
		DamageTypes = DamageTypeList(),
		Difficulties = DifficultyList(),
		EnemyAbilityOptions = ExtractEnemyAbilityOptions(),
		PVPEnemies = pvpEnemies,
		Groups = {
			Enemies = BuildGroupMap(configs),
			Abilities = BuildGroupMap(abilities),
			TowerBuffs = BuildGroupMap(towerBuffs),
			EnemyBuffs = BuildGroupMap(enemyBuffs),
			Towers = BuildGroupMap(configs2),
			TowerAbilities = BuildGroupMap(abilities2),
			PathEntities = BuildGroupMap(configs3),
			StaticEntities = BuildGroupMap(configs4),
			MapEntities = BuildGroupMap(configs5)
		},
		Relations = ExtractRelations(),
		TowerFields = towerFields,
		AttackLabels = {
			Enemies = BuildAttackLabels(configs, ResourceManager.GetEnemyConfigNames(), ResourceManager.GetEnemyConfig),
			PathEntities = BuildAttackLabels(
				configs3,
				ResourceManager.GetPathEntityConfigNames(),
				ResourceManager.GetPathEntityConfig
			),
			StaticEntities = BuildAttackLabels(
				configs4,
				ResourceManager.GetStaticEntityConfigNames(),
				ResourceManager.GetStaticEntityConfig
			),
			MapEntities = BuildAttackLabels(
				configs5,
				ResourceManager.GetMapEntityConfigNames(),
				ResourceManager.GetMapEntityConfig
			)
		},
		Enemies = enemies2,
		Abilities = ExtractAbilities(),
		Towers = towers2,
		TowerAbilities = ExtractTowerAbilities(),
		PathEntities = ExtractPathEntities(),
		PathEntityAbilities = ExtractPathEntityAbilities(),
		StaticEntities = ExtractStaticEntities(),
		MapEntities = ExtractMapEntities(),
		TowerBuffs = ExtractConfigs(
			ResourceManager.GetTowerBuffConfigNames(),
			ResourceManager.GetTowerBuffConfig,
			Schema.TowerBuff
		),
		EnemyBuffs = ExtractConfigs(
			ResourceManager.GetEnemyBuffConfigNames(),
			ResourceManager.GetEnemyBuffConfig,
			Schema.EnemyBuff
		),
		PowerUps = ExtractPowerUps(
			ResourceManager.GetRegularPowerUpConfigNames(),
			ResourceManager.GetRegularPowerUpConfig
		),
		CustomPowerUps = ExtractPowerUps(
			ResourceManager.GetCustomPowerUpConfigNames(),
			ResourceManager.GetCustomPowerUpConfig
		),
		Waves = ExtractWaves(),
		Economy = ExtractFields(PVPEconomyConfig, Schema.Economy)
	}
end

function Exporter.ToJSON()
	return HttpService:JSONEncode(Exporter.BuildSnapshot())
end

function Exporter.PrintJSON()
	print(Exporter.ToJSON())
end

function Exporter.PostSnapshot(value: string?)
	local json = Exporter.ToJSON()
	local v9 = math.max(1, (math.ceil(#json / 500000)))
	local guid = HttpService:GenerateGUID(false)
	local v10 = value or "http://localhost:7777"

	for i = 0, v9 - 1 do
		local v11 = string.sub(json, i * 500000 + 1, (i + 1) * 500000)
		local formatted = `{v10}/?id={guid}&index={i}&total={v9}`
		local success, result = pcall(function()
			HttpService:PostAsync(formatted, v11, Enum.HttpContentType.TextPlain)
		end)

		if not success then
			return false, `chunk {i + 1}/{v9}: {tostring(result)}`
		end
	end

	return true, nil
end

return Exporter