local ShipHandlerClass = {}
ShipHandlerClass.__index = ShipHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("PlacementHandler"))
require(common:WaitForChild("QueryType"))
local ShipTurretClass = require(script:WaitForChild("ShipTurretClass"))

function ShipHandlerClass.New(towerHash: number, p, p2, p3, p4: number)
	local turretData = p3.TurretData
	local turrets = {}

	for _, v in ipairs(turretData) do
		table.insert(turrets, ShipTurretClass.New(towerHash, p, p2, v, p4))
	end

	return (setmetatable({ TowerHash = towerHash, Turrets = turrets }, ShipHandlerClass))
end

function ShipHandlerClass:Attack(p: number, p2: number, p3, flag: boolean)
	local turret = self.Turrets[p]

	if turret then
		turret:Attack(p2, p3, flag)
	else
		warn("Couldn't find turret with index " .. tostring(p))
	end
end

function ShipHandlerClass:SetSpeedMultiplier(p: number)
	for _, turret in ipairs(self.Turrets) do
		turret:SetSpeedMultiplier(p)
	end
end

return ShipHandlerClass