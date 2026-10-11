local TowerUpgradeShopUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local v = {
	{
		Type = Enums.TowerUpgradeShopTypes.Health,
		DisplayString = "+%d%% Health",
		Icon = "rbxassetid://123699131196380",
		IconColor = Color3.fromHex("E8739A"),
		AffectsHealthHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Shield,
		DisplayString = "+%d%% Shield",
		Icon = "rbxassetid://71411141718245",
		IconColor = Color3.fromHex("9EBCDB"),
		AffectsHealthHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.ShieldRegenSpeed,
		DisplayString = "+%d%% Faster Shield Regen",
		IsReduction = true,
		Icon = "rbxassetid://138716473702989",
		IconColor = Color3.fromHex("C42525"),
		AffectsHealthHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Heal,
		DisplayString = "+%d%% Healing",
		Icon = "rbxassetid://96965055747589",
		IconColor = Color3.fromHex("C42525"),
		AffectsHealHandler = true,
		AffectsNearbyTowerBuffData = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Damage,
		DisplayString = "+%d%% Damage",
		Icon = "rbxassetid://72257435110934",
		IconColor = Color3.fromHex("C42525"),
		AffectsAttackHandler = true,
		AffectsAbilityHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.ChainDamage,
		DisplayString = "+%d%% Chain Damage",
		Icon = "rbxassetid://86750810319582",
		IconColor = Color3.fromHex("FFFFFF"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Range,
		DisplayString = "+%d%% Range",
		Icon = "rbxassetid://94816374060434",
		IconColor = Color3.fromHex("FFA600"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Firerate,
		DisplayString = "-%d%% Reload Time",
		IsReduction = true,
		Icon = "rbxassetid://124728312033314",
		IconColor = Color3.fromHex("B4FF00"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Splash,
		DisplayString = "+%d%% Splash Radius",
		Icon = "rbxassetid://121555757147883",
		IconColor = Color3.fromHex("32D0C0"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Pierce,
		DisplayString = "+%d Pierce",
		NotPercentage = true,
		Icon = "rbxassetid://85802199128388",
		IconColor = Color3.fromHex("E500FF"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.Freeze,
		DisplayString = "+%d%% Freeze",
		Icon = "rbxassetid://100103552647115",
		IconColor = Color3.fromHex("9EBCDB"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.StunDuration,
		DisplayString = "+%d%% Stun Duration",
		Icon = "rbxassetid://115854354672996",
		IconColor = Color3.fromHex("B4FF00"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.CashPerSecond,
		DisplayString = "+%d%% Cash Per Second",
		Icon = "rbxassetid://78620084214244",
		IconColor = Color3.fromHex("B4FF00")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.CashPerWave,
		DisplayString = "+%d%% Cash Per Wave",
		Icon = "rbxassetid://78620084214244",
		IconColor = Color3.fromHex("B4FF00")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.CashPerFullReload,
		DisplayString = "+%d%% Cash Per Full Reload",
		Icon = "rbxassetid://78620084214244",
		IconColor = Color3.fromHex("B4FF00")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.HealthPerWave,
		DisplayString = "+%d%% Health Per Wave",
		Icon = "rbxassetid://96965055747589",
		IconColor = Color3.fromHex("C42525")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopHealth,
		DisplayString = "+%d%% Troop Health",
		Icon = "rbxassetid://120229032597905",
		IconColor = Color3.fromHex("E8739A"),
		AffectsHealthHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopDamage,
		DisplayString = "+%d%% Troop Damage",
		Icon = "rbxassetid://72257435110934",
		IconColor = Color3.fromHex("C42525"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.TroopRange,
		DisplayString = "+%d%% Troop Range",
		Icon = "rbxassetid://94816374060434",
		IconColor = Color3.fromHex("FFA600"),
		AffectsAttackHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.DamageBuff,
		DisplayString = "+%d%% Damage Buff",
		Icon = "rbxassetid://118918162807578",
		IconColor = Color3.fromHex("32D0C0"),
		AffectsNearbyTowerBuffData = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.RangeBuff,
		DisplayString = "+%d%% Range Buff",
		Icon = "rbxassetid://74204531420459",
		IconColor = Color3.fromHex("E500FF"),
		AffectsNearbyTowerBuffData = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.NearbyTowerSellbackValue,
		DisplayString = "+%d%% Nearby Tower Sellback Value",
		Icon = "rbxassetid://78620084214244",
		IconColor = Color3.fromHex("B4FF00"),
		AffectsNearbyTowerBuffData = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.MovementSpeed,
		DisplayString = "+%d%% Movement Speed",
		Icon = "rbxassetid://134872865187813",
		IconColor = Color3.fromHex("9EBCDB"),
		AffectsHeliMovementHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.AbilityCooldowns,
		DisplayString = "-%d%% Ability Cooldowns",
		IsReduction = true,
		Icon = "rbxassetid://83389552974124",
		IconColor = Color3.fromHex("9EBCDB"),
		AffectsAbilityHandler = true
	},
	{
		Type = Enums.TowerUpgradeShopTypes.RebuildCount,
		DisplayString = "+%d%% Rebuild Count",
		Icon = "rbxassetid://82650619071041",
		IconColor = Color3.fromHex("E500FF")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.RebuildSpeed,
		DisplayString = "+%d%% Rebuild Speed",
		Icon = "rbxassetid://85302818979090",
		IconColor = Color3.fromHex("B4FF00")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.HealthPerKill,
		DisplayString = "+%d%% ",
		Icon = "rbxassetid://88247217070764",
		IconColor = Color3.fromHex("FFFFFF")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.GasCloudArea,
		DisplayString = "+%d%% ",
		Icon = "rbxassetid://88242936904163",
		IconColor = Color3.fromHex("E500FF")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.GasStickDuration,
		DisplayString = "+%d%% ",
		Icon = "rbxassetid://138912898658750",
		IconColor = Color3.fromHex("B4FF00")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.CollisionResistance,
		DisplayString = "+%d%% Collision Resistance",
		Icon = "rbxassetid://103196161195286",
		IconColor = Color3.fromHex("C42525")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.HealthOnKill,
		DisplayString = "+%d%% Health On Kill",
		Icon = "rbxassetid://88247217070764",
		IconColor = Color3.fromHex("FFFFFF")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.StealthRegainSpeed,
		DisplayString = "+%d%% Stealth Regain Speed",
		Icon = "rbxassetid://96048252544213",
		IconColor = Color3.fromHex("272727")
	},
	{
		Type = Enums.TowerUpgradeShopTypes.StealthBuilding,
		DisplayString = "Gain Stealth",
		NotPercentage = true,
		Icon = "rbxassetid://96048252544213",
		IconColor = Color3.fromHex("272727")
	}
}
local v2 = {}
local v3 = {}

function TowerUpgradeShopUtilities.GetDefaultMaxLevel()
	return 5
end

function TowerUpgradeShopUtilities.GetUpgradeShopTypeData(p: string)
	local v4 = v2[p]

	if v4 then
		return v4
	end

	warn("No upgrade shop type data found for type: " .. tostring(p))
	return v2[Enums.TowerUpgradeShopTypes.Health]
end

function TowerUpgradeShopUtilities.GetAmount(p, p2: string)
	local upgradeShopTypeData = TowerUpgradeShopUtilities.GetUpgradeShopTypeData(p2)
	local v4 = p[p2]

	if v4 then
		if upgradeShopTypeData.NotPercentage then
			if upgradeShopTypeData.IsReduction then
				return -v4.Amount
			end

			return v4.Amount
		elseif upgradeShopTypeData.IsReduction then
			return 1 - v4.Amount
		else
			return v4.Amount + 1
		end
	elseif upgradeShopTypeData.NotPercentage then
		return 0
	else
		return 1
	end
end

function TowerUpgradeShopUtilities.GetUpgradeString(p, p2: number)
	if p.NotPercentage then
		return string.format(p.DisplayString, p2)
	end

	return string.format(p.DisplayString, (math.round(p2 * 100)))
end

function TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p: string, p2: string)
	local v4 = v3[p]

	if v4 then
		return v4[p2]
	end

	v4 = {}
	v3[p] = v4
	local towerConfig = ResourceManager.GetTowerConfig(p)
	local towerUpgradeShopData = towerConfig and towerConfig.TowerUpgradeShopData

	if not towerUpgradeShopData then
		return
	end

	for _, v5 in pairs(towerUpgradeShopData) do
		v4[v5.Type] = v5
	end

	return v4[p2]
end

function TowerUpgradeShopUtilities.NewActiveUpgradeShopData()
	return { Amount = 0, Level = 0 }
end

function TowerUpgradeShopUtilities:GetUpgradeTypeToActiveUpgradeShopData(p: string)
	local v4 = self[p]

	if not v4 then
		v4 = {}
		self[p] = v4
	end

	return v4
end

function TowerUpgradeShopUtilities.GetActiveUpgradeShopData(p, p2: string, p3: string)
	if not TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p2, p3) then
		return false
	end

	local upgradeTypeToActiveUpgradeShopData = TowerUpgradeShopUtilities.GetUpgradeTypeToActiveUpgradeShopData(p, p2)
	local v4 = upgradeTypeToActiveUpgradeShopData[p3]

	if not v4 then
		v4 = TowerUpgradeShopUtilities.NewActiveUpgradeShopData()
		upgradeTypeToActiveUpgradeShopData[p3] = v4
	end

	return v4
end

function TowerUpgradeShopUtilities.GetCurrentLevelForTowerAndType(p, p2: string, p3: string)
	local activeUpgradeShopData = TowerUpgradeShopUtilities.GetActiveUpgradeShopData(p, p2, p3)

	if activeUpgradeShopData then
		return activeUpgradeShopData.Level
	end

	return 0
end

function TowerUpgradeShopUtilities.GetOperationCost(p, p2, flag: boolean?)
	local level = p.Level

	if flag then
		level -= 1
	end

	return (flag and -1 or 1) * (p2.Cost + p2.CostIncreasePerLevel * level)
end

function TowerUpgradeShopUtilities.GetTotalSpent(p, p2)
	local total = 0

	for i = 1, p.Level do
		total += p2.Cost + p2.CostIncreasePerLevel * (i - 1)
	end

	return total
end

function TowerUpgradeShopUtilities.CanPerformOperation(p, p2, p3: number, flag: boolean?, flag2: boolean?)
	if flag then
		if p.Level <= 0 then
			return false, "Minimum level reached!"
		end
	elseif p.Level >= (p2.OverrideMaxLevel or 5) then
		return false, "Maximum level reached!"
	end

	if flag2 or not (p3 < TowerUpgradeShopUtilities.GetOperationCost(p, p2, flag)) then
		return true
	end

	return false, "Insufficient credits!"
end

function TowerUpgradeShopUtilities.PerformOperation(p, p2, flag: boolean?)
	TowerUpgradeShopUtilities.SetLevel(p, p2, p.Level + (flag and -1 or 1))
end

function TowerUpgradeShopUtilities:SetLevel(p, level: number)
	self.Level = level
	self.Amount = level * p.Amount
end

for i, v4 in ipairs(v) do
	v4.SortOrder = i
	v2[v4.Type] = v4
end

return TowerUpgradeShopUtilities