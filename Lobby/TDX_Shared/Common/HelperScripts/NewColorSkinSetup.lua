local folder = Instance.new("Folder", workspace)
folder.Name = "ColorSkins"
local v = game.Selection:Get()

local function SurfaceAppearanceIsEqual(surfaceAppearance, data) -- 1 equivalent call inferred from this helper
	return surfaceAppearance.AlphaMode == data.AlphaMode
		and surfaceAppearance.Color == data.Color
		and surfaceAppearance.ColorMap == data.ColorMap
		and surfaceAppearance.MetalnessMap == data.MetalnessMap
		and surfaceAppearance.NormalMap == data.NormalMap
		and surfaceAppearance.RoughnessMap == data.RoughnessMap
end

for _, folder2 in pairs(v) do
	local name = folder2.Name
	local folder3 = Instance.new("Folder", folder)
	folder3.Name = name
	local folder4 = Instance.new("Folder", folder3)
	folder4.Name = "ColorData"
	local folder5 = Instance.new("Folder", folder3)
	folder5.Name = "SurfaceAppearanceData"
	local textureIDs = {}
	local v2 = {}
	local colors = {}

	for _, part in pairs(folder2:GetDescendants()) do
		if not part:IsA("MeshPart") then
			continue
		end

		local meshId = part.MeshId
		local v3

		if meshId:find("rbxassetid://") then
			v3 = string.match(meshId, "%d[%d.,]*")
		else
			v3 = string.match(meshId, "=%s*(%d[,.%d]*)")
		end

		if v3 then
			local textureID = part.TextureID
			local color = part.Color

			if textureID and textureID ~= "" then
				if textureIDs[v3] then
					warn("Duplicate texture ID found for " .. v3 .. " in " .. name)
					local clone = part:Clone()
					clone.Position += vector.create(0, 3, 0)
					clone.Parent = workspace
				else
					textureIDs[v3] = textureID
				end
			end

			if not textureID or textureID == "" then
				colors[v3] = color
			end

			local surfaceAppearance = part:FindFirstChildOfClass("SurfaceAppearance")

			if surfaceAppearance then
				local v4 = nil

				for k, v5 in pairs(v2) do
					if not SurfaceAppearanceIsEqual(surfaceAppearance, k) then -- inferred equivalent call
						continue
					end

					v4 = v5
					break
				end

				if not v4 then
					v4 = {}
					v2[surfaceAppearance] = v4
				end

				table.insert(v4, v3)
			end
		else
			warn("FormattedMeshId could not be derived from " .. meshId .. " in " .. name)
		end
	end

	for k, v3 in pairs(textureIDs) do
		folder3:SetAttribute(k, v3)
	end

	for k, v3 in pairs(colors) do
		folder4:SetAttribute(k, v3)
	end

	local clones = {}

	for k, v3 in pairs(v2) do
		local clone = k:Clone()
		clone.Parent = folder5

		for _, name2 in pairs(v3) do
			if clones[name2] then
				if clones[name2] ~= clone then
					warn("Conflicting surface appearances found for " .. name2 .. " in " .. name)
				end
			else
				local stringValue = Instance.new("StringValue")
				stringValue.Name = name2
				stringValue.Parent = clone
				clones[name2] = clone
			end
		end
	end
end

game.Selection:Set({ folder })