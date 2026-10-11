local SkinHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local BaseRigMethodHandler = require(common:WaitForChild("BaseRigMethodHandler"))
local isStudio = RunService:IsStudio()
local Weld = Utilities.Weld
local TryGetInstanceFromPath = Utilities.TryGetInstanceFromPath
local GetPathFromParent = Utilities.GetPathFromParent
local v = {}
local v2 = {}
local v3 = {}
local v4 = {}

local function GetTowerInfoKey(data) -- 1 equivalent call inferred from this helper
	return "Tower_" .. data.TowerName .. "_" .. data.TowerPath .. "_" .. data.TowerLevel .. "_" .. data.SkinName
end

local function GetStaticEntityInfoKey(data) -- 1 equivalent call inferred from this helper
	return "StaticEntity_" .. data.StaticEntityName .. "_" .. data.SkinName
end

local function ApplyColorSkin(p: string, folder, instance, _, data)
	local v5

	if p == "Tower" then
		v5 = GetTowerInfoKey(data) -- inferred equivalent call
	elseif p == "StaticEntity" then
		v5 = GetStaticEntityInfoKey(data) -- inferred equivalent call
	else
		warn("SkinHandler: unsupported entity class " .. p)
		return
	end

	local attributesByAttributeName = v[v5]
	local result = v2[v5]
	local childrenByMeshId = v3[v5]
	local childrenByName = v4[v5]

	if not attributesByAttributeName then
		attributesByAttributeName = {}
		local child

		if p == "Tower" then
			child = instance:FindFirstChild("P" .. tostring(data.TowerPath) .. "L" .. tostring(data.TowerLevel))
		end

		for attributeName, v6 in pairs(instance:GetAttributes()) do
			attributesByAttributeName[attributeName] = child and child:GetAttribute(attributeName) or v6
		end

		v[v5] = attributesByAttributeName
	end

	if not result then
		result = {}
		local colorData = instance:FindFirstChild("ColorData")

		if colorData then
			for k, v6 in pairs(colorData:GetAttributes()) do
				result[k] = v6
			end
		end

		v2[v5] = result
	end

	if not childrenByMeshId then
		childrenByMeshId = {}
		local decals = instance:FindFirstChild("Decals")

		if decals then
			for _, child in pairs(decals:GetChildren()) do
				local meshId = child:GetAttribute("MeshId")

				if meshId then
					childrenByMeshId[meshId] = child
				else
					warn("Decal missing MeshId attribute")
				end
			end
		end

		v3[v5] = childrenByMeshId
	end

	if not childrenByName then
		childrenByName = {}
		local surfaceAppearanceData = instance:FindFirstChild("SurfaceAppearanceData")

		if surfaceAppearanceData then
			for _, child in pairs(surfaceAppearanceData:GetChildren()) do
				for _, child2 in pairs(child:GetChildren()) do
					childrenByName[child2.Name] = child
					child2:Destroy()
				end
			end
		end

		v4[v5] = childrenByName
	end

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("MeshPart") then
			continue
		end

		if Utilities.TryReadChildValue(part, "HideIfColorSkin") then
			part.Transparency = 1
		end

		if Utilities.TryReadChildValue(part, "ShowIfColorSkin") then
			part.Transparency = 0
		end

		local meshId = part.MeshId
		local v6

		if meshId:find("rbxassetid://") then
			v6 = string.match(meshId, "%d[%d.,]*")
		else
			v6 = string.match(meshId, "=%s*(%d[,.%d]*)")
		end

		local textureID = attributesByAttributeName[v6]
		local color = result[v6]
		local v7 = childrenByMeshId[v6]
		local v8 = childrenByName[v6]
		local surfaceAppearance = part:FindFirstChildOfClass("SurfaceAppearance")

		if v8 then
			if surfaceAppearance then
				surfaceAppearance:Destroy()
			end

			local clone = v8:Clone()
			clone.Parent = part
			part.TextureID = ""
		elseif textureID then
			if surfaceAppearance then
				surfaceAppearance:Destroy()
			end

			part.TextureID = textureID
		end

		if color then
			part.Color = color
		end

		if not v7 then
			continue
		end

		local clone = v7:Clone()
		clone.Parent = part
	end

	instance:Destroy()
	return folder, attributesByAttributeName, result, childrenByName
