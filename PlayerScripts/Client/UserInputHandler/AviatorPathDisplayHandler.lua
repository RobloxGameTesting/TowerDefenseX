local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local AviatorFlightPathUtilities = require(common:WaitForChild("AviatorFlightPathUtilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local v = {}

local function NewDash(parent)
	local miscResource = ResourceManager.GetMiscResource("AviatorCircleLinePart")
	miscResource.Name = "Dash"
	miscResource.Anchored = true
	miscResource.CanCollide = false
	miscResource.CanTouch = false
	miscResource.CanQuery = false
	miscResource.CastShadow = false
	miscResource.Parent = parent
	return miscResource
end

local function DrawDash(state, vector: Vector3, vector2: Vector3, p: number)
	local dashesUsed = state.DashesUsed + 1
	state.DashesUsed = dashesUsed
	local dash = state.Dashes[dashesUsed]

	if dash then
		if dash.Parent ~= state.Model then
			dash.Parent = state.Model
		end
	else
		local model = state.Model
		dash = ResourceManager.GetMiscResource("AviatorCircleLinePart")
		dash.Name = "Dash"
		dash.Anchored = true
		dash.CanCollide = false
		dash.CanTouch = false
		dash.CanQuery = false
		dash.CastShadow = false
		dash.Parent = model
		state.Dashes[dashesUsed] = dash
	end

	local dashSiz = state.DashSizes[dashesUsed]

	if not dashSiz or math.abs(dashSiz.Z - (p + 0.012)) > 0.001 then
		local vector3 = Vector3.new(0.225, 0.01, p + 0.012)
		dash.Size = vector3
		state.DashSizes[dashesUsed] = vector3
	end

	table.insert(state.MoveParts, dash)
	table.insert(state.MoveCFrames, CFrame.lookAt((vector + vector2) / 2, vector2))
end

local function BuildRoute(object, height: number)
	local flightState, radius = object:GetFlightState()
	local pathLength = AviatorFlightPathUtilities.GetPathLength(flightState.Path, radius)
	local v2 = {
		Center = object:GetCenterPosition(),
		Height = height,
		Radius = radius,
		State = flightState,
		TotalLength = pathLength
	}

	if flightState.Mode == flightState.Path then
		return v2
	end

	local uToNextJunction = AviatorFlightPathUtilities.GetUToNextJunction(flightState.U, flightState.Sign)
	local junctionU = math.round((flightState.U + flightState.Sign * uToNextJunction) * 2) / 2 % 1
	v2.JunctionDistance = uToNextJunction * pathLength
	v2.JunctionU = junctionU
	local junctionSign

	if junctionU == 0.5 then
		junctionSign = -flightState.Sign
	else
		junctionSign = flightState.Sign
	end

	v2.JunctionSign = junctionSign
	v2.TotalLength = uToNextJunction * pathLength + AviatorFlightPathUtilities.GetPathLength(flightState.Mode, radius)
	return v2
end

local function GetRoutePosition(data, p: number)
	local state = data.State
	local radius = data.Radius
	local junctionDistance = data.JunctionDistance
	local mode, v2

	if junctionDistance and junctionDistance < p then
		mode = state.Mode
		v2 = data.JunctionU + data.JunctionSign * (p - junctionDistance) / AviatorFlightPathUtilities.GetPathLength(mode, radius)
	else
		mode = state.Path
		v2 = state.U + state.Sign * p / AviatorFlightPathUtilities.GetPathLength(mode, radius)
	end

	local offsetXZ, v3 = AviatorFlightPathUtilities.GetOffsetXZ(mode, v2 % 1, radius)
	local center = data.Center
	return (Vector3.new(center.X + offsetXZ, data.Height, center.Z + v3))
end

local function Draw(state, pylonMovementHandler)
	local route = BuildRoute(pylonMovementHandler, state.Height)
	local totalLength = route.TotalLength
	local v2 = os.clock() * 1 % 2.8
	state.DashesUsed = 0

	for i = -1, math.ceil(totalLength / 2.8) do
		local v3 = math.max(i * 2.8 + v2, 0)
		local v4 = math.min(i * 2.8 + v2 + 1.6, totalLength)

		if not (v4 - v3 < 0.02) then
			DrawDash(state, GetRoutePosition(route, v3), GetRoutePosition(route, v4), v4 - v3)
		end
	end

	workspace:BulkMoveTo(state.MoveParts, state.MoveCFrames, Enum.BulkMoveMode.FireCFrameChanged)
	table.clear(state.MoveParts)
	table.clear(state.MoveCFrames)

	for i = state.DashesUsed + 1, #state.Dashes do
		local dash = state.Dashes[i]

		if dash.Parent then
			dash.Parent = nil
		end
	end
end

local function DestroyDisplay(p)
	local v2 = v[p]

	if not v2 then
		return
	end

	for _, dash in pairs(v2.Dashes) do
		dash:Destroy()
	end

	v2.Model:Destroy()
	v[p] = nil
end

local AviatorPathDisplayHandler = {}

function AviatorPathDisplayHandler.TowerToggle(flag: boolean, p)
	local pylonMovementHandler = p.PylonMovementHandler
	local v2 = v[p]

	if not (pylonMovementHandler and pylonMovementHandler.GetFlightState) then
		DestroyDisplay(p)
	elseif flag then
		if not v2 then
			local centerPosition = pylonMovementHandler:GetCenterPosition()
			local model = Instance.new("Model")
			model.Name = "AviatorPath"
			v2 = {
				Model = model,
				Dashes = {},
				DashesUsed = 0,
				Height = MapHandler.GetRangeDisplayHeightAtXZ(centerPosition.X, centerPosition.Z) + 0.05,
				DashSizes = {},
				MoveParts = {},
				MoveCFrames = {}
			}
			v[p] = v2
		end

		if v2.Model.Parent ~= raycastIgnore then
			v2.Model.Parent = raycastIgnore
		end

		Draw(v2, pylonMovementHandler)
	elseif v2 and v2.Model.Parent ~= Hidden then
		v2.Model.Parent = Hidden
	end
end

function AviatorPathDisplayHandler.RemoveDestroyedTowers()
	for k in pairs(v) do
		if k:IsDestroyed() then
			DestroyDisplay(k)
		end
	end
end

return AviatorPathDisplayHandler