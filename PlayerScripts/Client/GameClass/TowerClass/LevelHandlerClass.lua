local LevelHandlerClass = {}
LevelHandlerClass.__index = LevelHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local LevelHandlerUtilities = require(common:WaitForChild("LevelHandlerUtilities"))
require(common:WaitForChild("Types"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))

function LevelHandlerClass.New(towerName: string, p, list)
	local v = {
		TowerName = towerName,
		Path1Level = list[1],
		Path2Level = list[2],
		OverallLevel = 0,
		MaximumLevel = #p.UpgradePathData.Path1Data,
		HasDynamicPriceScaling = LevelHandlerUtilities.HasDynamicPriceScaling(p),
		LockedInPath = 0,
		PathLockLevel = p.UpgradePathData.PathLockLevel,
		LevelStats = nil,
		UpgradePathData = p.UpgradePathData
	}
	setmetatable(v, LevelHandlerClass)
	v:LevelChanged()
	return v
end

function LevelHandlerClass:GetLevelOnPath(p: number)
	if p == 1 then
		return self.Path1Level
	elseif p == 2 then
		return self.Path2Level
	end

	error("Path should either be 1 or 2.")
end

function LevelHandlerClass.GetOtherPath(_, p: number)
	if p == 1 then
		return 2
	elseif p == 2 then
		return 1
	end

	error("Path should either be 1 or 2")
end

function LevelHandlerClass.GetLevelStats(p)
	return p.LevelStats
end

function LevelHandlerClass.GetOverallLevel(p)
	return p.OverallLevel
end

function LevelHandlerClass.GetPath(p)
	return p.LockedInPath
end

function LevelHandlerClass.GetMaxLevel(p)
	return p.MaximumLevel
end

function LevelHandlerClass.GetPathLockLevel(p)
	return p.PathLockLevel
end

function LevelHandlerClass:GetPathLevelString()
	if self.LockedInPath == 0 then
		return (tostring(self.OverallLevel))
	end

	return tostring(self.LockedInPath) .. "_" .. tostring(self:GetLevelOnPath(self.LockedInPath))
end

function LevelHandlerClass.GetUpgradePathData(p)
	return p.UpgradePathData
end

function LevelHandlerClass.GetLevelUpgradeCost(p, p2: number, p3: number, p4: number?, p5: number?, p6)
	return LevelHandlerUtilities.GetLevelUpgradeCost(p, p.TowerName, p2, p3, p4, p5, p6)
end

function LevelHandlerClass.GetMaxPossibleLevel(p, p2: number)
	return LevelHandlerUtilities.GetMaxPossibleLevel(p, p2)
end

function LevelHandlerClass.GetLevelAttainableWithCash(p, p2: number, p3: number, p4: number?, p5: number?, p6)
	return LevelHandlerUtilities.GetLevelAttainableWithCash(p, p.TowerName, p2, p3, p4, p5, p6)
end

function LevelHandlerClass:Upgraded(path1Level: number, path2Level: number)
	self.Path1Level = path1Level
	self.Path2Level = path2Level
	self:LevelChanged()
end

function LevelHandlerClass:LevelChanged()
	self.OverallLevel = math.max(self.Path1Level, self.Path2Level)
	self.LevelStats = TowerUtilities.GetLevelStats(self.UpgradePathData, self.Path1Level, self.Path2Level)

	if self.OverallLevel >= self.PathLockLevel then
		if self.Path1Level > self.Path2Level then
			self.LockedInPath = 1
		else
			self.LockedInPath = 2
		end
	end
end

return LevelHandlerClass