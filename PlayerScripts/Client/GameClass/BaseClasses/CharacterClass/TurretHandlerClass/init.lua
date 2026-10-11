local TurretHandlerClass = {}
TurretHandlerClass.__index = TurretHandlerClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
require(common:WaitForChild("Utilities"))
local TurretClass = require(script:WaitForChild("TurretClass"))

function TurretHandlerClass.New(p, items, speedMultiplier: number)
	local v = { Turrets = {}, SpeedMultiplier = speedMultiplier }

	for k, item in pairs(items) do
		v.Turrets[k] = TurretClass.New(p, item, speedMultiplier)
	end

	setmetatable(v, TurretHandlerClass)
	return v
end

function TurretHandlerClass.ToggleTurretAiming()
	TurretClass.ToggleTurretAiming()
end

function TurretHandlerClass:AimAtPosition(p: number, vector: Vector3, flag: boolean?)
	if flag then
		for _, turret in pairs(self.Turrets) do
			turret:AimAtPosition(vector)
		end
	else
		local turret = self.Turrets[p]

		if turret then
			turret:AimAtPosition(vector)
		else
			warn("TurretHandlerClass:Attacked: Turret not found at index", p)
		end
	end
end

function TurretHandlerClass:Attacked(p: number, p2: number?)
	local turret = self.Turrets[p]

	if turret then
		turret:Attacked(p2)
	else
		warn("TurretHandlerClass:Attacked: Turret not found at index", p)
	end
end

function TurretHandlerClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, turret in pairs(self.Turrets) do
		turret:SpeedMultiplierChanged(speedMultiplier)
	end

	self.SpeedMultiplier = speedMultiplier
end

function TurretHandlerClass:Run(p: number)
	for _, turret in pairs(self.Turrets) do
		turret:Run(p)
	end
end

return TurretHandlerClass