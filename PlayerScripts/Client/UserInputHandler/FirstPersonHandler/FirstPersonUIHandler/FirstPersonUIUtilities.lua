local FirstPersonUIUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local Utilities = require(common:WaitForChild("Utilities"))
script.Parent:WaitForChild("Handlers")
local frames = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames")
local default = frames:WaitForChild("Default")
local child = default
local v = {}
local parent = nil
local children = {}

local function SwapLightingEffects(instance)
	if parent then
		for _, v2 in pairs(children) do
			v2.Parent = parent
		end

		children = {}
	end

	if instance then
		for _, child2 in pairs(instance:GetChildren()) do
			child2.Parent = Lighting
			table.insert(children, child2)
		end
	end

	parent = instance
end

function FirstPersonUIUtilities.SetTower(_, p)
	local uiName = p.UIName

	if child then
		child.Visible = false
	end

	if uiName then
		child = frames:FindFirstChild(uiName)
	end

	if not (uiName and child) then
		child = default
	end

	child.Visible = true
	local pointers = child:FindFirstChild("Pointers")
	v = {}

	if pointers then
		for _, child2 in pairs(pointers:GetChildren()) do
			local name = child2.Name
			v[name] = Utilities.TryGetInstanceFromPath(child, child2.Value)

			if not v[name] then
				warn("GuiObject with path", child2.Value, "not found")
			end
		end
	end

	SwapLightingEffects(child:FindFirstChild("LightingEffects"))
end

function FirstPersonUIUtilities.RemoveTower()
	if child then
		child.Visible = false
	end

	child = nil
	v = {}
	SwapLightingEffects()
end

function FirstPersonUIUtilities.GetAmmoTextLabel()
	return v.AmmoText
end

function FirstPersonUIUtilities.GetCrosshair()
	return v.Crosshair
end

function FirstPersonUIUtilities.GetHitmarker()
	return v.Hitmarker
end

for _, child2 in pairs(frames:GetChildren()) do
	child2.Visible = false
end

return FirstPersonUIUtilities