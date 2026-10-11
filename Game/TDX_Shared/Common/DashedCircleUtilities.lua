local DashedCircleUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")

local function DrawLine(vector: Vector3, vector2: Vector3, miscResource, p: number) -- 1 equivalent call inferred from this helper
	local magnitude = (vector - vector2).Magnitude
	miscResource.Size = Vector3.new(p, 0.01, magnitude + 0.012)
	miscResource.CFrame = CFrame.new(vector, vector2) * CFrame.new(0, 0, -magnitude / 2)
end

local function GetCirclePoints(position: Vector3, p: number)
	assert(p > 0, "Range was not greater than 0")
	local v = math.clamp(math.ceil(6.283185307179586 * p / 1.5), 2, 40)
	local result = {}

	for i = 1, v do
		local v2 = 6.283185307179586 * i / v
		table.insert(result, position + p * Vector3.new(math.cos(v2), 0, (math.sin(v2))))
	end

	return result
end

function DashedCircleUtilities.NewCircle(position: Vector3, p: number, p2: number)
	local circlePoints = GetCirclePoints(position, p)
	local model = Instance.new("Model")
	model.Name = "Circle"
	local miscResource = ResourceManager.GetMiscResource("Torso")
	miscResource.Name = "Center"
	miscResource.Transparency = 1
	miscResource.CFrame = CFrame.new(position)
	miscResource.Parent = model
	model.PrimaryPart = miscResource

	for i = 1, #circlePoints do
		local v = circlePoints[i]
		local v2 = circlePoints[i % #circlePoints + 1]
		local miscResource2 = ResourceManager.GetMiscResource("RangeCircleLinePart")
		DrawLine(v, v2, miscResource2, p2) -- inferred equivalent call
		miscResource2.Name = "Line"
		miscResource2.Parent = model
	end

	model.Parent = raycastIgnore
	return model
end

function DashedCircleUtilities.NewDashedCircleData(vector: Vector3, radius: number, color: Color3, p: number)
	local v = {
		Visible = true,
		Radius = radius,
		Color = nil,
		CircleModel = DashedCircleUtilities.NewCircle(vector, radius, p)
	}
	DashedCircleUtilities.UpdateCircleColor(v, color)
	return v
end

function DashedCircleUtilities:UpdateCircleColor(color: Color3)
	if self.Color == color then
		return
	end

	for _, frame in pairs(self.CircleModel:GetDescendants()) do
		if frame:IsA("Frame") then
			frame.BackgroundColor3 = color
		end
	end

	self.Color = color
end

function DashedCircleUtilities.UpdateCirclePosition(p, position: Vector3)
	p.CircleModel:PivotTo(CFrame.new(position))
end

function DashedCircleUtilities.DestroyCircle(p)
	p.CircleModel:Destroy()
end

function DashedCircleUtilities:HideCircle()
	if not self.Visible then
		return
	end

	self.Visible = false
	self.CircleModel.Parent = Hidden
end

function DashedCircleUtilities:ShowCircle()
	if self.Visible then
		return
	end

	self.Visible = true
	self.CircleModel.Parent = raycastIgnore
end

return DashedCircleUtilities