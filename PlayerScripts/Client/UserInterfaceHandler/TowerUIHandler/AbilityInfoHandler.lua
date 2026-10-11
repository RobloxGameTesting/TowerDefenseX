local AbilityInfoHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local v = {
	"ProjectileHitData.SpawnStaticEntityData",
	"ProjectileHitData.Damage",
	"ProjectileHitData.PrimaryTargetExtraDamage",
	"ProjectileHitData.TowerStealthDuration",
	"RadiusDamage",
	"BodyHeatReduction",
	"ApplyBurnStats",
	"ProjectileHitData.DamageData.ExtraDamageData.DamageMultiplier",
	"ProjectileHitData.DamageData.ExtraDamageData.BossDamageMultiplier",
	"ProjectileHitData.DamageData.IceDamageData.BodyHeatReduction",
	"ProjectileHitData.DamageData.StunData.StunDuration",
	"ProjectileHitData.DamageData.StunData.IgnoreStunResistance",
	"ProjectileHitData.BurnEffectStats",
	"ProjectileHitData.SplashRadius",
	"TowerBuffNames",
	"SpawnPathEntityData",
	"SpawnStaticEntityData",
	"HasRevealEffect",
	"ProjectileHitData.MaximumTargetsHit",
	"RadiusDamageMaximumTargets",
	"Unstun",
	"HealPercentage",
	"HealAmount",
	"CustomQueryData",
	"ContinuousForTime",
	"MainAttackOverrideData.Damage",
	"MainAttackOverrideData.DamageType",
	"MainAttackOverrideData.ReloadTime",
	"MainAttackOverrideData.Range",
	"MainAttackOverrideData.SplashRadius",
	"MainAttackOverrideDataDuration"
}
local FormatNumberStat = Utilities.FormatNumberStat

local function GetStatFromStatName(p, value: string)
	local v2 = string.split(value, ".")

	for _, v3 in ipairs(v2) do
		p = p[v3]
	end

	return p
end

local function HasPassiveAbilityStatAndPassiveAbility(p, statName: string) -- 1 equivalent call inferred from this helper
	local selected = string.sub(statName, 1, 14) == "PassiveAbility"
	return selected, selected and p.Passive and true or false
end

local function ShouldIgnore(data, data2)
	local v2, v3 = HasPassiveAbilityStatAndPassiveAbility(data2, data.StatName) -- inferred equivalent call

	if v2 then
		return not v3
	else
		if data.IgnoreIfStatNameIsNilOrFalse then
			for _, v4 in ipairs(data.IgnoreIfStatNameIsNilOrFalse) do
				local v5 = string.split(v4, ".")
				local v6 = data2

				for _, v7 in ipairs(v5) do
					v6 = v6[v7]
				end

				if not v6 then
					return true
				end
			end
		end

		if data.IgnoreIfStatNameIsNilOrFalse2 then
			local ignoreIfStatNameIsNilOrFalse2 = data.IgnoreIfStatNameIsNilOrFalse2
			local v4 = string.split(ignoreIfStatNameIsNilOrFalse2, ".")
			local v5 = data2

			for _, v6 in ipairs(v4) do
				v5 = v5[v6]
			end

			if not v5 then
				return true
			end
		end

		if data.IgnoreIfStatNameIsTrue then
			local ignoreIfStatNameIsTrue = data.IgnoreIfStatNameIsTrue
			local v4 = string.split(ignoreIfStatNameIsTrue, ".")
			local v5 = data2

			for _, v6 in ipairs(v4) do
				v5 = v5[v6]
			end

			if v5 then
				return true
			end
		end

		if data.IgnoreIfStatNameEqualsMap then
			local statName = data.StatName
			local v4 = string.split(statName, ".")
			local v5 = data2

			for _, v6 in ipairs(v4) do
				v5 = v5[v6]
			end

			if v5 == data.IgnoreIfStatNameEqualsMap[data.StatName] then
				return true
			end
		end

		if not data.IgnoreIfStatNameGreaterThanMap then
			return false
		end

		for k, v4 in pairs(data.IgnoreIfStatNameGreaterThanMap) do
			local v5 = string.split(k, ".")
			local v6 = data2

			for _, v7 in ipairs(v5) do
				v6 = v6[v7]
			end

			if v6 and v4 < v6 then
				return true
			end
		end

		return false
	end
