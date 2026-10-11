local StatsDisplayHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("TowerBuffUtilities"))
local Utilities = require(common:WaitForChild("Utilities"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local StatDisplayUtilities = require(common:WaitForChild("StatDisplayUtilities"))
local SpawnTimersDisplayHandler = require(script.Parent:WaitForChild("SpawnTimersDisplayHandler"))
local TroopDetailsUtilities = require(script.Parent:WaitForChild("TroopDetailsUtilities"))
local towerUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local currentStats = towerUI:WaitForChild("CurrentStats")
local v = { (towerUI:WaitForChild("UIScale")) }
local v2 = ScalingCardClass.New(currentStats, 11, v)
local visible = false

local function UpdateVisibility()
	currentStats.Visible = visible

	if visible then
		local activeItemCount = v2:GetActiveItemCount()

		if activeItemCount > 6 then
			local v3 = 0.5 * (activeItemCount - 6) * v2:GetYShiftPerItem()
			currentStats.Position = UDim2.new(1, 0, 0, 272 + v3)
		else
			currentStats.Position = UDim2.new(1, 0, 0, 272)
		end
	end
end

function StatsDisplayHandler.Show(object)
	local config = object.Config
	local noBuffs = object.NoBuffs
	local levelStats = object.LevelHandler:GetLevelStats()
	local shipData = levelStats.ShipData
	local statMultipliers = object.BuffHandler:GetStatMultipliers()
	local displayStats = StatDisplayUtilities.GetDisplayStats(config)
	v2:DeactivateAllItems()
	local v3 = shipData and TowerUtilities.GetMainAttackCount(shipData) or 1

	for _, displayStat in pairs(displayStats) do
		if not (not levelStats.NoDisplayPierceCount or displayStat ~= "PierceCount") then
			continue
		end

		local statInfoData = StatDisplayUtilities.GetStatInfoData(displayStat)

		if statInfoData then
			if
				not StatDisplayUtilities.ShouldIgnore(statInfoData, levelStats, object)
				and (displayStat ~= "AttackCount" or not (v3 <= 1))
			then
				local descriptionFunction = statInfoData:DescriptionFunction(
					levelStats,
					statMultipliers,
					v3,
					nil,
					object
				)

				if descriptionFunction then
					if typeof(descriptionFunction) == "table" then
						for _, v4 in ipairs(descriptionFunction) do
							v2:ActivateItem(v4, {
								LayoutOrder = statInfoData._LayoutOrder,
								ImageId = statInfoData.ImageId,
								ImageScale = statInfoData.ImageScale
							})
						end
					else
						v2:ActivateItem(descriptionFunction, {
							LayoutOrder = statInfoData._LayoutOrder,
							ImageId = statInfoData.ImageId,
							ImageScale = statInfoData.ImageScale
						})
					end
				end
			end
		else
			warn("StatInfoData not implemented for", displayStat)
		end
	end

	if object.Type == Enums.Towers.Farm then
		local levelOnPath = object.LevelHandler:GetLevelOnPath(1)
		local levelOnPath2 = object.LevelHandler:GetLevelOnPath(2)
		local farmAdditionalStatStrings = StatDisplayUtilities.GetFarmAdditionalStatStrings(
			levelOnPath,
			levelOnPath2,
			false,
			object:GetUpgradeShopMultiplier(Enums.TowerUpgradeShopTypes.HealthPerWave)
		)

		for i, farmAdditionalStatString in ipairs(farmAdditionalStatStrings) do
			v2:ActivateItem(farmAdditionalStatString, {
				LayoutOrder = 97 + i,
				ImageId = "rbxassetid://12191388343"
			})
		end
	end

	if levelStats.DisplayCashEarned then
		v2:ActivateItem(string.format("CASH EARNED: %s", Utilities.FormatNumberStat(object.CashEarned, 0)), {
			LayoutOrder = 100,
			ImageId = "rbxassetid://15498074414"
		})
	end

	local upgradeShopMultiplier = object:GetUpgradeShopMultiplier(Enums.TowerUpgradeShopTypes.TroopHealth)
	local upgradeShopMultiplier2 = object:GetUpgradeShopMultiplier(Enums.TowerUpgradeShopTypes.TroopDamage)
	local v4 = {}

	for _, v5 in levelStats.SpawnPathEntityData do
		local pathEntityConfig = ResourceManager.GetPathEntityConfig(v5.PathEntityType)
		local overrideDisplayName = string.upper(pathEntityConfig.OverrideDisplayName or v5.PathEntityType)
		local burstSize = v5.BurstSize or 1
		local v6 = v5.Interval - levelStats.SpawnPathEntityIntervalReduction
		local health = pathEntityConfig.Health
		local attacksDPS = TowerUtilities.CalculateAttacksDPS(pathEntityConfig.AttackData)
		local v7 = math.ceil(upgradeShopMultiplier * health)
		local statsText

		if attacksDPS then
			statsText = `{v7} HP | {math.round(upgradeShopMultiplier2 * attacksDPS)} DPS | {burstSize} EVERY {v6}S`
		else
			statsText = `{v7} HP | {burstSize} EVERY {v6}S`
		end

		table.insert(v4, {
			PathEntityType = v5.PathEntityType,
			DisplayName = overrideDisplayName,
			StatsText = statsText,
			MaximumCount = v5.MaximumCount,
			DetailRows = TroopDetailsUtilities.GetRows(pathEntityConfig, upgradeShopMultiplier2)
		})
	end

	if noBuffs then
		v2:ActivateItem("NO FRIENDLY BUFFS", {
			LayoutOrder = 110,
			ImageId = "rbxassetid://15498074529",
			ImageScale = 0.9
		})
	elseif config.DisallowedBuffTypesMap and config.DisallowedBuffTypesMap[Enums.TowerBuffTypes.Damage] then
		v2:ActivateItem("NO DAMAGE BUFFS", {
			LayoutOrder = 111,
			ImageId = "rbxassetid://15498074529",
			ImageScale = 0.9
		})
	end

	v2:ScaleFrame()
	visible = v2:GetActiveItemCount() > 0
	UpdateVisibility()
	SpawnTimersDisplayHandler.Show(object, v4)
end

function StatsDisplayHandler.Update()
	UpdateVisibility()
	SpawnTimersDisplayHandler.Update()
end

return StatsDisplayHandler