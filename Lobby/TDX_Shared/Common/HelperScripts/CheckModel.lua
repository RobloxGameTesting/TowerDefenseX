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

for _, v in pairs(game.Selection:Get()) do
	CheckForScripts(v)
	CheckCollisions(v)
	CheckAnchored(v)
end