end

local function GetAmountFromUpgradeShop(p, damage: string) -- 2 equivalent calls inferred from this helper
	return TowerUpgradeShopUtilities.GetAmount(p, damage)
end

local LocalPlayer = Players.LocalPlayer
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local towerUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local uiScale = towerUI:WaitForChild("UIScale")
local v2 = {}
local v3 = {
	towerUI:WaitForChild("AbilityStats1"),
	towerUI:WaitForChild("AbilityStats2"),
	towerUI:WaitForChild("AbilityStats3"),
	towerUI:WaitForChild("AbilityStats4")
}
local v4 = {
	ScalingCardClass.New(v3[1], 7, { uiScale }),
	ScalingCardClass.New(v3[2], 7, { uiScale }),
	ScalingCardClass.New(v3[3], 7, { uiScale }),
	ScalingCardClass.New(v3[4], 7, { uiScale })
}
local v5 = { false, false, false }
local v6 = { false, false, false }

local function UpdateVisibility(p: number) -- 3 equivalent calls inferred from this helper
	v3[p].Visible = v6[p] and v5[p]
end

function AbilityInfoHandler.AbilityChanged(p: number, data, p2)
	if data.NoShowInfo then
		v3[p].Visible = false
		return
	end

	local upgradeTypeToActiveUpgradeShopData = localPlayerWrapper.UpgradeShopDataHandler:GetUpgradeTypeToActiveUpgradeShopData(p2.Type)
	local overrideDisplayStats = data.OverrideDisplayStats or v
	local displayStatAdditions = data.DisplayStatAdditions
	local v7 = v4[p]
	v7:DeactivateAllItems()
	v7:ActivateItem(data.DisplayName:upper(), {
		LayoutOrder = -1,
		TextSize = 22,
		TextYAlignment = Enum.TextYAlignment.Center
	})

	for _, overrideDisplayStat in pairs(overrideDisplayStats) do
		local v8 = v2[overrideDisplayStat]

		if v8 then
			if not ShouldIgnore(v8, data) then
				local descriptionFunction = v8:DescriptionFunction(data, upgradeTypeToActiveUpgradeShopData, p2)

				if descriptionFunction then
					if typeof(descriptionFunction) == "table" then
						for _, v9 in pairs(descriptionFunction) do
							v7:ActivateItem(v9, {
								LayoutOrder = v8._LayoutOrder,
								ImageId = v8.ImageId,
								ImageScale = v8.ImageScale
							})
						end
					else
						v7:ActivateItem(descriptionFunction, {
							LayoutOrder = v8._LayoutOrder,
							ImageId = v8.ImageId,
							ImageScale = v8.ImageScale
						})
					end
				end
			end
		else
			warn("StatInfoData not implemented for", overrideDisplayStat)
		end
	end

	if displayStatAdditions then
		for i, displayStatAddition in ipairs(displayStatAdditions) do
			v7:ActivateItem(displayStatAddition.Text, {
				LayoutOrder = 100 + i,
				ImageId = displayStatAddition.ImageId or "rbxassetid://12191388343",
				ImageScale = displayStatAddition.ImageScale or 1
			})
		end
	end

	v7:ScaleFrame()
	v5[p] = v7:GetActiveItemCount() > 0
	UpdateVisibility(p) -- inferred equivalent call
end

function AbilityInfoHandler.Show(p: number)
	v6[p] = true
	UpdateVisibility(p) -- inferred equivalent call
end

