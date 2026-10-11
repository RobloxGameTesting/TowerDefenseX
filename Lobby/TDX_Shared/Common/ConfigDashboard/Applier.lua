local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Schema = require(common:WaitForChild("ConfigDashboard"):WaitForChild("Schema"))
local PVPEconomyConfig = require(common:WaitForChild("PVPEconomyConfig"))
local PowerUpsConfigHandler = require(common:WaitForChild("Resources"):WaitForChild("Misc"):WaitForChild("PowerUpsConfigHandler"))
local Applier = {}
local v = {}
local function DeepCopy(items)
	if typeof(items) ~= "table" then
		return items
	end

	local result = {}

	for k, item in pairs(items) do
		result[k] = DeepCopy(item)
	end

	return result
end

local function DeepRestore(items, items2)
	for k in pairs(items) do
		if items2[k] == nil then
			items[k] = nil
		end
	end

	for k, item in pairs(items2) do
		if typeof(item) == "table" then
			if typeof(items[k]) ~= "table" then
				items[k] = {}
			end

			DeepRestore(items[k], item)
		else
			items[k] = item
		end
	end
end

local function ApplyFields(p, p2, items, p3: string, list)
	for k, item in pairs(items) do
		local v2 = p2[k]

		if not v2 then
			continue
		end

		if v2.ReadOnly then
			warn(`[ConfigDashboard] {p3}.{k} is read-only; ignored`)
		elseif item == "$delete" then
			if v2.Optional then
				p[k] = nil
				table.insert(list, `{p3}.{k} = (removed)`)
			else
				warn(`[ConfigDashboard] {p3}.{k} is required; cannot remove`)
			end
		else
			local coerce, v3 = Schema.Coerce(v2, item, ResourceManager.HasEnemyConfig)

			if coerce then
				p[k] = v3
				table.insert(list, `{p3}.{k} = {tostring(v3)}`)
			else
				warn(`[ConfigDashboard] Ignored {p3}.{k}: {tostring(v3)}`)
			end
		end
	end
end

local function ApplyAttackList(attackData, attackData2, p: string, p2)
	if typeof(attackData) ~= "table" or typeof(attackData2) ~= "table" then
		return
	end

	for k, item in pairs(attackData2) do
		if typeof(item) ~= "table" then
			continue
		end

		local v2 = tonumber(k)
		local v3 = v2 and attackData[v2]

		if v3 then
			ApplyFields(v3, Schema.AttackData, item, `{p}.Attack[{tostring(k)}]`, p2)
		else
			warn(`[ConfigDashboard] Ignored unknown {p}.AttackData[{tostring(k)}]`)
		end
	end
end

local function ApplyDeathSpawnChanceMap(p, enemyTypeChanceMap, formatted: string, list)
	if typeof(enemyTypeChanceMap) ~= "table" then
		return
	end

	for k, item in pairs(enemyTypeChanceMap) do
		if not (typeof(k) == "string" and k ~= "") then
			continue
		end

		if item == "$delete" then
			if typeof(p.EnemyTypeChanceMap) == "table" and p.EnemyTypeChanceMap[k] ~= nil then
				p.EnemyTypeChanceMap[k] = nil
				table.insert(list, `{formatted}.EnemyTypeChanceMap[{k}] = (removed)`)
			end
		elseif ResourceManager.HasEnemyConfig(k) then
			local coerce, v2 = Schema.Coerce(Schema.DeathSpawnChanceValue, item)

			if coerce then
				if typeof(p.EnemyTypeChanceMap) ~= "table" then
					p.EnemyTypeChanceMap = {}
				end

				p.EnemyTypeChanceMap[k] = v2
				table.insert(list, `{formatted}.EnemyTypeChanceMap[{k}] = {tostring(v2)}`)
			else
				warn(`[ConfigDashboard] Ignored {formatted}.EnemyTypeChanceMap[{k}]: {tostring(v2)}`)
			end
		else
			warn(`[ConfigDashboard] Ignored {formatted}.EnemyTypeChanceMap[{k}]: unknown enemy`)
		end
	end

	if typeof(p.EnemyTypeChanceMap) == "table" and next(p.EnemyTypeChanceMap) == nil then
		p.EnemyTypeChanceMap = nil
	end
end

local function ApplyDeathSpawnList(deathSpawnData, deathSpawnData2, p: string, p2)
	if typeof(deathSpawnData) ~= "table" or typeof(deathSpawnData2) ~= "table" then
		return
	end

	for k, item in pairs(deathSpawnData2) do
		if typeof(item) ~= "table" then
			continue
		end

		local v2 = tonumber(k)
		local v3 = v2 and deathSpawnData[v2]

		if v3 then
			local formatted = `{p}.DeathSpawn[{tostring(k)}]`
			ApplyFields(v3, Schema.EnemyDeathSpawn, item, formatted, p2)
			ApplyDeathSpawnChanceMap(v3, item.EnemyTypeChanceMap, formatted, p2)
		else
			warn(`[ConfigDashboard] Ignored unknown {p}.DeathSpawnData[{tostring(k)}]`)
		end
	end
end

local function BuildSpawnEntry(p, p2: string)
	local v2 = {}
	ApplyFields(v2, Schema.SpawnPathEntity, p, p2, {})

	if typeof(v2.PathEntityType) ~= "string" then
		warn(`[ConfigDashboard] {p2}: new spawn entry needs a valid PathEntityType; ignored`)
		return nil
	end

	v2.StartDelay = v2.StartDelay or 0
	v2.Interval = v2.Interval or 1
	return v2
end

