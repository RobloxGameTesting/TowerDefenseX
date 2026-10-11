local createVector = vector.create
local PlacementHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("Types"))
local v = nil
local v2 = nil
local v3 = nil
local v4 = nil
local spaceOccupiers = workspace:WaitForChild("Game"):WaitForChild("SpaceOccupiers")
local placementProbes = workspace:WaitForChild("Game"):WaitForChild("PlacementProbes")
local raycastParams = nil
local raycastParams2 = nil
local raycastParams3 = nil
local overlapParams = nil
local overlapParams2 = nil
local v5 = nil
local miscResource = ResourceManager.GetMiscResource("TowerPlacementProbe")
miscResource.Parent = placementProbes
local v6 = {
	createVector(-1, 0, 0),
	createVector(1, 0, 0),
	createVector(0, 0, -1),
	createVector(0, 0, 1),
	createVector(-0.70710677, 0, -0.70710677),
	createVector(0.70710677, 0, -0.70710677),
	createVector(-0.70710677, 0, 0.70710677),
	createVector(0.70710677, 0, 0.70710677)
}

local function CheckUnderneath(position: Vector3)
	local raycastResult = workspace:Raycast(
		position + createVector(0, 0.5, 0),
		createVector(0, -0.501, 0),
		raycastParams2
	)
	local instance = raycastResult and raycastResult.Instance

	if not instance then
		return true
	end

	if instance:IsA("Part") and instance.Shape == Enum.PartType.Ball then
		return false
	end

	return not instance:GetAttribute("NoPlacement")
end

local function IsWater(raycastResult: RaycastResult)
	return raycastResult.Material == Enum.Material.Water or raycastResult.Instance:IsDescendantOf(v5)
end

local function CheckUnderneathIsWater(vector: Vector3)
	local raycastResult = workspace:Raycast(
		vector + createVector(0, 0.5, 0),
		createVector(0, -0.501, 0),
		raycastParams2
	)

	if
		raycastResult
		and (raycastResult.Material == Enum.Material.Water or raycastResult.Instance:IsDescendantOf(v5))
	then
		return true
	end

	return false
end

local function CheckYBounds(vector: Vector3)
	local y = vector.Y
	return not (y < v3 or v4 < y)
end

local function CheckNotOnPath(vector: Vector3)
	if workspace:Raycast(vector + createVector(0, 50, 0), createVector(0, -100, 0), raycastParams) then
		return false
	end

	return true
end

