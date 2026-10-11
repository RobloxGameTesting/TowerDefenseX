local function Weld(p, part) -- 2 equivalent calls inferred from this helper
	local weld = Instance.new("Weld")
	weld.Part0 = p
	weld.Part1 = part
	weld.C0 = p.CFrame:Inverse()
	weld.C1 = part.CFrame:Inverse()
	weld.Parent = p
	return weld
end

local function GetPathFromParent(parent, p)
	local name = parent.Name
	local v = 10

	while parent.Parent ~= p and v > 0 do
		parent = parent.Parent
		name = parent.Name .. ">" .. name
		v -= 1
	end

	return name
end

local function WeldAppearanceParts(folder, instance)
	instance:PivotTo(folder:GetPivot())
	instance.Parent = folder
	local partsByName = {}
	local v = {}

	for _, part in folder:GetDescendants() do
		if not (part ~= folder.PrimaryPart and part:IsA("BasePart")) then
			continue
		end

		local name = part.Name
		local parent = part
		local v2 = 10

		while parent.Parent ~= folder and v2 > 0 do
			parent = parent.Parent
			name = parent.Name .. ">" .. name
			v2 -= 1
		end

		partsByName[name] = part
		v[part] = true
	end

	for _, folder2 in instance:GetChildren() do
		if folder2:IsA("Folder") and folder2.Name == "Animations" then
			folder2.Parent = folder
		end

		if folder2 == instance.PrimaryPart or folder2:IsA("Folder") then
			continue
		end

		local parent = partsByName[folder2.Name]

		if parent then
			for _, part in folder2:GetDescendants() do
				if part:IsA("BasePart") then
					Weld(folder2, part) -- inferred equivalent call
				end
			end

			Weld(parent, folder2) -- inferred equivalent call
			folder2.Parent = parent
			parent.Transparency = 1
			v[parent] = nil
		else
			warn(`ApplyMeshPartSkin: could not find matching instance for {folder2.Name}`)
		end
	end

	instance:Destroy()
end

local v = game.Selection:Get()
WeldAppearanceParts(v[1], v[2])