function AbilityInfoHandler.Hide(p: number)
	v6[p] = false
	UpdateVisibility(p) -- inferred equivalent call
end

function AbilityInfoHandler.AtLeastOneActiveItem(p: number)
	return v5[p]
end

for i, v7 in ipairs({
	{
		StatName = "ProjectileHitData.SpawnStaticEntityData",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.SpawnStaticEntityData" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			local values = {}
			local spawnStaticEntityData = p.ProjectileHitData.SpawnStaticEntityData
			local name = spawnStaticEntityData.Name
			local lifetime = spawnStaticEntityData.Lifetime
			local staticEntityConfig = ResourceManager.GetStaticEntityConfig(name)
			local overrideDisplayName = string.upper(staticEntityConfig.OverrideDisplayName or name)

			if spawnStaticEntityData.DamageStatsTransferredToStaticEntity then
				local formatted = `SPAWN: {overrideDisplayName}`

				if lifetime then
					formatted ..= ` | LASTS {lifetime} SECONDS`
				end

				table.insert(values, formatted)
				return values
			else
				local collisionHealth = staticEntityConfig.CollisionHealth
				local formatted = `SPAWN: {overrideDisplayName}`

				if collisionHealth then
					formatted ..= ` | {collisionHealth} HP`
				end

				if lifetime then
					formatted ..= ` | LASTS {lifetime} SECONDS`
				end

				table.insert(values, formatted)
				return values
			end
		end
	},
	{
		StatName = "ProjectileHitData.Damage",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.Damage" },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2, _)
			return `DAMAGE: {FormatNumberStat(
				p.ProjectileHitData.Damage * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Damage),
				self.DecimalPlaces
			)}` -- inferred equivalent call
		end
	},
	{
		StatName = "ProjectileHitData.PrimaryTargetExtraDamage",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.PrimaryTargetExtraDamage" },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			return `PRIMARY TARGET EXTRA DAMAGE: {FormatNumberStat(p.ProjectileHitData.PrimaryTargetExtraDamage, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ProjectileHitData.TowerStealthDuration",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.TowerStealthDuration" },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _, _)
			return `STEALTH TOWERS FOR {FormatNumberStat(p.ProjectileHitData.TowerStealthDuration, self.DecimalPlaces)} SECONDS`
		end
	},
	{
		StatName = "RadiusDamage",
		IgnoreIfStatNameIsNilOrFalse = { "RadiusDamage" },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2, _)
			local v7 = p.RadiusDamage * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Damage) -- inferred equivalent call
			local continuousReloadTime = p.ContinuousReloadTime
			local formatNumberStat = FormatNumberStat(v7 / (continuousReloadTime or 1), self.DecimalPlaces)

			if continuousReloadTime then
				return `DAMAGE: {formatNumberStat} PER SECOND`
			end

			return `DAMAGE: {formatNumberStat}`
		end
	},
	{
		StatName = "BodyHeatReduction",
		IgnoreIfStatNameIsNilOrFalse = { "BodyHeatReduction" },
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			local bodyHeatReduction = p.BodyHeatReduction
			local continuousReloadTime = p.ContinuousReloadTime
			local formatNumberStat = FormatNumberStat(
				bodyHeatReduction / (continuousReloadTime or 1),
				self.DecimalPlaces
			)

			if continuousReloadTime then
				return `FREEZE AMOUNT: {formatNumberStat} PER SECOND`
			end

			return `FREEZE AMOUNT: {formatNumberStat}`
		end
	},
	{
		StatName = "ApplyBurnStats",
		IgnoreIfStatNameIsNilOrFalse = { "ApplyBurnStats" },
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			local applyBurnStats = p.ApplyBurnStats
			local formatNumberStat = FormatNumberStat(applyBurnStats.DamagePerSecond, self.DecimalPlaces)
			local stickDuration = math.round(applyBurnStats.StickDuration)
			return string.upper(`Burn ({formatNumberStat} DPS for {stickDuration} seconds)`)
		end
	},
	{
		StatName = "ProjectileHitData.DamageData.ExtraDamageData.DamageMultiplier",
		IgnoreIfStatNameIsNilOrFalse = {
			"ProjectileHitData",
			"ProjectileHitData.DamageData",
			"ProjectileHitData.DamageData.ExtraDamageData",
			"ProjectileHitData.DamageData.ExtraDamageData.DamageMultiplier"
		},
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _, _)
			local projectileHitData = p.ProjectileHitData
			local damageMultiplier = projectileHitData.DamageData.ExtraDamageData.DamageMultiplier

			if damageMultiplier == 0 then
				return
			end

			local v7 = damageMultiplier * 100
			local duration = projectileHitData.DamageData.ExtraDamageData.Duration
			return `ENEMIES TAKE +{FormatNumberStat(v7, self.DecimalPlaces)}% DAMAGE FOR {FormatNumberStat(duration, 1)} SECONDS`
		end
	},
	{
		StatName = "ProjectileHitData.DamageData.ExtraDamageData.BossDamageMultiplier",
		IgnoreIfStatNameIsNilOrFalse = {
			"ProjectileHitData",
			"ProjectileHitData.DamageData",
			"ProjectileHitData.DamageData.ExtraDamageData",
			"ProjectileHitData.DamageData.ExtraDamageData.BossDamageMultiplier"
		},
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _, _)
			local projectileHitData = p.ProjectileHitData
			local bossDamageMultiplier = projectileHitData.DamageData.ExtraDamageData.BossDamageMultiplier

			if bossDamageMultiplier == 0 then
				return
			end

			local v7 = bossDamageMultiplier * 100
			local duration = projectileHitData.DamageData.ExtraDamageData.Duration
			return `BOSSES TAKE +{FormatNumberStat(v7, self.DecimalPlaces)}% DAMAGE FOR {FormatNumberStat(duration, 1)} SECONDS`
		end
	},
	{
		StatName = "ProjectileHitData.DamageData.IceDamageData.BodyHeatReduction",
		IgnoreIfStatNameIsNilOrFalse = {
			"ProjectileHitData",
			"ProjectileHitData.DamageData",
			"ProjectileHitData.DamageData.IceDamageData",
			"ProjectileHitData.DamageData.IceDamageData.BodyHeatReduction"
		},
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			return `FREEZE AMOUNT: {FormatNumberStat(p.ProjectileHitData.DamageData.IceDamageData.BodyHeatReduction, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ProjectileHitData.DamageData.StunData.StunDuration",
		IgnoreIfStatNameIsNilOrFalse = {
			"ProjectileHitData",
			"ProjectileHitData.DamageData",
			"ProjectileHitData.DamageData.StunData",
			"ProjectileHitData.DamageData.StunData.StunDuration"
		},
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			return `STUN DURATION: {FormatNumberStat(p.ProjectileHitData.DamageData.StunData.StunDuration, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ProjectileHitData.DamageData.StunData.IgnoreStunResistance",
		IgnoreIfStatNameIsNilOrFalse = {
			"ProjectileHitData",
			"ProjectileHitData.DamageData",
			"ProjectileHitData.DamageData.StunData",
			"ProjectileHitData.DamageData.StunData.IgnoreStunResistance"
		},
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, _, _, _)
			return "IGNORE STUN RESISTANCE"
		end
	},
	{
		StatName = "ProjectileHitData.BurnEffectStats",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.BurnEffectStats" },
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			local result = {}
			local burnEffectStats = p.ProjectileHitData.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = FormatNumberStat(burnEffectStats.DamagePerSecond, self.DecimalPlaces)
			local stickDuration = math.round(burnEffectStats.StickDuration)
			local enemyBuffNames = burnEffectStats.EnemyBuffNames
			table.insert(result, string.upper(`{displayName} ({formatNumberStat} DPS for {stickDuration} seconds)`))

			if not enemyBuffNames then
				return result
			end

			for _, enemyBuffName in pairs(enemyBuffNames) do
				local enemyBuffConfig = ResourceManager.GetEnemyBuffConfig(enemyBuffName)

				if enemyBuffConfig.Type ~= Enums.EnemyBuffTypes.DamageResistance then
					continue
				end

				local v7 = math.round(100 * enemyBuffConfig.Percentage)
				local v8 = enemyBuffConfig.BossPercentage and math.round(100 * enemyBuffConfig.BossPercentage)

				if v8 == 0 then
					v8 = nil
				end

				if enemyBuffConfig.IsDebuff then
					table.insert(result, string.upper(`ENEMY DAMAGE RESISTANCES REDUCED BY {v7}%`))
				else
					table.insert(result, string.upper(`ENEMY DAMAGE RESISTANCES INCREASED BY {v7}%`))
				end

				if not v8 then
					continue
				end

				if enemyBuffConfig.IsDebuff then
					table.insert(result, string.upper(`BOSS DAMAGE RESISTANCES REDUCED BY {v8}%`))
				else
					table.insert(result, string.upper(`BOSS DAMAGE RESISTANCES INCREASED BY {v8}%`))
				end
			end

			return result
		end
	},
	{
		StatName = "ProjectileHitData.SplashRadius",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.IsSplash" },
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			return `SPLASH RADIUS: {FormatNumberStat(p.ProjectileHitData.SplashRadius, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "TowerBuffNames",
		IgnoreIfStatNameIsNilOrFalse = { "TowerBuffNames" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			local towerBuffNames = p.TowerBuffNames
			local result = {}

			for _, towerBuffName in pairs(towerBuffNames) do
				local towerBuffConfig = ResourceManager.GetTowerBuffConfig(towerBuffName)

				if not towerBuffConfig then
					continue
				end

				local formatNumberStat = FormatNumberStat(towerBuffConfig.Percentage, nil, true)
				local v7 = nil
				local v8 = nil
				local executionTime

				if towerBuffConfig.DependentOnAbilityBeingActive then
					executionTime = p.ExecutionTime
				else
					executionTime = towerBuffConfig.Time
				end

				if towerBuffConfig.Type == Enums.TowerBuffTypes.Firerate then
					v7 = "FIRERATE BUFF:"
				elseif
					towerBuffConfig.Type == Enums.TowerBuffTypes.Range
					or towerBuffConfig.Type == Enums.TowerBuffTypes.Range2
					or towerBuffConfig.Type == Enums.TowerBuffTypes.Range3
				then
					v7 = "RANGE BUFF:"
				elseif
					towerBuffConfig.Type == Enums.TowerBuffTypes.Damage
					or towerBuffConfig.Type == Enums.TowerBuffTypes.Damage2
					or towerBuffConfig.Type == Enums.TowerBuffTypes.Damage3
				then
					v7 = "DAMAGE BUFF:"
				elseif towerBuffConfig.Type == Enums.TowerBuffTypes.Heal then
					if not towerBuffConfig.HealPerSecond then
						continue
					end

					v8 = `HEAL ALLIES {math.round(towerBuffConfig.HealPerSecond * towerBuffConfig.Time)} HP`
				elseif towerBuffConfig.Type == Enums.TowerBuffTypes.Uber then
					v8 = "UBER: INVULNERABLE FOR " .. executionTime .. " SECONDS"
				else
					warn("Buff type not implemented for", towerBuffConfig.Type)
					continue
				end

				if not v8 then
					if towerBuffConfig.NoDisplayDurationForAbilityInfo then
						v8 = v7 .. " " .. formatNumberStat .. "%"
					else
						v8 = v7 .. " " .. formatNumberStat .. "% FOR " .. executionTime .. " SECONDS"
					end
				end

				table.insert(result, v8)
			end

			return result
		end
	},
	{
		StatName = "SpawnPathEntityData",
		IgnoreIfStatNameIsNilOrFalse = { "SpawnPathEntityData" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			local spawnPathEntityData = p.SpawnPathEntityData
			local result = {}

			for _, v7 in pairs(spawnPathEntityData) do
				local pathEntityType = v7.PathEntityType
				local pathEntityConfig = ResourceManager.GetPathEntityConfig(pathEntityType)

				if not pathEntityConfig then
					continue
				end

				local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or pathEntityType)
				local health = pathEntityConfig.Health
				local attacksDPS = TowerUtilities.CalculateAttacksDPS(pathEntityConfig.AttackData)
				local formatted = `SPAWN: {string.upper(overrideDisplayName)} | {health} HP`

				if attacksDPS then
					formatted ..= " | " .. math.round(attacksDPS) .. " DPS"
				end

				table.insert(result, formatted)
			end

			return result
		end
	},
	{
		StatName = "SpawnStaticEntityData",
		IgnoreIfStatNameIsNilOrFalse = { "SpawnStaticEntityData" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			local spawnStaticEntityData = p.SpawnStaticEntityData
			local result = {}

			for _, v7 in pairs(spawnStaticEntityData) do
				local staticEntityType = v7.StaticEntityType
				local staticEntityConfig = ResourceManager.GetStaticEntityConfig(staticEntityType)

				if not staticEntityConfig then
					continue
				end

				local overrideDisplayName = string.upper(staticEntityConfig.OverrideDisplayName or staticEntityType)
				local lifetime = staticEntityConfig.Lifetime
				local attacksDPS = TowerUtilities.CalculateAttacksDPS(staticEntityConfig.AttackData)
				local stealthRevealData = staticEntityConfig.StealthRevealData
				local multiHealData = staticEntityConfig.MultiHealData
				local formatted = `SPAWN: {string.upper(overrideDisplayName)}`

				if lifetime then
					formatted ..= " | LASTS " .. lifetime .. " SECONDS"
				end

				if stealthRevealData then
					formatted ..= " | REVEALS STEALTH"
				end

				if multiHealData then
					local healAmountPerTarget = multiHealData.HealAmountPerTarget
					local reloadTime = multiHealData.ReloadTime
					local maximumTargets = multiHealData.MaximumTargets
					formatted ..= " | " .. healAmountPerTarget * (1 / reloadTime) .. " HEAL PER SECOND | " .. maximumTargets .. " TARGETS"
				elseif attacksDPS then
					formatted ..= " | " .. math.round(attacksDPS) .. " DPS"
				end

				table.insert(result, formatted)
			end

			return result
		end
	},
	{
		StatName = "HasRevealEffect",
		IgnoreIfStatNameIsNilOrFalse = { "HasRevealEffect" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			local revealPermanent = p.RevealPermanent
			local revealTime = p.RevealTime

			if revealPermanent then
				return "REVEAL ENEMIES PERMANENTLY"
			end

			return "REVEAL ENEMIES FOR " .. FormatNumberStat(revealTime, 1) .. " SECONDS"
		end
	},
	{
		StatName = "ProjectileHitData.MaximumTargetsHit",
		IgnoreIfStatNameIsNilOrFalse = { "ProjectileHitData", "ProjectileHitData.MaximumTargetsHit" },
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _, _)
			return `MAX TARGETS HIT: {FormatNumberStat(p.ProjectileHitData.MaximumTargetsHit, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "RadiusDamageMaximumTargets",
		IgnoreIfStatNameIsNilOrFalse = { "RadiusDamageMaximumTargets" },
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _, _)
			return `MAX TARGETS HIT: {FormatNumberStat(p.RadiusDamageMaximumTargets, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "Unstun",
		IgnoreIfStatNameIsNilOrFalse = { "Unstun" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			if p.TargetSelf then
				return "REMOVE STUN DEBUFFS"
			end

			return "UNSTUN ALLIES"
		end
	},
	{
		StatName = "HealPercentage",
		IgnoreIfStatNameIsNilOrFalse = { "HealPercentage" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			if p.TargetSelf then
				return `HEAL {math.round(p.HealPercentage * 100)}% HP`
			end

			return `HEAL ALLIES {math.round(p.HealPercentage * 100)}% HP`
		end
	},
	{
		StatName = "HealAmount",
		IgnoreIfStatNameIsNilOrFalse = { "HealAmount" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, _)
			if p.TargetSelf then
				return `HEAL {p.HealAmount} HP`
			end

			return `HEAL ALLIES {p.HealAmount} HP`
		end
	},
	{
		StatName = "CustomQueryData",
		IgnoreIfStatNameIsNilOrFalse = { "CustomQueryData" },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			local customQueryData = p.CustomQueryData
			local v7 = {}

			if customQueryData.QueryType then
				table.insert(v7, `TARGETS {string.upper(customQueryData.QueryType)} ENEMY`)
			end

			return v7
		end
	},
	{
		StatName = "ContinuousForTime",
		IgnoreIfStatNameIsNilOrFalse = { "ContinuousForTime" },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			return `LASTS {FormatNumberStat(p.ContinuousForTime, self.DecimalPlaces)} SECONDS`
		end
	},
	{
		StatName = "MainAttackOverrideData.Damage",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideData", "MainAttackOverrideData.Damage" },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, p2)
			local damage = p2.LevelHandler:GetLevelStats().Damage
			local damage2 = p.MainAttackOverrideData.Damage
			return `DAMAGE: {FormatNumberStat(damage, self.DecimalPlaces)} → {FormatNumberStat(damage2, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MainAttackOverrideData.DamageType",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideData", "MainAttackOverrideData.DamageType" },
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DescriptionFunction = function(self, p, _, p2)
			local levelStats = p2.LevelHandler:GetLevelStats()
			return `DAMAGE TYPE: {string.upper(levelStats.DamageType)} → {string.upper(p.MainAttackOverrideData.DamageType)}`
		end
	},
	{
		StatName = "MainAttackOverrideData.Range",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideData", "MainAttackOverrideData.Range" },
		ImageId = "rbxassetid://12191389133",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, p2)
			local range = p2.LevelHandler:GetLevelStats().Range
			local range2 = p.MainAttackOverrideData.Range
			return `RANGE: {FormatNumberStat(range, self.DecimalPlaces)} → {FormatNumberStat(range2, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MainAttackOverrideData.ReloadTime",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideData", "MainAttackOverrideData.ReloadTime" },
		ImageId = "rbxassetid://12191387561",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(self, p, _, p2)
			local reloadTime = p2.LevelHandler:GetLevelStats().ReloadTime
			local reloadTime2 = p.MainAttackOverrideData.ReloadTime
			return `RELOAD TIME: {FormatNumberStat(reloadTime, self.DecimalPlaces)} → {FormatNumberStat(reloadTime2, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MainAttackOverrideData.SplashRadius",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideData", "MainAttackOverrideData.SplashRadius" },
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _, p2)
			local splashRadius = p2.LevelHandler:GetLevelStats().SplashRadius
			local splashRadius2 = p.MainAttackOverrideData.SplashRadius
			return `SPLASH RADIUS: {FormatNumberStat(splashRadius, self.DecimalPlaces)} → {FormatNumberStat(splashRadius2, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MainAttackOverrideDataDuration",
		IgnoreIfStatNameIsNilOrFalse = { "MainAttackOverrideDataDuration" },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			return `ACTIVE FOR {FormatNumberStat(p.MainAttackOverrideDataDuration, self.DecimalPlaces)} SECONDS`
		end
	}
}) do
	v2[v7.StatName] = v7
	v7._LayoutOrder = i
end

return AbilityInfoHandler