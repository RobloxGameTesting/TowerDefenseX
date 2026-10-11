local createVector = vector.create
local AimingGuideHandler = {}
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local DashedCircleUtilities = require(common:WaitForChild("DashedCircleUtilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local color = Color3.fromRGB(72, 244, 121)
local color2 = Color3.fromRGB(62, 211, 102)
local color3 = Color3.fromRGB(238, 103, 91)
local color4 = Color3.fromRGB(255, 0, 0)
local folder = ResourceManager.GetMiscResource("AimingGuide")
local highlight = folder:WaitForChild("Highlight")
folder.Parent = Hidden
local primaryPart = folder.PrimaryPart
local topArrow = primaryPart:FindFirstChild("TopArrow")
local v = {
	primaryPart:FindFirstChild("SideArrow1"),
	primaryPart:FindFirstChild("SideArrow2"),
	primaryPart:FindFirstChild("SideArrow3"),
	primaryPart:FindFirstChild("SideArrow4")
}
local miscResource = ResourceManager.GetMiscResource("AimingGuideBeam")
local start = miscResource:FindFirstChild("Start")
local firstChild = miscResource:FindFirstChild("End")
local c0 = topArrow.C0
local total = 0
local v2 = nil

local function ColorAimingGuideArrows(color5: Color3)
	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Color = color5
		end
	end
end

local function AnimateAimingGuide(p: number)
	topArrow.C0 = (c0 + Vector3.new(0, math.cos(total * 3.141592653589793) ^ 2 * 4, 0)) * CFrame.Angles(0, 0, total * 3.141592653589793)

	for i = 1, #v do
		v[i].C1 = CFrame.new(0, 0, math.cos(total * 3.141592653589793) ^ 2 * 0.5)
	end

	total += p
end

function AimingGuideHandler.Show(p: number, vector: Vector3, position: Vector3, flag: boolean, p2: number?)
	local v3

	if flag then
		v3 = color
		highlight.FillColor = color
		highlight.OutlineColor = color2
		ColorAimingGuideArrows(color)
	else
		v3 = color3
		highlight.FillColor = color3
		highlight.OutlineColor = color4
		ColorAimingGuideArrows(color3)
	end

	folder.Parent = raycastIgnore
	folder:PivotTo(CFrame.new(position) * CFrame.Angles(0, total * 3.141592653589793 / 3, 0))
	AnimateAimingGuide(p)
	start.Position = vector + createVector(0, 0.15, 0) + createVector(0, 0.01, 0)
	firstChild.Position = position + createVector(0, 0.15, 0)
	miscResource.Parent = raycastIgnore

	if p2 then
		if v2 and v2.Radius == p2 then
			DashedCircleUtilities.UpdateCirclePosition(v2, position)
		else
			if v2 then
				DashedCircleUtilities.DestroyCircle(v2)
			end

			v2 = DashedCircleUtilities.NewDashedCircleData(position, p2, v3, 0.15)
		end

		DashedCircleUtilities.UpdateCircleColor(v2, v3)
	elseif v2 then
		DashedCircleUtilities.DestroyCircle(v2)
		v2 = nil
	end
end

function AimingGuideHandler.Hide()
	folder.Parent = Hidden
	miscResource.Parent = Hidden

	if v2 then
		DashedCircleUtilities.DestroyCircle(v2)
		v2 = nil
	end
end

return AimingGuideHandler