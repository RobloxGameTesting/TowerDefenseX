local DirectControlHandlerClass = {}
DirectControlHandlerClass.__index = DirectControlHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))

function DirectControlHandlerClass.New(_)
	return (setmetatable({ Tower = nil, Active = false, IndexToStateDataMap = {} }, DirectControlHandlerClass))
end

function DirectControlHandlerClass:SetTower(tower)
	self.Tower = tower
end

function DirectControlHandlerClass.Run(p, p2: number)
	for _, v in pairs(p.IndexToStateDataMap) do
		if v.TimeLeftInState > 0 then
			v.TimeLeftInState = math.max(v.TimeLeftInState - p2, 0)
		end
	end
end

function DirectControlHandlerClass:LevelStatsChanged(_)
	self.IndexToStateDataMap = {}
end

function DirectControlHandlerClass:Start()
	self.Active = true
	local customCode = self.Tower.Character:GetCustomCode()

	if customCode and customCode.SetInFPSMode then
		customCode:SetInFPSMode(true)
	end
end

function DirectControlHandlerClass:Stop()
	self.Active = false
	local customCode = self.Tower.Character:GetCustomCode()

	if customCode and customCode.SetInFPSMode then
		customCode:SetInFPSMode(false)
	end
end

function DirectControlHandlerClass.IsActive(p)
	return p.Active
end

function DirectControlHandlerClass.SetStateData(p, p2: number, p3)
	p.IndexToStateDataMap[p2] = p3
end

function DirectControlHandlerClass.GetPreviousStateData(p, p2: number)
	return p.IndexToStateDataMap[p2]
end

return DirectControlHandlerClass