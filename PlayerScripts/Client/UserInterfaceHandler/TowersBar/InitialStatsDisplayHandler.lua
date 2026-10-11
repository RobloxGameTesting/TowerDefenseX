local InitialStatsDisplayHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("TowerBuffUtilities"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
local StatDisplayUtilities = require(common:WaitForChild("StatDisplayUtilities"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local v = {
	"Damage",
	"HealAmount",
	"BurnEffectStats",
	"BodyHeatReduction",
	"SplashRadius",
	"ReloadTime",
	"BaitEnemyAttacks",
	"ShieldSharedGrant",
	"ShieldDirectGrant",
	"ShieldGrantRefreshTime",
	"Range",
	"StunDuration",
	"SlowdownPercentage",
	"ChainCount",
	"PierceCount",
	"MovementSpeed",
	"MaximumROM",
	"StealthDetection",
	"CanTargetAir",
	"AirUnitDamageMultiplier",
	"IgnoreGround"
}

local function HasPassiveAbilityStatAndPassiveAbility(p, statName: string)
	local v2 = string.sub(statName, 1, 14) == "PassiveAbility"
	local v3 = false

	if not v2 then
		return v2, false
	end

	local v4 = {}
	local abilityNames = p.AbilityNames

	if abilityNames then
		for _, abilityName in ipairs(abilityNames) do
			table.insert(v4, (ResourceManager.GetTowerAbilityConfig(abilityName)))
		end
	end

	for _, v5 in ipairs(v4) do
		if v5.Passive then
			v3 = true
		end
	end

	return v2, v3
end

local function ShouldIgnore(data, baseLevelData)
	local statName = data.StatName
	local v2, v3 = HasPassiveAbilityStatAndPassiveAbility(baseLevelData, statName)

	if v2 then
		return not v3
	else
		if
			not baseLevelData[statName]
			or data.IgnoreIfStatNameIsNilOrFalse and not baseLevelData[data.IgnoreIfStatNameIsNilOrFalse]
			or data.IgnoreIfStatNameIsTrue and baseLevelData[data.IgnoreIfStatNameIsTrue]
			or data.IgnoreIfStatNameEqualsMap and baseLevelData[statName] == data.IgnoreIfStatNameEqualsMap[statName]
		then
			return true
		end

		if data.IgnoreIfStatNameGreaterThanMap then
			for k, v4 in pairs(data.IgnoreIfStatNameGreaterThanMap) do
				local v5 = baseLevelData[k]

				if v5 and v4 < v5 then
					return true
				end
			end
		end

		if baseLevelData.NoDisplayPierceCount and statName == "PierceCount" then
			return true
		end

		return false
	end
end

local function GetAmountFromUpgradeShop(p, damage: string) -- 19 equivalent calls inferred from this helper
	return TowerUpgradeShopUtilities.GetAmount(p, damage)
end

local LocalPlayer = Players.LocalPlayer
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local bottomBar = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar")
local initialStats = bottomBar:WaitForChild("InitialStats")
local v2 = {}
local v3 = { bottomBar:WaitForChild("UIScale"), (initialStats:WaitForChild("UIScale")) }
local v4 = ScalingCardClass.New(initialStats, 8, v3)
local v5 = false
local v6 = false

local function UpdateVisibility() -- 3 equivalent calls inferred from this helper
	initialStats.Visible = v6 and v5
end

function InitialStatsDisplayHandler.Show(p)
	v4:DeactivateAllItems()
	local towerName = p.TowerName

	if towerName then
		local towerConfig = ResourceManager.GetTowerConfig(towerName)
		local baseLevelData = towerConfig.UpgradePathData.BaseLevelData
		local overrideDisplayStats = towerConfig.OverrideDisplayStats or v

		if towerConfig.AdditionalDisplayStats then
			overrideDisplayStats = table.clone(overrideDisplayStats)

			for _, additionalDisplayStat in ipairs(towerConfig.AdditionalDisplayStats) do
				if not table.find(overrideDisplayStats, additionalDisplayStat) then
					table.insert(overrideDisplayStats, additionalDisplayStat)
				end
			end
		end

		v4:ActivateItem(towerName:upper(), {
			LayoutOrder = -1,
			TextSize = 24,
			TextYAlignment = Enum.TextYAlignment.Center
		})

		for _, overrideDisplayStat in pairs(overrideDisplayStats) do
			local v7 = v2[overrideDisplayStat]

			if v7 then
				if not ShouldIgnore(v7, baseLevelData) then
					v4:ActivateItem(
						v7:DescriptionFunction(
							baseLevelData,
							(localPlayerWrapper.UpgradeShopDataHandler:GetUpgradeTypeToActiveUpgradeShopData(towerName))
						),
						{
							LayoutOrder = v7._LayoutOrder,
							ImageId = v7.ImageId,
							ImageScale = v7.ImageScale
						}
					)
				end
			else
				warn("StatInfoData not implemented for", overrideDisplayStat)
			end
		end

		if towerName == Enums.Towers.Farm then
			local farmAdditionalStatStrings = StatDisplayUtilities.GetFarmAdditionalStatStrings(0, 0, true)

			for i, farmAdditionalStatString in ipairs(farmAdditionalStatStrings) do
				v4:ActivateItem(farmAdditionalStatString, {
					LayoutOrder = 100 + i,
					ImageId = StatDisplayUtilities.GetDefaultHoverAdditionIcon(),
					ImageScale = 1
				})
			end
		end

		if baseLevelData.SpawnPathEntityData then
			for i, v7 in ipairs(baseLevelData.SpawnPathEntityData) do
				local pathEntityConfig = ResourceManager.GetPathEntityConfig(v7.PathEntityType)
				local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or v7.PathEntityType)
				local health = pathEntityConfig.Health
				local attacksDPS = TowerUtilities.CalculateAttacksDPS(pathEntityConfig.AttackData)

				if attacksDPS then
					local v8 = math.round(attacksDPS)
					v4:ActivateItem(string.upper(`{overrideDisplayName} | {health} HP | {v8} DPS`), {
						LayoutOrder = 110 + i,
						ImageId = "rbxassetid://12191388343",
						ImageScale = 1
					})
				else
					v4:ActivateItem(string.upper(`{overrideDisplayName} | {health} HP`), {
						LayoutOrder = 110 + i,
						ImageId = "rbxassetid://12191388343",
						ImageScale = 1
					})
				end
			end
		end

		if towerConfig.IgnoreAirPlacementLimit then
			v4:ActivateItem("IGNORE AIR PLACEMENT LIMIT", {
				LayoutOrder = 100,
				ImageId = "rbxassetid://12191388343",
				ImageScale = 1
			})
		end

		v4:ScaleFrame()
		local towerFrame = p.TowerFrame
		local parent = initialStats.Parent
		local absolutePosition = towerFrame.AbsolutePosition
		local absoluteSize = towerFrame.AbsoluteSize
		local absolutePosition2 = parent.AbsolutePosition
		local absoluteSize2 = parent.AbsoluteSize
		local v7 = (absolutePosition.X + absoluteSize.X / 2 - absolutePosition2.X) / absoluteSize2.X
		local v8 = (absolutePosition.Y - absolutePosition2.Y) / absoluteSize2.Y
		v4:SetPosition(UDim2.new(v7, 0, v8, -8))
		v5 = v4:GetActiveItemCount() > 0
		v6 = true
		UpdateVisibility() -- inferred equivalent call
	else
		v5 = false
		UpdateVisibility() -- inferred equivalent call
	end
end

function InitialStatsDisplayHandler.Hide()
	v6 = false
	UpdateVisibility() -- inferred equivalent call
end

for i, v7 in ipairs({
	{
		StatName = "Damage",
		IgnoreIfStatNameEqualsMap = { Damage = 0 },
		ImageId = "rbxassetid://12191387711",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.Damage * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Damage) -- inferred equivalent call
			return `DAMAGE: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "HealAmount",
		IgnoreIfStatNameIsNilOrFalse = "HealAmount",
		IgnoreIfStatNameEqualsMap = { HealAmount = 0 },
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.HealAmount / p.ReloadTime * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			return `HEAL PER SECOND: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "BurnEffectStats",
		IgnoreIfStatNameIsNilOrFalse = "BurnEffectStats",
		ImageId = "rbxassetid://15246030444",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _)
			local burnEffectStats = p.BurnEffectStats
			local displayName = burnEffectStats.DisplayName or burnEffectStats.Name
			local formatNumberStat = Utilities.FormatNumberStat(burnEffectStats.DamagePerSecond, self.DecimalPlaces)
			local stickDuration = math.round(burnEffectStats.StickDuration)
			return string.upper(`{displayName} ({formatNumberStat} DPS for {stickDuration} seconds)`)
		end
	},
	{
		StatName = "CashPerWave",
		IgnoreIfStatNameIsNilOrFalse = "CashPerWave",
		IgnoreIfStatNameEqualsMap = { CashPerWave = 0 },
		ImageId = "rbxassetid://14037827267",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.CashPerWave * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.CashPerWave) -- inferred equivalent call
			return `CASH PER WAVE: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "CashPerTick",
		IgnoreIfStatNameIsNilOrFalse = "CashPerTick",
		IgnoreIfStatNameEqualsMap = { CashPerTick = 0 },
		ImageId = "rbxassetid://70726090297438",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			return `{p.CashPerTick * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.CashPerSecond)} CASH EVERY {Utilities.FormatNumberStat(p.CashTickDuration, self.DecimalPlaces)} SECONDS` -- inferred equivalent call
		end
	},
	{
		StatName = "CashPerDamageMultiplier",
		IgnoreIfStatNameIsNilOrFalse = "CashPerDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { CashPerDamageMultiplier = 0 },
		ImageId = "rbxassetid://97821518331188",
		ImageScale = 1,
		DecimalPlaces = 2,
		DescriptionFunction = function(self, p, _)
			return `CASH PER DAMAGE MULTIPLIER: {p.CashPerDamageMultiplier}`
		end
	},
	{
		StatName = "GoldWinBonus",
		IgnoreIfStatNameIsNilOrFalse = "GoldWinBonus",
		IgnoreIfStatNameEqualsMap = { GoldWinBonus = 0 },
		ImageId = "rbxassetid://84168181217670",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _)
			return `CASH PER DAMAGE MULTIPLIER: {p.GoldWinBonus}`
		end
	},
	{
		StatName = "BodyHeatReduction",
		IgnoreIfStatNameEqualsMap = { BodyHeatReduction = 0 },
		ImageId = "rbxassetid://14376195522",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.BodyHeatReduction * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Freeze) -- inferred equivalent call
			return `FREEZE AMOUNT: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "SplashRadius",
		IgnoreIfStatNameIsNilOrFalse = "IsSplash",
		ImageId = "rbxassetid://14037827106",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.SplashRadius * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Splash) -- inferred equivalent call
			return `SPLASH RADIUS: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ReloadTime",
		IgnoreIfStatNameGreaterThanMap = { HealAmount = 0 },
		ImageId = "rbxassetid://12191387561",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.ReloadTime * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Firerate) -- inferred equivalent call
			return `RELOAD TIME: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "NearbyTowerFirerateBuff",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerFirerateBuff",
		IgnoreIfStatNameEqualsMap = { NearbyTowerFirerateBuff = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(self, p, _)
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
		DescriptionFunction = function(self, p, p2)
			local v7 = p.NearbyTowerRangeBuff * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.RangeBuff) -- inferred equivalent call
			return `RANGE BUFF: {Utilities.FormatNumberStat(v7, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerDamageBuff",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerDamageBuff",
		IgnoreIfStatNameEqualsMap = { NearbyTowerDamageBuff = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.NearbyTowerDamageBuff * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.DamageBuff) -- inferred equivalent call
			return `DAMAGE BUFF: {Utilities.FormatNumberStat(v7, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerDiscount",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerDiscount",
		IgnoreIfStatNameEqualsMap = { NearbyTowerDiscount = 0 },
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(self, p, _)
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
		DescriptionFunction = function(self, p, p2)
			local v7 = p.NearbyTowerSellback * GetAmountFromUpgradeShop( -- inferred equivalent call
				p2,
				Enums.TowerUpgradeShopTypes.NearbyTowerSellbackValue
			)
			return `NEARBY TOWER SELLBACK: {Utilities.FormatNumberStat(v7, nil, true)}%`
		end
	},
	{
		StatName = "NearbyTowerHealPerSecond",
		IgnoreIfStatNameIsNilOrFalse = "NearbyTowerHealPerSecond",
		IgnoreIfStatNameEqualsMap = { NearbyTowerHealPerSecond = 0 },
		ImageId = "rbxassetid://17664702175",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.NearbyTowerHealPerSecond * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Heal) -- inferred equivalent call
			return `NEARBY TOWER HEAL PER SECOND: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "BaitEnemyAttacks",
		IgnoreIfStatNameIsNilOrFalse = "BaitEnemyAttacks",
		ImageId = "rbxassetid://14049011308",
		ImageScale = 0.9,
		DescriptionFunction = function(self, _, _)
			return "BAIT ENEMY ATTACKS"
		end
	},
	{
		StatName = "ShieldSharedGrant",
		IgnoreIfStatNameEqualsMap = { ShieldSharedGrant = 0 },
		ImageId = "rbxassetid://121224933813250",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.ShieldSharedGrant * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			return `SHARED SHIELD GRANT: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ShieldDirectGrant",
		IgnoreIfStatNameEqualsMap = { ShieldDirectGrant = 0 },
		ImageId = "rbxassetid://129365774406947",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.ShieldDirectGrant * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Shield) -- inferred equivalent call
			return `DIRECT SHIELD GRANT: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "ShieldGrantRefreshTime",
		IgnoreIfStatNameEqualsMap = { ShieldGrantRefreshTime = 0 },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.ShieldGrantRefreshTime * GetAmountFromUpgradeShop( -- inferred equivalent call
				p2,
				Enums.TowerUpgradeShopTypes.ShieldRegenSpeed
			)
			return `SHIELD GRANT INTERVAL: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "Range",
		ImageId = "rbxassetid://12191389133",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.Range * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Range) -- inferred equivalent call
			return `RANGE: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "KnockbackStuds",
		IgnoreIfStatNameEqualsMap = { KnockbackStuds = 0 },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _)
			local knockbackStuds = p.KnockbackStuds
			return `KNOCKBACK: {Utilities.FormatNumberStat(knockbackStuds, self.DecimalPlaces)} STUDS`
		end
	},
	{
		StatName = "KnockbackSuspendTime",
		IgnoreIfStatNameEqualsMap = { KnockbackSuspendTime = 0 },
		ImageId = "rbxassetid://15498074294",
		ImageScale = 0.9,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, _)
			local knockbackSuspendTime = p.KnockbackSuspendTime
			return `SUSPEND: {Utilities.FormatNumberStat(knockbackSuspendTime, self.DecimalPlaces)} SECONDS`
		end
	},
	{
		StatName = "StunDuration",
		IgnoreIfStatNameEqualsMap = { StunDuration = 0 },
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 2,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.StunDuration * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.StunDuration) -- inferred equivalent call
			return `STUN DURATION: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "SlowdownPercentage",
		IgnoreIfStatNameEqualsMap = { SlowdownPercentage = 0, SlowdownDuration = 0 },
		IgnoreIfStatNameIsNilOrFalse = "SlowdownDuration",
		ImageId = "rbxassetid://14376195685",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _)
			local slowdownPercentage = p.SlowdownPercentage or 0
			local slowdownDuration = p.SlowdownDuration or 0
			return `{Utilities.FormatNumberStat(slowdownPercentage, self.DecimalPlaces, true)}% SLOWDOWN FOR {Utilities.FormatNumberStat(slowdownDuration, 1)} SECONDS`
		end
	},
	{
		StatName = "ChainCount",
		IgnoreIfStatNameEqualsMap = { ChainCount = 0 },
		ImageId = "rbxassetid://12191387329",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _)
			return `CHAIN COUNT: {Utilities.FormatNumberStat(p.ChainCount, self.DecimalPlaces)} ({math.round((p.ChainDamageMultiplier or 0) * 100)}% DAMAGE)`
		end
	},
	{
		StatName = "PierceCount",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.PierceCount + GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Pierce) -- inferred equivalent call
			return `PIERCE: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MovementSpeed",
		IgnoreIfStatNameIsNilOrFalse = "MovementSpeed",
		ImageId = "rbxassetid://83017077237761",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.MovementSpeed * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.MovementSpeed) -- inferred equivalent call
			return `MOVEMENT SPEED: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "MaximumROM",
		IgnoreIfStatNameIsNilOrFalse = "MaximumROM",
		ImageId = "rbxassetid://12191388203",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, _)
			local maximumROM = p.MaximumROM
			return `RANGE OF MOTION: {Utilities.FormatNumberStat(maximumROM, self.DecimalPlaces)}°`
		end
	},
	{
		StatName = "StealthDetection",
		IgnoreIfStatNameIsNilOrFalse = "StealthDetection",
		ImageId = "rbxassetid://12191387908",
		ImageScale = 0.95,
		DescriptionFunction = function(self, _, _)
			return "STEALTH DETECTION"
		end
	},
	{
		StatName = "CanTargetAir",
		IgnoreIfStatNameIsNilOrFalse = "CanTargetAir",
		ImageId = "rbxassetid://101046814547305",
		ImageScale = 1,
		DescriptionFunction = function(self, _, _)
			return "CAN TARGET AIR ENEMIES"
		end
	},
	{
		StatName = "AirUnitDamageMultiplier",
		IgnoreIfStatNameEqualsMap = { AirUnitDamageMultiplier = 1 },
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DescriptionFunction = function(self, p, _)
			return `AIR ENEMIES TAKE +{Utilities.FormatNumberStat(100 * (p.AirUnitDamageMultiplier - 1), 0)}% DAMAGE`
		end
	},
	{
		StatName = "IgnoreGround",
		IgnoreIfStatNameIsNilOrFalse = "IgnoreGround",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(self, _, _)
			return "CANNOT TARGET GROUND ENEMIES"
		end
	},
	{
		StatName = "IgnoreObstacles",
		IgnoreIfStatNameIsNilOrFalse = "IgnoreObstacles",
		ImageId = "rbxassetid://14573048133",
		ImageScale = 0.9,
		DescriptionFunction = function(self, _, _)
			return "IGNORE OBSTACLES"
		end
	},
	{
		StatName = "Health",
		ImageId = "rbxassetid://103814500469848",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p, p2)
			local v7 = p.Health * GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Health) -- inferred equivalent call
			return `HEALTH: {Utilities.FormatNumberStat(v7, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "PassiveAbility",
		ImageId = "rbxassetid://12191388343",
		ImageScale = 1,
		DescriptionFunction = function(self, p, p2)
			local abilityNames = p.AbilityNames
			local v7 = {}

			for _, abilityName in ipairs(abilityNames) do
				table.insert(v7, (ResourceManager.GetTowerAbilityConfig(abilityName)))
			end

			if not v7 then
				warn("No AbilityConfigs found")
				return ""
			end

			local function FindNextPassiveAbilityIndex()
				local count = 0

				for i, v8 in ipairs(v7) do
					if not v8.Passive then
						continue
					end

					count += 1

					if count == 1 then
						return i
					end
				end

				return nil
			end

			local v8 = v7[FindNextPassiveAbilityIndex()]

			if v8 then
				return "PASSIVE ABILITY: " .. StatDisplayUtilities.GetPassiveAbilityString(
					v8,
					GetAmountFromUpgradeShop(p2, Enums.TowerUpgradeShopTypes.Damage)
				)
			end

			warn(`Missing AbilityConfig for PassiveAbility (Index = {1})`)
			return ""
		end
	}
}) do
	v2[v7.StatName] = v7
	v7._LayoutOrder = i
end

InitialStatsDisplayHandler.Hide()
return InitialStatsDisplayHandler