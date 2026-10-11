local createVector = vector.create
local GroundDirectionalAiming = {}
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local event = BindableHandler.GetEvent("TowerPlacementRotationIncrement")
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local color = Color3.fromRGB(72, 244, 121)
local flag = false
local v = 0
local v2 = nil
local v3 = 0
local v4 = 0
local model = Instance.new("Model")
model.Name = "DirectionalAimingZone"
model.Parent = Hidden
local v5 = {}
local count = 0

local function NewLinePart()
	local folder = ResourceManager.GetMiscResource("RangeCircleLinePart")
	folder.Name = "Line"

	for _, frame in pairs(folder:GetDescendants()) do
		if frame:IsA("Frame") then
			frame.BackgroundColor3 = color
		end
	end

	folder.Parent = model
	return folder
end

local function NewChevron(p: number)
	local miscResource = ResourceManager.GetMiscResource("AimingGuide")
	local clone = miscResource:FindFirstChild("SideArrow"):Clone()
	miscResource:Destroy()
	clone.Name = "Chevron"
	clone.Anchored = true
	clone.CanCollide = false
	clone.CanTouch = false
	clone.CanQuery = false
	clone.Color = color
	clone.Size *= p
	clone.Parent = model
	return clone
end

local newChevron = NewChevron(3)
local newChevron2 = NewChevron(1.5)
local total = 0

local function DrawLine(vector: Vector3, vector2: Vector3, p) -- 1 equivalent call inferred from this helper
	local magnitude = (vector - vector2).Magnitude
	p.Size = Vector3.new(0.25, 0.01, magnitude + 0.012)
	p.CFrame = CFrame.new(vector, vector2) * CFrame.new(0, 0, -magnitude / 2)
end

local function GetNextDash() -- 1 equivalent call inferred from this helper
	count += 1
	local v6 = v5[count]

	if not v6 then
		v6 = NewLinePart()
		v5[count] = v6
	end

	return v6
end

local function DrawDashedLine(vector: Vector3, vector2: Vector3)
	local magnitude = (vector2 - vector).Magnitude
	local unit = (vector2 - vector).Unit
	local v6 = math.max(math.floor((magnitude + 4) / 12), 1)
	local v7 = math.min(8, magnitude)
	local v8 = (magnitude - (v6 * v7 + (v6 - 1) * 4)) / 2

	for i = 1, v6 do
		local v9 = vector + unit * (v8 + (i - 1) * (v7 + 4))
		DrawLine(v9, v9 + unit * v7, GetNextDash()) -- inferred equivalent call
	end
end

function GroundDirectionalAiming.Run(p: number, vector: Vector3)
	MapHandler.HidePathHighlight()
	AimingGuideHandler.Show(p, vector, vector, true)
	v2 = vector
	local v6 = v * 0.7853981633974483
	local vector2 = Vector3.new(math.cos(v6), 0, (math.sin(v6)))
	local vector3 = Vector3.new(-math.sin(v6), 0, (math.cos(v6)))
	local v7 = vector + vector2 * (v3 / 2)
	local v8 = vector - vector2 * (v3 / 2)
	local v9 = vector3 * (v4 / 2)
	count = 0
	DrawDashedLine(v8 + v9, v7 + v9)
	DrawDashedLine(v8 - v9, v7 - v9)
	DrawDashedLine(v7 - v9, v7 + v9)
	DrawDashedLine(v8 - v9, v8 + v9)

	for i = count + 1, #v5 do
		v5[i].Size = createVector(0.001, 0.001, 0.001)
	end

	total += p
	local v10 = math.cos(total * 3.141592653589793) ^ 2 * 0.5
	local v11 = v7 + vector2 * 3 + createVector(0, 0.1, 0)
	newChevron.CFrame = CFrame.new(v11, v11 + vector2)
	local v12 = vector + vector2 * (v10 + 4) + createVector(0, 0.1, 0)
	newChevron2.CFrame = CFrame.new(v12, v12 + vector2)
	model.Parent = raycastIgnore
end

function GroundDirectionalAiming.BeginGroundDirectionalAiming(p: number, p2: number)
	v3 = p
	v4 = p2
	flag = true
end

function GroundDirectionalAiming.GetCurrentAimData()
	if v2 then
		return true, v2, v * 0.7853981633974483
	end

	return false, nil, 0
end

function GroundDirectionalAiming.Hide()
	flag = false
	v2 = nil
	AimingGuideHandler.Hide()
	model.Parent = Hidden
end

event:AttachCallback(function()
	if flag then
		v = (v + 1) % 8
	end
end)
return GroundDirectionalAiming