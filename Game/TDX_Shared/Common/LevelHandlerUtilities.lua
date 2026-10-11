local LevelHandlerUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))

function LevelHandlerUtilities.HasDynamicPriceScaling(p)
	for _, v in pairs(p.UpgradePathData.Path1Data) do
		if v.DynamicPriceScaling then
			return true
		end
	end

	if p.UpgradePathData.Path2Data then
		for _, v in pairs(p.UpgradePathData.Path2Data) do
			if v.DynamicPriceScaling then
				return true
			end
		end
	end

	return false
end

function LevelHandlerUtilities.GetUpgradeKey(p: string, p2: number, p3: number)
	return p .. "_" .. p2 .. "_" .. p3
end

function LevelHandlerUtilities.GetMaxPossibleLevel(data, p: number)
	if not (data.LockedInPath ~= 0 and data.LockedInPath ~= p) then
		return data.MaximumLevel
	end

	return data.PathLockLevel - 1
end

function LevelHandlerUtilities.GetLevelAttainableWithCash(object, p: string, p2: number, p3: number, p4: number?, p5: number?, p6)
	local levelOnPath = object:GetLevelOnPath(p2)

	if object.MaximumLevel <= levelOnPath then
		return 0, 0
	end

	local upgradePathData = object.UpgradePathData
	local path1Data

	if upgradePathData.OnePathOnly or p2 == 1 then
		path1Data = upgradePathData.Path1Data
	else
		path1Data = upgradePathData.Path2Data
	end

	local maxPossibleLevel = LevelHandlerUtilities.GetMaxPossibleLevel(object, p2)
	local total = 0

	for i = levelOnPath + 1, maxPossibleLevel do
		local cost = path1Data[i].Cost

		if p4 and i < object.MaximumLevel then
			cost = math.ceil(cost * (1 - p4))
		end

		if p5 then
			cost *= p5
		end

		if object.HasDynamicPriceScaling then
			cost += p6[LevelHandlerUtilities.GetUpgradeKey(p, p2, i)] or 0
		end

		if p3 < total + cost then
			return i - 1, total
		else
			total += cost
		end
	end

	return maxPossibleLevel, total
end

function LevelHandlerUtilities.GetLevelUpgradeCost(object, p: string, p2: number, p3: number, p4: number?, p5: number?, p6)
	if p3 <= 0 then
		return 0
	end

	local levelOnPath = object:GetLevelOnPath(p2)

	if object.MaximumLevel <= levelOnPath then
		print("LevelHandlerUtilities::GetLevelUpgradeCost error: Maximum level on this path already reached")
		return 0
	end

	local upgradePathData = object.UpgradePathData
	local path1Data

	if upgradePathData.OnePathOnly or p2 == 1 then
		path1Data = upgradePathData.Path1Data
	else
		path1Data = upgradePathData.Path2Data
	end

	local maxPossibleLevel = LevelHandlerUtilities.GetMaxPossibleLevel(object, p2)
	local total = 0

	for i = levelOnPath + 1, math.min(levelOnPath + p3, maxPossibleLevel) do
		local cost = path1Data[i].Cost

		if p4 and i < object.MaximumLevel then
			cost = math.ceil(cost * (1 - p4))
		end

		if p5 then
			cost *= p5
		end

		if object.HasDynamicPriceScaling then
			cost += p6[LevelHandlerUtilities.GetUpgradeKey(p, p2, i)] or 0
		end

		total += cost
	end

	return total
end

return LevelHandlerUtilities