local ShipUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))

function ShipUtilities.GetTurretModel(instance, p)
	local child = instance:FindFirstChild(p.TurretModelName)

	if not child then
		warn("Turret handler could not find turret model with name " .. p.TurretModelName)
	end

	return child
end

function ShipUtilities.GetTurretMotor6D(instance, instance2, flag: boolean?)
	local v = false
	local primaryPart = instance.PrimaryPart or instance:FindFirstChild("Pivot_Turret")

	if not primaryPart then
		warn("ShipUtilities.GetTurretMotor6D could not find turret pivot for turret model " .. instance.Name)
		return nil, false
	end

	local child = instance2:FindFirstChild(primaryPart.Name)
	local part1 = nil

	if not child then
		local base = instance2:FindFirstChild("Base")

		if base then
			part1 = base.Part1

			if part1 then
				child = part1:FindFirstChild(primaryPart.Name)
			end
		end
	end

	if not child and flag then
		child = Utilities.Motor6D(part1 or instance2, primaryPart)
		child.Name = "Pivot_Turret"
		v = true
	end

	if not child then
		warn("ShipUtilities.GetTurretMotor6D could not find or create Motor6D with name " .. primaryPart.Name)
	end

	return child, v
end

function ShipUtilities.GetTurretGunModels(instance, p)
	local children = {}

	for i = 1, p.GunCount do
		local child = instance:FindFirstChild("Gun" .. tostring(i))

		if not child then
			warn("Turret handler could not find gun #" .. tostring(i))
		end

		table.insert(children, child)
	end

	return children
end

return ShipUtilities