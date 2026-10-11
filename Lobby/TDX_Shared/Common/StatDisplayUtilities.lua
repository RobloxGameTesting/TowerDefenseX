local StatDisplayUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TowerBuffUtilities"))
local Utilities = require(common:WaitForChild("Utilities"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local v = {
	"Damage",
	"HealAmount",
	"DamageIncreaseOverTimeMaxMultiplier",
	"DamageIncreaseOverTimeDuration",
	"DamageIncreaseOverTimeCooldown",
	"DamageIncreasePerSecond",
	"BurnEffectStats",
	"BurnEffectStats.MaximumTargetsHit",
	"BurnEffectStats.EnemyBuffNames",
	"ApplyBurnStats",
	"ExtraDamageMultiplier",
	"ExtraDamageMultiplierBoss",
	"AirUnitDamageMultiplier",
	"ExtraDamageDuration",
	"StunDuration",
	"SlowdownPercentage",
	"BodyHeatReduction",
	"FrozenEnemyDamageMultiplier",
	"IgnoreResistance",
	"SplashRadius",
	"SplashMaximumTargetsHit",
	"ChainCount",
	"PrimaryTargetMultiplier",
	"StaticEntityLifetime",
	"AimTime",
	"ReloadTime",
	"BurstSize",
	"NearbyTowerDeathCashback",
	"CashPerCompletedBurst",
	"BaitEnemyAttacks",
	"ShieldSharedGrant",
	"ShieldDirectGrant",
	"ShieldGrantRefreshTime",
	"Range",
	"MinRange",
	"PierceCount",
	"AttackCount",
	"TimeToRegainStealth",
	"MovementSpeed",
	"MaximumROM",
	"DPS",
	"StealthDetection"
}
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(151, 250, 128)
local color3 = Color3.fromRGB(255, 141, 141)
local color4 = Color3.fromRGB(250, 221, 128)
local towerConfig = ResourceManager.GetTowerConfig(Enums.Towers.Farm)
local frozen = table.freeze({})
local v2 = {}

local function GetTextColor(flag: boolean, flag2: boolean, flag3: boolean?) -- 4 equivalent calls inferred from this helper
	if flag3 then
		return color4
	end

	if flag then
		return color2
	end

	if flag2 then
		return color3
	end

	return color
end

local function GetColorTextFormat(p: string, color5: Color3, flag: boolean?, _) -- 23 equivalent calls inferred from this helper
	if flag then
		return p
	end

	return string.format("<font color=\"rgb(%d,%d,%d)\">%s</font>", color5.R * 255, color5.G * 255, color5.B * 255, p)
end

local function GetAmountFromUpgradeShop(p, damage: string) -- 23 equivalent calls inferred from this helper
	local upgradeTypeToActiveUpgradeShopData = p and p.UpgradeTypeToActiveUpgradeShopData or frozen
	return TowerUpgradeShopUtilities.GetAmount(upgradeTypeToActiveUpgradeShopData, damage)
end

local function GetBaseStat(object, p: string, p2)
	if not object then
		return p2
	end

	local mainAttackOverrideData = object:GetMainAttackOverrideData()

	if not mainAttackOverrideData then
		return p2
	end

	local v3 = mainAttackOverrideData[p]

	if v3 then
		return v3, true
	end

	return p2
end

local function GetStatFromStatName(p, value: string, object)
	if object then
		local mainAttackOverrideData = object:GetMainAttackOverrideData()

		if mainAttackOverrideData and mainAttackOverrideData[value] then
			return mainAttackOverrideData[value]
		end
	end

	local v3 = string.split(value, ".")

	for _, v4 in ipairs(v3) do
		p = p[v4]
	end

	return p
end

local function HasPassiveAbilityStatAndPassiveAbility(p, statName: string) -- 1 equivalent call inferred from this helper
	local v3 = string.sub(statName, 1, 14) == "PassiveAbility"
	local v4 = false

	if not v3 then
		return v3, false
	end

	local abilityConfigs = p.AbilityConfigs

	for _, abilityConfig in ipairs(abilityConfigs) do
		if abilityConfig.Passive then
			v4 = true
		end
	end

	return v3, v4
end

function StatDisplayUtilities.GetDisplayStats(p)
	local overrideDisplayStats = p.OverrideDisplayStats or v

	if not p.AdditionalDisplayStats then
		return overrideDisplayStats
	end

	overrideDisplayStats = table.clone(overrideDisplayStats)

	for _, additionalDisplayStat in ipairs(p.AdditionalDisplayStats) do
		if not table.find(overrideDisplayStats, additionalDisplayStat) then
			table.insert(overrideDisplayStats, additionalDisplayStat)
		end
	end

	return overrideDisplayStats
end

function StatDisplayUtilities.GetStatInfoData(p: string)
	return v2[p]
end

function StatDisplayUtilities.ShouldIgnore(data, p, object)
	local v3, v4 = HasPassiveAbilityStatAndPassiveAbility(p, data.StatName) -- inferred equivalent call

	if v3 then
		return not v4
	else
		if data.IgnoreIfStatNameIsNilOrFalse then
			local ignoreIfStatNameIsNilOrFalse = data.IgnoreIfStatNameIsNilOrFalse
			local v5, v6

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData and mainAttackOverrideData[ignoreIfStatNameIsNilOrFalse] then
					v5 = mainAttackOverrideData[ignoreIfStatNameIsNilOrFalse]
				else
					v6 = string.split(ignoreIfStatNameIsNilOrFalse, ".")
					v5 = p

					for i, v7 in ipairs(v6) do
						v5 = v5[v7]
					end
				end
			else
				v6 = string.split(ignoreIfStatNameIsNilOrFalse, ".")
				v5 = p

				for i, v7 in ipairs(v6) do
					v5 = v5[v7]
				end
			end

			if not v5 then
				return true
			end
		end

		if data.IgnoreIfStatNameIsNilOrFalse2 then
			local ignoreIfStatNameIsNilOrFalse2 = data.IgnoreIfStatNameIsNilOrFalse2
			local v5, v6

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData and mainAttackOverrideData[ignoreIfStatNameIsNilOrFalse2] then
					v5 = mainAttackOverrideData[ignoreIfStatNameIsNilOrFalse2]
				else
					v6 = string.split(ignoreIfStatNameIsNilOrFalse2, ".")
					v5 = p

					for i, v7 in ipairs(v6) do
						v5 = v5[v7]
					end
				end
			else
				v6 = string.split(ignoreIfStatNameIsNilOrFalse2, ".")
				v5 = p

				for i, v7 in ipairs(v6) do
					v5 = v5[v7]
				end
			end

			if not v5 then
				return true
			end
		end

		if data.IgnoreIfStatNameIsTrue then
			local ignoreIfStatNameIsTrue = data.IgnoreIfStatNameIsTrue
			local v5, v6

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData and mainAttackOverrideData[ignoreIfStatNameIsTrue] then
					v5 = mainAttackOverrideData[ignoreIfStatNameIsTrue]
				else
					v6 = string.split(ignoreIfStatNameIsTrue, ".")
					v5 = p

					for i, v7 in ipairs(v6) do
						v5 = v5[v7]
					end
				end
			else
				v6 = string.split(ignoreIfStatNameIsTrue, ".")
				v5 = p

				for i, v7 in ipairs(v6) do
					v5 = v5[v7]
				end
			end

			if v5 then
				return true
			end
		end

		if data.IgnoreIfStatNameEqualsMap then
			local statName = data.StatName
			local v5, v6

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData and mainAttackOverrideData[statName] then
					v5 = mainAttackOverrideData[statName]
				else
					v6 = string.split(statName, ".")
					v5 = p

					for i, v7 in ipairs(v6) do
						v5 = v5[v7]
					end
				end
			else
				v6 = string.split(statName, ".")
				v5 = p

				for i, v7 in ipairs(v6) do
					v5 = v5[v7]
				end
			end

			if v5 == data.IgnoreIfStatNameEqualsMap[data.StatName] then
				return true
			end
		end

		if not data.IgnoreIfStatNameGreaterThanMap then
			return false
		end

		for k, v5 in pairs(data.IgnoreIfStatNameGreaterThanMap) do
			local v6, v7

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData and mainAttackOverrideData[k] then
					v6 = mainAttackOverrideData[k]
				else
					v7 = string.split(k, ".")
					v6 = p

					for i, v8 in ipairs(v7) do
						v6 = v6[v8]
					end
				end
			else
				v7 = string.split(k, ".")
				v6 = p

				for i, v8 in ipairs(v7) do
					v6 = v6[v8]
				end
			end

			if v6 and v5 < v6 then
				return true
			end
		end

		return false
	end
end

function StatDisplayUtilities.GetDefaultHoverAdditionIcon()
	return "rbxassetid://12191388343"
end

function StatDisplayUtilities.GetFarmAdditionalStatStrings(p: number, _: number, flag: boolean?, value: number?)
	local v3 = {}
	local v4 = value or 1

	if workspace:GetAttribute("IsPVP") then
		table.insert(v3, "HP PER WAVE: IGNORED IN PVP")
	elseif p >= 5 then
		table.insert(
			v3,
			string.upper(`HP PER WAVE: {math.floor(v4 * (towerConfig.BaseCrateHP + towerConfig.P1L5CrateHP))}`)
		)
	elseif p >= 3 then
		table.insert(
			v3,
			string.upper(`HP PER WAVE: {math.floor(v4 * (towerConfig.BaseCrateHP + towerConfig.P1L3CrateHP))}`)
		)
	else
		table.insert(v3, string.upper(`HP PER WAVE: {math.floor(v4 * towerConfig.BaseCrateHP)}`))
	end

	if p >= 4 then
		table.insert(
			v3,
			string.upper(flag and "1% Tower Economics" or "Gain 1% of value of nearby towers per crate (5000 MAX)")
		)
	end

	return v3
end

function StatDisplayUtilities.GetPassiveAbilityString(data, value: number?)
	local v3 = nil

	if data.DisplayDPSFromHitData then
		if data.ProjectileHitData then
			local v4 = (value or 1) * data.ProjectileHitData.Damage

			if data.BurstSize then
				v4 *= data.BurstSize
			end

			v3 = string.format(data.DisplayName, v4 / data.Cooldown)
		else
			warn("Ability " .. data.Name .. " is set to display DPS from hit data but has no ProjectileHitData")
		end
	else
		v3 = `{data.DisplayName}`
	end

	return string.upper(v3)
end

for i, v3 in ipairs({
	{
		StatName = "Damage",
		IgnoreIfStatNameEqualsMap = { Damage = 0 },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, p3, _: number?, flag: boolean?, object)
			local damageMultiplier = p3 and p3.DamageMultiplier or 0
			local v3 = damageMultiplier > 0
			local v4 = damageMultiplier < 0
			local damage = p2.Damage
			local v5

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local damage2 = mainAttackOverrideData.Damage

					if damage2 then
						damage = damage2
						v5 = true
					end
				end
			end

			local v6 = damage * (1 + damageMultiplier) * GetAmountFromUpgradeShop( -- inferred equivalent call
				object,
				Enums.TowerUpgradeShopTypes.Damage
			)
			local formatNumberStat = Utilities.FormatNumberStat(v6, p.DecimalPlaces)
			local textColor = GetTextColor(v3, v4, v5) -- inferred equivalent call
			formatNumberStat = GetColorTextFormat(formatNumberStat, textColor, flag) -- inferred equivalent call
			local formatted = `DAMAGE: {formatNumberStat}`
			local damageMultiplier2 = object and object:GetDamageMultiplier()

			if damageMultiplier2 and damageMultiplier2 > 1 then
				local v9 = v6 * (damageMultiplier2 - 1)
				local v10 = "+" .. Utilities.FormatNumberStat(v9, p.DecimalPlaces)
				local v11 = color2
				formatted ..= ` ({string.format("<font color=\"rgb(%d,%d,%d)\">%s</font>", v11.R * 255, v11.G * 255, v11.B * 255, v10)})`
			end

			return formatted
		end
	},
	{
		StatName = "HealAmount",
		IgnoreIfStatNameIsNilOrFalse = "HealAmount",
		IgnoreIfStatNameEqualsMap = { HealAmount = 0 },
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.HealAmount / p2.ReloadTime * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			return `HEAL PER SECOND: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "DamageIncreaseOverTimeMaxMultiplier",
		IgnoreIfStatNameIsNilOrFalse = "DamageIncreaseOverTimeMaxMultiplier",
		IgnoreIfStatNameEqualsMap = { DamageIncreaseOverTimeMaxMultiplier = 0 },
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local damageIncreaseOverTimeMaxMultiplier = p2.DamageIncreaseOverTimeMaxMultiplier
			return `DAMAGE OVER TIME MAX MULTIPLIER: {Utilities.FormatNumberStat(damageIncreaseOverTimeMaxMultiplier, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "DamageIncreaseOverTimeDuration",
		IgnoreIfStatNameIsNilOrFalse = "DamageIncreaseOverTimeDuration",
		IgnoreIfStatNameEqualsMap = { DamageIncreaseOverTimeDuration = 0 },
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local damageIncreaseOverTimeDuration = p2.DamageIncreaseOverTimeDuration
			return `DAMAGE OVER TIME DURATION: {Utilities.FormatNumberStat(damageIncreaseOverTimeDuration, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "DamageIncreaseOverTimeCooldown",
		IgnoreIfStatNameIsNilOrFalse = "DamageIncreaseOverTimeCooldown",
		IgnoreIfStatNameEqualsMap = { DamageIncreaseOverTimeCooldown = 0 },
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local damageIncreaseOverTimeCooldown = p2.DamageIncreaseOverTimeCooldown
			return `DAMAGE OVER TIME COOLDOWN: {Utilities.FormatNumberStat(damageIncreaseOverTimeCooldown, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "DamageIncreasePerSecond",
		IgnoreIfStatNameIsNilOrFalse = "DamageIncreasePerSecond",
		IgnoreIfStatNameEqualsMap = { DamageIncreasePerSecond = 0 },
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local damageIncreasePerSecond = p2.DamageIncreasePerSecond
			return `DAMAGE INCREASE PER SECOND: {Utilities.FormatNumberStat(damageIncreasePerSecond, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "BurnEffectStats",
		IgnoreIfStatNameIsNilOrFalse = "BurnEffectStats",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = Utilities.FormatNumberStat(burnEffectStats.DamagePerSecond, p.DecimalPlaces)
			local formatNumberStat2 = Utilities.FormatNumberStat(burnEffectStats.StickDuration, 1)
			return string.upper(`{displayName} ({formatNumberStat} DPS for {formatNumberStat2} seconds)`)
		end
	},
	{
		StatName = "BurnEffectStats.EnemyBuffNames",
		IgnoreIfStatNameIsNilOrFalse = "BurnEffectStats",
		IgnoreIfStatNameIsNilOrFalse2 = "BurnEffectStats.EnemyBuffNames",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, _)
			local enemyBuffNames = p.BurnEffectStats.EnemyBuffNames
			local result = {}

			for _, enemyBuffName in pairs(enemyBuffNames) do
				local enemyBuffConfig = ResourceManager.GetEnemyBuffConfig(enemyBuffName)

				if enemyBuffConfig.Type ~= Enums.EnemyBuffTypes.DamageResistance then
					continue
				end

				local v3 = math.round(100 * enemyBuffConfig.Percentage)
				local v4 = enemyBuffConfig.BossPercentage and math.round(100 * enemyBuffConfig.BossPercentage)
				local formatNumberStat = Utilities.FormatNumberStat(enemyBuffConfig.Time, 1)

				if v4 == 0 then
					v4 = nil
				end

				if enemyBuffConfig.IsDebuff then
					table.insert(
						result,
						string.upper(`ENEMY DAMAGE RESISTANCES REDUCED BY {v3}% FOR {formatNumberStat} SECONDS`)
					)
				else
					table.insert(
						result,
						string.upper(`ENEMY DAMAGE RESISTANCES INCREASED BY {v3}% FOR {formatNumberStat} SECONDS`)
					)
				end

				if not v4 then
					continue
				end

				if enemyBuffConfig.IsDebuff then
					table.insert(
						result,
						string.upper(`BOSS DAMAGE RESISTANCES REDUCED BY {v4}% FOR {formatNumberStat} SECONDS`)
					)
				else
					table.insert(
						result,
						string.upper(`BOSS DAMAGE RESISTANCES INCREASED BY {v4}% FOR {formatNumberStat} SECONDS`)
					)
				end
			end

			return result
		end
	},
	{
		StatName = "BurnEffectStats.MaximumTargetsHit",
		IgnoreIfStatNameIsNilOrFalse = "BurnEffectStats",
		IgnoreIfStatNameIsNilOrFalse2 = "BurnEffectStats.MaximumTargetsHit",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, _)
			local burnEffectStats = p.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local maximumTargetsHit = burnEffectStats.MaximumTargetsHit
			return string.upper(`{displayName} MAX TARGETS HIT: {maximumTargetsHit}`)
		end
	},
	{
		StatName = "ApplyBurnStats",
		IgnoreIfStatNameIsNilOrFalse = "ApplyBurnStats",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local applyBurnStats = p2.ApplyBurnStats
			local formatNumberStat = Utilities.FormatNumberStat(applyBurnStats.DamagePerSecond, p.DecimalPlaces)
			local stickDuration = math.round(applyBurnStats.StickDuration)
			return string.upper(`Burn ({formatNumberStat} DPS for {stickDuration} seconds)`)
		end
	},
	{
		StatName = "ExtraDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { ExtraDamageMultiplier = 0 },
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local extraDamageMultiplier = p2.ExtraDamageMultiplier
			return `ENEMIES TAKE +{Utilities.FormatNumberStat(100 * extraDamageMultiplier, p.DecimalPlaces)}% DAMAGE`
		end
	},
	{
		StatName = "ExtraDamageMultiplierBoss",
		IgnoreIfStatNameEqualsMap = { ExtraDamageMultiplierBoss = 0 },
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local extraDamageMultiplierBoss = p2.ExtraDamageMultiplierBoss
			return `BOSSES TAKE +{Utilities.FormatNumberStat(100 * extraDamageMultiplierBoss, p.DecimalPlaces)}% DAMAGE`
		end
	},
	{
		StatName = "AirUnitDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { AirUnitDamageMultiplier = 1 },
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local airUnitDamageMultiplier = p2.AirUnitDamageMultiplier
			return `AIR ENEMIES TAKE +{Utilities.FormatNumberStat(100 * (airUnitDamageMultiplier - 1), p.DecimalPlaces)}% DAMAGE`
		end
	},
	{
		StatName = "ExtraDamageDuration",
		IgnoreIfStatNameEqualsMap = { ExtraDamageDuration = 0 },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local extraDamageDuration = p2.ExtraDamageDuration
			return `EXTRA DAMAGE DURATION: {Utilities.FormatNumberStat(extraDamageDuration, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "StunDuration",
		IgnoreIfStatNameEqualsMap = { StunDuration = 0 },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.StunDuration * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.StunDuration) -- inferred equivalent call
			return `STUN DURATION: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "SlowdownPercentage",
		IgnoreIfStatNameEqualsMap = { SlowdownPercentage = 0, SlowdownDuration = 0 },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local slowdownPercentage = p2.SlowdownPercentage
			local slowdownDuration = p2.SlowdownDuration
			return `{Utilities.FormatNumberStat(slowdownPercentage, p.DecimalPlaces, true)}% SLOWDOWN FOR {Utilities.FormatNumberStat(slowdownDuration, 1)} SECONDS`
		end
	},
	{
		StatName = "CashPerWave",
		IgnoreIfStatNameIsNilOrFalse = "CashPerWave",
		IgnoreIfStatNameEqualsMap = { CashPerWave = 0 },
		ImageId = "rbxassetid://14037827267",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, p3)
			local v3 = p2.CashPerWave * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.CashPerWave) -- inferred equivalent call
			local formatNumberStat = Utilities.FormatNumberStat(v3, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `CASH PER WAVE: {formatNumberStat}`
		end
	},
	{
		StatName = "CashPerTick",
		IgnoreIfStatNameIsNilOrFalse = "CashPerTick",
		IgnoreIfStatNameEqualsMap = { CashPerTick = 0 },
		ImageId = "rbxassetid://70726090297438",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, p3)
			local v3 = p2.CashPerTick * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.CashPerSecond) -- inferred equivalent call
			local cashTickDuration = p2.CashTickDuration
			local formatted = `{Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
			local formatted2 = `{Utilities.FormatNumberStat(cashTickDuration, p.DecimalPlaces)}`
			local v4 = color
			formatted = GetColorTextFormat(formatted, v4, flag) -- inferred equivalent call
			formatted2 = GetColorTextFormat(formatted2, v4, flag) -- inferred equivalent call
			return `{formatted} CASH EVERY {formatted2} SECONDS`
		end
	},
	{
		StatName = "CashPerDamageMultiplier",
		IgnoreIfStatNameIsNilOrFalse = "CashPerDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { CashPerDamageMultiplier = 0 },
		ImageId = "rbxassetid://97821518331188",
		ImageScale = 1,
		DecimalPlaces = 2,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local cashPerDamageMultiplier = p2.CashPerDamageMultiplier
			local formatted = `{Utilities.FormatNumberStat(cashPerDamageMultiplier * 100, p.DecimalPlaces)}%`
			formatted = GetColorTextFormat(formatted, color, flag) -- inferred equivalent call
			return `CASH PER DAMAGE MULTIPLIER: {formatted}`
		end
	},
	{
		StatName = "GoldWinBonus",
		IgnoreIfStatNameIsNilOrFalse = "GoldWinBonus",
		IgnoreIfStatNameEqualsMap = { GoldWinBonus = 0 },
		ImageId = "rbxassetid://84168181217670",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local goldWinBonus = p2.GoldWinBonus
			local formatted = `{Utilities.FormatNumberStat(goldWinBonus, p.DecimalPlaces)}`
			formatted = GetColorTextFormat(formatted, color, flag) -- inferred equivalent call
			return `GOLD WIN BONUS: {formatted}`
		end
	},
	{
		StatName = "BodyHeatReduction",
		IgnoreIfStatNameEqualsMap = { BodyHeatReduction = 0 },
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, p3)
			local v3 = p2.BodyHeatReduction * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Freeze) -- inferred equivalent call
			local formatNumberStat = Utilities.FormatNumberStat(v3, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `FREEZE AMOUNT: {formatNumberStat}`
		end
	},
	{
		StatName = "FrozenEnemyDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { FrozenEnemyDamageMultiplier = 1 },
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DescriptionFunction = function(_, p, _, _: number?, flag: boolean?, _)
			local frozenEnemyDamageMultiplier = p.FrozenEnemyDamageMultiplier
			local formatNumberStat = Utilities.FormatNumberStat(frozenEnemyDamageMultiplier - 1, nil, true)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `EXTRA DAMAGE ON FROZEN ENEMIES: {formatNumberStat}%`
		end
	},
	{
		StatName = "IgnoreResistance",
		IgnoreIfStatNameIsNilOrFalse = "IgnoreResistance",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DescriptionFunction = function(_, p)
			return `IGNORE {string.upper(p.DamageType)} RESISTANCE`
		end
	},
	{
		StatName = "SplashRadius",
		IgnoreIfStatNameIsNilOrFalse = "IsSplash",
		IgnoreIfStatNameIsTrue = "SplashHasBeenRemoved",
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, object)
			local splashRadius = p2.SplashRadius
			local flag2

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local splashRadius2 = mainAttackOverrideData.SplashRadius

					if splashRadius2 then
						splashRadius = splashRadius2
						flag2 = true
					end
				end
			end

			local v3 = splashRadius * GetAmountFromUpgradeShop(object, Enums.TowerUpgradeShopTypes.Splash) -- inferred equivalent call
			local formatNumberStat = Utilities.FormatNumberStat(v3, p.DecimalPlaces)
			local v4

			if flag2 then
				v4 = color4
			else
				v4 = color
			end

			formatNumberStat = GetColorTextFormat(formatNumberStat, v4, flag) -- inferred equivalent call
			return `SPLASH RADIUS: {formatNumberStat}`
		end
	},
	{
		StatName = "SplashMaximumTargetsHit",
		IgnoreIfStatNameIsNilOrFalse = "IsSplash",
		IgnoreIfStatNameIsTrue = "SplashHasBeenRemoved",
		IgnoreIfStatNameGreaterThanMap = { SplashMaximumTargetsHit = 10000 },
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local splashMaximumTargetsHit = p2.SplashMaximumTargetsHit
			return `MAX TARGETS HIT: {Utilities.FormatNumberStat(splashMaximumTargetsHit, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "ChainCount",
		IgnoreIfStatNameEqualsMap = { ChainCount = 0 },
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, p2)
			local chainCount = p.ChainCount
			local chainDamageMultiplier = p.ChainDamageMultiplier
			local chainDamage = Enums.TowerUpgradeShopTypes.ChainDamage
			return `CHAIN COUNT: {chainCount} ({math.round(chainDamageMultiplier * GetAmountFromUpgradeShop(p2, chainDamage) * 100)}% DAMAGE)` -- inferred equivalent call
		end
	},
	{
		StatName = "PrimaryTargetMultiplier",
		IgnoreIfStatNameEqualsMap = { PrimaryTargetMultiplier = 1 },
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local primaryTargetMultiplier = p2.PrimaryTargetMultiplier
			return `PRIMARY TARGET MULTIPLIER: {Utilities.FormatNumberStat(primaryTargetMultiplier, p.DecimalPlaces)}X`
		end
	},
	{
		StatName = "StaticEntityLifetime",
		IgnoreIfStatNameIsNilOrFalse = "SpawnStaticEntityName",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local staticEntityLifetime = p2.StaticEntityLifetime

			if not staticEntityLifetime then
				return
			end

			local staticEntityConfig = ResourceManager.GetStaticEntityConfig(p2.SpawnStaticEntityName)
			local overrideDisplayName = string.upper(staticEntityConfig.OverrideDisplayName or p2.SpawnStaticEntityName)
			local formatNumberStat = Utilities.FormatNumberStat(staticEntityLifetime, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `{overrideDisplayName} LIFETIME: {formatNumberStat}`
		end
	},
	{
		StatName = "AimTime",
		IgnoreIfStatNameEqualsMap = { AimTime = 0 },
		ImageId = "rbxassetid://15643912892",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local aimTime = p2.AimTime
			local formatNumberStat = Utilities.FormatNumberStat(aimTime, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `AIM TIME: {formatNumberStat}`
		end
	},
	{
		StatName = "ReviveDuration",
		ImageId = "",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local reviveDuration = p2.ReviveDuration
			local formatNumberStat = Utilities.FormatNumberStat(reviveDuration, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `REVIVE DURATION: {formatNumberStat}`
		end
	},
	{
		StatName = "ReloadTime",
		IgnoreIfStatNameGreaterThanMap = { HealAmount = 0 },
		ImageId = "rbxassetid://12191387561",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(p, p2, p3, _: number?, flag: boolean?, object)
			local firerateMultiplier = p3 and p3.FirerateMultiplier or 0
			local v3 = firerateMultiplier > 0
			local v4 = firerateMultiplier < 0
			local reloadTime = p2.ReloadTime
			local v5

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local reloadTime2 = mainAttackOverrideData.ReloadTime

					if reloadTime2 then
						reloadTime = reloadTime2
						v5 = true
					end
				end
			end

			local v6 = 1 / (1 + firerateMultiplier) * reloadTime * GetAmountFromUpgradeShop( -- inferred equivalent call
				object,
				Enums.TowerUpgradeShopTypes.Firerate
			)
			local formatNumberStat = Utilities.FormatNumberStat(v6, p.DecimalPlaces)
			local textColor = GetTextColor(v3, v4, v5) -- inferred equivalent call
			formatNumberStat = GetColorTextFormat(formatNumberStat, textColor, flag) -- inferred equivalent call
			return `RELOAD TIME: {formatNumberStat}`
		end
	},
	{
		StatName = "BurstSize",
		IgnoreIfStatNameIsNilOrFalse = "IsBurst",
		IgnoreIfStatNameEqualsMap = { BurstSize = 1 },
		ImageId = "rbxassetid://12734318416",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local burstSize = p2.BurstSize
			local formatNumberStat = Utilities.FormatNumberStat(burstSize, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `BURST SIZE: {formatNumberStat}`
		end
	},
	{
		StatName = "NearbyTowerFirerateBuff",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerFirerateBuff",
		IgnoreIfStatNameEqualsMap = { NearbyTowerFirerateBuff = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, _)
			local nearbyTowerFirerateBuff = p.NearbyTowerFirerateBuff
			return `FIRERATE BUFF: {Utilities.FormatNumberStat(nearbyTowerFirerateBuff, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerRangeBuff",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerRangeBuff",
		IgnoreIfStatNameEqualsMap = { NearbyTowerRangeBuff = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, p2)
			local v3 = p.NearbyTowerRangeBuff * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.RangeBuff) -- inferred equivalent call
			return `RANGE BUFF: {Utilities.FormatNumberStat(v3, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerDamageBuff",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerDamageBuff",
		IgnoreIfStatNameEqualsMap = { NearbyTowerDamageBuff = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, p2)
			local v3 = p.NearbyTowerDamageBuff * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.DamageBuff) -- inferred equivalent call
			return `DAMAGE BUFF: {Utilities.FormatNumberStat(v3, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerDiscount",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerDiscount",
		IgnoreIfStatNameEqualsMap = { NearbyTowerDiscount = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, _)
			local nearbyTowerDiscount = p.NearbyTowerDiscount
			return `NEARBY TOWER DISCOUNT: {Utilities.FormatNumberStat(nearbyTowerDiscount, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerSellback",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerSellback",
		IgnoreIfStatNameEqualsMap = { NearbyTowerSellback = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, p2)
			local v3 = p.NearbyTowerSellback * GetAmountFromUpgradeShop( -- inferred equivalent call
				p2,
				Enums.TowerUpgradeShopTypes.NearbyTowerSellbackValue
			)
			return `NEARBY TOWER SELLBACK: {Utilities.FormatNumberStat(v3, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerDeathCashback",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerDeathCashback",
		IgnoreIfStatNameEqualsMap = { NearbyTowerDeathCashback = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, _)
			local nearbyTowerDeathCashback = p.NearbyTowerDeathCashback
			return `NEARBY TOWER DEATH CASHBACK: {Utilities.FormatNumberStat(nearbyTowerDeathCashback, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerHealPerSecond",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerHealPerSecond",
		IgnoreIfStatNameEqualsMap = { NearbyTowerHealPerSecond = 0 },
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.NearbyTowerHealPerSecond * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			return `NEARBY TOWER HEAL PER SECOND: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "BaitEnemyAttacks",
		IgnoreIfStatNameIsNilOrFalse = "BaitEnemyAttacks",
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DescriptionFunction = function(_, _, _, _: number?, _: boolean?, _)
			return "BAIT ENEMY ATTACKS"
		end
	},
	{
		StatName = "ShieldSharedGrant",
		IgnoreIfStatNameEqualsMap = { ShieldSharedGrant = 0 },
		ImageId = "rbxassetid://121224933813250",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.ShieldSharedGrant * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			return `SHARED SHIELD GRANT: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "ShieldDirectGrant",
		IgnoreIfStatNameEqualsMap = { ShieldDirectGrant = 0 },
		ImageId = "rbxassetid://129365774406947",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.ShieldDirectGrant * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			return `DIRECT SHIELD GRANT: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "ShieldGrantRefreshTime",
		IgnoreIfStatNameEqualsMap = { ShieldGrantRefreshTime = 0 },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.ShieldGrantRefreshTime * GetAmountFromUpgradeShop( -- inferred equivalent call
				p3,
				Enums.TowerUpgradeShopTypes.ShieldRegenSpeed
			)
			return `SHIELD GRANT INTERVAL: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "Range",
		ImageId = "rbxassetid://12191389133",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, p3, _: number?, flag: boolean?, object)
			local rangeMultiplier = p3 and p3.RangeMultiplier or 0
			local v3 = rangeMultiplier > 0
			local v4 = rangeMultiplier < 0
			local range = p2.Range
			local v5

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local range2 = mainAttackOverrideData.Range

					if range2 then
						range = range2
						v5 = true
					end
				end
			end

			local v6 = range * (1 + rangeMultiplier) * GetAmountFromUpgradeShop( -- inferred equivalent call
				object,
				Enums.TowerUpgradeShopTypes.Range
			)
			local formatNumberStat = Utilities.FormatNumberStat(v6, p.DecimalPlaces)
			local textColor = GetTextColor(v3, v4, v5) -- inferred equivalent call
			formatNumberStat = GetColorTextFormat(formatNumberStat, textColor, flag) -- inferred equivalent call
			return `RANGE: {formatNumberStat}`
		end
	},
	{
		StatName = "MinRange",
		IgnoreIfStatNameEqualsMap = { MinRange = 0 },
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, _)
			local minRange = p2.MinRange
			return `MIN RANGE: {Utilities.FormatNumberStat(minRange, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "KnockbackStuds",
		IgnoreIfStatNameEqualsMap = { KnockbackStuds = 0 },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, object)
			local knockbackStuds = p2.KnockbackStuds
			local flag2

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local knockbackStuds2 = mainAttackOverrideData.KnockbackStuds

					if knockbackStuds2 then
						knockbackStuds = knockbackStuds2
						flag2 = true
					end
				end
			end

			local formatNumberStat = Utilities.FormatNumberStat(knockbackStuds, p.DecimalPlaces)
			local v3

			if flag2 then
				v3 = color4
			else
				v3 = color
			end

			formatNumberStat = GetColorTextFormat(formatNumberStat, v3, flag) -- inferred equivalent call
			return `KNOCKBACK: {formatNumberStat} STUDS`
		end
	},
	{
		StatName = "KnockbackSuspendTime",
		IgnoreIfStatNameEqualsMap = { KnockbackSuspendTime = 0 },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, object)
			local knockbackSuspendTime = p2.KnockbackSuspendTime
			local flag2

			if object then
				local mainAttackOverrideData = object:GetMainAttackOverrideData()

				if mainAttackOverrideData then
					local knockbackSuspendTime2 = mainAttackOverrideData.KnockbackSuspendTime

					if knockbackSuspendTime2 then
						knockbackSuspendTime = knockbackSuspendTime2
						flag2 = true
					end
				end
			end

			local formatNumberStat = Utilities.FormatNumberStat(knockbackSuspendTime, p.DecimalPlaces)
			local v3

			if flag2 then
				v3 = color4
			else
				v3 = color
			end

			formatNumberStat = GetColorTextFormat(formatNumberStat, v3, flag) -- inferred equivalent call
			return `SUSPEND: {formatNumberStat} SECONDS`
		end
	},
	{
		StatName = "PierceCount",
		IgnoreIfStatNameIsNilOrFalse = "IsPiercing",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, p3)
			local v3 = p2.PierceCount + GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Pierce) -- inferred equivalent call
			local formatNumberStat = Utilities.FormatNumberStat(v3, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `PIERCE: {formatNumberStat}`
		end
	},
	{
		StatName = "AttackCount",
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(_, _, _, p: number?)
			return `ATTACKS: {p}`
		end
	},
	{
		StatName = "TimeToRegainStealth",
		IgnoreIfStatNameIsNilOrFalse = "RegainStealthIfRevealed",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local timeToRegainStealth = p2.TimeToRegainStealth
			local formatNumberStat = Utilities.FormatNumberStat(timeToRegainStealth, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `REGAIN STEALTH TIME: {formatNumberStat}`
		end
	},
	{
		StatName = "StealthDetection",
		ImageId = "rbxassetid://12191387908",
		ImageScale = 0.95,
		DescriptionFunction = function(_, p, p2, _: number?, flag: boolean?, _)
			local stealthDetection = p2 and p2.StealthDetection

			if not (p.StealthDetection or stealthDetection) then
				return nil
			end

			if p.StealthDetection or not stealthDetection then
				stealthDetection = false
			end

			local v3

			if stealthDetection then
				v3 = color2
			else
				v3 = color
			end

			return GetColorTextFormat("STEALTH DETECTION", v3, flag)
		end
	},
	{
		StatName = "MovementSpeed",
		IgnoreIfStatNameEqualsMap = { MovementSpeed = 0 },
		ImageId = "rbxassetid://83017077237761",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, p3)
			local v3 = p2.MovementSpeed * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.MovementSpeed) -- inferred equivalent call
			local formatNumberStat = Utilities.FormatNumberStat(v3, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `MOVEMENT SPEED: {formatNumberStat}`
		end
	},
	{
		StatName = "MaximumROM",
		IgnoreIfStatNameIsNilOrFalse = "MaximumROM",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, flag: boolean?, _)
			local maximumROM = p2.MaximumROM
			local formatNumberStat = Utilities.FormatNumberStat(maximumROM, p.DecimalPlaces)
			formatNumberStat = GetColorTextFormat(formatNumberStat, color, flag) -- inferred equivalent call
			return `RANGE OF MOTION: {formatNumberStat}°`
		end
	},
	{
		StatName = "IgnoreObstacles",
		IgnoreIfStatNameIsNilOrFalse = "IgnoreObstacles",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DescriptionFunction = function(_, _)
			return "IGNORE OBSTACLES"
		end
	},
	{
		StatName = "Health",
		ImageId = "rbxassetid://103814500469848",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local v3 = p2.Health * GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Health) -- inferred equivalent call
			return `HEALTH: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "DPS",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(p, p2, p3, p4: number?, flag: boolean?, object)
			if p2.NoShowDPS then
				return
			end

			local mainAttackOverrideData = object and object:GetMainAttackOverrideData()
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(object, Enums.TowerUpgradeShopTypes.Damage) -- inferred equivalent call
			local amountFromUpgradeShop2 = GetAmountFromUpgradeShop(object, Enums.TowerUpgradeShopTypes.Firerate) -- inferred equivalent call
			local dps = TowerUtilities.CalculateDPS(p2, nil, amountFromUpgradeShop2, mainAttackOverrideData)
			local dps2 = TowerUtilities.CalculateDPS(p2, p3, amountFromUpgradeShop2, mainAttackOverrideData)
			local v3 = dps * amountFromUpgradeShop
			local v4 = dps2 * amountFromUpgradeShop
			local damageMultiplier = object and object:GetDamageMultiplier()

			if damageMultiplier and damageMultiplier > 1 then
				v4 *= damageMultiplier
			end

			local v5 = v3 < v4
			local v6 = v4 < v3
			local formatNumberStat = Utilities.FormatNumberStat(v4, p.DecimalPlaces)
			local textColor = GetTextColor(v5, v6, mainAttackOverrideData) -- inferred equivalent call

			if p4 > 1 then
				formatNumberStat = GetColorTextFormat(formatNumberStat, textColor, flag) -- inferred equivalent call
				return `DPS: {formatNumberStat} (PER ATTACK)`
			else
				formatNumberStat = GetColorTextFormat(formatNumberStat, textColor, flag) -- inferred equivalent call
				return `DPS: {formatNumberStat}`
			end
		end
	},
	{
		StatName = "CashPerCompletedBurst",
		ImageId = "rbxassetid://15498074414",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(p, p2, _, _: number?, _: boolean?, p3)
			local cashPerCompletedBurst = p2.CashPerCompletedBurst

			if not cashPerCompletedBurst or cashPerCompletedBurst == 0 then
				return
			end

			local v3 = cashPerCompletedBurst * GetAmountFromUpgradeShop( -- inferred equivalent call
				p3,
				Enums.TowerUpgradeShopTypes.CashPerFullReload
			)
			return `FULL RELOAD CASH: {Utilities.FormatNumberStat(v3, p.DecimalPlaces)}`
		end
	},
	{
		StatName = "PassiveAbility",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(_, p, _, _: number?, _: boolean?, p2)
			local abilityConfigs = p.AbilityConfigs

			if not abilityConfigs then
				warn("No AbilityConfigs found")
				return ""
			end

			local function FindNextPassiveAbilityIndex()
				local count = 0

				for i, abilityConfig in ipairs(abilityConfigs) do
					if not abilityConfig.Passive then
						continue
					end

					count += 1

					if count == 1 then
						return i
					end
				end

				return nil
			end

			local abilityConfig = abilityConfigs[FindNextPassiveAbilityIndex()]

			if abilityConfig then
				return "PASSIVE ABILITY: " .. StatDisplayUtilities.GetPassiveAbilityString(
					abilityConfig,
					GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Damage)
				)
			end

			warn(`Missing AbilityConfig for PassiveAbility (Index = {1})`)
			return ""
		end
	}
}) do
	v2[v3.StatName] = v3
	v3._LayoutOrder = i
end

return StatDisplayUtilities