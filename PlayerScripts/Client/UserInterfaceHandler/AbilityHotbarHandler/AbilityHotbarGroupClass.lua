local AbilityHotbarGroupClass = {}
AbilityHotbarGroupClass.__index = AbilityHotbarGroupClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local AbilityHotbarItemClass = require(script.Parent:WaitForChild("AbilityHotbarItemClass"))
local udim = UDim.new(-0.29, 0)
local udim2 = UDim.new(-0.37, 0)
local udim3 = UDim.new(0, 0)

function AbilityHotbarGroupClass.New(name: string, parent)
	local template = parent:FindFirstChild("Template")
	template.Visible = false
	local clone = template:Clone()
	clone.Name = name
	clone.Parent = parent
	clone.Visible = false
	return (setmetatable(
		{
			HotbarItems = {},
			Frame = clone,
			AspectRatioConstraint = clone:FindFirstChild("UIAspectRatioConstraint"),
			ListLayout = clone:FindFirstChild("UIListLayout")
		},
		AbilityHotbarGroupClass
	))
end

function AbilityHotbarGroupClass:Update(data)
	local v = {}

	for k in pairs(self.HotbarItems) do
		v[k] = true
	end

	local v2 = -1e999

	for k, v3 in pairs(data.LevelToAbilityDataMap) do
		local hotbarItem = self.HotbarItems[k]
		v2 = math.max(v2, k)

		if not hotbarItem then
			hotbarItem = AbilityHotbarItemClass.New(k, data.DisplayLevel, v3, self.Frame)
			self.HotbarItems[k] = hotbarItem
		end

		hotbarItem:Update(v3)
		v[k] = nil
	end

	for k in pairs(v) do
		self.HotbarItems[k]:Destroy()
		self.HotbarItems[k] = nil
	end

	for k, hotbarItem in pairs(self.HotbarItems) do
		hotbarItem:SetIsHighestLevel(k == v2)
	end

	if data.Count > 0 then
		self.Frame.Visible = true
	else
		self.Frame.Visible = false
	end

	if data.Count >= 3 then
		self.AspectRatioConstraint.AspectRatio = 1.9
		self.ListLayout.Padding = udim
	elseif data.Count == 2 then
		self.AspectRatioConstraint.AspectRatio = 1.45
		self.ListLayout.Padding = udim2
	else
		self.AspectRatioConstraint.AspectRatio = 1
		self.ListLayout.Padding = udim3
	end
end

function AbilityHotbarGroupClass:Destroy()
	self.Frame:Destroy()
end

return AbilityHotbarGroupClass