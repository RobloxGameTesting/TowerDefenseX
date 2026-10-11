local function CheckForScripts(folder)
	for _, Script in pairs(folder:GetDescendants()) do
		if not (Script:IsA("Script") or Script:IsA("LocalScript") or Script:IsA("ModuleScript")) then
			continue
		end

		warn("SCRIPT DETECTED", Script:GetFullName())
	end
end

local function CheckCollisions(folder)
	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		if part.CanCollide then
			part.CanCollide = false
			print(part.Name, "CanCollide")
		end

		if not part.CanTouch then
			continue
		end

		part.CanTouch = false
		print(part.Name, "CanTouch")
	end
end

local function CheckAnchored(folder)
	local primaryPart = folder.PrimaryPart

	for _, part in pairs(folder:GetDescendants()) do
		if not (part:IsA("BasePart") and part ~= primaryPart and part.Anchored) then
			continue
		end

		part.Anchored = false
		print(part.Name, "Anchored")
	end
end

local function GetPathToTowerModel(p, parent)
	local name = parent.Name

	while parent.Parent ~= p do
		name = parent.Parent.Name .. ">" .. name
		parent = parent.Parent
	end

	return name
end

local v = game.Selection:Get()

for _, folder in pairs(v) do
	local primaryPart = folder.PrimaryPart

	for _, part in pairs(folder:GetDescendants()) do
		if not (part ~= primaryPart and part:IsA("BasePart")) then
			continue
		end

		if part.Transparency > 0.999 then
			part:Destroy()
		else
			local name = part.Name
			local parent = part

			while parent.Parent ~= folder do
				name = parent.Parent.Name .. ">" .. name
				parent = parent.Parent
			end

			part.Name = name
			part.Parent = folder
		end
	end

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			part:Destroy()
		end
	end

	CheckForScripts(folder)
	CheckCollisions(folder)
	CheckAnchored(folder)
end