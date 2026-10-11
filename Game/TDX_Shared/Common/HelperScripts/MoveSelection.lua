local v = game.Selection:Get()
local v2 = v[1]
local v3 = v[2]
v3.Size = v2.Size
v3.CFrame = v2.CFrame
local v4 = game.Selection:Get()
local v5 = v4[1]

for i = 2, #v4 do
	local instance = v4[i]
	local clone = v5:Clone()

	if instance:IsA("BasePart") then
		if clone:IsA("BasePart") then
			clone.CFrame = instance.CFrame
		else
			clone:PivotTo(instance.CFrame)
		end
	elseif instance:IsA("PVInstance") then
		if clone:IsA("BasePart") then
			clone.CFrame = instance:GetPivot()
		else
			clone:PivotTo(instance:GetPivot())
		end
	end

	clone.Parent = instance.Parent
end

local v6 = game.Selection:Get()

for i = 1, #v6, 2 do
	local v7 = v6[i]
	v6[i + 1].WorldCFrame = v7.WorldCFrame
end