local function ApplySpawnEntries(p, p2: string, items, p3: string, list)
	if typeof(items) ~= "table" then
		return
	end

	p[p2] = p[p2] or {}
	local v2 = p[p2]
	local v3 = {}
	local v4 = {}

	for k, item in pairs(items) do
		local v5 = tonumber(k)

		if item == "$delete" then
			if v5 and v2[v5] then
				table.insert(v4, v5)
			end
		elseif typeof(item) == "table" then
			if v5 and v2[v5] then
				ApplyFields(v2[v5], Schema.SpawnPathEntity, item, `{p3}.Spawn[{tostring(k)}]`, list)
			elseif v5 then
				table.insert(v3, k)
			else
				warn(`[ConfigDashboard] Ignored non-numeric spawn key {p3}[{tostring(k)}]`)
			end
		end
	end

	table.sort(v4, function(a, b)
		return b < a
	end)

	for _, v5 in ipairs(v4) do
		table.remove(v2, v5)
		table.insert(list, `{p3}.Spawn[{v5}] = removed`)
	end

	table.sort(v3, function(a, b)
		return (tonumber(a) or 0) < (tonumber(b) or 0)
	end)

	for _, v5 in ipairs(v3) do
		local spawnEntry = BuildSpawnEntry(items[v5], `{p3}.NewSpawn[{tostring(v5)}]`)

		if not spawnEntry then
			continue
		end

		table.insert(v2, spawnEntry)
		table.insert(list, `{p3} = added spawn {spawnEntry.PathEntityType}`)
	end

	if next(v2) == nil then
		p[p2] = nil
	end
end

local function ApplyRemoveSpawnNames(p, removeSpawnPathEntityNames, p2: string, list)
	if typeof(removeSpawnPathEntityNames) ~= "table" then
		return
	end

	local function ResolveName(p3)
		local coerce, v2 = Schema.Coerce(Schema.SpawnRemoveName, p3)

		if coerce and ResourceManager.HasPathEntityConfig(v2) then
			return v2
		end

		return nil
	end

	p.RemoveSpawnPathEntityNames = p.RemoveSpawnPathEntityNames or {}
	local removeSpawnPathEntityNames2 = p.RemoveSpawnPathEntityNames
	local v2 = {}
	local v3 = {}

	for k, item in pairs(removeSpawnPathEntityNames) do
		local v4 = tonumber(k)

		if item == "$delete" then
			if v4 and removeSpawnPathEntityNames2[v4] then
				table.insert(v3, v4)
			end
		elseif v4 and removeSpawnPathEntityNames2[v4] then
			local coerce, v5 = Schema.Coerce(Schema.SpawnRemoveName, item)

			if not (coerce and ResourceManager.HasPathEntityConfig(v5)) then
				v5 = nil
			end

			if v5 then
				removeSpawnPathEntityNames2[v4] = v5
				table.insert(list, `{p2}.Remove[{v4}] = {v5}`)
			else
				warn(`[ConfigDashboard] Ignored {p2}.Remove[{tostring(k)}]: invalid path entity`)
			end
		elseif v4 then
			table.insert(v2, k)
		else
			warn(`[ConfigDashboard] Ignored non-numeric remove key {p2}[{tostring(k)}]`)
		end
	end

	table.sort(v3, function(a, b)
		return b < a
	end)

	for _, v4 in ipairs(v3) do
		table.remove(removeSpawnPathEntityNames2, v4)
		table.insert(list, `{p2}.Remove[{v4}] = removed`)
	end

	table.sort(v2, function(a, b)
		return (tonumber(a) or 0) < (tonumber(b) or 0)
	end)

	for _, v4 in ipairs(v2) do
		local item = removeSpawnPathEntityNames[v4]
		local coerce, v5 = Schema.Coerce(Schema.SpawnRemoveName, item)

		if not (coerce and ResourceManager.HasPathEntityConfig(v5)) then
			v5 = nil
		end

		if v5 then
			table.insert(removeSpawnPathEntityNames2, v5)
			table.insert(list, `{p2}.Remove = added {v5}`)
		else
			warn(`[ConfigDashboard] Ignored new {p2}.Remove[{tostring(v4)}]: invalid path entity`)
		end
	end

	if next(removeSpawnPathEntityNames2) == nil then
		p.RemoveSpawnPathEntityNames = nil
	end
end

local function FindResistance(damageReductionTable, k: string)
	if typeof(damageReductionTable) == "table" then
		for i, v2 in ipairs(damageReductionTable) do
			if typeof(v2) == "table" and v2.DamageType == k then
				return i, v2
			end
		end
	end

	return nil, nil
end

local function ApplyResistances(enemyConfig, damageReductions, p: string, list)
	if typeof(damageReductions) ~= "table" then
		return
	end

	for k, item in pairs(damageReductions) do
		if not (typeof(k) == "string" and k ~= "") then
			continue
		end

		if item == "$delete" then
			local resistance = FindResistance(enemyConfig.DamageReductionTable, k)

			if resistance then
				table.remove(enemyConfig.DamageReductionTable, resistance)
				table.insert(list, `{p}.Resistance[{k}] = (removed)`)
			end
		else
			local coerce, damageReduction = Schema.Coerce(Schema.DamageReductionValue, item)

			if coerce then
				if typeof(enemyConfig.DamageReductionTable) ~= "table" then
					enemyConfig.DamageReductionTable = {}
				end

				local _, v2 = FindResistance(enemyConfig.DamageReductionTable, k)

				if v2 then
					v2.DamageReduction = damageReduction
				else
					table.insert(enemyConfig.DamageReductionTable, {
						DamageType = k,
						DamageReduction = damageReduction
					})
				end

				table.insert(list, `{p}.Resistance[{k}] = {tostring(damageReduction)}`)
			else
				warn(`[ConfigDashboard] Ignored {p}.Resistance[{k}]: {tostring(damageReduction)}`)
			end
		end
	end
end

local function ApplyAdditionalStats(enemyConfig, playerCountToAdditionalStatsMap, p: string, p2)
	if
		typeof(playerCountToAdditionalStatsMap) ~= "table"
		or typeof(enemyConfig.PlayerCountToAdditionalStatsMap) ~= "table"
	then
		return
	end

	for k, item in pairs(playerCountToAdditionalStatsMap) do
		if typeof(item) ~= "table" then
			continue
		end

		local v2 = tonumber(k)
		local v3 = v2 and enemyConfig.PlayerCountToAdditionalStatsMap[v2]

		if typeof(v3) == "table" then
			ApplyFields(v3, Schema.EnemyAdditionalStats, item, `{p}.PlayerCount[{tostring(k)}]`, p2)
		else
			warn(`[ConfigDashboard] Ignored unknown {p}.PlayerCount[{tostring(k)}]`)
		end
	end
end