local function CheckFootprintNotOnPath(position: Vector3, p: number)
	local v7 = math.max(p - 0.3, 0.05)
	miscResource.Size = Vector3.new(100, v7 * 2, v7 * 2)
	miscResource.Position = position
	return not (#workspace:GetPartsInPart(miscResource, overlapParams2) > 0)
end

local function CheckIntersectingObstacles(position: Vector3, radius: number, placementType: string)
	local v7 = placementType == Enums.PlacementTypes.Water and 0.1 or 0.5
	miscResource.Size = Vector3.new(2, radius * 2, radius * 2)
	miscResource.Position = position + Vector3.new(0, 1 + v7, 0)

	if #workspace:GetPartsInPart(miscResource, overlapParams) > 0 then
		return false
	end

	miscResource.Size = createVector(2, 0.05, 0.05)
	miscResource.Position = position + createVector(0, 1.1, 0)
	return not (#workspace:GetPartsInPart(miscResource, overlapParams) > 0)
end

local function CheckEdges(position: Vector3, radius: number)
	local count = 0

	for _, v7 in pairs(v6) do
		local v8 = position + (radius - 0.3) * v7

		if
			workspace:Raycast(v8 + createVector(0, 50, 0), createVector(0, -100, 0), raycastParams)
			or not workspace:Raycast(v8 + createVector(0, 1, 0), createVector(0, -2, 0), raycastParams2)
		then
			return false
		end

		if count < 2 and workspace:Raycast(v8 + createVector(0, 1, 0), createVector(0, -1.02, 0), raycastParams2) then
			count += 1
		end
	end

	return not (count < 2)
end

function PlacementHandler.Check(position: Vector3, data, p: number?)
	local radius = data.Radius
	local placementType = data.PlacementType

	if
		not MapHandler.IsWithinTeamBounds(position, p)
		or data.IsSmallShip and not v2
		or not CheckUnderneath(position)
	then
		return false
	end

	local raycastResult = workspace:Raycast(
		position + createVector(0, 0.5, 0),
		createVector(0, -0.501, 0),
		raycastParams2
	)
	local v7

	if raycastResult then
		v7 = (raycastResult.Material == Enum.Material.Water or raycastResult.Instance:IsDescendantOf(v5)) and true
			or false
	else
		v7 = false
	end

	if placementType == Enums.PlacementTypes.Ground then
		if v7 then
			return false
		end

		local y = position.Y

		if
			y < v3
			or v4 < y
			or workspace:Raycast(position + createVector(0, 50, 0), createVector(0, -100, 0), raycastParams)
		then
			return false
		end

		local v8 = math.max(radius - 0.3, 0.05)
		miscResource.Size = Vector3.new(100, v8 * 2, v8 * 2)
		miscResource.Position = position

		if #workspace:GetPartsInPart(miscResource, overlapParams2) > 0 then
			return false
		end
	else
		if placementType ~= Enums.PlacementTypes.Water then
			return placementType == Enums.PlacementTypes.Air
		end

		if not (v and v7) then
			return false
		end
	end

	if not CheckIntersectingObstacles(position, radius, placementType) then
		return false
	end

	if CheckEdges(position, radius) then
		return true
	end

	return false
end

function PlacementHandler.GetValidArcs(vector: Vector3, p, distanceBeforeHit: number, cframe: CFrame?, p2: number?, flag: boolean?, flag2: boolean?)
	local v7 = vector + Vector3.new(0, p.MaxObstacleHeight, 0)
	assert(distanceBeforeHit > 0, "Range was not greater than 0")
	local unit, v8, flag3

	if cframe and p2 then
		unit = cframe.LookVector.Unit
		v8 = math.rad(p2 / 2)
		flag3 = true
	else
		flag3 = false
	end

	local v9 = 6.283185307179586 * distanceBeforeHit
	local validArcsCustomDivisionCount = p.ValidArcsCustomDivisionCount or math.clamp(math.ceil(v9 / 1.5), 2, 40)
	local result = table.create(validArcsCustomDivisionCount)

	for i = 1, validArcsCustomDivisionCount do
		local v10 = 6.283185307179586 * i / validArcsCustomDivisionCount
		local v11 = distanceBeforeHit * Vector3.new(math.cos(v10), 0, (math.sin(v10)))
		local v12 = {
			Hit = false,
			ZeroLength = false,
			EndPointDirection = v11,
			GoalDirection = v11,
			DistanceBeforeHit = distanceBeforeHit
		}

		if flag3 then
			local v13 = math.acos((math.clamp(v11.Unit:Dot(unit), -1, 1)))
			local v14 = v8 < v13

			if flag2 then
				local partAtPosition = Utilities.PartAtPosition(v7 + v11, v14 and "Bright red" or "Bright green", 10)

				if v13 > 6.283185307179586 then
					Utilities.TextDisplayOnPart(partAtPosition, v13)
				end
			end

			if v14 then
				v12.Hit = true
				v12.EndPointDirection = v11.Unit * 0.001
				v12.DistanceBeforeHit = 0.001
				v12.ZeroLength = true
				table.insert(result, v12)
				continue
			end
		end

		local raycastResult = not flag and workspace:Raycast(v7, v11, raycastParams3)

		if raycastResult then
			local endPointDirection = raycastResult.Position - v7

			if endPointDirection.Magnitude < 0.01 then
				v12.ZeroLength = true
			end

			v12.Hit = true
			v12.EndPointDirection = endPointDirection
			v12.DistanceBeforeHit = endPointDirection.Magnitude
		end

		table.insert(result, v12)
	end

	return result
end

function PlacementHandler.OccupySpace(vector: Vector3, p: number)
	local miscResource2 = ResourceManager.GetMiscResource("TowerPlacementProbe")
	miscResource2.Size = Vector3.new(2, p * 2, p * 2)
	miscResource2.Position = vector + createVector(0, 1.5, 0)
	miscResource2.Parent = spaceOccupiers
	return miscResource2
end

function PlacementHandler:RelocateSpaceOccupier(vector: Vector3)
	self.Position = vector + createVector(0, 1.5, 0)
end

function PlacementHandler.GetGroundHeight(vector: Vector3)
	local raycastResult = workspace:Raycast(vector + createVector(0, 3, 0), createVector(0, -50, 0), raycastParams2)

	if raycastResult then
		return (Vector3.new(vector.X, raycastResult.Position.Y, vector.Z))
	end

	return vector
end

function PlacementHandler.GetGroundHeightAtXZ(p: number, p2: number, p3: number?, value: number?, value2: number?)
	local selected = p3 or MapHandler.GetRangeDisplayHeight()
	local vector = Vector3.new(p, math.min(selected + (value or 100), value2 or 1e999), p2)
	local raycastResult = workspace:Raycast(vector, createVector(0, -200, 0), raycastParams2)

	if raycastResult then
		return raycastResult.Position.Y
	end

	return selected
end

function PlacementHandler.GetGroundLocationInRandomCircle(vector: Vector3, p: number, p2: number, p3: number?)
	local v7 = vector

	for _ = 1, p3 do
		v7 = vector + Vector3.new(math.random() * 2 * p - p, 0, math.random() * 2 * p - p)
		local raycastResult = workspace:Raycast(v7 + Vector3.new(0, p2, 0), Vector3.new(0, -p2, 0), raycastParams2)

		if raycastResult then
			return (Vector3.new(v7.X, raycastResult.Position.Y, v7.Z))
		end
	end

	return v7
end

function PlacementHandler.Initialize()
	v = MapHandler.CanPlaceOnWater()
	v2 = MapHandler.CanPlaceSmallShip()
	v3, v4 = MapHandler.GetMinMaxHeight()
	raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Include
	raycastParams.FilterDescendantsInstances = MapHandler.GetPathZoneInstances()
	raycastParams2 = RaycastParams.new()
	raycastParams2.FilterType = Enum.RaycastFilterType.Include
	raycastParams2.FilterDescendantsInstances = MapHandler.GetMapInstances()
	raycastParams3 = RaycastParams.new()
	raycastParams3.FilterType = Enum.RaycastFilterType.Include
	raycastParams3.FilterDescendantsInstances = MapHandler.GetLOSInstances()
	overlapParams = OverlapParams.new()
	overlapParams.FilterType = Enum.RaycastFilterType.Include
	overlapParams.FilterDescendantsInstances = MapHandler.GetPlacementProbeInstances()
	overlapParams.MaxParts = 1
	overlapParams2 = OverlapParams.new()
	overlapParams2.FilterType = Enum.RaycastFilterType.Include
	overlapParams2.FilterDescendantsInstances = MapHandler.GetPathZoneInstances()
	overlapParams2.MaxParts = 1
	v5 = MapHandler.GetWaterFolder()
end

return PlacementHandler