local TroopDetailsUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))

local function FormatNumber(p: number) -- 11 equivalent calls inferred from this helper
	if p == math.floor(p) then
		return (tostring(p))
	end

	return (string.format("%.2f", p):gsub("0+$", ""))
end

local function FormatDamage(p: number) -- 4 equivalent calls inferred from this helper
	return FormatNumber(math.round(p * 10) / 10) -- inferred equivalent call
end

local function Tag(value: string, value2: string?)
	return {
		Text = string.upper(value),
		Kind = value2 or "Effect"
	}
end

local function RangeTag(range: number) -- 2 equivalent calls inferred from this helper
	local formatted = `RANGE {FormatNumber(range)}` -- inferred equivalent call
	return { Text = string.upper(formatted), Kind = "Limit" }
end

local function IgnoresResistance(damageType: string?, ignoreResistance: boolean?) -- 2 equivalent calls inferred from this helper
	if ignoreResistance == true then
		return true
	elseif damageType == nil then
		return false
	else
		return string.find(damageType, "IgnoreResistance", 1, true) ~= nil
	end
end

local function AddDamageDataTags(list, damageData)
	if not damageData then
		return
	end

	local stunData = damageData.StunData

	if stunData then
		local formatted = `STUN {FormatNumber(stunData.StunDuration)}S` -- inferred equivalent call
		table.insert(list, { Text = string.upper(formatted), Kind = "Effect" })

		if stunData.CanStunBoss then
			table.insert(list, { Text = string.upper("STUNS BOSSES"), Kind = "Effect" })
		end
	end

	if damageData.KnockbackData then
		local formatted = `KNOCKBACK {FormatNumber(damageData.KnockbackData.KnockbackStuds)}` -- inferred equivalent call
		table.insert(list, { Text = string.upper(formatted), Kind = "Effect" })
	end

	if damageData.BurnDamageData then
		local formatted = `BURN {FormatNumber(damageData.BurnDamageData.DamagePerSecond)} DPS` -- inferred equivalent call
		table.insert(list, { Text = string.upper(formatted), Kind = "Effect" })
	end

	if damageData.SlowdownData then
		local formatted = `SLOW {FormatNumber(math.round(100 * damageData.SlowdownData.Percentage))}%` -- inferred equivalent call
		table.insert(list, { Text = string.upper(formatted), Kind = "Effect" })
	end

	if damageData.IceDamageData then
		table.insert(list, { Text = string.upper("CHILLS"), Kind = "Effect" })
	end
end

local function GetAbilityDisplayName(value: string, pathEntityAbilityConfig) -- 1 equivalent call inferred from this helper
	if pathEntityAbilityConfig.DisplayName then
		return pathEntityAbilityConfig.DisplayName
	end

	return string.match(value, "([^_]+)$") or value
end

local function GetAttackRows(p, p2: number)
	local result = {}
	local attackData = p.AttackData

	if not attackData then
		return result
	end

	for i, v in ipairs(attackData) do
		local description = v.Description or #attackData == 1 and "Main Attack" or `Attack {i}`
		local damageText = FormatDamage(p2 * v.Damage) -- inferred equivalent call

		if v.IsBurst and v.BurstSize and v.BurstSize > 1 then
			damageText = `{damageText} ×{v.BurstSize}`
		end

		local tags = {}

		if v.IsSplash and v.SplashRadius then
			local formatted = `SPLASH {FormatNumber(v.SplashRadius)}` -- inferred equivalent call
			table.insert(tags, { Text = string.upper(formatted), Kind = "Effect" })
		end

		if v.IsPiercing and v.PierceCount then
			local formatted = `PIERCE {v.PierceCount}`
			table.insert(tags, { Text = string.upper(formatted), Kind = "Effect" })
		end

		if IgnoresResistance(v.DamageType, v.IgnoreResistance) then -- inferred equivalent call
			table.insert(tags, { Text = string.upper("IGNORES RESIST"), Kind = "Effect" })
		end

		if v.CanTargetAir then
			table.insert(tags, { Text = string.upper("HITS AIR"), Kind = "Effect" })
		end

		local range = v.Range
		table.insert(tags, RangeTag(range)) -- inferred equivalent call
		local v2 = {
			Name = string.upper(description),
			DamageText = damageText,
			EveryText = `{FormatNumber(v.ReloadTime)}S`,
			Tags = tags
		} -- inferred equivalent call
		table.insert(result, v2)
	end

	return result
end

