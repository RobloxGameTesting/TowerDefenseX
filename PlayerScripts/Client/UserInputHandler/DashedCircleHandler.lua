local DashedCircleHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TowerBuffUtilities"))
local DashedCircleUtilities = require(common:WaitForChild("DashedCircleUtilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local AviatorPathDisplayHandler = require(script.Parent:WaitForChild("AviatorPathDisplayHandler"))
local GameClass = script.Parent.Parent:WaitForChild("GameClass")
local TowerClass = GameClass:WaitForChild("TowerClass")
local PathEntityClass = GameClass:WaitForChild("PathEntityClass")
local StaticEntityClass = GameClass:WaitForChild("StaticEntityClass")
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 82, 82)
local color3 = Color3.fromRGB(255, 255, 255)
local v = {}
local v2 = {}
local v3 = {}

local function LazyToggleCircle(p, object, flag: boolean, position: Vector3, value: number?, color4: Color3?, p2: number?)
	local v4 = p[object]
	local radius = value or 1
	local v5 = p2 or radius <= 3 and 0.07 or radius <= 6 and 0.1 or 0.15

	if flag then
		if not position then
			warn("Position not given for LazyToggleCircle when toggling on")
			position = object:GetPosition()
		end

		if not v4 then
			p[object] = DashedCircleUtilities.NewDashedCircleData(position, radius, color4 or color, v5)
			return
		end

		local v6 = false

		if v4.Radius == radius then
			DashedCircleUtilities.UpdateCirclePosition(v4, position)
		else
			DashedCircleUtilities.DestroyCircle(v4)
			v4.CircleModel = DashedCircleUtilities.NewCircle(position, radius, v5)
			v4.Radius = radius
			v6 = true
		end

		if v6 or v4.Color ~= color4 then
			DashedCircleUtilities.UpdateCircleColor(v4, color4 or color)
			v4.Color = color4 or color
		end
	elseif v4 then
		DashedCircleUtilities.DestroyCircle(v4)
		p[object] = nil
	end
end

function DashedCircleHandler.TowerToggleCircle(flag: boolean, object, p: number?, color4: Color3?, p2: number?)
	local pylonMovementHandler = object.PylonMovementHandler
	local attackPosition

	if pylonMovementHandler and pylonMovementHandler.GetAttackPosition then
		attackPosition = pylonMovementHandler:GetAttackPosition()
	else
		attackPosition = object:GetPosition()
	end

	local x = attackPosition.X
	local z = attackPosition.Z
	LazyToggleCircle(v, object, flag, Vector3.new(x, MapHandler.GetRangeDisplayHeightAtXZ(x, z), z), p, color4, p2)

	if pylonMovementHandler and pylonMovementHandler.GetFlightState then
		AviatorPathDisplayHandler.TowerToggle(flag, object)
	end
end

function DashedCircleHandler.PathEntityToggleCircle(flag: boolean, object, p: number?, color4: Color3?, p2: number?)
	LazyToggleCircle(v2, object, flag, object:GetPosition(), p, color4, p2)
end

function DashedCircleHandler.StaticEntityToggleCircle(flag: boolean, object, p: number?, color4: Color3?, p2: number?)
	LazyToggleCircle(v2, object, flag, object:GetPosition(), p, color4, p2)
end

function DashedCircleHandler.RefreshDashedCircleForTower(p: number)
	local module = require(TowerClass)

	for _, v4 in pairs(module.GetTowers()) do
		if v4.Hash ~= p then
			continue
		end

		local v5

		if v4.OverrideUseMovingRangeCircle == nil then
			v5 = not v4.UseMovingRangeCircle or false
		else
			v5 = not v4.OverrideUseMovingRangeCircle or false
		end

		DashedCircleHandler.TowerToggleCircle(not v5 and v4:CanShowDashedCircle(), v4, v4:GetCurrentRange(), color)
	end
end

function DashedCircleHandler.Run(_: number)
	for k, v4 in pairs(v) do
		if not k:IsDestroyed() then
			continue
		end

		v4.CircleModel:Destroy()
		v[k] = nil
	end

	AviatorPathDisplayHandler.RemoveDestroyedTowers()
	local module = require(TowerClass)

	for _, v4 in pairs(module.GetTowers()) do
		if v4.OverrideUseMovingRangeCircle == nil then
			if not v4.UseMovingRangeCircle then
				continue
			end
		elseif not v4.OverrideUseMovingRangeCircle then
			continue
		end

		DashedCircleHandler.TowerToggleCircle(v4:CanShowDashedCircle(), v4, v4:GetCurrentRange(), color)
	end

	for k, v4 in pairs(v2) do
		if not k:IsDestroyed() then
			continue
		end

		v4.CircleModel:Destroy()
		v2[k] = nil
	end

	local module2 = require(PathEntityClass)

	for _, v4 in pairs(module2.GetPathEntities()) do
		if not v4.AttackClientDataTable then
			continue
		end

		local currentRange, v5 = v4:GetCurrentRange()
		DashedCircleHandler.PathEntityToggleCircle(v4.UserInputHovered, v4, currentRange + 1, v5 and color2 or color)
	end

	for k, v4 in pairs(v3) do
		if not k:IsDestroyed() then
			continue
		end

		v4.CircleModel:Destroy()
		v3[k] = nil
	end

	local module3 = require(StaticEntityClass)

	for _, v4 in pairs(module3.GetStaticEntities()) do
		if not v4.DashedCircleRange then
			break
		end

		DashedCircleHandler.StaticEntityToggleCircle(v4.UserInputHovered, v4, v4.DashedCircleRange + 0, color3)
	end
end

return DashedCircleHandler