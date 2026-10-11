local createVector = vector.create
local RangeCircleHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("PlacementHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local color = Color3.fromRGB(99, 139, 181)
local color2 = Color3.fromRGB(196, 40, 28)
local color3 = Color3.fromRGB(255, 255, 255)
local color4 = Color3.fromRGB(147, 221, 255)
local color5 = Color3.fromRGB(255, 171, 172)
local v = {}
local folder = Instance.new("Folder", raycastIgnore)
local folder2 = Instance.new("Folder", Hidden)
local model = Instance.new("Model", folder)
local model2 = Instance.new("Model", folder)
local highlight = Instance.new("Highlight", model)
local lastTime = os.clock()
local now = os.clock()
local v2 = false
local v3 = nil

local function ToggleArcParts(state, visible: boolean) -- 2 equivalent calls inferred from this helper
	if visible and not state.Visible then
		state.W1.Parent = model
		state.W2.Parent = model
		state.L.Parent = model2
	elseif not visible and state.Visible then
		state.W1.Parent = folder2
		state.W2.Parent = folder2
		state.L.Parent = folder2
	end

	state.Visible = visible
end

local function GetArcParts(i: number, visible: boolean)
	local v4 = v[i]

	if not v4 then
		local miscResource = ResourceManager.GetMiscResource("RangeCircleWedgePart")
		local miscResource2 = ResourceManager.GetMiscResource("RangeCircleWedgePart")
		local miscResource3 = ResourceManager.GetMiscResource("RangeCircleLinePart")
		miscResource.Parent = folder2
		miscResource2.Parent = folder2
		miscResource3.Parent = folder2
		local surfaceGui = miscResource3:FindFirstChild("SurfaceGui")
		v4 = {
			Visible = false,
			W1 = miscResource,
			W2 = miscResource2,
			L = miscResource3,
			Gui1 = surfaceGui:FindFirstChild("Left"),
			Gui2 = surfaceGui:FindFirstChild("Center"),
			Gui3 = surfaceGui:FindFirstChild("Right")
		}
		v[i] = v4
	end

	ToggleArcParts(v4, visible) -- inferred equivalent call
	return v4.W1, v4.W2, v4.L
end

local function DrawTriangle(vector: Vector3, vector2: Vector3, vector3: Vector3, p, p2, color6: Color3, transparency: number)
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
	local v4 = math.abs((vector7:Dot(unit2)))
	p.Size = Vector3.new(0, v4, (math.abs((vector7:Dot(unit3)))))
	p.CFrame = CFrame.fromMatrix((vector + vector2) / 2, unit, unit2, unit3)
	p.Color = color6
	p.Transparency = transparency
	p2.Size = Vector3.new(0, v4, (math.abs((vector8:Dot(unit3)))))
	p2.CFrame = CFrame.fromMatrix((vector + vector3) / 2, -unit, unit2, -unit3)
	p2.Color = color6
	p2.Transparency = transparency
	return p, p2
end

local function DrawLine(vector: Vector3, vector2: Vector3, p) -- 1 equivalent call inferred from this helper
	local magnitude = (vector - vector2).Magnitude
	p.Size = Vector3.new(0.1, 0.01, magnitude + 0.012)
	p.CFrame = CFrame.new(vector, vector2) * CFrame.new(0, 0, -magnitude / 2)
end

local function ResetTimeActivated() -- 4 equivalent calls inferred from this helper
	lastTime = os.clock()
	now = lastTime
end

function RangeCircleHandler.GetLastChangeTimestamp()
	return now
end

function RangeCircleHandler.DrawRangeCircle(vector: Vector3, flag: boolean, list, flag2: boolean?, flag3: boolean?, flag4: boolean?, flag5: boolean?, color6: Color3?, color7: Color3?)
	local v4 = flag3 and 0.9 or 0.7
	local v5 = math.clamp(((os.clock() - lastTime) / 0.125) ^ 0.25, 0.01, 1)
	local v6 = flag2 and 1 or v5
	local v7

	if flag4 or flag5 or v2 then
		v7 = color3
		highlight.Enabled = false
		v4 = 1
	elseif flag3 then
		v7 = color3
		highlight.Enabled = false
	else
		local outlineColor

		if flag then
			v7 = color6 or color
			outlineColor = color7 or color4
		else
			v7 = color6 or color2
			outlineColor = color7 or color5
		end

		highlight.OutlineColor = outlineColor
		highlight.Enabled = true
	end

	for i = 1, #list do
		local v8 = list[i]
		local v9 = list[i % #list + 1]
		assert(v8 and v9, "Current or next arc missing")
		local visible = not (flag5 or v8.ZeroLength or v9.ZeroLength)
		local v10, v11, v12 = GetArcParts(i, visible)

		if not visible then
			continue
		end

		DrawLine(vector + v6 * v8.GoalDirection, vector + v6 * v9.GoalDirection, v12) -- inferred equivalent call
		DrawTriangle(
			vector + createVector(0, 0.01, 0),
			vector + v6 * v8.EndPointDirection,
			vector + v6 * v9.EndPointDirection,
			v10,
			v11,
			v7,
			v4
		)
	end

	for i = #list + 1, #v do
		GetArcParts(i, false)
	end
end

function RangeCircleHandler.Show()
	folder.Parent = raycastIgnore
	local enabled = highlight.Enabled
	local outlineColor = highlight.OutlineColor
	highlight:Destroy()
	highlight = Instance.new("Highlight", model)
	highlight.Adornee = model
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.OutlineColor = outlineColor
	highlight.Enabled = enabled
	ResetTimeActivated() -- inferred equivalent call
end

function RangeCircleHandler.Hide()
	folder.Parent = Hidden
	ResetTimeActivated() -- inferred equivalent call
end

function RangeCircleHandler.ToggleFPSMode(flag: boolean, p)
	v2 = flag

	if flag then
		RangeCircleHandler.Hide()
		v3 = p
	else
		local flag2 = true

		if v3 then
			if not v3:ShouldShowRangeCircle() then
				flag2 = false
			end

			v3 = nil
		end

		if flag2 then
			RangeCircleHandler.Show()
		end
	end

	ResetTimeActivated() -- inferred equivalent call
end

function RangeCircleHandler.TowerChanged()
	for _, v4 in pairs(v) do
		ToggleArcParts(v4, false) -- inferred equivalent call
	end

	ResetTimeActivated() -- inferred equivalent call
end

folder.Name = "RangeCircleParts"
folder2.Name = "HiddenRangeCircleParts"
model.Name = "Wedges"
model2.Name = "Lines"
Instance.new("Humanoid", model)
highlight.Adornee = model
highlight.FillTransparency = 1
highlight.OutlineTransparency = 0
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
return RangeCircleHandler