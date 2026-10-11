if workspace:GetAttribute("IsLobby") then
	return {}
end

local PingDirectionHUD = { ClassName = script.Name, ClassModule = script }
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local PingConfig = require(common:WaitForChild("PingConfig"))
local pingDirectionHUD = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PingDirectionHUD", 5)
local marker = pingDirectionHUD:WaitForChild("Marker", 5)
marker.Visible = false
local v = {}

local function CreateMarker(part)
	if v[part] then
		return
	end

	local pingSlotIndex = part:GetAttribute("PingSlotIndex")

	if type(pingSlotIndex) ~= "number" then
		return
	end

	local ping = PingConfig.Pings[pingSlotIndex]

	if not ping then
		return
	end

	local clone = marker:Clone()
	local icon = clone:FindFirstChild("Icon")

	if icon then
		icon.Image = ping.WorldIcon
		icon.ImageColor3 = ping.ActiveColor
	end

	clone.Visible = true
	clone.Parent = pingDirectionHUD
	v[part] = clone
end

local function DestroyMarkerFor(p)
	local v2 = v[p]

	if v2 then
		v2:Destroy()
		v[p] = nil
	end
end

local function UpdateMarker(k, p)
	local currentCamera = workspace.CurrentCamera

	if not currentCamera then
		return
	end

	local viewportSize = currentCamera.ViewportSize
	local worldToViewportPoint = currentCamera:WorldToViewportPoint(k.Position)
	local v2 = viewportSize.X * 0.5
	local v3 = viewportSize.Y * 0.5
	local v4

	if
		worldToViewportPoint.Z > 0
		and worldToViewportPoint.X >= 0
		and worldToViewportPoint.X <= viewportSize.X
		and worldToViewportPoint.Y >= 0
	then
		v4 = worldToViewportPoint.Y <= viewportSize.Y
	else
		v4 = false
	end

	if v4 then
		p.Visible = false
		return
	end

	local v5 = worldToViewportPoint.X - v2
	local v6 = worldToViewportPoint.Y - v3

	if worldToViewportPoint.Z < 0 then
		v5 = -v5
		v6 = -v6
	end

	local v7 = v2 - 56
	local v8 = v3 - 56
	local v9 = math.abs(v5)
	local v10 = math.abs(v6)
	local v11 = math.min(not (v9 > 0) and 1e999 or v7 / v9, not (v10 > 0) and 1e999 or v8 / v10)
	p.Position = UDim2.fromOffset(v5 * v11 + v2, v6 * v11 + v3)
	p.Visible = true
end

for _, part in ipairs(CollectionService:GetTagged(PingConfig.ActivePingTag)) do
	if part:IsA("BasePart") then
		CreateMarker(part)
	end
end

CollectionService:GetInstanceAddedSignal(PingConfig.ActivePingTag):Connect(function(part)
	if part:IsA("BasePart") then
		CreateMarker(part)
	end
end)
CollectionService:GetInstanceRemovedSignal(PingConfig.ActivePingTag):Connect(function(part)
	local v2 = part:IsA("BasePart") and v[part]

	if v2 then
		v2:Destroy()
		v[part] = nil
	end
end)
RunService.RenderStepped:Connect(function()
	for k, v2 in pairs(v) do
		UpdateMarker(k, v2)
	end
end)
return PingDirectionHUD