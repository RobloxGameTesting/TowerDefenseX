local AbilityHotbarRowClass = {}
AbilityHotbarRowClass.__index = AbilityHotbarRowClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("AbilityTypes"))
local AbilityHotbarGroupClass = require(script.Parent:WaitForChild("AbilityHotbarGroupClass"))
local abilityHotbar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("AbilityHotbar")
local rowTemplate = abilityHotbar:WaitForChild("RowTemplate")

function AbilityHotbarRowClass.New(layoutOrder: number, name: string)
	local clone = rowTemplate:Clone()
	clone.Name = name
	clone.Parent = abilityHotbar
	clone.LayoutOrder = layoutOrder
	clone.Visible = false
	return (setmetatable({ HotbarGroups = {}, Frame = clone }, AbilityHotbarRowClass))
end

function AbilityHotbarRowClass:Update(items)
	local v = {}
	local count = 0

	for k in pairs(self.HotbarGroups) do
		v[k] = true
	end

	for k, item in pairs(items) do
		local hotbarGroup = self.HotbarGroups[k]

		if not hotbarGroup then
			hotbarGroup = AbilityHotbarGroupClass.New(k, self.Frame)
			self.HotbarGroups[k] = hotbarGroup
		end

		hotbarGroup:Update(item)
		v[k] = nil
		count += 1
	end

	for k in pairs(v) do
		self.HotbarGroups[k]:Destroy()
		self.HotbarGroups[k] = nil
	end

	if count > 0 then
		self.Frame.Visible = true
	else
		self.Frame.Visible = false
	end
end

function AbilityHotbarRowClass.Hide(p)
	p.Frame.Visible = false
end

function AbilityHotbarRowClass:Destroy()
	self.Frame:Destroy()
end

rowTemplate.Visible = false
return AbilityHotbarRowClass