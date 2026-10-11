local UpgradeShopDataHandlerClass = {}
UpgradeShopDataHandlerClass.__index = UpgradeShopDataHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
local TowerUpgradeShopUtilities = require(common:WaitForChild("TowerUpgradeShopUtilities"))
require(common:WaitForChild("ResourceManager"))

function UpgradeShopDataHandlerClass.New()
	return (setmetatable({ Credits = 0, TowerToUpgradeTypeToActiveUpgradeData = {} }, UpgradeShopDataHandlerClass))
end

function UpgradeShopDataHandlerClass:Initialize(towerToUpgradeTypeToActiveUpgradeData)
	self.TowerToUpgradeTypeToActiveUpgradeData = towerToUpgradeTypeToActiveUpgradeData
end

function UpgradeShopDataHandlerClass.DataUpdate(p, p2: string, p3: string, p4: number)
	local upgradeShopItemDataForTower = TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p2, p3)

	if not upgradeShopItemDataForTower then
		return
	end

	local activeUpgradeShopData = TowerUpgradeShopUtilities.GetActiveUpgradeShopData(
		p.TowerToUpgradeTypeToActiveUpgradeData,
		p2,
		p3
	)
	TowerUpgradeShopUtilities.SetLevel(activeUpgradeShopData, upgradeShopItemDataForTower, p4)
end

function UpgradeShopDataHandlerClass:SetCredits(credits: number)
	self.Credits = credits
end

function UpgradeShopDataHandlerClass.GetCredits(p)
	return p.Credits
end

function UpgradeShopDataHandlerClass.GetCurrentData(p)
	return p.TowerToUpgradeTypeToActiveUpgradeData
end

function UpgradeShopDataHandlerClass.GetUpgradeTypeToActiveUpgradeShopData(p, p2: string)
	return TowerUpgradeShopUtilities.GetUpgradeTypeToActiveUpgradeShopData(p.TowerToUpgradeTypeToActiveUpgradeData, p2)
end

function UpgradeShopDataHandlerClass.CheckOperation(p, p2: string, p3: string, flag: boolean?, flag2: boolean?)
	local upgradeShopItemDataForTower = TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p2, p3)

	if not upgradeShopItemDataForTower then
		return false, "Invalid operation!"
	end

	local activeUpgradeShopData = TowerUpgradeShopUtilities.GetActiveUpgradeShopData(
		p.TowerToUpgradeTypeToActiveUpgradeData,
		p2,
		p3
	)
	local canPerformOperation, v = TowerUpgradeShopUtilities.CanPerformOperation(
		activeUpgradeShopData,
		upgradeShopItemDataForTower,
		p.Credits,
		flag,
		flag2
	)
	return canPerformOperation, v
end

function UpgradeShopDataHandlerClass.GetCurrentLevelForTowerAndType(p, p2: string, p3: string)
	return TowerUpgradeShopUtilities.GetCurrentLevelForTowerAndType(p.TowerToUpgradeTypeToActiveUpgradeData, p2, p3)
end

function UpgradeShopDataHandlerClass.GetNextUpgradeCostForTowerAndType(p, p2: string, p3: string)
	local upgradeShopItemDataForTower = TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p2, p3)

	if not upgradeShopItemDataForTower then
		return
	end

	local activeUpgradeShopData = TowerUpgradeShopUtilities.GetActiveUpgradeShopData(
		p.TowerToUpgradeTypeToActiveUpgradeData,
		p2,
		p3
	)
	return TowerUpgradeShopUtilities.GetOperationCost(activeUpgradeShopData, upgradeShopItemDataForTower)
end

function UpgradeShopDataHandlerClass.RefundForTower(p, p2: string)
	local v = p.TowerToUpgradeTypeToActiveUpgradeData[p2]

	if not v then
		return
	end

	for k, v2 in pairs(v) do
		local upgradeShopItemDataForTower = TowerUpgradeShopUtilities.GetUpgradeShopItemDataForTower(p2, k)
		TowerUpgradeShopUtilities.SetLevel(v2, upgradeShopItemDataForTower, 0)
	end
end

return UpgradeShopDataHandlerClass