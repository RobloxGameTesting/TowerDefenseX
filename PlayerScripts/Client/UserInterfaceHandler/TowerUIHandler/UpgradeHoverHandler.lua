local UpgradeHoverHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local StatDisplayUtilities = require(common:WaitForChild("StatDisplayUtilities"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local FormatNumberStat = Utilities.FormatNumberStat

local function GetAmountFromUpgradeShop(upgradeTypeToActiveUpgradeShopData, damage: string) -- 26 equivalent calls inferred from this helper
	return TowerUpgradeShopUtilities.GetAmount(upgradeTypeToActiveUpgradeShopData, damage)
end

local LocalPlayer = Players.LocalPlayer
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local towerUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local upgradeHover = towerUI:WaitForChild("UpgradeHover")
local uiScale = towerUI:WaitForChild("UIScale")
local v = {}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = ScalingCardClass.New(upgradeHover, 9, { uiScale })
local towerConfig = ResourceManager.GetTowerConfig(Enums.Towers.Farm)

local function GetNextLevelStats(p: number) -- 1 equivalent call inferred from this helper
	local levelOnPath = v3:GetLevelOnPath(p)
	local upgradePathData = v3:GetUpgradePathData()
	local v7

	if upgradePathData.OnePathOnly or p == 1 then
		v7 = upgradePathData.Path1Data
	else
		v7 = upgradePathData.Path2Data
	end

	return v7[levelOnPath + 1]
end

local function GetStatFromStatName(p, value: string)
	local v7 = string.split(value, ".")

	for _, v8 in ipairs(v7) do
		p = p[v8]
	end

	return p
end

function UpgradeHoverHandler.SetCurrentLevelHandler(p, p2: string, p3)
	v3 = p
	v4 = p2
	v5 = p3
end

function UpgradeHoverHandler.UpgradeHovered(p: number, p2)
	v2 = p2

	if not v3 then
		return
	end

	v6:DeactivateAllItems()
	local upgradeTypeToActiveUpgradeShopData = localPlayerWrapper.UpgradeShopDataHandler:GetUpgradeTypeToActiveUpgradeShopData(v4)
	local levelStats = v3:GetLevelStats()
	local nextLevelStats = GetNextLevelStats(p) -- inferred equivalent call

	if not nextLevelStats then
		return
	end

	local hoverDescriptionAdditions = nextLevelStats.HoverDescriptionAdditions

	if hoverDescriptionAdditions then
		if typeof(hoverDescriptionAdditions) == "string" then
			if hoverDescriptionAdditions == "Gain %dHP per crate" then
				local baseCrateHP

				if v4 == Enums.Towers.Farm then
					local levelOnPath = v3:GetLevelOnPath(1)

					if levelOnPath >= 4 then
						baseCrateHP = towerConfig.BaseCrateHP + towerConfig.P1L5CrateHP
					elseif levelOnPath >= 2 then
						baseCrateHP = towerConfig.BaseCrateHP + towerConfig.P1L3CrateHP
					else
						baseCrateHP = towerConfig.BaseCrateHP
					end
				else
					warn("Not implemented for", v4)
					baseCrateHP = 0
				end

				local v7 = baseCrateHP * GetAmountFromUpgradeShop( -- inferred equivalent call
					upgradeTypeToActiveUpgradeShopData,
					Enums.TowerUpgradeShopTypes.HealthPerWave
				)
				local v8 = string.format("Gain %dHP per crate", (math.floor(v7)))
				v6:ActivateItem(string.upper(v8), {
					LayoutOrder = 200,
					ImageId = "rbxassetid://12191388343"
				})
			else
				v6:ActivateItem(string.upper(hoverDescriptionAdditions), {
					LayoutOrder = 200,
					ImageId = "rbxassetid://12191388343"
				})
			end
		elseif typeof(hoverDescriptionAdditions) == "table" then
			for i, hoverDescriptionAddition in ipairs(hoverDescriptionAdditions) do
				v6:ActivateItem(string.upper(hoverDescriptionAddition), {
					LayoutOrder = i + 200,
					ImageId = "rbxassetid://12191388343"
				})
			end
		end
	end

	local shipData = levelStats.ShipData
	local shipData2 = nextLevelStats.ShipData
	local v7 = shipData and TowerUtilities.GetMainAttackCount(shipData) or 1
	local levelOnPath = v3:GetLevelOnPath(p)
	local v8 = shipData2 and TowerUtilities.GetMainAttackCount(shipData2)

	if (v8 or v7 ~= 1 and levelOnPath > 2) and v7 ~= v8 then
		v6:ActivateItem(string.upper(`ATTACKS: {v7} → {v8 or 1}`), {
			LayoutOrder = v.RangeIncrease._LayoutOrder + 1,
			ImageId = "rbxassetid://14049011308",
			ImageScale = 0.9
		})
	end

	local flag = false

	for k in pairs(nextLevelStats) do
		if k == "RemoveBurst" then
			flag = true
		end
	end

	local overrideDisplayStats = v5.OverrideDisplayStats
	local v9 = false
	local flag2 = false

	for k in pairs(nextLevelStats) do
		local v10 = v[k]

		if k == "AbilityNames" then
			local abilityNames = nextLevelStats.AbilityNames

			for i, abilityName in ipairs(abilityNames) do
				local towerAbilityConfig = ResourceManager.GetTowerAbilityConfig(abilityName)

				if towerAbilityConfig then
					if not table.find(levelStats.AbilityConfigs, towerAbilityConfig) then
						local passive = towerAbilityConfig.Passive
						local passiveAbilityString = StatDisplayUtilities.GetPassiveAbilityString(
							towerAbilityConfig,
							GetAmountFromUpgradeShop(
								upgradeTypeToActiveUpgradeShopData,
								Enums.TowerUpgradeShopTypes.Damage
							)
						)
						v6:ActivateItem(
							(passive and "PASSIVE " or "") .. "ABILITY: " .. string.upper(passiveAbilityString),
							{
								LayoutOrder = v10._LayoutOrder + i + (passive and 10 or 0),
								ImageId = v10.ImageId,
								ImageScale = v10.ImageScale
							}
						)
					end
				else
					warn("Couldn't find ability with name " .. tostring(abilityName))
				end
			end
		elseif k == "BurnEffectStats" then
			local burnEffectStats = nextLevelStats.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(burnEffectStats.DamagePerSecond, 1)
			local stickDuration = math.round(burnEffectStats.StickDuration)
			v6:ActivateItem(string.upper(`{displayName} ({formatNumberStat} DPS for {stickDuration} seconds)`), {
				LayoutOrder = v10._LayoutOrder,
				ImageId = v10.ImageId,
				ImageScale = v10.ImageScale
			})
		elseif k == "ApplyBurnStats" then
			local applyBurnStats = nextLevelStats.ApplyBurnStats
			local formatNumberStat = FormatNumberStat(applyBurnStats.DamagePerSecond, 1)
			local stickDuration = math.round(applyBurnStats.StickDuration)
			v6:ActivateItem(string.upper(`Burn ({formatNumberStat} DPS for {stickDuration} seconds)`), {
				LayoutOrder = v10._LayoutOrder,
				ImageId = v10.ImageId,
				ImageScale = v10.ImageScale
			})
		elseif k == "AddSpawnPathEntityData" then
			local addSpawnPathEntityData = nextLevelStats.AddSpawnPathEntityData
			local amountFromUpgradeShop = GetAmountFromUpgradeShop( -- inferred equivalent call
				upgradeTypeToActiveUpgradeShopData,
				Enums.TowerUpgradeShopTypes.TroopHealth
			)
			local amountFromUpgradeShop2 = GetAmountFromUpgradeShop( -- inferred equivalent call
				upgradeTypeToActiveUpgradeShopData,
				Enums.TowerUpgradeShopTypes.TroopDamage
			)

			for _, v11 in pairs(addSpawnPathEntityData) do
				local pathEntityConfig = ResourceManager.GetPathEntityConfig(v11.PathEntityType)
				local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or v11.PathEntityType)
				local burstSize = v11.BurstSize or 1
				local v12 = v11.Interval - levelStats.SpawnPathEntityIntervalReduction
				local health = pathEntityConfig.Health
				local attacksDPS = TowerUtilities.CalculateAttacksDPS(pathEntityConfig.AttackData)
				local v13 = math.ceil(amountFromUpgradeShop * health)

				if attacksDPS then
					local v14 = math.round(amountFromUpgradeShop2 * attacksDPS)
					v6:ActivateItem(
						string.upper(`{overrideDisplayName} | {v13} HP | {v14} DPS | {burstSize} every {v12} seconds`),
						{
							LayoutOrder = v10._LayoutOrder,
							ImageId = v10.ImageId,
							ImageScale = v10.ImageScale
						}
					)
				else
					v6:ActivateItem(
						string.upper(`{overrideDisplayName} | {v13} HP | {burstSize} every {v12} seconds`),
						{
							LayoutOrder = v10._LayoutOrder,
							ImageId = v10.ImageId,
							ImageScale = v10.ImageScale
						}
					)
				end
			end
		elseif k == "RemoveSpawnPathEntityNames" then
			local removeSpawnPathEntityNames = nextLevelStats.RemoveSpawnPathEntityNames

			for _, removeSpawnPathEntityName in pairs(removeSpawnPathEntityNames) do
				local v11 = false

				if nextLevelStats.AddSpawnPathEntityData then
					for _, v12 in pairs(nextLevelStats.AddSpawnPathEntityData) do
						if v12.PathEntityType ~= removeSpawnPathEntityName then
							continue
						end

						v11 = true
						break
					end
				end

				if v11 then
					continue
				end

				local pathEntityConfig = ResourceManager.GetPathEntityConfig(removeSpawnPathEntityName)
				local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or removeSpawnPathEntityName)
				v6:ActivateItem(string.upper(`{overrideDisplayName} removed`), {
					LayoutOrder = v10._LayoutOrder,
					ImageId = v10.ImageId,
					ImageScale = v10.ImageScale
				})
			end
		elseif k == "DynamicPriceScaling" then
			local dynamicPriceScaling = nextLevelStats.DynamicPriceScaling
			v6:ActivateItem(string.upper(`DYNAMIC PRICE SCALING ({dynamicPriceScaling})`), {
				LayoutOrder = v10._LayoutOrder,
				ImageId = v10.ImageId,
				ImageScale = v10.ImageScale
			})
		else
			if k == "ReloadTimeDecrease" then
				if flag or levelStats.ReloadTimeHasBeenOverriden then
					continue
				end
			elseif k == "SplashMaximumTargetsHitIncrease" and levelStats.SplashHasBeenRemoved then
				continue
			end

			if v10 then
				local statName = v10.StatName
				local overrideDescriptionFunction = v10.OverrideDescriptionFunction
				local v11

				if statName then
					local v12 = string.split(statName, ".")
					v11 = levelStats

					for _, v13 in ipairs(v12) do
						v11 = v11[v13]
					end
				else
					v11 = statName
				end

				local v12 = nil

				if
					(not v10.IgnoreIfNotInOverrideDisplayStats or overrideDisplayStats and table.find(overrideDisplayStats, v10.StatName))
					and (not (levelStats.NoDisplayPierceCount or nextLevelStats.NoDisplayPierceCount) or statName ~= "PierceCount")
				then
					if typeof(v11) == "number" then
						local v13 = nextLevelStats[k]

						if k == "ArcSpreadAngleIncrease" then
							v11 = math.deg(v11)
						end

						if not v10.IsOverride then
							local v14

							if statName then
								local v15 = string.split(statName, ".")
								v14 = levelStats

								for _, v16 in ipairs(v15) do
									v14 = v14[v16]
								end
							else
								v14 = statName
							end

							if statName == "ArcMaximumRadians" then
								v14 = math.deg(v14)
							end

							v13 = v14 + v13 * (v10.IsDecrease and -1 or 1)
						end

						if v11 == v13 then
							continue
						end

						local flag3 = false

						if overrideDescriptionFunction then
							if k == "BodyHeatReductionIncrease" or k == "OverrideBodyHeatReduction" then
								v12 = overrideDescriptionFunction(
									v10,
									levelStats,
									v11,
									v13,
									upgradeTypeToActiveUpgradeShopData
								)
							elseif k == "CashPerTickOverride" or k == "CashTickDurationOverride" then
								if flag2 then
									v9 = true
								else
									local v14 = string.split("CashPerTick", ".")
									local cashPerTick = levelStats
									local v15 = { CashPerTick = 0, CashTickDuration = 0 }

									for _, v16 in ipairs(v14) do
										cashPerTick = cashPerTick[v16]
									end

									v15.CashPerTick = cashPerTick
									local v16 = string.split("CashTickDuration", ".")
									local cashTickDuration = levelStats

									for _, v17 in ipairs(v16) do
										cashTickDuration = cashTickDuration[v17]
									end

									v15.CashTickDuration = cashTickDuration
									v12 = overrideDescriptionFunction(v10, levelStats, v15, {
										CashPerTick = nextLevelStats.CashPerTickOverride or v15.CashPerTick,
										CashTickDuration = nextLevelStats.CashTickDurationOverride or v15.CashTickDuration
									}, upgradeTypeToActiveUpgradeShopData)
									flag2 = true
								end
							elseif k == "OverrideReloadTime" and not nextLevelStats.RemoveBurst then
								flag3 = true
							else
								v12 = overrideDescriptionFunction(
									v10,
									levelStats,
									v11,
									v13,
									upgradeTypeToActiveUpgradeShopData
								)
							end
						else
							flag3 = true
						end

						if flag3 then
							local decimalPlaces = v10.DecimalPlaces
							v12 = FormatNumberStat(v11, decimalPlaces) .. " " .. "→" .. " " .. FormatNumberStat(v13, decimalPlaces)
						end
					elseif overrideDescriptionFunction then
						v12 = overrideDescriptionFunction(
							v10,
							levelStats,
							nil,
							v10.IsOverride and nextLevelStats[k],
							upgradeTypeToActiveUpgradeShopData
						)
					end

					if v12 and not v9 then
						v6:ActivateItem(v12, {
							LayoutOrder = v10._LayoutOrder,
							ImageId = v10.ImageId,
							ImageScale = v10.ImageScale
						})
					end
				end
			end
		end
	end

	v6:ScaleFrame()
	v6:SetPosition(UDim2.new(1, 0, 0, p2.Position.Y.Offset))
	v6:ShowIfActiveItems()
