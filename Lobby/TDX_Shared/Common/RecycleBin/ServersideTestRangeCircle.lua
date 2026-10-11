local createVector = vector.create
local ServersideTestRangeCircle = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("PlacementHandler"))
local Utilities = require(common:WaitForChild("Utilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local color = Color3.fromRGB(99, 139, 181)
local color2 = Color3.fromRGB(196, 40, 28)
local v = {}
local folder = Instance.new("Folder", raycastIgnore)
local folder2 = Instance.new("Folder", Hidden)
local now = os.clock()

local function ToggleArcParts(state, visible: boolean) -- 2 equivalent calls inferred from this helper
	if visible and not state.Visible then
		state.W1.Parent = folder
		state.W2.Parent = folder
		state.L.Parent = folder
	elseif not visible and state.Visible then
		state.W1.Parent = folder2
		state.W2.Parent = folder2
		state.L.Parent = folder2
	end

	state.Visible = visible
end

local function GetArcParts(i: number, visible: boolean)
	local v2 = v[i]

	if not v2 then
		local miscResource = ResourceManager.GetMiscResource("RangeCircleWedgePart")
		local miscResource2 = ResourceManager.GetMiscResource("RangeCircleWedgePart")
		local miscResource3 = ResourceManager.GetMiscResource("RangeCircleLinePart")
		miscResource.Parent = folder2
		miscResource2.Parent = folder2
		miscResource3.Parent = folder2
		local surfaceGui = miscResource3:FindFirstChild("SurfaceGui")
		v2 = {
			Visible = false,
			W1 = miscResource,
			W2 = miscResource2,
			L = miscResource3,
			Gui1 = surfaceGui:FindFirstChild("Left"),
			Gui2 = surfaceGui:FindFirstChild("Center"),
			Gui3 = surfaceGui:FindFirstChild("Right")
		}
		v[i] = v2
	end

	ToggleArcParts(v2, visible) -- inferred equivalent call
	return v2.W1, v2.W2, v2.L
end

local function DrawTriangle(vector: Vector3, vector2: Vector3, vector3: Vector3, p, p2, color3: Color3)
	local vector4 = vector2 - vector
	local vector5 = vector3 - vector
	local vector6 = vector3 - vector2
	local dot = vector4:Dot(vector4)
	local dot2 = vector5:Dot(vector5)
	local dot3 = vector6:Dot(vector6)

	if dot2 < dot and dot3 < dot then
		vector3, vector = vector, vector3
	elseif dot3 < dot2 and dot < dot2 then
		vector, vector2 = vector2, vector
	end

	local vector7 = vector2 - vector
	local vector8 = vector3 - vector
	local vector9 = vector3 - vector2
	local unit = vector8:Cross(vector7).Unit
	local unit2 = vector9:Cross(unit).Unit
	local unit3 = vector9.Unit
	local v2 = math.abs((vector7:Dot(unit2)))
	p.Size = Vector3.new(0, v2, (math.abs((vector7:Dot(unit3)))))
	p.CFrame = CFrame.fromMatrix((vector + vector2) / 2, unit, unit2, unit3)
	p.Color = color3
	p2.Size = Vector3.new(0, v2, (math.abs((vector8:Dot(unit3)))))
	p2.CFrame = CFrame.fromMatrix((vector + vector3) / 2, -unit, unit2, -unit3)
	p2.Color = color3
	return p, p2
end

local function DrawLine(vector: Vector3, vector2: Vector3, p, p2, i)
	local magnitude = (vector - vector2).Magnitude
	p.Size = Vector3.new(0.001, 0.01, magnitude + 0.012)
	p.CFrame = CFrame.new(vector, vector2) * CFrame.new(0, 0, -magnitude / 2)
	local textDisplayOnPart, _ = Utilities.TextDisplayOnPart(p, tostring(i) .. "->" .. tostring(p2))
	textDisplayOnPart.Size = UDim2.new(3, 0, 2, 0)
	textDisplayOnPart.StudsOffsetWorldSpace = createVector(0, 0, 0)
end

local function ResetTimeActivated() -- 3 equivalent calls inferred from this helper
	now = os.clock()
end

function ServersideTestRangeCircle.DrawRangeCircle(vector: Vector3, flag: boolean, list)
	local color3 = flag and color or color2

	for i = 1, #list do
		local v2 = list[i]
		local v3 = list[i % #list + 1]
		assert(v2 and v3, "Current or next arc missing")
		local visible = not (v2.ZeroLength or v3.ZeroLength)
		local v4, v5, v6 = GetArcParts(i, visible)

		if not visible then
			continue
		end

		DrawLine(vector + 1 * v2.GoalDirection, vector + 1 * v3.GoalDirection, v6, 360 * i / #list, i)
		DrawTriangle(
			vector + createVector(0, 0.01, 0),
			vector + 1 * v2.EndPointDirection,
			vector + 1 * v3.EndPointDirection,
			v4,
			v5,
			color3
		)
	end
end

function ServersideTestRangeCircle.Show()
	folder.Parent = raycastIgnore
	ResetTimeActivated() -- inferred equivalent call
end

function ServersideTestRangeCircle.Hide()
	folder.Parent = Hidden
	ResetTimeActivated() -- inferred equivalent call
end

function ServersideTestRangeCircle.TowerChanged()
	for _, v2 in pairs(v) do
		ToggleArcParts(v2, false) -- inferred equivalent call
	end

	ResetTimeActivated() -- inferred equivalent call
end

folder.Name = "RangeCircleParts"
folder2.Name = "HiddenRangeCircleParts"
return ServersideTestRangeCircle