local function EnemyAbilityNameSet(p)
	local result = {}

	if typeof(p.AbilityNames) ~= "table" then
		return result
	end

	for _, name in ipairs(p.AbilityNames) do
		if typeof(name) ~= "string" then
			if typeof(name) == "table" and typeof(name.Name) == "string" then
				name = name.Name
			else
				name = nil
			end
		end

		if name then
			result[name] = true
		end
	end

	return result
end

local function ApplyAbilityStatOverrides(enemyConfig, difficultyToAbilityStatOverridesMap, p: string, list)
	if typeof(difficultyToAbilityStatOverridesMap) ~= "table" then
		return
	end

	local enemyAbilityNameSet = EnemyAbilityNameSet(enemyConfig)

	for k, item in pairs(difficultyToAbilityStatOverridesMap) do
		if not (typeof(k) == "string" and k ~= "") then
			continue
		end

		if item == "$delete" then
			if typeof(enemyConfig.DifficultyToAbilityStatOverridesMap) == "table" then
				enemyConfig.DifficultyToAbilityStatOverridesMap[k] = nil
				table.insert(list, `{p}.{k} = (removed)`)
			end
		elseif typeof(item) == "table" then
			if typeof(enemyConfig.DifficultyToAbilityStatOverridesMap) ~= "table" then
				enemyConfig.DifficultyToAbilityStatOverridesMap = {}
			end

			local v2 = enemyConfig.DifficultyToAbilityStatOverridesMap[k]

			if typeof(v2) ~= "table" then
				v2 = {}
				enemyConfig.DifficultyToAbilityStatOverridesMap[k] = v2
			end

			for k2, v3 in pairs(item) do
				if not (typeof(k2) == "string" and k2 ~= "") then
					continue
				end

				if v3 == "$delete" then
					if v2[k2] ~= nil then
						v2[k2] = nil
						table.insert(list, `{p}.{k}.{k2} = (removed)`)
					end
				elseif typeof(v3) == "table" then
					local v4 = v2[k2]

					if typeof(v4) ~= "table" then
						if enemyAbilityNameSet[k2] then
							v4 = {}
							v2[k2] = v4
						else
							warn(`[ConfigDashboard] Ignored {p}.{k}.{k2}: not one of the enemy's abilities`)
							continue
						end
					end

					ApplyFields(v4, Schema.EnemyAbilityStatOverrides, v3, `{p}.{k}.{k2}`, list)
				end
			end

			if next(v2) == nil then
				enemyConfig.DifficultyToAbilityStatOverridesMap[k] = nil
			end
		end
	end

	if
		typeof(enemyConfig.DifficultyToAbilityStatOverridesMap) == "table"
		and next(enemyConfig.DifficultyToAbilityStatOverridesMap) == nil
	then
		enemyConfig.DifficultyToAbilityStatOverridesMap = nil
	end
end

local function ApplyEnemies(enemies, p)
	for k, item in pairs(enemies) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasEnemyConfig(k) then
			local enemyConfig = ResourceManager.GetEnemyConfig(k)
			ApplyFields(enemyConfig, Schema.Enemy, item, `Enemy[{k}]`, p)
			ApplyFields(enemyConfig, Schema.EnemyPVP, item, `Enemy[{k}]`, p)
			ApplyAttackList(enemyConfig.AttackData, item.AttackData, `Enemy[{k}]`, p)
			ApplyDeathSpawnList(enemyConfig.DeathSpawnData, item.DeathSpawnData, `Enemy[{k}]`, p)
			ApplyResistances(enemyConfig, item.DamageReductions, `Enemy[{k}]`, p)
			ApplyAdditionalStats(enemyConfig, item.PlayerCountToAdditionalStatsMap, `Enemy[{k}]`, p)
			ApplyAbilityStatOverrides(enemyConfig, item.DifficultyToAbilityStatOverridesMap, `Enemy[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown enemy "{k}"`)
		end
	end
end