end

function UpgradeHoverHandler.UpgradeUnhovered(p)
	if p == v2 then
		v6:Hide()
	end
end

for i, v7 in ipairs({
	{
		UpgradeName = "DamageIncrease",
		StatName = "Damage",
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Damage) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `DAMAGE: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "HealAmountIncrease",
		StatName = "HealAmount",
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, p2, p3, p4, p5)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p5, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			local v7 = p3 * amountFromUpgradeShop
			local v8 = p4 * amountFromUpgradeShop
			local reloadTime = p2.ReloadTime
			return `HEAL PER SECOND: {FormatNumberStat(v7 / reloadTime, p.DecimalPlaces)} → {FormatNumberStat(v8 / reloadTime, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "DamageIncreaseOverTimeMaxMultiplierOverride",
		StatName = "DamageIncreaseOverTimeMaxMultiplier",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `DAMAGE OVER TIME MAX MULTIPLIER: {not p2 and "N/A" or FormatNumberStat(p2, p.DecimalPlaces) or "N/A"} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "DamageIncreaseOverTimeDurationOverride",
		StatName = "DamageIncreaseOverTimeDuration",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `DAMAGE OVER TIME DURATION: {not p2 and "N/A" or FormatNumberStat(p2, p.DecimalPlaces) or "N/A"} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "DamageIncreaseOverTimeCooldownOverride",
		StatName = "DamageIncreaseOverTimeCooldown",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `DAMAGE OVER TIME COOLDOWN: {not p2 and "N/A" or FormatNumberStat(p2, p.DecimalPlaces) or "N/A"} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "DamageIncreasePerSecondOverride",
		StatName = "DamageIncreasePerSecond",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `DAMAGE INCREASE PER SECOND: {not p2 and "N/A" or FormatNumberStat(p2, p.DecimalPlaces) or "N/A"} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "BurnEffectStats",
		StatName = "BurnEffectStats",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9
	},
	{
		UpgradeName = "ApplyBurnStats",
		StatName = "ApplyBurnStats",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9
	},
	{
		UpgradeName = "ExtraDamageMultiplierIncrease",
		StatName = "ExtraDamageMultiplier",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `ENEMIES TAKE EXTRA DAMAGE: {FormatNumberStat(100 * p2, p.DecimalPlaces)}% → {FormatNumberStat(100 * p3, p.DecimalPlaces)}%`
		end
	},
	{
		UpgradeName = "ExtraDamageMultiplierBossIncrease",
		StatName = "ExtraDamageMultiplierBoss",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `BOSSES TAKE EXTRA DAMAGE: {FormatNumberStat(100 * p2, p.DecimalPlaces)}% → {FormatNumberStat(100 * p3, p.DecimalPlaces)}%`
		end
	},
	{
		UpgradeName = "ExtraDamageDurationIncrease",
		StatName = "ExtraDamageDuration",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `EXTRA DAMAGE DURATION: {FormatNumberStat(p2, p.DecimalPlaces)} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "BurnEffectDamagePerSecondIncrease",
		StatName = "BurnEffectStats.DamagePerSecond",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p4, p.DecimalPlaces)
			return `{string.upper(displayName)} DPS: {formatNumberStat} → {formatNumberStat2}`
		end
	},
	{
		UpgradeName = "OverrideBurnEffectEnemyBuffNames",
		StatName = "BurnEffectStats.EnemyBuffNames",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, _, list)
			if #list > 1 then
				warn("OverrideBurnEffectEnemyBuffNames does not currently support multiple enemy buffs. Only displaying the first buff.")
			end

			local v7 = list[1]

			if v7 then
				local enemyBuffConfig = ResourceManager.GetEnemyBuffConfig(v7)

				if enemyBuffConfig.Type == Enums.EnemyBuffTypes.DamageResistance then
					local v8 = math.round(100 * enemyBuffConfig.Percentage)
					local v9 = enemyBuffConfig.BossPercentage and math.round(100 * enemyBuffConfig.BossPercentage)

					if v9 == 0 then
						v9 = nil
					end

					if enemyBuffConfig.IsDebuff then
						return `REDUCE ENEMY DAMAGE RESISTANCES BY {v8}% {not v9 and "" or "(" .. v9 .. "% FOR BOSSES)"}`
					end

					return `INCREASE ENEMY DAMAGE RESISTANCES BY {v8}% {not v9 and "" or "(" .. v9 .. "% FOR BOSSES)"}`
				end
			end
		end
	},
	{
		UpgradeName = "BurnEffectRadiusIncrease",
		StatName = "BurnEffectStats.Radius",
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p4, p.DecimalPlaces)
			return `{string.upper(displayName)} RADIUS: {formatNumberStat} → {formatNumberStat2}`
		end
	},
	{
		UpgradeName = "BurnEffectDurationIncrease",
		StatName = "BurnEffectStats.Duration",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p4, p.DecimalPlaces)
			return `{string.upper(displayName)} DURATION: {formatNumberStat} → {formatNumberStat2}`
		end
	},
	{
		UpgradeName = "OverrideBurnEffectDuration",
		StatName = "BurnEffectStats.Duration",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p4, p.DecimalPlaces)
			return `{string.upper(displayName)} DURATION: {formatNumberStat} → {formatNumberStat2}`
		end
	},
	{
		UpgradeName = "BurnEffectStickDurationIncrease",
		StatName = "BurnEffectStats.StickDuration",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p4, p.DecimalPlaces)
			return `{string.upper(displayName)} STICK DURATION: {formatNumberStat} → {formatNumberStat2}`
		end
	},
	{
		UpgradeName = "OverrideBurnEffectMaximumTargetsHit",
		StatName = "BurnEffectStats.MaximumTargetsHit",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local burnEffectStats = p2.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(p4, p.DecimalPlaces)

			if not p3 or p3 > 10000 then
				return `{string.upper(displayName)} MAX TARGETS HIT: ∞ → {formatNumberStat}`
			end

			local formatNumberStat2 = FormatNumberStat(p3, p.DecimalPlaces)
			return `{string.upper(displayName)} MAX TARGETS HIT: {formatNumberStat2} → {formatNumberStat}`
		end
	},
	{
		UpgradeName = "StunDurationIncrease",
		StatName = "StunDuration",
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.StunDuration) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `STUN DURATION: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "SlowdownPercentageIncrease",
		StatName = "SlowdownPercentage",
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3, _)
			return `SLOWDOWN: {FormatNumberStat(p2, p.DecimalPlaces, true)}% → {FormatNumberStat(p3, p.DecimalPlaces, true)}%`
		end
	},
	{
		UpgradeName = "SlowdownDurationIncrease",
		StatName = "SlowdownDuration",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, _)
			return `SLOWDOWN DURATION: {FormatNumberStat(p2, p.DecimalPlaces)} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "CashPerWaveIncrease",
		StatName = "CashPerWave",
		ImageId = "rbxassetid://14037827267",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.CashPerWave) -- inferred equivalent call
			return `MORE CASH PER WAVE: {p * amountFromUpgradeShop} → {p2 * amountFromUpgradeShop}`
		end
	},
	{
		UpgradeName = "CashPerTickOverride",
		StatName = "CashPerTick",
		ImageId = "rbxassetid://70726090297438",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local cashPerTick = p.CashPerTick
			local cashTickDuration = p.CashTickDuration
			local cashPerTick2 = p2.CashPerTick
			local cashTickDuration2 = p2.CashTickDuration
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.CashPerSecond) -- inferred equivalent call
			return `{cashPerTick * amountFromUpgradeShop} CASH EVERY {cashTickDuration} SECONDS → {cashPerTick2 * amountFromUpgradeShop} CASH EVERY {cashTickDuration2} SECONDS`
		end
	},
	{
		UpgradeName = "CashTickDurationOverride",
		StatName = "CashTickDuration",
		ImageId = "rbxassetid://70726090297438",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local cashPerTick = p.CashPerTick
			local cashTickDuration = p.CashTickDuration
			local cashPerTick2 = p2.CashPerTick
			local cashTickDuration2 = p2.CashTickDuration
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.CashPerSecond) -- inferred equivalent call
			return `{cashPerTick * amountFromUpgradeShop} CASH EVERY {cashTickDuration} SECONDS → {cashPerTick2 * amountFromUpgradeShop} CASH EVERY {cashTickDuration2} SECONDS`
		end
	},
	{
		UpgradeName = "CashPerDamageMultiplierIncrease",
		StatName = "CashPerDamageMultiplier",
		ImageId = "rbxassetid://97821518331188",
		ImageScale = 1,
		DecimalPlaces = 2,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `CASH PER DAMAGE MULTIPLIER: {FormatNumberStat(p2 * 100, p.DecimalPlaces)}% → {FormatNumberStat(p3 * 100, p.DecimalPlaces)}%`
		end
	},
	{
		UpgradeName = "GoldWinBonusOverride",
		StatName = "GoldWinBonus",
		ImageId = "rbxassetid://84168181217670",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return `VICTORY GOLD BONUS: {p} → {p2}`
		end
	},
	{
		UpgradeName = "BodyHeatReductionIncrease",
		StatName = "BodyHeatReduction",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Freeze) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(v8, p.DecimalPlaces)
			return string.format("FREEZE AMOUNT: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "OverrideBodyHeatReduction",
		StatName = "BodyHeatReduction",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Freeze) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(v8, p.DecimalPlaces)
			return string.format("FREEZE AMOUNT: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "FrozenEnemyDamageMultiplierIncrease",
		StatName = "FrozenEnemyDamageMultiplier",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _, p, p2)
			local formatNumberStat = FormatNumberStat(p - 1, nil, true)
			local formatNumberStat2 = FormatNumberStat(p2 - 1, nil, true)
			return string.format("EXTRA DAMAGE ON FROZEN ENEMIES: %s%% → %s%%", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "PermanentSpeedMultiplierIfFrozenIncrease",
		StatName = "PermanentSpeedMultiplierIfFrozen",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _, p, p2)
			local formatNumberStat = FormatNumberStat(1 - p, nil, true)
			local formatNumberStat2 = FormatNumberStat(1 - p2, nil, true)
			return string.format(
				"PERMANENT SPEED REDUCTION IF FROZEN: %s%% → %s%%",
				formatNumberStat,
				formatNumberStat2
			)
		end
	},
	{
		UpgradeName = "DamageMultiplierIfFrozenIncrease",
		StatName = "DamageMultiplierIfFrozen",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _, p, p2)
			local formatNumberStat = FormatNumberStat(p - 1, nil, true)
			local formatNumberStat2 = FormatNumberStat(p2 - 1, nil, true)
			return string.format("TAKE EXTRA DAMAGE IF FROZEN: %s%% → %s%%", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "ThawTimeIfFrozenIncrease",
		StatName = "ThawTimeIfFrozen",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			local formatNumberStat = FormatNumberStat(p2, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p3, p.DecimalPlaces)
			return string.format("THAW TIME IF FROZEN: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "IgnoreIceResistance",
		StatName = "IgnoreIceResistance",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function()
			return "IGNORE ICE RESISTANCE"
		end
	},
	{
		UpgradeName = "CanFreezeBoss",
		StatName = "CanFreezeBoss",
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function()
			return "CAN FREEZE BOSSES"
		end
	},
	{
		UpgradeName = "DamageType",
		StatName = "DamageType",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, p, _, value)
			return `DAMAGE TYPE: {string.upper(p.DamageType)} → {string.upper(value)}`
		end
	},
	{
		UpgradeName = "GainIgnoreResistance",
		StatName = "IgnoreResistance",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, p)
			return `IGNORE {string.upper(p.DamageType)} RESISTANCE`
		end
	},
	{
		UpgradeName = "RemoveIgnoreResistance",
		StatName = "IgnoreResistance",
		ImageId = "rbxassetid://15498074529",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, p)
			return `REMOVE IGNORE {string.upper(p.DamageType)} RESISTANCE`
		end
	},
	{
		UpgradeName = "StaticEntityLifetimeIncrease",
		StatName = "StaticEntityLifetime",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, p2, p3, p4)
			local staticEntityConfig = ResourceManager.GetStaticEntityConfig(p2.SpawnStaticEntityName)
			return `{string.upper(staticEntityConfig.OverrideDisplayName or p2.SpawnStaticEntityName)} LIFETIME: {FormatNumberStat(p3, p.DecimalPlaces)} → {FormatNumberStat(p4, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "SplashRadiusIncrease",
		StatName = "SplashRadius",
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Splash) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(v8, p.DecimalPlaces)
			return string.format("SPLASH RADIUS: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "RemoveSplash",
		StatName = "SplashDamage",
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		OverrideDescriptionFunction = function()
			return "NO SPLASH DAMAGE"
		end
	},
	{
		UpgradeName = "PrimaryTargetMultiplierOverride",
		StatName = "PrimaryTargetMultiplier",
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			local formatNumberStat = FormatNumberStat(p2, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p3, p.DecimalPlaces)
			return string.format("PRIMARY TARGET MULTIPLIER: %sX → %sX", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "AimTimeOverride",
		StatName = "AimTime",
		ImageId = "rbxassetid://15643912892",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			local formatNumberStat = FormatNumberStat(p2, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(p3, p.DecimalPlaces)
			return string.format("AIM TIME: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "SplashMaximumTargetsHitIncrease",
		StatName = "SplashMaximumTargetsHit",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			if p > 10000 then
				return string.format("MAX TARGETS HIT: ∞ → %d", p2)
			end

			return string.format("MAX TARGETS HIT: %d → %d", p, p2)
		end
	},
	{
		UpgradeName = "SplashMaximumTargetsHitOverride",
		StatName = "SplashMaximumTargetsHit",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, p, p2)
			if p > 10000 then
				return string.format("MAX TARGETS HIT: ∞ → %d", p2)
			end

			return string.format("MAX TARGETS HIT: %d → %d", p, p2)
		end
	},
	{
		UpgradeName = "ArcMaximumTargetsHitIncrease",
		StatName = "ArcMaximumTargetsHit",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return string.format("TARGETS HIT: %d → %d", p, p2)
		end
	},
	{
		UpgradeName = "ArcSpreadAngleIncrease",
		StatName = "ArcMaximumRadians",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return string.format("ARC ANGLE: %d° → %d°", p, p2)
		end
	},
	{
		UpgradeName = "ChainCountIncrease",
		StatName = "ChainCount",
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return `CHAIN COUNT: {p} → {p2}`
		end
	},
	{
		UpgradeName = "NearbyTowerFirerateBuffIncrease",
		StatName = "NearbyTowerFirerateBuff",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, _)
			local formatNumberStat = FormatNumberStat(p, nil, true)
			local formatNumberStat2 = FormatNumberStat(p2, nil, true)
			return string.format("FIRERATE BUFF: %s%% → %s%%", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "NearbyTowerRangeBuffIncrease",
		StatName = "NearbyTowerRangeBuff",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.RangeBuff) -- inferred equivalent call
			local v7 = p * amountFromUpgradeShop
			local v8 = p2 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, nil, true)
			local formatNumberStat2 = FormatNumberStat(v8, nil, true)
			return string.format("RANGE BUFF: %s%% → %s%%", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "NearbyTowerDamageBuffIncrease",
		StatName = "NearbyTowerDamageBuff",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.DamageBuff) -- inferred equivalent call
			local v7 = p * amountFromUpgradeShop
			local v8 = p2 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, nil, true)
			local formatNumberStat2 = FormatNumberStat(v8, nil, true)
			return string.format("DAMAGE BUFF: %s%% → %s%%", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "NearbyTowerDiscountIncrease",
		StatName = "NearbyTowerDiscount",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, _)
			local formatNumberStat = FormatNumberStat(p, nil, true)
			local formatNumberStat2 = FormatNumberStat(p2, nil, true)
			return string.format(
				"NEARBY TOWER DISCOUNT: %s%% → %s%% (EXCEPT MAX UPGRADES)",
				formatNumberStat,
				formatNumberStat2
			)
		end
	},
	{
		UpgradeName = "NearbyTowerSellbackIncrease",
		StatName = "NearbyTowerSellback",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop( -- inferred equivalent call
				p3,
				Enums.TowerUpgradeShopTypes.NearbyTowerSellbackValue
			)
			p *= amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(p2 * amountFromUpgradeShop, nil, true)
			return string.format("NEARBY TOWER SELLBACK: %s%%", formatNumberStat)
		end
	},
	{
		UpgradeName = "NearbyTowerDeathCashbackIncrease",
		StatName = "NearbyTowerDeathCashback",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, _, p, _)
			local formatNumberStat = FormatNumberStat(p, nil, true)
			return string.format("NEARBY TOWER DEATH CASHBACK: %s%%", formatNumberStat)
		end
	},
	{
		UpgradeName = "NearbyTowerHealPerSecondIncrease",
		StatName = "NearbyTowerHealPerSecond",
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			p2 *= amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(p3 * amountFromUpgradeShop, p.DecimalPlaces)
			return string.format("NEARBY TOWER HEAL PER SECOND: %s", formatNumberStat)
		end
	},
	{
		UpgradeName = "ReviveDurationDecrease",
		StatName = "ReviveDuration",
		ImageId = "",
		ImageScale = 0.9,
		IsDecrease = true,
		DecimalPlaces = 2,
		OverrideDescriptionFunction = function(p, _, p2, p3, _)
			return `REVIVE DURATION: {FormatNumberStat(p2, p.DecimalPlaces)} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "ReloadTimeDecrease",
		StatName = "ReloadTime",
		ImageId = "rbxassetid://12191387561",
		ImageScale = 0.9,
		IsDecrease = true,
		DecimalPlaces = 2,
		OverrideDescriptionFunction = function(p, p2, p3, p4, p5)
			if p2.HealAmount then
				return
			end

			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p5, Enums.TowerUpgradeShopTypes.Firerate) -- inferred equivalent call
			local v7 = p3 * amountFromUpgradeShop
			local v8 = p4 * amountFromUpgradeShop
			return `RELOAD TIME: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "OverrideReloadTime",
		StatName = "ReloadTime",
		ImageId = "rbxassetid://12191387561",
		ImageScale = 0.9,
		DecimalPlaces = 3,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Firerate) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			local formatNumberStat = FormatNumberStat(v7, p.DecimalPlaces)
			local formatNumberStat2 = FormatNumberStat(v8, p.DecimalPlaces)
			return string.format("AUTO CONVERSION: %s → %s", formatNumberStat, formatNumberStat2)
		end
	},
	{
		UpgradeName = "CashPerCompletedBurstIncrease",
		StatName = "CashPerCompletedBurst",
		ImageId = "rbxassetid://15498074414",
		ImageScale = 1,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.CashPerFullReload) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `FULL RELOAD CASH: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "BurstSizeIncrease",
		StatName = "BurstSize",
		ImageId = "rbxassetid://12734318416",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return string.format("BURST SIZE: %d → %d", p, p2)
		end
	},
	{
		UpgradeName = "BurstSizeOverride",
		StatName = "BurstSize",
		ImageId = "rbxassetid://12734318416",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return string.format("BURST SIZE: %d → %d", p, p2)
		end
	},
	{
		UpgradeName = "RangeIncrease",
		StatName = "Range",
		ImageId = "rbxassetid://12191389133",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Range) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `RANGE: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "MinRangeOverride",
		StatName = "MinRange",
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `MIN RANGE: {FormatNumberStat(p2, p.DecimalPlaces)} → {FormatNumberStat(p3, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "KnockbackStudsOverride",
		StatName = "KnockbackStuds",
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `KNOCKBACK: {FormatNumberStat(p2, p.DecimalPlaces)} → {FormatNumberStat(p3, p.DecimalPlaces)} STUDS`
		end
	},
	{
		UpgradeName = "KnockbackSuspendTimeOverride",
		StatName = "KnockbackSuspendTime",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			return `SUSPEND: {FormatNumberStat(p2, p.DecimalPlaces)} SECONDS → {FormatNumberStat(p3, p.DecimalPlaces)} SECONDS`
		end
	},
	{
		UpgradeName = "PierceCountIncrease",
		StatName = "PierceCount",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Pierce) -- inferred equivalent call
			local v7 = p + amountFromUpgradeShop
			local v8 = p2 + amountFromUpgradeShop
			return string.format("PIERCE: %d → %d", v7, v8)
		end
	},
	{
		UpgradeName = "GainStealthDetection",
		StatName = "StealthDetection",
		ImageId = "rbxassetid://12191387908",
		ImageScale = 0.95,
		OverrideDescriptionFunction = function()
			return "STEALTH DETECTION"
		end
	},
	{
		UpgradeName = "GainCanTargetAir",
		StatName = "CanTargetAir",
		ImageId = "rbxassetid://101046814547305",
		ImageScale = 1,
		OverrideDescriptionFunction = function()
			return "CAN TARGET AIR ENEMIES"
		end
	},
	{
		UpgradeName = "GainStunImmunity",
		StatName = "StunImmunity",
		ImageId = "rbxassetid://80304437071744",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function()
			return "STUN IMMUNITY"
		end
	},
	{
		UpgradeName = "GainStealth",
		StatName = "Stealth",
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function()
			return "STEALTH"
		end
	},
	{
		UpgradeName = "TimeToRegainStealthOverride",
		StatName = "TimeToRegainStealth",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(p, _, p2, p3)
			local formatNumberStat = FormatNumberStat(p3, p.DecimalPlaces)

			if p2 then
				return `REGAIN STEALTH TIME: {FormatNumberStat(p2, p.DecimalPlaces)} → {formatNumberStat}`
			end

			return `REGAIN STEALTH TIME: {formatNumberStat}`
		end
	},
	{
		UpgradeName = "AddSpawnPathEntityData",
		StatName = "SpawnPathEntityData",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1
	},
	{
		UpgradeName = "RemoveSpawnPathEntityNames",
		StatName = "SpawnPathEntityData",
		ImageId = "rbxassetid://15498074529",
		ImageScale = 0.9
	},
	{
		UpgradeName = "ReduceSpawnPathEntityInterval",
		StatName = "SpawnPathEntityIntervalReduction",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return `REDUCE ALL SPAWN INTERVALS: {p} → {p2}`
		end
	},
	{
		UpgradeName = "MovementSpeedIncrease",
		StatName = "MovementSpeed",
		ImageId = "rbxassetid://74056988555860",
		ImageScale = 1,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.MovementSpeed) -- inferred equivalent call
			return `MOVEMENT SPEED: {p * amountFromUpgradeShop} → {p2 * amountFromUpgradeShop}`
		end
	},
	{
		UpgradeName = "MaximumROMIncrease",
		StatName = "MaximumROM",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_, _, p, p2)
			return `RANGE OF MOTION: {p} → {p2}`
		end
	},
	{
		UpgradeName = "MaximumROMOverride",
		StatName = "MaximumROM",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, value, p)
			return `RANGE OF MOTION: {value or 360} → {p}`
		end
	},
	{
		UpgradeName = "RemoveMaximumROM",
		StatName = "MaximumROM",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, _, _)
			return "UNLIMITED RANGE OF MOTION"
		end
	},
	{
		UpgradeName = "GainIgnoreObstacles",
		StatName = "IgnoreObstacles",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		OverrideDescriptionFunction = function(_, _)
			return "IGNORE OBSTACLES"
		end
	},
	{
		UpgradeName = "ShieldSharedGrantIncrease",
		StatName = "ShieldSharedGrant",
		ImageId = "rbxassetid://121224933813250",
		ImageScale = 1,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `SHARED SHIELD GRANT: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "ShieldSharedGrantRemove",
		StatName = "ShieldSharedGrant",
		ImageId = "rbxassetid://15498074529",
		ImageScale = 0.9,
		IsOverride = true,
		OverrideDescriptionFunction = function(_, _, _, _)
			return "SHARED SHIELD GRANT REMOVED"
		end
	},
	{
		UpgradeName = "ShieldDirectGrantIncrease",
		StatName = "ShieldDirectGrant",
		ImageId = "rbxassetid://129365774406947",
		ImageScale = 1,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `DIRECT SHIELD GRANT: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "ShieldGrantRefreshTimeDecrease",
		StatName = "ShieldGrantRefreshTime",
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		IsDecrease = true,
		DecimalPlaces = 1,
		OverrideDescriptionFunction = function(p, _, p2, p3, p4)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p4, Enums.TowerUpgradeShopTypes.ShieldRegenSpeed) -- inferred equivalent call
			local v7 = p2 * amountFromUpgradeShop
			local v8 = p3 * amountFromUpgradeShop
			return `SHIELD GRANT INTERVAL: {FormatNumberStat(v7, p.DecimalPlaces)} → {FormatNumberStat(v8, p.DecimalPlaces)}`
		end
	},
	{
		UpgradeName = "AbilityNames",
		StatName = "AbilityConfigs",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1
	},
	{
		UpgradeName = "DisableManualAiming",
		StatName = "DisableManualAiming",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		OverrideDescriptionFunction = function(_)
			return "AUTOMATIC AIMING"
		end
	},
	{
		UpgradeName = "HealthIncrease",
		StatName = "Health",
		ImageId = "rbxassetid://103814500469848",
		ImageScale = 1,
		DecimalPlaces = 0,
		IgnoreIfNotInOverrideDisplayStats = true,
		OverrideDescriptionFunction = function(_, _, p, p2, p3)
			local amountFromUpgradeShop = GetAmountFromUpgradeShop(p3, Enums.TowerUpgradeShopTypes.Health) -- inferred equivalent call
			return `HEALTH: {p * amountFromUpgradeShop} → {p2 * amountFromUpgradeShop}`
		end
	},
	{
		UpgradeName = "GainUntargetable",
		StatName = "Untargetable",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 0,
		OverrideDescriptionFunction = function(_, _, _, _, _)
			return "NOT TARGETABLE"
		end
	},
	{
		UpgradeName = "DynamicPriceScaling",
		StatName = "DynamicPriceScaling",
		ImageId = "rbxassetid://15498074414",
		ImageScale = 1,
		DecimalPlaces = 0
	}
}) do
	v[v7.UpgradeName] = v7
	v7._LayoutOrder = i
end

UpgradeHoverHandler.UpgradeUnhovered()
return UpgradeHoverHandler