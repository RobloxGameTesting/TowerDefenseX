local v = game.Selection:Get()[1]
local internal = v:FindFirstChild("_Internal")

if not internal then
	warn("Internal folder not found in TowerSet")
	return
end

local v2 = internal:FindFirstChild("SFX")

if not v2 then
	v2 = Instance.new("Folder", internal)
	v2.Name = "SFX"
end

local v3 = internal:FindFirstChild("VFX")

if not v3 then
	v3 = Instance.new("Folder", internal)
	v3.Name = "VFX"
end

local models = {}
local path1 = v:FindFirstChild("Path1")
local path2 = v:FindFirstChild("Path2")

if not (path1 and path2) then
	warn("Path1 or Path2 not found in TowerSet")
	return
end

for _, model in pairs(v:GetChildren()) do
	if model:IsA("Model") then
		table.insert(models, model)
	end
end

for _, model in pairs(path1:GetChildren()) do
	if model:IsA("Model") then
		table.insert(models, model)
	end
end

for _, model in pairs(path2:GetChildren()) do
	if model:IsA("Model") then
		table.insert(models, model)
	end
end

for _, v4 in pairs(models) do
	local minigun = v4:FindFirstChild("Minigun")

	if not minigun then
		continue
	end

	local weapon = minigun:FindFirstChild("Weapon")

	if weapon then
		local name = (v4.Parent == path1 and "Path1_" or v4.Parent == path2 and "Path2_" or "") .. (table.find({
			"Base",
			"1",
			"2"
		}, v4.Name) and "Base" or table.find({ "3", "4" }, v4.Name) and "3" or "5")
		local v5 = v2:FindFirstChild(name)

		if not v5 then
			v5 = Instance.new("Folder", v2)
			v5.Name = name
		end

		local v6 = weapon:FindFirstChild("SoundPointer")

		if not v6 then
			v6 = Instance.new("ObjectValue", weapon)
			v6.Name = "SoundPointer"
		end

		v6.Value = v5

		for _, attachment in pairs(minigun:GetDescendants()) do
			if not (attachment:IsA("Attachment") and attachment.Name == "Barrel") then
				continue
			end

			local v7 = v3:FindFirstChild(name)

			if not v7 then
				v7 = Instance.new("Folder", v3)
				v7.Name = name
			end

			local v8 = attachment:FindFirstChild("EmitterPointer")

			if not v8 then
				v8 = Instance.new("ObjectValue", attachment)
				v8.Name = "EmitterPointer"
			end

			v8.Value = v7
		end
	else
		warn("PrimaryPart not found in Weapon", minigun:GetFullName())
	end
end