local function ApplyPathEntities(pathEntities, p)
	for k, item in pairs(pathEntities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasPathEntityConfig(k) then
			local pathEntityConfig = ResourceManager.GetPathEntityConfig(k)
			ApplyFields(pathEntityConfig, Schema.PathEntity, item, `PathEntity[{k}]`, p)
			ApplyAttackList(pathEntityConfig.AttackData, item.AttackData, `PathEntity[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown path entity "{k}"`)
		end
	end
end

local function ApplyStaticEntities(staticEntities, p)
	for k, item in pairs(staticEntities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasStaticEntityConfig(k) then
			local staticEntityConfig = ResourceManager.GetStaticEntityConfig(k)
			ApplyFields(staticEntityConfig, Schema.StaticEntity, item, `StaticEntity[{k}]`, p)

			if typeof(item.HitData) == "table" and typeof(staticEntityConfig.HitData) == "table" then
				ApplyFields(
					staticEntityConfig.HitData,
					Schema.AbilityProjectileHit,
					item.HitData,
					`StaticEntity[{k}].HitData`,
					p
				)
			end

			if typeof(item.MultiHealData) == "table" and typeof(staticEntityConfig.MultiHealData) == "table" then
				ApplyFields(
					staticEntityConfig.MultiHealData,
					Schema.MultiHealData,
					item.MultiHealData,
					`StaticEntity[{k}].MultiHealData`,
					p
				)
			end

			ApplyAttackList(staticEntityConfig.AttackData, item.AttackData, `StaticEntity[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown static entity "{k}"`)
		end
	end
end

local function ApplyMapEntityStatOverrides(mapEntityConfig, difficultyToStatOverrideMap, p: string, list)
	if typeof(difficultyToStatOverrideMap) ~= "table" then
		return
	end

	for k, item in pairs(difficultyToStatOverrideMap) do
		if not (typeof(k) == "string" and k ~= "") then
			continue
		end

		if item == "$delete" then
			if typeof(mapEntityConfig.DifficultyToStatOverrideMap) == "table" then
				mapEntityConfig.DifficultyToStatOverrideMap[k] = nil
				table.insert(list, `{p}.Difficulty.{k} = (removed)`)
			end
		elseif typeof(item) == "table" then
			if typeof(mapEntityConfig.DifficultyToStatOverrideMap) ~= "table" then
				mapEntityConfig.DifficultyToStatOverrideMap = {}
			end

			local v2 = mapEntityConfig.DifficultyToStatOverrideMap[k]

			if typeof(v2) ~= "table" then
				v2 = {}
				mapEntityConfig.DifficultyToStatOverrideMap[k] = v2
			end

			ApplyFields(v2, Schema.MapEntityStatOverrides, item, `{p}.Difficulty.{k}`, list)

			if next(v2) == nil then
				mapEntityConfig.DifficultyToStatOverrideMap[k] = nil
			end
		end
	end

	if
		typeof(mapEntityConfig.DifficultyToStatOverrideMap) == "table"
		and next(mapEntityConfig.DifficultyToStatOverrideMap) == nil
	then
		mapEntityConfig.DifficultyToStatOverrideMap = nil
	end
end

local function ApplyMapEntities(mapEntities, p)
	for k, item in pairs(mapEntities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasMapEntityConfig(k) then
			local mapEntityConfig = ResourceManager.GetMapEntityConfig(k)
			ApplyFields(mapEntityConfig, Schema.MapEntity, item, `MapEntity[{k}]`, p)
			ApplyAttackList(mapEntityConfig.AttackData, item.AttackData, `MapEntity[{k}]`, p)
			ApplyMapEntityStatOverrides(mapEntityConfig, item.DifficultyToStatOverrideMap, `MapEntity[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown map entity "{k}"`)
		end
	end
end

local function ApplyBuffs(items, callback, callback2, p, p2: string, p3)
	for k, item in pairs(items) do
		if typeof(item) ~= "table" then
			continue
		end

		if callback(k) then
			ApplyFields(callback2(k), p, item, `{p2}[{k}]`, p3)
		else
			warn(`[ConfigDashboard] Ignored unknown {p2} "{k}"`)
		end
	end
end

local ApplyNode

local function ApplyEditableList(p, data, items, p2: string, list)
	local field = data.Field
	local v2 = p[field]

	if typeof(v2) ~= "table" then
		v2 = {}
		p[field] = v2
	end

	local v3 = {}
	local v4 = {}

	for k, item in pairs(items) do
		local v5 = tonumber(k)

		if item == "$delete" then
			if v5 and v2[v5] then
				table.insert(v4, v5)
			end
		elseif typeof(item) == "table" then
			if v5 and v2[v5] then
				ApplyNode(v2[v5], data, item, `{p2}[{tostring(k)}]`, list)
			elseif v5 then
				table.insert(v3, k)
			else
				warn(`[ConfigDashboard] Ignored non-numeric key {p2}[{tostring(k)}]`)
			end
		end
	end

	table.sort(v4, function(a, b)
		return b < a
	end)

	for _, v5 in ipairs(v4) do
		table.remove(v2, v5)
		table.insert(list, `{p2}[{v5}] = removed`)
	end

	table.sort(v3, function(a, b)
		return (tonumber(a) or 0) < (tonumber(b) or 0)
	end)

	for _, v5 in ipairs(v3) do
		local formatted = `{p2}.New[{tostring(v5)}]`
		local v6 = {}

		if data.Fields then
			ApplyFields(v6, data.Fields, items[v5], formatted, {})
		end

		local v7 = data.Finalize and data.Finalize(v6, v2)

		if v7 then
			warn(`[ConfigDashboard] {formatted}: {v7}; ignored`)
		else
			table.insert(v2, v6)
			table.insert(list, `{p2} = added entry`)
		end
	end

	if next(v2) == nil then
		p[field] = nil
	end
end

ApplyNode = function(p, p2, item, p3: string, p4)
	if p2.Fields then
		ApplyFields(p, p2.Fields, item, p3, p4)
	end

	for k, v2 in pairs(p2.Children or {}) do
		local v3 = item[k]

		if typeof(v3) ~= "table" then
			continue
		end

		local v4 = v2.Field and p[v2.Field]

		if v2.List and v2.Editable then
			ApplyEditableList(p, v2, v3, `{p3}.{k}`, p4)
		elseif v2.List then
			for k2, v5 in pairs(v3) do
				if typeof(v5) ~= "table" then
					continue
				end

				local v6 = tonumber(k2)

				if v6 then
					if typeof(v4) == "table" then
						v6 = v4[v6]
					else
						v6 = false
					end
				end

				if v6 then
					ApplyNode(v6, v2, v5, `{p3}.{k}[{tostring(k2)}]`, p4)
				else
					warn(`[ConfigDashboard] Ignored unknown {p3}.{k}[{tostring(k2)}]`)
				end
			end
		elseif typeof(v4) == "table" then
			ApplyNode(v4, v2, v3, `{p3}.{k}`, p4)
		end
	end
end

local function ApplyAbilities(abilities, p)
	for k, item in pairs(abilities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasEnemyAbilityConfig(k) then
			ApplyNode(ResourceManager.GetEnemyAbilityConfig(k), Schema.AbilityShape, item, `Ability[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown ability "{k}"`)
		end
	end
end

local function ApplyPathEntityAbilities(pathEntityAbilities, p)
	for k, item in pairs(pathEntityAbilities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasPathEntityAbilityConfig(k) then
			ApplyNode(
				ResourceManager.GetPathEntityAbilityConfig(k),
				Schema.PathEntityAbilityShape,
				item,
				`PathEntityAbility[{k}]`,
				p
			)
		else
			warn(`[ConfigDashboard] Ignored unknown path entity ability "{k}"`)
		end
	end
end

local function ApplyTowerAbilities(towerAbilities, p)
	for k, item in pairs(towerAbilities) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasTowerAbilityConfig(k) then
			local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(k)
			ApplyFields(towerAbilityConfig, Schema.TowerAbility, item, `TowerAbility[{k}]`, p)

			if
				typeof(item.ProjectileHitData) == "table"
				and typeof(towerAbilityConfig.ProjectileHitData) == "table"
			then
				ApplyFields(
					towerAbilityConfig.ProjectileHitData,
					Schema.AbilityProjectileHit,
					item.ProjectileHitData,
					`TowerAbility[{k}].ProjectileHitData`,
					p
				)
			end

			if
				typeof(item.MainAttackOverrideData) == "table"
				and typeof(towerAbilityConfig.MainAttackOverrideData) == "table"
			then
				ApplyFields(
					towerAbilityConfig.MainAttackOverrideData,
					Schema.TowerAbilityMainAttack,
					item.MainAttackOverrideData,
					`TowerAbility[{k}].MainAttackOverrideData`,
					p
				)
			end

			if typeof(item.ApplyBurnStats) == "table" and typeof(towerAbilityConfig.ApplyBurnStats) == "table" then
				ApplyFields(
					towerAbilityConfig.ApplyBurnStats,
					Schema.TowerApplyBurn,
					item.ApplyBurnStats,
					`TowerAbility[{k}].ApplyBurnStats`,
					p
				)
			end

			ApplyNode(towerAbilityConfig, Schema.TowerAbilityShape, item, `TowerAbility[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown tower ability "{k}"`)
		end
	end
end

local function ApplyTowerLevels(p, items, p2: string, p3)
	if typeof(p) ~= "table" or typeof(items) ~= "table" then
		return
	end

	for k, item in pairs(items) do
		if typeof(item) ~= "table" then
			continue
		end

		local v2 = tonumber(k)
		local v3 = v2 and p[v2]

		if v3 then
			ApplyFields(v3, Schema.TowerUpgradeStats, item, `{p2}[{tostring(k)}]`, p3)
			ApplySpawnEntries(v3, "AddSpawnPathEntityData", item.AddSpawnPathEntityData, `{p2}[{tostring(k)}]`, p3)
			ApplyRemoveSpawnNames(v3, item.RemoveSpawnPathEntityNames, `{p2}[{tostring(k)}]`, p3)

			if typeof(item.BurnEffectStats) == "table" and typeof(v3.BurnEffectStats) == "table" then
				ApplyFields(
					v3.BurnEffectStats,
					Schema.TowerBurnEffect,
					item.BurnEffectStats,
					`{p2}[{tostring(k)}].Burn`,
					p3
				)
			end

			if typeof(item.ApplyBurnStats) == "table" and typeof(v3.ApplyBurnStats) == "table" then
				ApplyFields(
					v3.ApplyBurnStats,
					Schema.TowerApplyBurn,
					item.ApplyBurnStats,
					`{p2}[{tostring(k)}].ApplyBurn`,
					p3
				)
			end
		else
			warn(`[ConfigDashboard] Ignored unknown {p2}[{tostring(k)}]`)
		end
	end
end

local function ApplyPlayerCountEntries(list, items, p, p2: string, p3: string, list2)
	local v2 = {}
	local v3 = {}

	for k, item in pairs(items) do
		local v4 = tonumber(k)

		if v4 and not (v4 < 1) and not (v4 > 4) and v4 % 1 == 0 then
			if item == "$delete" then
				if list[v4] ~= nil then
					table.insert(v3, v4)
				end
			elseif list[v4] == nil then
				table.insert(v2, k)
			else
				local coerce, v5 = Schema.Coerce(p, item)

				if coerce then
					list[v4] = v5
					table.insert(list2, `{p3}.{p2}[{v4}] = {tostring(v5)}`)
				else
					warn(`[ConfigDashboard] Ignored {p3}.{p2}[{v4}]: {tostring(v5)}`)
				end
			end
		else
			warn(`[ConfigDashboard] Ignored invalid {p3} player count [{tostring(k)}]`)
		end
	end

	table.sort(v3, function(a, b)
		return b < a
	end)

	for _, v4 in ipairs(v3) do
		table.remove(list, v4)
		table.insert(list2, `{p3}.{p2}[{v4}] = (removed)`)
	end

	table.sort(v2, function(a, b)
		return (tonumber(a) or 0) < (tonumber(b) or 0)
	end)

	for _, v4 in ipairs(v2) do
		if #list >= 4 then
			warn(`[ConfigDashboard] {p3}.{p2} is capped at 4 player counts`)
			break
		end

		local coerce, v5 = Schema.Coerce(p, items[v4])

		if coerce then
			table.insert(list, v5)
			table.insert(list2, `{p3}.{p2}[{#list}] = {tostring(v5)} (added)`)
		else
			warn(`[ConfigDashboard] Ignored new {p3}.{p2}[{tostring(v4)}]: {tostring(v5)}`)
		end
	end
end

local function ApplyLimitEntries(p, p2, p3: string, p4) -- 2 equivalent calls inferred from this helper
	ApplyPlayerCountEntries(p, p2, Schema.TowerLimitValue, "Limit", p3, p4)
end

local function ApplyLimitMap(towerConfig, limitMap, formatted: string, p)
	if typeof(limitMap) ~= "table" then
		return
	end

	towerConfig.LimitMap = towerConfig.LimitMap or {}
	ApplyLimitEntries(towerConfig.LimitMap, limitMap, formatted, p) -- inferred equivalent call

	if next(towerConfig.LimitMap) == nil then
		towerConfig.LimitMap = nil
	end
end

local function ApplyDifficultyLimitMapOverride(towerConfig, difficultyToLimitMapOverride, formatted: string, list)
	if typeof(difficultyToLimitMapOverride) ~= "table" then
		return
	end

	for k, item in pairs(difficultyToLimitMapOverride) do
		if not (typeof(k) == "string" and k ~= "") then
			continue
		end

		if item == "$delete" then
			if typeof(towerConfig.DifficultyToLimitMapOverride) == "table" then
				towerConfig.DifficultyToLimitMapOverride[k] = nil
				table.insert(list, `{formatted}.LimitOverride.{k} = (removed)`)
			end
		elseif typeof(item) == "table" then
			if typeof(towerConfig.DifficultyToLimitMapOverride) ~= "table" then
				towerConfig.DifficultyToLimitMapOverride = {}
			end

			local v2 = towerConfig.DifficultyToLimitMapOverride[k]

			if typeof(v2) ~= "table" then
				v2 = {}
				towerConfig.DifficultyToLimitMapOverride[k] = v2
			end

			ApplyLimitEntries(v2, item, `{formatted}.LimitOverride.{k}`, list) -- inferred equivalent call

			if next(v2) == nil then
				towerConfig.DifficultyToLimitMapOverride[k] = nil
			end
		end
	end

	if
		typeof(towerConfig.DifficultyToLimitMapOverride) == "table"
		and next(towerConfig.DifficultyToLimitMapOverride) == nil
	then
		towerConfig.DifficultyToLimitMapOverride = nil
	end
end

local function ApplyTowers(towers, p)
	for k, item in pairs(towers) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasTowerConfig(k) then
			local towerConfig = ResourceManager.GetTowerConfig(k)
			local upgradePathData = towerConfig and towerConfig.UpgradePathData

			if typeof(upgradePathData) == "table" then
				local formatted = `Tower[{k}]`
				ApplyFields(towerConfig, Schema.TowerConfigTop, item, formatted, p)
				ApplyLimitMap(towerConfig, item.LimitMap, formatted, p)
				ApplyDifficultyLimitMapOverride(towerConfig, item.DifficultyToLimitMapOverride, formatted, p)

				if typeof(item.Base) == "table" and typeof(upgradePathData.BaseLevelData) == "table" then
					ApplyFields(upgradePathData.BaseLevelData, Schema.TowerBaseStats, item.Base, `{formatted}.Base`, p)
					ApplySpawnEntries(
						upgradePathData.BaseLevelData,
						"SpawnPathEntityData",
						item.Base.SpawnPathEntityData,
						`{formatted}.Base`,
						p
					)

					if
						typeof(item.Base.BurnEffectStats) == "table"
						and typeof(upgradePathData.BaseLevelData.BurnEffectStats) == "table"
					then
						ApplyFields(
							upgradePathData.BaseLevelData.BurnEffectStats,
							Schema.TowerBurnEffect,
							item.Base.BurnEffectStats,
							`{formatted}.Base.Burn`,
							p
						)
					end

					if
						typeof(item.Base.ApplyBurnStats) == "table"
						and typeof(upgradePathData.BaseLevelData.ApplyBurnStats) == "table"
					then
						ApplyFields(
							upgradePathData.BaseLevelData.ApplyBurnStats,
							Schema.TowerApplyBurn,
							item.Base.ApplyBurnStats,
							`{formatted}.Base.ApplyBurn`,
							p
						)
					end
				end

				ApplyTowerLevels(upgradePathData.Path1Data, item.Path1, `{formatted}.Path1`, p)
				ApplyTowerLevels(upgradePathData.Path2Data, item.Path2, `{formatted}.Path2`, p)
			else
				warn(`[ConfigDashboard] Tower "{k}" has no UpgradePathData; ignored`)
			end
		else
			warn(`[ConfigDashboard] Ignored unknown tower "{k}"`)
		end
	end
end

local function BuildSequence(p, p2: string)
	local v2 = {}
	ApplyFields(v2, Schema.Sequence, p, p2, {})

	if typeof(v2.EnemyType) ~= "string" then
		warn(`[ConfigDashboard] {p2}: new spawn sequence needs a valid EnemyType; ignored`)
		return nil
	end

	v2.StartDelay = v2.StartDelay or 0
	v2.Count = v2.Count or 1
	v2.Interval = v2.Interval or 1
	return v2
end

local function ApplySequences(p, spawnSequences, p2: string, list)
	if typeof(spawnSequences) ~= "table" then
		return
	end

	p.SpawnSequences = p.SpawnSequences or {}
	local spawnSequences2 = p.SpawnSequences
	local v2 = {}
	local v3 = {}

	for k, item in pairs(spawnSequences) do
		local v4 = tonumber(k)

		if item == "$delete" then
			if v4 and spawnSequences2[v4] then
				table.insert(v3, v4)
			end
		elseif typeof(item) == "table" then
			if v4 and spawnSequences2[v4] then
				ApplyFields(spawnSequences2[v4], Schema.Sequence, item, `{p2}.Seq[{tostring(k)}]`, list)
			elseif v4 then
				table.insert(v2, k)
			else
				warn(`[ConfigDashboard] Ignored non-numeric sequence key {p2}[{tostring(k)}]`)
			end
		end
	end

	table.sort(v3, function(a, b)
		return b < a
	end)

	for _, v4 in ipairs(v3) do
		table.remove(spawnSequences2, v4)
		table.insert(list, `{p2}.Seq[{v4}] = removed`)
	end

	table.sort(v2, function(a, b)
		return (tonumber(a) or 0) < (tonumber(b) or 0)
	end)

	for _, v4 in ipairs(v2) do
		local sequence = BuildSequence(spawnSequences[v4], `{p2}.NewSeq[{tostring(v4)}]`)

		if not sequence then
			continue
		end

		table.insert(spawnSequences2, sequence)
		table.insert(list, `{p2} = added {sequence.EnemyType} x{sequence.Count}`)
	end
end

local function BuildWave(p, formatted: string, list)
	local v2 = {}
	ApplyFields(v2, Schema.WaveEntry, p, formatted, {})
	v2.CashBonus = v2.CashBonus or 0
	v2.SpawnSequences = {}
	ApplySequences(v2, p.SpawnSequences, formatted, list)
	return v2
end

local function ApplyStartingCashMap(waveConfig, playerCountToStartingCashMap, p: string, list)
	if typeof(playerCountToStartingCashMap) ~= "table" then
		return
	end

	waveConfig.PlayerCountToStartingCashMap = waveConfig.PlayerCountToStartingCashMap or {}
	ApplyPlayerCountEntries(
		waveConfig.PlayerCountToStartingCashMap,
		playerCountToStartingCashMap,
		Schema.WaveStartingCashValue,
		"StartingCash",
		p,
		list
	)

	if next(waveConfig.PlayerCountToStartingCashMap) == nil then
		waveConfig.PlayerCountToStartingCashMap = nil
	elseif waveConfig.StartingCash ~= nil then
		waveConfig.StartingCash = nil
		table.insert(list, `{p}.StartingCash = (removed, superseded by the player count map)`)
	end
end

local function GuardStartingCash(waveConfig, p: string, list)
	local playerCountToStartingCashMap = waveConfig.PlayerCountToStartingCashMap

	if
		waveConfig.StartingCash ~= nil
		or typeof(playerCountToStartingCashMap) == "table" and next(playerCountToStartingCashMap) ~= nil
	then
		return
	end

	waveConfig.StartingCash = 0
	warn(`[ConfigDashboard] {p} was left with no starting cash source; defaulting StartingCash to 0`)
	table.insert(list, `{p}.StartingCash = 0 (no source set)`)
end

local function ApplyCashPerDamage(waveConfig, cashPerDamageData, p: string, list)
	if typeof(cashPerDamageData) ~= "table" or typeof(waveConfig.CashPerDamageData) ~= "table" then
		return
	end

	for k, item in pairs(cashPerDamageData) do
		if typeof(item) ~= "table" then
			continue
		end

		local v2 = tonumber(k)
		local v3 = v2 and waveConfig.CashPerDamageData[v2]

		if typeof(v3) == "table" then
			ApplyFields(v3, Schema.WaveCashPerDamage, item, `{p}.CashPerDamage[{tostring(k)}]`, list)
		else
			warn(`[ConfigDashboard] Ignored unknown {p}.CashPerDamage[{tostring(k)}]`)
		end
	end
end

local function ApplyTowerCostMultipliers(waveConfig, towerCostMultiplierMap, p: string, list)
	if typeof(towerCostMultiplierMap) ~= "table" then
		return
	end

	for k, item in pairs(towerCostMultiplierMap) do
		if typeof(k) ~= "string" then
			continue
		end

		local towerCostMultiplierMap2 = waveConfig.TowerCostMultiplierMap

		if item == "$delete" then
			if typeof(towerCostMultiplierMap2) == "table" and towerCostMultiplierMap2[k] ~= nil then
				towerCostMultiplierMap2[k] = nil
				table.insert(list, `{p}.TowerCostMultiplier[{k}] = (removed)`)
			end
		elseif ResourceManager.HasTowerConfig(k) then
			local coerce, v2 = Schema.Coerce(Schema.WaveTowerCostMultiplier, item)

			if coerce then
				if typeof(towerCostMultiplierMap2) ~= "table" then
					towerCostMultiplierMap2 = {}
					waveConfig.TowerCostMultiplierMap = towerCostMultiplierMap2
				end

				towerCostMultiplierMap2[k] = v2
				table.insert(list, `{p}.TowerCostMultiplier[{k}] = {tostring(v2)}`)
			else
				warn(`[ConfigDashboard] Ignored {p}.TowerCostMultiplier[{k}]: {tostring(v2)}`)
			end
		else
			warn(`[ConfigDashboard] Ignored {p}.TowerCostMultiplier for unknown tower {k}`)
		end
	end

	if typeof(waveConfig.TowerCostMultiplierMap) == "table" and next(waveConfig.TowerCostMultiplierMap) == nil then
		waveConfig.TowerCostMultiplierMap = nil
	end
end

local function ApplyWaves(waves, list)
	for k, item in pairs(waves) do
		if typeof(item) ~= "table" then
			continue
		end

		local waveConfig = ResourceManager.GetWaveConfig(k)

		if not waveConfig then
			continue
		end

		ApplyFields(waveConfig, Schema.WaveTop, item, `Waves[{k}]`, list)
		ApplyStartingCashMap(waveConfig, item.PlayerCountToStartingCashMap, `Waves[{k}]`, list)
		GuardStartingCash(waveConfig, `Waves[{k}]`, list)
		ApplyCashPerDamage(waveConfig, item.CashPerDamageData, `Waves[{k}]`, list)
		ApplyTowerCostMultipliers(waveConfig, item.TowerCostMultiplierMap, `Waves[{k}]`, list)
		local waves2 = item.Waves

		if typeof(waves2) ~= "table" then
			continue
		end

		waveConfig.Waves = waveConfig.Waves or {}
		local waves3 = waveConfig.Waves
		local v2 = {}
		local v3 = {}

		for k2, wave in pairs(waves2) do
			local v4 = tonumber(k2)

			if wave == "$delete" then
				if v4 and waves3[v4] then
					table.insert(v3, v4)
				end
			elseif typeof(wave) == "table" then
				if v4 and waves3[v4] then
					ApplyFields(waves3[v4], Schema.WaveEntry, wave, `Waves[{k}].Wave[{tostring(k2)}]`, list)
					ApplySequences(waves3[v4], wave.SpawnSequences, `Waves[{k}].Wave[{tostring(k2)}]`, list)
				elseif v4 then
					table.insert(v2, k2)
				else
					warn(`[ConfigDashboard] Ignored non-numeric wave key {k}[{tostring(k2)}]`)
				end
			end
		end

		table.sort(v3, function(a, b)
			return b < a
		end)

		for _, v4 in ipairs(v3) do
			table.remove(waves3, v4)
			table.insert(list, `Waves[{k}].Wave[{v4}] = removed`)
		end

		table.sort(v2, function(a, b)
			return (tonumber(a) or 0) < (tonumber(b) or 0)
		end)

		for _, v4 in ipairs(v2) do
			local formatted = `Waves[{k}].NewWave[{tostring(v4)}]`
			table.insert(waves3, (BuildWave(waves2[v4], formatted, list)))
			table.insert(list, `{formatted} = added wave (now #{#waves3})`)
		end
	end
end

local function ApplyPowerUpConfig(p, item, p2: string, p3)
	ApplyFields(p, Schema.PowerUp, item, p2, p3)

	if typeof(item.Attacks) == "table" and typeof(p.Attacks) == "table" then
		for k, attack in pairs(item.Attacks) do
			local attack2 = p.Attacks[k]

			if typeof(attack) ~= "table" then
				continue
			end

			if typeof(attack2) == "table" then
				ApplyFields(attack2, Schema.PowerUpAttack, attack, `{p2}.Attack[{k}]`, p3)
			else
				warn(`[ConfigDashboard] Ignored unknown {p2}.Attack[{tostring(k)}]`)
			end
		end
	end
end

local function GetLiveRegularPowerUp(p: string)
	local success, config = pcall(PowerUpsConfigHandler.GetConfig, p)

	if success and typeof(config) == "table" then
		return config
	end

	return nil
end

local function ApplyPowerUps(powerUps, p)
	for k, item in pairs(powerUps) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasRegularPowerUpConfig(k) then
			local regularPowerUpConfig = ResourceManager.GetRegularPowerUpConfig(k)
			ApplyPowerUpConfig(regularPowerUpConfig, item, `PowerUp[{k}]`, p)
			local success, config = pcall(PowerUpsConfigHandler.GetConfig, k)

			if not success or typeof(config) ~= "table" then
				config = nil
			end

			if config and config ~= regularPowerUpConfig then
				ApplyPowerUpConfig(config, item, `PowerUp[{k}](live)`, {})
			end
		else
			warn(`[ConfigDashboard] Ignored unknown power-up "{k}"`)
		end
	end
end

local function ApplyCustomPowerUps(customPowerUps, p)
	for k, item in pairs(customPowerUps) do
		if typeof(item) ~= "table" then
			continue
		end

		if ResourceManager.HasCustomPowerUpConfig(k) then
			ApplyPowerUpConfig(ResourceManager.GetCustomPowerUpConfig(k), item, `CustomPowerUp[{k}]`, p)
		else
			warn(`[ConfigDashboard] Ignored unknown custom power-up "{k}"`)
		end
	end
end

local function ApplyEconomy(economy, p) -- 1 equivalent call inferred from this helper
	ApplyFields(PVPEconomyConfig, Schema.Economy, economy, "Economy", p)
end

local function ResolvePayloadConfigs(data)
	local v2 = {}

	local function Add(p) -- 5 equivalent calls inferred from this helper
		if typeof(p) == "table" then
			table.insert(v2, p)
		end
	end

	local function Section(items, callback, callback2)
		if typeof(items) ~= "table" then
			return
		end

		for k in pairs(items) do
			if typeof(k) == "string" and callback(k) then
				Add(callback2(k)) -- inferred equivalent call
			end
		end
	end

	Section(data.Enemies, ResourceManager.HasEnemyConfig, ResourceManager.GetEnemyConfig)
	Section(data.Abilities, ResourceManager.HasEnemyAbilityConfig, ResourceManager.GetEnemyAbilityConfig)
	Section(
		data.PathEntityAbilities,
		ResourceManager.HasPathEntityAbilityConfig,
		ResourceManager.GetPathEntityAbilityConfig
	)
	Section(data.Towers, ResourceManager.HasTowerConfig, ResourceManager.GetTowerConfig)
	Section(data.TowerAbilities, ResourceManager.HasTowerAbilityConfig, ResourceManager.GetTowerAbilityConfig)
	Section(data.PathEntities, ResourceManager.HasPathEntityConfig, ResourceManager.GetPathEntityConfig)
	Section(data.StaticEntities, ResourceManager.HasStaticEntityConfig, ResourceManager.GetStaticEntityConfig)
	Section(data.MapEntities, ResourceManager.HasMapEntityConfig, ResourceManager.GetMapEntityConfig)
	Section(data.TowerBuffs, ResourceManager.HasTowerBuffConfig, ResourceManager.GetTowerBuffConfig)
	Section(data.EnemyBuffs, ResourceManager.HasEnemyBuffConfig, ResourceManager.GetEnemyBuffConfig)
	Section(data.CustomPowerUps, ResourceManager.HasCustomPowerUpConfig, ResourceManager.GetCustomPowerUpConfig)

	if typeof(data.PowerUps) == "table" then
		for k in pairs(data.PowerUps) do
			if not (typeof(k) == "string" and ResourceManager.HasRegularPowerUpConfig(k)) then
				continue
			end

			Add(ResourceManager.GetRegularPowerUpConfig(k)) -- inferred equivalent call
			local success, config = pcall(PowerUpsConfigHandler.GetConfig, k)

			if not success or typeof(config) ~= "table" then
				config = nil
			end

			Add(config) -- inferred equivalent call
		end
	end

	if typeof(data.Waves) == "table" then
		for k in pairs(data.Waves) do
			if typeof(k) == "string" then
				Add(ResourceManager.GetWaveConfig(k)) -- inferred equivalent call
			end
		end
	end

	if typeof(data.Economy) == "table" then
		Add(PVPEconomyConfig) -- inferred equivalent call
	end

	return v2
end

local function RestoreBaselineForPayload(data)
	for _, v2 in ipairs((ResolvePayloadConfigs(data))) do
		if v[v2] == nil then
			v[v2] = DeepCopy(v2)
		end
	end

	for k, v2 in pairs(v) do
		DeepRestore(k, v2)
	end
end

function Applier.Apply(data)
	local v2 = {}

	if typeof(data) ~= "table" then
		warn("[ConfigDashboard] Payload was not a table; nothing applied")
		return v2
	end

	RestoreBaselineForPayload(data)

	if typeof(data.Enemies) == "table" then
		ApplyEnemies(data.Enemies, v2)
	end

	if typeof(data.Abilities) == "table" then
		ApplyAbilities(data.Abilities, v2)
	end

	if typeof(data.PathEntityAbilities) == "table" then
		ApplyPathEntityAbilities(data.PathEntityAbilities, v2)
	end

	if typeof(data.Towers) == "table" then
		ApplyTowers(data.Towers, v2)
	end

	if typeof(data.TowerAbilities) == "table" then
		ApplyTowerAbilities(data.TowerAbilities, v2)
	end

	if typeof(data.PathEntities) == "table" then
		ApplyPathEntities(data.PathEntities, v2)
	end

	if typeof(data.StaticEntities) == "table" then
		ApplyStaticEntities(data.StaticEntities, v2)
	end

	if typeof(data.MapEntities) == "table" then
		ApplyMapEntities(data.MapEntities, v2)
	end

	if typeof(data.TowerBuffs) == "table" then
		ApplyBuffs(
			data.TowerBuffs,
			ResourceManager.HasTowerBuffConfig,
			ResourceManager.GetTowerBuffConfig,
			Schema.TowerBuff,
			"TowerBuff",
			v2
		)
	end

	if typeof(data.EnemyBuffs) == "table" then
		ApplyBuffs(
			data.EnemyBuffs,
			ResourceManager.HasEnemyBuffConfig,
			ResourceManager.GetEnemyBuffConfig,
			Schema.EnemyBuff,
			"EnemyBuff",
			v2
		)
	end

	if typeof(data.PowerUps) == "table" then
		ApplyPowerUps(data.PowerUps, v2)
	end

	if typeof(data.CustomPowerUps) == "table" then
		ApplyCustomPowerUps(data.CustomPowerUps, v2)
	end

	if typeof(data.Waves) == "table" then
		ApplyWaves(data.Waves, v2)
	end

	if typeof(data.Economy) == "table" then
		ApplyEconomy(data.Economy, v2) -- inferred equivalent call
	end

	return v2
end

return Applier