local function GetAbilityRow(abilityName: string, p: number)
	if not ResourceManager.HasPathEntityAbilityConfig(abilityName) then
		return nil
	end

	local pathEntityAbilityConfig = ResourceManager.GetPathEntityAbilityConfig(abilityName)
	local pathEntityToEnemyRangedData = pathEntityAbilityConfig.PathEntityToEnemyRangedData
	local pathEntityToEnemyRadiusEffectData = pathEntityAbilityConfig.PathEntityToEnemyRadiusEffectData
	local projectileHitData = pathEntityAbilityConfig.ProjectileHitData
	local damage = pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.Damage
		or pathEntityToEnemyRadiusEffectData and pathEntityToEnemyRadiusEffectData.Damage
		or projectileHitData and projectileHitData.Damage
	local damageType = pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.DamageType
		or pathEntityToEnemyRadiusEffectData and pathEntityToEnemyRadiusEffectData.DamageType
		or projectileHitData and projectileHitData.DamageType
	local damageData = pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.DamageData
		or pathEntityToEnemyRadiusEffectData and pathEntityToEnemyRadiusEffectData.DamageData
		or projectileHitData and projectileHitData.DamageData
	local damageText

	if damage then
		local v = p * damage
		local burstSize = pathEntityAbilityConfig.BurstSize

		if burstSize and burstSize > 6 then
			local v2 = (burstSize - 1) * (pathEntityAbilityConfig.BurstInterval or 0)
			damageText = `{FormatDamage(v * burstSize)} / {FormatDamage(v2)}S` -- inferred equivalent call
		elseif burstSize and burstSize > 1 then
			damageText = `{FormatDamage(v)} ×{burstSize}` -- inferred equivalent call
		else
			damageText = FormatNumber(math.round(v * 10) / 10) -- inferred equivalent call
		end
	else
		damageText = "—"
	end

	local tags = {}

	if projectileHitData and projectileHitData.IsSplash and projectileHitData.SplashRadius then
		local formatted = `SPLASH {FormatNumber(projectileHitData.SplashRadius)}` -- inferred equivalent call
		table.insert(tags, { Text = string.upper(formatted), Kind = "Effect" })
	end

	if pathEntityToEnemyRadiusEffectData then
		table.insert(tags, { Text = string.upper("AREA"), Kind = "Effect" })
	end

	if damage and IgnoresResistance(damageType, damageData and damageData.IgnoreResistance) then -- inferred equivalent call
		table.insert(tags, { Text = string.upper("IGNORES RESIST"), Kind = "Effect" })
	end

	AddDamageDataTags(tags, damageData)

	if pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.CanTargetAir then
		table.insert(tags, { Text = string.upper("HITS AIR"), Kind = "Effect" })
	end

	if pathEntityAbilityConfig.SpawnPathEntities then
		for _, spawnPathEntity in ipairs(pathEntityAbilityConfig.SpawnPathEntities) do
			local pathEntityType = spawnPathEntity.PathEntityType
			local v = ResourceManager.HasPathEntityConfig(pathEntityType)
				and ResourceManager.GetPathEntityConfig(pathEntityType)

			if v then
				pathEntityType = v.OverrideDisplayName or pathEntityType
			end

			local formatted = `{spawnPathEntity.Count or 1} {pathEntityType}`
			table.insert(tags, { Text = string.upper(formatted), Kind = "Summon" })
		end
	end

	local range = pathEntityToEnemyRangedData and pathEntityToEnemyRangedData.Range
		or pathEntityToEnemyRadiusEffectData and pathEntityToEnemyRadiusEffectData.MaximumRange

	if range then
		table.insert(tags, RangeTag(range)) -- inferred equivalent call
	end

	local cooldown = pathEntityAbilityConfig.Cooldown
	local v = {
		Name = string.upper(GetAbilityDisplayName(abilityName, pathEntityAbilityConfig)), -- inferred equivalent call
		DamageText = damageText,
		EveryText = 0,
		Tags = 0
	}
	local everyText

	if cooldown then
		everyText = `{FormatNumber(cooldown)}S` or "—" -- inferred equivalent call
	else
		everyText = "—"
	end

	v.EveryText = everyText
	v.Tags = tags
	return v
end

function TroopDetailsUtilities.GetRows(p, p2: number)
	local result = GetAttackRows(p, p2)
	local abilityNames = p.AbilityNames

	if not abilityNames then
		return result
	end

	for _, abilityName in ipairs(abilityNames) do
		local abilityRow = GetAbilityRow(abilityName, p2)

		if abilityRow then
			table.insert(result, abilityRow)
		end
	end

	return result
end

function TroopDetailsUtilities.HasDetails(list)
	return #list > 1 or list[1] ~= nil and #list[1].Tags > 0
end

return TroopDetailsUtilities