end

local function ApplyMeshPartSkin(folder, instance, instance2, _)
	local rotationOffset = instance:GetAttribute("RotationOffset") or CFrame.new()
	instance:PivotTo(folder:GetPivot() * rotationOffset)
	local forceRemove = instance:FindFirstChild("ForceRemove")

	if forceRemove then
		for _, child in pairs(forceRemove:GetChildren()) do
			local tryGetInstanceFromPath = TryGetInstanceFromPath(folder, child.Name)

			if tryGetInstanceFromPath then
				tryGetInstanceFromPath:Destroy()
			else
				warn(`ApplyMeshPartSkin: could not find instance to remove {child.Name}`)
			end
		end
	end

	local descendants = {}
	local v5 = {}
	local descendants2 = {}

	for _, descendant in folder:GetDescendants() do
		if descendant:IsA("BasePart") then
			descendants[GetPathFromParent(descendant, folder)] = descendant

			if descendant ~= folder.PrimaryPart then
				v5[descendant] = true
			end
		elseif descendant:IsA("Attachment") then
			descendants2[GetPathFromParent(descendant, folder)] = descendant
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant:Destroy()
		end
	end

	for _, folder2 in instance:GetChildren() do
		if folder2:IsA("Folder") then
			continue
		end

		local name = folder2.Name
		local parent2 = descendants[name]
		local parent3 = descendants2[name]

		if parent2 then
			for _, part in folder2:GetDescendants() do
				if part:IsA("BasePart") then
					Weld(folder2, part)
				end
			end

			Weld(parent2, folder2)
			folder2.Anchored = false
			folder2.Parent = parent2
			parent2.Transparency = 1
			parent2.Parent:SetAttribute("SkinChildReplaced", true)
			v5[parent2] = nil

			if isStudio then
				folder2.Name ..= "__Skin"
			end
		elseif parent3 then
			local v6 = Utilities.TryReadChildValue(folder2, "Reparent")

			if v6 then
				if not descendants[v6] then
					warn(`Could not find new parent {v6}`)
				end

				parent3.Parent = descendants[v6]
			end

			if not Utilities.TryReadChildValue(folder2, "NoReposition") then
				parent3.WorldCFrame = CFrame.new(folder2.Position) * parent3.WorldCFrame.Rotation
			end

			if Utilities.TryReadChildValue(folder2, "ReplaceEmitters") then
				for _, emitter in pairs(parent3:GetChildren()) do
					if emitter:IsA("ParticleEmitter") then
						emitter:Destroy()
					end
				end

				for _, child in pairs(folder2:GetChildren()) do
					if child:IsA("ParticleEmitter") or child:IsA("BasePart") then
						child.Parent = parent3
					end
				end
			end

			if Utilities.TryReadChildValue(folder2, "ReplaceBeams") then
				local parent = parent3.Parent

				for _, beam in pairs(parent:GetChildren()) do
					if beam:IsA("Beam") then
						beam:Destroy()
					end
				end

				for _, beam in pairs(folder2:GetChildren()) do
					if not beam:IsA("Beam") then
						continue
					end

					beam.Attachment0 = beam.Attachment0 and parent:FindFirstChild(beam.Attachment0.Name)
					beam.Attachment1 = beam.Attachment1 and parent:FindFirstChild(beam.Attachment1.Name)
					beam.Parent = parent
				end
			end
		else
			warn(`ApplyMeshPartSkin: could not find matching instance for {folder2.Name} (Parent: {folder2.Parent.Name})`)
		end
	end

	local projectileOriginReplacement = instance:FindFirstChild("ProjectileOriginReplacement")

	if projectileOriginReplacement then
		for _, child in pairs(projectileOriginReplacement:GetChildren()) do
			local child2 = folder:FindFirstChild(child.Name)

			if child2 then
				Weld(child2.PrimaryPart, child.PrimaryPart)
				child.Parent = child2.Parent

				for _, part in child.PrimaryPart:GetChildren() do
					if part:IsA("BasePart") then
						Weld(child.PrimaryPart, part)
					end
				end

				child2.Name = "PreSkin__" .. child2.Name

				for _, part in pairs(child2:GetChildren()) do
					if not part:IsA("BasePart") then
						part.Parent = child
					end
				end
			else
				warn(`ApplyMeshPartSkin: could not find matching projectile origin replacement for {child.Name}`)
			end
		end
	end

	local projectileSkinData = instance:FindFirstChild("ProjectileSkinData")

	if projectileSkinData then
		for _, child in pairs(projectileSkinData:GetChildren()) do
			local children = {}

			for _, child2 in pairs(folder:GetChildren()) do
				if child2.Name == child.Name then
					table.insert(children, child2)
				end
			end

			if #children == 0 then
				warn(`ApplyMeshPartSkin: could not find matching projectile origin for {child.Name}`)
			else
				for _, parent in pairs(children) do
					local projectileSkinName = parent:FindFirstChild("ProjectileSkinName")

					if projectileSkinName then
						projectileSkinName:Destroy()
					end

					local clone = child:Clone()
					clone.Parent = parent
					clone.Name = "ProjectileSkinName"
				end
			end
		end
	end

	local sfxReplacement = instance:FindFirstChild("SFXReplacement")

	if sfxReplacement then
		for _, child in pairs(sfxReplacement:GetChildren()) do
			local parent = TryGetInstanceFromPath(folder, child.Name)

			if parent then
				for _, child2 in pairs(parent:GetChildren()) do
					if not (child2:IsA("Sound") or child2:IsA("ObjectValue") and child2.Name == "SoundPointer") then
						continue
					end

					child2:Destroy()
				end

				for _, child2 in pairs(child:GetChildren()) do
					child2.Parent = parent
				end
			else
				warn(`ApplyMeshPartSkin: could not find matching SFX replacement for {child.Name}`)
			end
		end
	end

	local vfxReplacement = instance:FindFirstChild("VFXReplacement")

	if vfxReplacement then
		for _, child in pairs(vfxReplacement:GetChildren()) do
			local parent = TryGetInstanceFromPath(folder, child.Name)

			if parent then
				for _, child2 in pairs(parent:GetChildren()) do
					if not (child2:IsA("ParticleEmitter") or child2:IsA("ObjectValue") and child2.Name == "EmitterPointer") then
						continue
					end

					child2:Destroy()
				end

				for _, child2 in pairs(child:GetChildren()) do
					child2.Parent = parent
				end
			else
				warn(`ApplyMeshPartSkin: could not find matching VFX replacement for {child.Name}`)
			end
		end
	end

	local emitterColorOverride = instance2 and instance2:FindFirstChild("EmitterColorOverride")

	if emitterColorOverride then
		local color = emitterColorOverride.Color

		for _, emitter in pairs(folder:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Color = color
			end
		end
	end

	local animationReplacement = instance:FindFirstChild("AnimationReplacement")

	if animationReplacement then
		local animations = folder:FindFirstChild("Animations")

		for _, child in pairs(animationReplacement:GetChildren()) do
			local child2 = animations:FindFirstChild(child.Name)

			if child2 then
				child2:Destroy()
				child.Parent = animations
			else
				warn(`ApplyMeshPartSkin: could not find matching animation replacement for {child.Name}`)
			end
		end
	end

	for k in pairs(v5) do
		if k.Transparency > 0.999 then
			continue
		end

		if Utilities.TryReadChildValue(k, "SkinMakeInvisible", false) then
			k.Transparency = 1
		end

		if Utilities.TryReadChildValue(k, "SkinIgnore", false) then
			continue
		end

		if k.Parent and Utilities.TryReadChildValue(k.Parent, "SkinIgnoreChildren", false) then
			if not k.Parent:GetAttribute("SkinChildReplaced") then
				continue
			end

			if Utilities.TryReadChildValue(k, "SkinMakeInvisibleIfChildOfParentReplaced") then
				k.Transparency = 1
				continue
			elseif not Utilities.TryReadChildValue(k, "SkinDestroyIfChildOfParentReplaced") then
				continue
			end
		end

		k:Destroy()
	end

	if instance:GetAttribute("ViewportScale") then
		folder:SetAttribute("ViewportScale", instance:GetAttribute("ViewportScale"))
	end

	if instance:GetAttribute("ViewportPosition") then
		folder:SetAttribute("ViewportPosition", instance:GetAttribute("ViewportPosition"))
	end

	if instance:GetAttribute("ViewportOrientation") then
		folder:SetAttribute("ViewportOrientation", instance:GetAttribute("ViewportOrientation"))
	end

	instance:Destroy()
	return folder
end

local function ApplyModelSkin(instance, instance2, p, _)
	instance2:PivotTo(instance:GetPivot())

	if instance2:GetAttribute("UseBaseRigMethod") then
		instance2 = BaseRigMethodHandler.SetUp(instance2, p)
	end

	instance:Destroy()
	return instance2
end

function SkinHandler.ApplySkin(p: string, p2: string, skinName: string, instance, towerPath: number?, towerLevel: number?, p3: number?, p4: string?)
	if skinName == "" then
		return instance
	end

	local v5 = nil
	local v6, skinType, v7

	if p == "Tower" then
		v6, skinType, v7 = ResourceManager.GetTowerSkin(p2, towerPath, towerLevel, p3, skinName)
		v5 = { TowerName = p2, TowerPath = towerPath, TowerLevel = towerLevel, SkinName = skinName }
	elseif p == "StaticEntity" then
		v6, skinType, v7 = ResourceManager.GetStaticEntitySkin(p2, p4, skinName, true)

		if not v6 then
			return instance
		end

		v5 = { StaticEntityName = p2, SkinName = skinName }
	else
		if p ~= "PathEntity" then
			warn("SkinHandler: unsupported entity class " .. p)
			return instance
		end

		v6, skinType, v7 = ResourceManager.GetPathEntitySkin(p2, p4, skinName, true)

		if not v6 then
			return instance
		end
	end

	local colorSkinMeshIdToTextureIdMap = nil
	local colorSkinMeshIdToColorMap = nil
	local colorSkinMeshIdToSAMap = nil

	if skinType == Enums.SkinTypes.ColorSkin then
		v6, colorSkinMeshIdToTextureIdMap, colorSkinMeshIdToColorMap, colorSkinMeshIdToSAMap = ApplyColorSkin(p, instance, v6, v7, v5)
		return v6, {
			SkinType = skinType,
			HoverHeight = v7 and Utilities.TryReadChildValue(v7, "HoverHeight", nil),
			CFrameOffset = v7 and Utilities.TryReadChildValue(v7, "CFrameOffset", CFrame.new()),
			ColorSkinMeshIdToTextureIdMap = colorSkinMeshIdToTextureIdMap,
			ColorSkinMeshIdToColorMap = colorSkinMeshIdToColorMap,
			ColorSkinMeshIdToSAMap = colorSkinMeshIdToSAMap
		}
	end

	if skinType == Enums.SkinTypes.MeshPartSkin then
		v6 = ApplyMeshPartSkin(instance, v6, v7, v5)
		return v6, {
			SkinType = skinType,
			HoverHeight = v7 and Utilities.TryReadChildValue(v7, "HoverHeight", nil),
			CFrameOffset = v7 and Utilities.TryReadChildValue(v7, "CFrameOffset", CFrame.new()),
			ColorSkinMeshIdToTextureIdMap = colorSkinMeshIdToTextureIdMap,
			ColorSkinMeshIdToColorMap = colorSkinMeshIdToColorMap,
			ColorSkinMeshIdToSAMap = colorSkinMeshIdToSAMap
		}
	end

	if skinType ~= Enums.SkinTypes.ModelSkin then
		warn("Unknown skin type " .. tostring(skinType))
		return instance
	end

	v6:PivotTo(instance:GetPivot())

	if v6:GetAttribute("UseBaseRigMethod") then
		v6 = BaseRigMethodHandler.SetUp(v6, v7)
	end

	instance:Destroy()
	return v6, {
		SkinType = skinType,
		HoverHeight = v7 and Utilities.TryReadChildValue(v7, "HoverHeight", nil),
		CFrameOffset = v7 and Utilities.TryReadChildValue(v7, "CFrameOffset", CFrame.new()),
		ColorSkinMeshIdToTextureIdMap = colorSkinMeshIdToTextureIdMap,
		ColorSkinMeshIdToColorMap = colorSkinMeshIdToColorMap,
		ColorSkinMeshIdToSAMap = colorSkinMeshIdToSAMap
	}
end

return SkinHandler