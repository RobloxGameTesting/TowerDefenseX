local function GetMesh(partOperation)
	for _, dataModelMesh in pairs(partOperation:GetChildren()) do
		if dataModelMesh:IsA("DataModelMesh") then
			return dataModelMesh
		end
	end

	local specialMesh = nil

	if partOperation.ClassName == "WedgePart" then
		local specialMesh2 = Instance.new("SpecialMesh", partOperation)
		specialMesh2.MeshType = "Wedge"
		return specialMesh2
	elseif partOperation.ClassName == "CornerWedgePart" then
		local specialMesh2 = Instance.new("SpecialMesh", partOperation)
		specialMesh2.MeshType = "CornerWedge"
		return specialMesh2
	else
		if partOperation.ClassName == "VehicleSeat" then
			return (Instance.new("BlockMesh", partOperation))
		end

		if partOperation.ClassName == "Part" then
			if partOperation.Shape == Enum.PartType.Block then
				return (Instance.new("BlockMesh", partOperation))
			end

			specialMesh = Instance.new("SpecialMesh", partOperation)

			if partOperation.Shape == Enum.PartType.Cylinder then
				specialMesh.MeshType = "Cylinder"
				return specialMesh
			end

			if partOperation.Shape == Enum.PartType.Ball then
				specialMesh.MeshType = "Sphere"
				return specialMesh
			end
		elseif partOperation:IsA("PartOperation") then
			return specialMesh
		end

		return specialMesh
	end
end

local function GetPartBounds(items)
	local x = 1e999
	local y = 1e999
	local z = 1e999
	local x2 = -1e999
	local y2 = -1e999
	local z2 = -1e999

	local function CheckPos(data)
		if data.X < x then
			x = data.X
		end

		if data.Y < y then
			y = data.Y
		end

		if data.Z < z then
			z = data.Z
		end

		local x3 = data.X

		if x2 < x3 then
			x2 = data.X
		end

		local y3 = data.Y

		if y2 < y3 then
			y2 = data.Y
		end

		local z3 = data.Z

		if z2 < z3 then
			z2 = data.Z
		end
	end

	for _, item in pairs(items) do
		local cframe = item.CFrame
		local size = item.Size
		local v = cframe * CFrame.new(size.X / 2, size.Y / 2, size.Z / 2)

		if v.X < x then
			x = v.X
		end

		if v.Y < y then
			y = v.Y
		end

		if v.Z < z then
			z = v.Z
		end

		if x2 < v.X then
			x2 = v.X
		end

		if y2 < v.Y then
			y2 = v.Y
		end

		if z2 < v.Z then
			z2 = v.Z
		end

		local v2 = cframe * CFrame.new(size.X / -2, size.Y / 2, size.Z / 2)

		if v2.X < x then
			x = v2.X
		end

		if v2.Y < y then
			y = v2.Y
		end

		if v2.Z < z then
			z = v2.Z
		end

		if x2 < v2.X then
			x2 = v2.X
		end

		if y2 < v2.Y then
			y2 = v2.Y
		end

		if z2 < v2.Z then
			z2 = v2.Z
		end

		local v3 = cframe * CFrame.new(size.X / -2, size.Y / -2, size.Z / 2)

		if v3.X < x then
			x = v3.X
		end

		if v3.Y < y then
			y = v3.Y
		end

		if v3.Z < z then
			z = v3.Z
		end

		if x2 < v3.X then
			x2 = v3.X
		end

		if y2 < v3.Y then
			y2 = v3.Y
		end

		if z2 < v3.Z then
			z2 = v3.Z
		end

		local v4 = cframe * CFrame.new(size.X / -2, size.Y / -2, size.Z / -2)

		if v4.X < x then
			x = v4.X
		end

		if v4.Y < y then
			y = v4.Y
		end

		if v4.Z < z then
			z = v4.Z
		end

		if x2 < v4.X then
			x2 = v4.X
		end

		if y2 < v4.Y then
			y2 = v4.Y
		end

		if z2 < v4.Z then
			z2 = v4.Z
		end

		local v5 = cframe * CFrame.new(size.X / 2, size.Y / -2, size.Z / 2)

		if v5.X < x then
			x = v5.X
		end

		if v5.Y < y then
			y = v5.Y
		end

		if v5.Z < z then
			z = v5.Z
		end

		if x2 < v5.X then
			x2 = v5.X
		end

		if y2 < v5.Y then
			y2 = v5.Y
		end

		if z2 < v5.Z then
			z2 = v5.Z
		end

		local v6 = cframe * CFrame.new(size.X / 2, size.Y / -2, size.Z / -2)

		if v6.X < x then
			x = v6.X
		end

		if v6.Y < y then
			y = v6.Y
		end

		if v6.Z < z then
			z = v6.Z
		end

		if x2 < v6.X then
			x2 = v6.X
		end

		if y2 < v6.Y then
			y2 = v6.Y
		end

		if z2 < v6.Z then
			z2 = v6.Z
		end

		local v7 = cframe * CFrame.new(size.X / 2, size.Y / 2, size.Z / -2)

		if v7.X < x then
			x = v7.X
		end

		if v7.Y < y then
			y = v7.Y
		end

		if v7.Z < z then
			z = v7.Z
		end

		if x2 < v7.X then
			x2 = v7.X
		end

		if y2 < v7.Y then
			y2 = v7.Y
		end

		if z2 < v7.Z then
			z2 = v7.Z
		end

		local v8 = cframe * CFrame.new(size.X / -2, size.Y / 2, size.Z / -2)

		if v8.X < x then
			x = v8.X
		end

		if v8.Y < y then
			y = v8.Y
		end

		if v8.Z < z then
			z = v8.Z
		end

		if x2 < v8.X then
			x2 = v8.X
		end

		if y2 < v8.Y then
			y2 = v8.Y
		end

		if z2 < v8.Z then
			z2 = v8.Z
		end
	end

	return Vector3.new(x, y, z), (Vector3.new(x2, y2, z2))
end

local function GetScaledNumberSequence(size, p)
	local numberSequenceKeypoints = {}

	for _, keypoint in ipairs(size.Keypoints) do
		table.insert(
			numberSequenceKeypoints,
			NumberSequenceKeypoint.new(keypoint.Time, p * keypoint.Value, keypoint.Envelope and p * keypoint.Envelope)
		)
	end

	return NumberSequence.new(numberSequenceKeypoints)
end

local function ScaleJoints(instances, p)
	for _, item in pairs(instances) do
		local className = item.ClassName
		local parent = item.Parent
		local name = item.Name
		local part0 = item.Part0
		local part1 = item.Part1
		local c0 = item.C0
		local c1 = item.C1
		local instance = Instance.new(className)
		instance.Name = name
		instance.Part0 = part0
		instance.Part1 = part1
		instance.C0 = CFrame.new(c0.p * p) * (c0 - c0.p)
		instance.C1 = CFrame.new(c1.p * p) * (c1 - c1.p)
		instance.Parent = parent
		item:Destroy()
	end
end

local function ScaleParts(instances, p, primaryPart)
	local v, v2 = GetPartBounds({ primaryPart } or instances)
	local midpoint = (v + v2) / 2
	local v3 = {}

	for _, item in pairs(instances) do
		if v3[item] then
			continue
		end

		v3[item] = true
		local anchored = item.Anchored
		item.Anchored = true
		local v4 = item.Position - midpoint
		local v5 = item.CFrame - item.Position
		local size = item.Size * p
		item.Size = size

		if item.Size ~= size then
			local fileMesh = GetMesh(item)

			if fileMesh and (fileMesh:IsA("FileMesh") and fileMesh.MeshId == "" or not fileMesh:IsA("FileMesh")) then
				fileMesh.Scale *= size / item.Size
			end
		end

		item.CFrame = CFrame.new(v4 * p + midpoint) * v5
		item.Anchored = anchored
	end
end

local function ScaleMeshes(instances, p)
	for _, fileMesh in pairs(instances) do
		if not (fileMesh:IsA("FileMesh") and fileMesh.MeshId ~= "" and fileMesh.Parent:IsA("BasePart")) then
			continue
		end

		fileMesh.Scale *= p
		fileMesh.Offset *= p
	end
end

local function ScaleBeams(instances, p)
	for _, item in pairs(instances) do
		item.Width0 *= p
		item.Width1 *= p
		item.TextureLength *= p
	end
end

local function ScaleAttachments(instances, p) -- 1 equivalent call inferred from this helper
	for _, item in pairs(instances) do
		item.Position *= p
	end
end

local function ScaleParticleEmitters(instances, p)
	for _, item in pairs(instances) do
		item.Size = GetScaledNumberSequence(item.Size, p)
		item.Speed = NumberRange.new(p * item.Speed.Min, p * item.Speed.Max)
		item.Acceleration *= p
	end
end

local function ScaleSmokes(instances, p) -- 1 equivalent call inferred from this helper
	for _, item in pairs(instances) do
		item.RiseVelocity *= p
		item.Size *= p
	end
end

local function ScaleLights(instances, p) -- 1 equivalent call inferred from this helper
	for _, item in pairs(instances) do
		item.Range *= math.sqrt(p)
	end
end

local function ScaleTextures(instances, p) -- 1 equivalent call inferred from this helper
	for _, item in pairs(instances) do
		item.StudsPerTileU *= p
		item.StudsPerTileV *= p
	end
end

local function ScaleSelectionBoxes(instances, p) -- 1 equivalent call inferred from this helper
	for _, item in pairs(instances) do
		item.LineThickness *= p
	end
end

local function GetAndScaleKeyframeSequences(folder, p)
	for _, keyframeSequence in ipairs(folder:GetDescendants()) do
		if not keyframeSequence:IsA("KeyframeSequence") then
			continue
		end

		for _, folder2 in ipairs(keyframeSequence:GetChildren()) do
			for _, descendant in ipairs(folder2:GetDescendants()) do
				if descendant.ClassName ~= "Pose" then
					continue
				end

				local cframe = descendant.CFrame
				descendant.CFrame = cframe - cframe.p + cframe.p * p
			end
		end
	end
end

local function Resize(folder, p, primaryPart)
	local descendants = folder:GetDescendants()
	table.insert(descendants, folder)
	local instances = {}
	local instances2 = {}
	local instances3 = {}
	local instances4 = {}
	local instances5 = {}
	local instances6 = {}
	local instances7 = {}
	local instances8 = {}
	local instances9 = {}
	local instances10 = {}

	for _, instance in pairs(descendants) do
		if instance:IsA("BasePart") then
			table.insert(instances, instance)
		elseif instance:IsA("JointInstance") then
			table.insert(instances2, instance)
		elseif instance:IsA("DataModelMesh") then
			table.insert(instances3, instance)
		elseif instance:IsA("Beam") then
			table.insert(instances4, instance)
		elseif instance:IsA("Attachment") then
			table.insert(instances5, instance)
		elseif instance:IsA("ParticleEmitter") then
			table.insert(instances6, instance)
		elseif instance:IsA("Smoke") then
			table.insert(instances7, instance)
		elseif instance:IsA("Light") then
			table.insert(instances8, instance)
		elseif instance:IsA("Texture") then
			table.insert(instances9, instance)
		elseif instance:IsA("SelectionBox") then
			table.insert(instances10, instance)
		end
	end

	if not primaryPart then
		if folder:IsA("Model") then
			primaryPart = folder.PrimaryPart or nil
		else
			primaryPart = nil
		end
	end

	ScaleParts(instances, p, primaryPart)
	ScaleJoints(instances2, p)
	ScaleMeshes(instances3, p)
	ScaleBeams(instances4, p)
	ScaleAttachments(instances5, p) -- inferred equivalent call
	ScaleParticleEmitters(instances6, p)
	ScaleSmokes(instances7, p) -- inferred equivalent call
	ScaleLights(instances8, p) -- inferred equivalent call
	ScaleTextures(instances9, p) -- inferred equivalent call
	ScaleSelectionBoxes(instances10, p) -- inferred equivalent call
	GetAndScaleKeyframeSequences(folder, p)
end

local function FormatModel(folder)
	local xSIXxAnimationSaves = folder:FindFirstChild("xSIXxAnimationSaves")

	if xSIXxAnimationSaves then
		xSIXxAnimationSaves:Destroy()
	end

	local primaryPart = folder.PrimaryPart

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		if part == primaryPart then
			part.Anchored = true
		else
			part.Anchored = false
		end

		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = true
	end

	if not folder:FindFirstChild("Animations") then
		local folder2 = Instance.new("Folder")
		folder2.Name = "Animations"
		folder2.Parent = folder
		local animation = Instance.new("Animation")
		animation.Name = "Move"
		animation.Parent = folder2
	end
end

local v = game.Selection:Get()[1]

if not v then
	error("No model selected")
end

Resize(v, 0.65)
FormatModel(v)

local function FormatModelTower(folder)
	local xSIXxAnimationSaves = folder:FindFirstChild("xSIXxAnimationSaves")

	if xSIXxAnimationSaves then
		xSIXxAnimationSaves:Destroy()
	end

	local primaryPart = folder.PrimaryPart

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		if part == primaryPart then
			part.Anchored = true
		else
			part.Anchored = false
		end

		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = true
	end

	if not folder:FindFirstChild("Animations") then
		local folder2 = Instance.new("Folder")
		folder2.Name = "Animations"
		folder2.Parent = folder
		local animation = Instance.new("Animation")
		animation.Name = "Attack"
		animation.Parent = folder2
		local animation2 = Instance.new("Animation")
		animation2.Name = "Idle"
		animation2.Parent = folder2
	end
end

v = game.Selection:Get()[1]

if not v then
	error("No model selected")
end

FormatModelTower(v)

local function AdjustAllSoundVolume(folder)
	for _, sound in pairs(folder:GetDescendants()) do
		if sound:IsA("Sound") then
			sound.Volume *= 0.5
		end
	end
end

v = game.Selection:Get()[1]

if not v then
	error("No model selected")
end

AdjustAllSoundVolume(v)

local function Scale(instance) -- 1 equivalent call inferred from this helper
	instance:ScaleTo(0.4)
end

v = game.Selection:Get()[1]

if not v then
	error("No model selected")
end

Scale(v) -- inferred equivalent call
local parent2 = game.Selection:Get()[1]
local mortar1 = parent2.Mortar1

for _, child in pairs(parent2:GetChildren()) do
	if child.Name ~= "base" then
		continue
	end

	y = mortar1:Clone()
	y:SetPrimaryPartCFrame(child.CFrame)
	y.Parent = parent2
end

local v2 = game.Selection:Get()[1]

for _, child in pairs(v2:GetChildren()) do
	if not child.Name:find("Mortar") then
		continue
	end

	local primaryPart = nil

	for _, child2 in pairs(child:GetChildren()) do
		if child2.Name:find("Mortar") then
			primaryPart = child2
		end
	end

	child.PrimaryPart = primaryPart
end

v = game.Selection:Get()[1]
local v3 = game.Selection:Get()[2]
local v4 = { v.Turret1, v.Turret2, v.Turret3, v.Turret4, v.Turret5 }

local function FastWeld(p, part) -- 2 equivalent calls inferred from this helper
	local motor6D = Instance.new("Motor6D")
	motor6D.Part0 = p
	motor6D.Part1 = part
	motor6D.C0 = p.CFrame:Inverse()
	motor6D.C1 = part.CFrame:Inverse()
	motor6D.Parent = p
	return motor6D
end

local function f(instance)
	for _, model in pairs(instance:GetChildren()) do
		if not (model:IsA("Model") and model.Name:find("Gun")) then
			continue
		end

		local barrel = model:FindFirstChild("Barrel")

		if not barrel then
			continue
		end

		local clone = v3:Clone()
		clone.CFrame = barrel.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -1, 0)
		clone.Parent = model
		clone.Name = "ProjectileOrigin"
		FastWeld(barrel, clone) -- inferred equivalent call
		local Selection = game:GetService("Selection")
		Selection:Add({ clone })
	end
end

for _, v5 in pairs(v4) do
	f(v5)
end

for _, v5 in pairs(game.Selection:Get()) do
	if v5.Name == "Root" then
		v5.C0 += vector.create(0, 0.3, 0)
	end
end

local v5 = game.Selection:Get()

for _ = 1, 10 do
	for _, folder in pairs(v5) do
		for _, emitter in pairs(folder:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter:Emit(emitter.Rate)
			end
		end

		if folder:IsA("ParticleEmitter") then
			folder:Emit(folder.Rate)
		end
	end

	task.wait(0.08)
end

v = workspace:FindFirstChild("Base")
game.Selection:Get()
local v6 = {
	v.Turret1,
	v.Turret2,
	v.Turret3,
	v.Turret4,
	v.Turret5,
	v.Mortar1,
	v.Mortar2,
	v.Mortar3,
	v.Mortar4,
	v.Mortar5,
	v.Mortar6,
	v.Mortar7,
	v.Mortar8
}

local function g(instance)
	for _, model in pairs(instance:GetChildren()) do
		if not (model:IsA("Model") and model.Name:find("Gun")) then
			continue
		end

		local barrel = model:FindFirstChild("Barrel")

		if not barrel then
			continue
		end

		for _, sound in pairs(barrel:GetChildren()) do
			if sound:IsA("Sound") then
				sound:Destroy()
			end
		end
	end
end

for _, v7 in pairs(v6) do
	g(v7)
end

local v7 = game.Selection:Get()

for i = 1, #v7, 2 do
	local v8 = v7[i]
	local v9 = v7[i + 1]
	v9.C0 = v8.C0
	v9.C1 = v8.C1
end

local folder = game.Selection:Get()[1]

for _, sound in pairs(folder:GetDescendants()) do
	if not (sound:IsA("Sound") and sound.SoundId == "rbxassetid://10740059480") then
		continue
	end

	sound.SoundId = "rbxassetid://14016611275"
	sound.Volume = 0.03
end

local v8 = {
	Torso = Color3.fromRGB(40, 40, 40),
	LeftLeg = Color3.fromRGB(40, 40, 40),
	RightLeg = Color3.fromRGB(40, 40, 40),
	LeftArm = Color3.fromRGB(255, 154, 71),
	RightArm = Color3.fromRGB(255, 154, 71),
	Head = Color3.fromRGB(255, 154, 71)
}
local color = Color3.fromRGB(61, 61, 61)
local color2 = Color3.fromRGB(255, 195, 142)

local function RecolorZombie(instance)
	local v9 = {
		Torso = instance:FindFirstChild("Torso"),
		LeftLeg = instance:FindFirstChild("LeftLeg"),
		RightLeg = instance:FindFirstChild("RightLeg"),
		LeftArm = instance:FindFirstChild("LeftArm"),
		RightArm = instance:FindFirstChild("RightArm"),
		Head = instance:FindFirstChild("Head")
	}

	for k, v10 in pairs(v9) do
		v10.Material = Enum.Material.SmoothPlastic
		v10.TextureID = ""
		v10.Color = v8[k]
		local blood = v10:FindFirstChild("Blood")
		local metal = v10:FindFirstChild("Metal")

		if blood then
			blood.Color = color2
		end

		if metal then
			metal.Color = color
		end
	end
end

for _, v9 in pairs(game.Selection:Get()) do
	RecolorZombie(v9)
end

v = game.Selection:Get()
local v9 = v[1]
local part2 = v[2]
local partsByMeshId = {}

for _, part in pairs(v9:GetDescendants()) do
	if part:IsA("MeshPart") then
		partsByMeshId[part.MeshId] = part
	end
end

for _, part in pairs(part2:GetDescendants()) do
	if part:IsA("MeshPart") and partsByMeshId[part.MeshId] then
		partsByMeshId[part.MeshId].Color = part.Color
	end
end

local function weld(p, part)
	local fastWeld = FastWeld(p, part) -- inferred equivalent call
	fastWeld.Name = part.Name
	return fastWeld
end

v = game.Selection:Get()
v9 = v[1]
part2 = v[2]
local v10 = v[3]
v = v9.PrimaryPart
local v11 = v:FindFirstChild(part2.Name)

if v11 then
	v11:Destroy()
end

v11 = Instance.new("Motor6D")
v11.Part0 = v10
v11.Part1 = part2
v11.C0 = v10.CFrame:Inverse()
v11.C1 = part2.CFrame:Inverse()
v11.Parent = v10
v11.Name = part2.Name
part2 = Instance.new("Motor6D")
part2.Part0 = v
part2.Part1 = v10
part2.C0 = v.CFrame:Inverse()
part2.C1 = v10.CFrame:Inverse()
part2.Parent = v
part2.Name = v10.Name
part2 = Instance.new("Folder", v9)
part2.Name = "OscillationData"
v9 = Instance.new("Configuration", part2)
v9.Name = "Rotor"
part2 = Instance.new("StringValue", v9)
part2.Name = "WeldPointer"
part2.Value = v.Name .. ">" .. v10.Name
v = Instance.new("Vector3Value", v9)
v.Name = "C0AnglePerSecond"
v.Value = vector.create(0, 15.707963, 0)
v = Instance.new("Vector3Value", v9)
v.Name = "C1AnglePerSecond"
v.Value = vector.create(0, 0, 0)
v10.Transparency = 1
local v12 = game.Selection:Get()
local v13 = v12[1]
local weld2 = v13.Parent:FindFirstChildOfClass("Weld")

for i = 2, #v12 do
	local v14 = v12[i]
	local clone = v13:Clone()
	clone.Parent = v14
	local weld3 = Instance.new("Weld", v14)
	weld3.C0 = weld2.C0
	weld3.C1 = weld2.C1
	weld3.Part0 = clone
	weld3.Part1 = v14
end

v = Instance.new("Part")
v.CanCollide = false
v.CanTouch = false
v.Anchored = true
v.Size = vector.create(0.8, 0.8, 0.4)
v.TopSurface = Enum.SurfaceType.Smooth
v.BottomSurface = Enum.SurfaceType.Smooth
v.Parent = workspace
local Selection = game:GetService("Selection")
Selection:Set({ v })
local Selection2 = game:GetService("Selection")
local v14 = Selection2:Get()
local v15 = v14[1]

for i = 2, #v14 do
	local v16 = v14[i]
	local parent = v16.Parent
	local clone = v15:Clone()
	clone.CFrame = v16.CFrame
	clone.Size = v16.Size
	clone.Parent = parent
	clone.Name = "Root"
	parent.PrimaryPart = clone
end

local Selection3 = game:GetService("Selection")
local v16 = Selection3:Get()

for i = 2, #v16 do
	v16[i].Parent.PrimaryPart.Transparency = 1
end

for _, sound in game:GetDescendants() do
	if not (sound:IsA("Sound") and sound.SoundId:find("88858815")) then
		continue
	end

	print(sound)
	print(sound.Parent)
	print(sound.Parent.Parent)
end

for _, v17 in pairs(game.Selection:Get()) do
	local root = v17:FindFirstChild("Root")
	local torso = v17:FindFirstChild("Torso")

	if root and torso then
		root.Position = torso.Position
		v17.PrimaryPart = root
	else
		warn("Missing Root or Torso")
	end
end

local v17 = { "Meshes/operator_xmas_2_RL", "Meshes/operator_xmas_RL" }

for _, v18 in pairs(game.Selection:Get()) do
	local child = nil

	for _, childName in pairs(v17) do
		child = v18:FindFirstChild(childName)

		if child then
			break
		end
	end

	if child then
		child.Name = "Right Leg"
	else
		warn("Missing part in " .. v18.Name)
	end
end

for _, v18 in pairs(game.Selection:Get()) do
	v18.PrimaryPart = v18.Root
end

for _, v18 in pairs(game.Selection:Get()) do
	v18.PrimaryPart = v18:FindFirstChildOfClass("MeshPart")
end

local v18 = game.Selection:Get()
local v19 = v18[1]

for i = 2, #v18 do
	v18[i]:PivotTo(v19:GetPivot())
end

local v20 = game.Selection:Get()
local v21 = v20[1]

for i = 2, #v20 do
	v20[i]:PivotTo(v21:GetPivot() + Vector3.new(0, 0, (i - 1) * 2))
end

for _, parent in pairs(game.Selection:Get()) do
	local appearance = parent:FindFirstChild("Appearance")

	if not appearance then
		continue
	end

	local weapon = appearance:FindFirstChild("Weapon")

	if not weapon then
		continue
	end

	local model = Instance.new("Model")
	model.Name = "Minigun"
	model.Parent = parent
	weapon.Parent = model
end

local v22 = game.Selection:Get()

for i = 1, #v22 do
	local v23 = v22[i]
	v23.Name = tostring(i)
	v23.LayoutOrder = i
end

for _, folder2 in pairs(game.Selection:Get()) do
	for _, descendant in pairs(folder2:GetDescendants()) do
		if descendant.Name == "Death" then
			descendant:Destroy()
		end
	end
end

for _, folder2 in pairs(game.Selection:Get()) do
	for _, descendant in pairs(folder2:GetDescendants()) do
		if descendant.Name == "Right Leg" then
			descendant.Name = "Right leg"
		end
	end
end

v = game.Selection:Get()
v9 = v[1]
local v23 = v[2]
print(math.atan2(v23.Position.Z - v9.Position.Z, v23.Position.X - v9.Position.X) * 180 / 3.141592653589793 + 90)

for _, emitter in pairs(game.Selection:Get()) do
	if emitter:IsA("ParticleEmitter") then
		emitter.Rate *= 0.75
	end
end

for _, emitter in pairs(game.Selection:Get()) do
	if not emitter:IsA("ParticleEmitter") then
		continue
	end

	local speed = emitter.Speed
	emitter.Speed = NumberRange.new(0.75 * speed.Min, 0.75 * speed.Max)
end

v = game.Selection:Get()
local v24 = v[1]
v9 = v[2]

local function weld2_2(p, part) -- 11 equivalent calls inferred from this helper
	local weld3 = Instance.new("Weld")
	weld3.Part0 = p
	weld3.Part1 = part
	weld3.C0 = p.CFrame:Inverse()
	weld3.C1 = part.CFrame:Inverse()
	weld3.Parent = p
	weld3.Name = part.Name
	return weld3
end

for _, descendant in pairs(v9:GetDescendants()) do
	if descendant.Name == v24.Name then
		weld2_2(v24, descendant) -- inferred equivalent call
	end
end

local v25 = {
	Torso = "Torso",
	["Right Leg"] = "RightLeg",
	["Left Leg"] = "LeftLeg",
	["Right Arm"] = "RightArm",
	["Left Arm"] = "LeftArm",
	Head = "Head",
	RightLeg = "Right Leg",
	LeftLeg = "Left Leg",
	RightArm = "Right Arm",
	LeftArm = "Left Arm"
}
local v26 = { "Torso", "RightLeg", "LeftLeg", "RightArm", "LeftArm", "Head" }

for _, v27 in pairs(game.Selection:Get()) do
	for _, child in pairs(v27:GetChildren()) do
		local name = v25[child.Name]

		if name then
			child.Name = name
		end
	end
end

local function weld3(p, part)
	return weld2_2(p, part) -- inferred equivalent call
end

for _, v27 in pairs(game.Selection:Get()) do
	local appearance = v27:FindFirstChild("Appearance")

	if appearance then
		for _, childName in pairs(v26) do
			local v28 = v25[childName]
			local v29 = v27:FindFirstChild(childName) or v28 and v27:FindFirstChild(v28)

			if v29 then
				for _, descendant in pairs(appearance:GetDescendants()) do
					if descendant.Name == childName or descendant.Name == v28 then
						weld2_2(v29, descendant) -- inferred equivalent call
					end
				end
			else
				warn("No " .. childName .. " found in " .. v27.Name)
			end
		end
	else
		warn("No Appearance model found in " .. v27.Name)
	end
end

for _, v27 in pairs(game.Selection:Get()) do
	local base = v27:FindFirstChild("Base")
	local root = v27:FindFirstChild("Root")

	if base and root then
		root.Position = Vector3.new(base.Position.X, 0, base.Position.Z)
	else
		warn("Missing Base or Root in " .. v27.Name)
	end
end

for _, part in pairs(workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.MaterialVariant == "Messy Concrete" then
		part.MaterialVariant = "AssemblyLine Messy Concrete"
	end
end

for _, v27 in pairs(game:GetService("MaterialService")) do
	if v27.Name == "Messy Concrete" then
		v27.Name = "AssemblyLine Messy Concrete"
	end
end

local v27 = game.Selection:Get()
local v28 = v27[1]

for i = 2, #v27 do
	local v29 = v27[i]
	local torso = v29:FindFirstChild("Torso")

	if torso then
		local clone = v28:Clone()
		clone.Parent = torso
		v29.Animations.Aim.SoundTrigger.Value = clone
	else
		warn("No Torso found in " .. v29.Name)
	end
end

warn("RESULTS\n")
local count = 0

local function ProcessDescendant(sound) -- 3 equivalent calls inferred from this helper
	if sound:IsA("Sound") and sound.SoundId == "rbxassetid://" .. 16933627465 then
		print(sound:GetFullName(), "\n")
		count += 1
	end
end

for _, descendant in pairs(game.ServerStorage:GetDescendants()) do
	ProcessDescendant(descendant) -- inferred equivalent call
end

for _, descendant in pairs(workspace:GetDescendants()) do
	ProcessDescendant(descendant) -- inferred equivalent call
end

for _, descendant in pairs(game.ReplicatedStorage.TDX_Shared.Common.Resources:GetDescendants()) do
	ProcessDescendant(descendant) -- inferred equivalent call
end

warn("FOUND " .. count .. " RESULTS")

for _, button in pairs(game.Selection:Get()[1]:GetChildren()) do
	if button:IsA("ImageButton") then
		button:FindFirstChild("Selected").Image = button.Image
	end
end

v = game.Players:FindFirstChild("loravocado")

if not v then
	warn("Couldn't find playerloravocado")
end

local Data = require(game.ServerScriptService.Server.Data)
Data.Update(v, "Inventory", function(p)
	p.Towers = {}
	return p
end)

for _, v29 in pairs(game.Selection:Get()) do
	v29.Rate = math.ceil(v29.Rate / 2)
end

for _, emitter in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not (emitter:IsA("ParticleEmitter") and emitter:GetAttribute("EmitDelay") and emitter:GetAttribute("EmitDelay") ~= 0) then
		continue
	end

	print(emitter:GetAttribute("EmitDelay"), "->", emitter:GetFullName())
end

local v29 = game.Selection:Get()

for _, v30 in pairs(v29) do
	local animSaves = v30:FindFirstChild("AnimSaves")

	if animSaves then
		if #animSaves:GetChildren() > 1 then
			warn("Multiple AnimSaves in " .. v30.Name)
		else
			for _, child in pairs(animSaves:GetChildren()) do
				child.Name = v30.Name .. " Move"
			end
		end
	else
		warn("No AnimSaves in " .. v30.Name)
	end
end

local function FastWeld3(p, part)
	return weld2_2(p, part) -- inferred equivalent call
end

for _, v30 in pairs(game.Selection:Get()) do
	local mainBody = v30:FindFirstChild("MainBody")
	local head = v30:FindFirstChild("Head")
	local torso = v30:FindFirstChild("Torso")

	if head and torso then
		local weld4 = Instance.new("Weld")
		weld4.Part0 = mainBody
		weld4.Part1 = head
		weld4.C0 = mainBody.CFrame:Inverse()
		weld4.C1 = head.CFrame:Inverse()
		weld4.Parent = mainBody
		weld4.Name = head.Name
		weld4 = Instance.new("Weld")
		weld4.Part0 = mainBody
		weld4.Part1 = torso
		weld4.C0 = mainBody.CFrame:Inverse()
		weld4.C1 = torso.CFrame:Inverse()
		weld4.Parent = mainBody
		weld4.Name = torso.Name
	else
		warn("Missing Head or Torso in " .. v30.Name)
	end
end

for _, v30 in pairs(game.Selection:Get()) do
	local head = v30.Head
	local torso = v30.Torso
	head.Value = v30.Drummer.Head
	torso.Value = v30.Drummer.Torso
end

local v30 = game.Selection:Get()
local v31 = v30[1]

for i = 2, #v30 do
	local turret = v30[i].Turret
	local clone = v31:Clone()
	clone.Position = turret.Appearance.TurretCenter.Position
	clone.Parent = turret
end

for _, v32 in pairs(game.Selection:Get()) do
	local primaryPart = v32.PrimaryPart
	local turret = v32.Turret
	local objectValue = Instance.new("ObjectValue", turret)
	objectValue.Name = "PivotWeld"
	objectValue.Value = primaryPart.Pivot_Turret
end

local function FastWeld4(p, part)
	return weld2_2(p, part) -- inferred equivalent call
end

for _, v32 in pairs(game.Selection:Get()) do
	local v35 = v32.PrimaryPart
	v35 = v32.Turret
	local pivot_Turret = v35:FindFirstChild("Pivot_Turret")
	local torso = v35.Gunner.Torso
	weld2_2(pivot_Turret, torso) -- inferred equivalent call
	torso = v35.Appearance.AppearanceAnchor
	v35 = Instance.new("Weld")
	v35.Part0 = pivot_Turret
	v35.Part1 = torso
	v35.C0 = pivot_Turret.CFrame:Inverse()
	v35.C1 = torso.CFrame:Inverse()
	v35.Parent = pivot_Turret
	v35.Name = torso.Name
end

for _, v32 in pairs(game.Selection:Get()) do
	v32.Turret.PrimaryPart = v32.Turret.Pivot_Turret
end

for _, folder2 in pairs(game.Selection:Get()) do
	for _, descendant in pairs(folder2:GetDescendants()) do
		if descendant:IsA("Model") and descendant.Name == "AnimSaves" then
			descendant:Destroy()
		elseif descendant:IsA("Folder") and descendant.Name == "xSIXxAnimationSaves" then
			descendant:Destroy()
		end
	end
end

local v32 = game.Selection:Get()
local v35 = v32[1]

for i = 2, #v32 do
	local v36 = v32[i]
	v35:Clone().Parent = v36.Bassist
end

for _, v36 in pairs(game.Selection:Get()) do
	v36.PrimaryPart:Destroy()
end

for _, v36 in pairs(game.Selection:Get()) do
	for _, childName in pairs({ "Weapon", "Weapon.L", "Weapon.R", "Slide" }) do
		local child = v36:FindFirstChild(childName)

		if not child then
			continue
		end

		local child2 = child:FindFirstChild(childName)

		if child2 then
			child2:Destroy()
		end
	end
end

local v36 = game.Selection:Get()

for i = 1, #v36, 2 do
	local v37 = v36[i]
	v36[i + 1].TextureID = v37.TextureID
end

for _, sound in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not (sound:IsA("Sound") and (sound.Name == "CannonWoosh" or sound.Name == "Fire")) then
		continue
	end

	sound.SoundId = "rbxassetid://18329921904"
	sound.Volume = 0.24
	print(sound:GetFullName())
end

for _, v37 in pairs(game.Selection:Get()) do
	v37:Emit(v37.Rate)
end

for _, v37 in pairs(game.Selection:Get()) do
	v37.Name = "LaserRifle>" .. v37.Name
end

for _, v37 in pairs(game.Selection:Get()) do
	v37.Parent = v37.Parent.Parent
end

v = game.Selection:Get()
game.Selection:Set({})
local backgrounds = {}

for _, v37 in pairs(v) do
	table.insert(backgrounds, v37.Background)
end

game.Selection:Set(backgrounds)

for _, v37 in pairs(game.Selection:Get()) do
	local animSaves = v37:FindFirstChild("AnimSaves") or Instance.new("Model", v37)
	animSaves.Name = "AnimSaves"

	for _, keyframeSequence in pairs(v37:GetChildren()) do
		if keyframeSequence:IsA("KeyframeSequence") then
			keyframeSequence.Parent = animSaves
		end
	end

	if v37:FindFirstChildOfClass("AnimationController") then
		v37:FindFirstChildOfClass("AnimationController"):Destroy()
	end
end

for _, v37 in pairs(game.Selection:Get()) do
	if v37:FindFirstChild("AnimSaves") then
		v37:FindFirstChild("AnimSaves"):Destroy()
	end
end

for _, folder2 in pairs(game.Selection:Get()) do
	for _, part in pairs(folder2:GetDescendants()) do
		if part.Name ~= "Gun>Weapon" then
			continue
		end

		part.Name = "Main"

		if not part:IsA("MeshPart") then
			continue
		end

		local model = Instance.new("Model", part.Parent)
		model.Name = "Launcher"
		part.Parent = model
	end
end

for _, v37 in pairs(game.Selection:Get()) do
	for _, child in pairs(v37:GetChildren()) do
		if child.Name == "LeftArm" then
			child.Name = "Left Arm"
		elseif child.Name == "RightArm" then
			child.Name = "Right Arm"
		elseif child.Name == "LeftLeg" then
			child.Name = "Left Leg"
		elseif child.Name == "RightLeg" then
			child.Name = "Right Leg"
		end
	end
end

for _, v37 in pairs(game.Selection:Get()) do
	v37:SetAttribute("HoverHeight", v37.PrimaryPart.Position.Y)
end

local v37 = game.Selection:Get()
local v38 = v37[1]

for i = 2, #v37 do
	local v39 = v37[i]
	local v40 = false

	for _, child in pairs(v39:GetChildren()) do
		if child.Name ~= v38.Name then
			continue
		end

		weld2_2(v38, child) -- inferred equivalent call
		v40 = true
		break
	end

	if not v40 then
		warn("No " .. v38.Name .. " found in " .. v39.Name)
	end
end

local function FastWeld5(p, part)
	return weld2_2(p, part) -- inferred equivalent call
end

for _, parent in pairs(game.Selection:Get()) do
	local v40 = parent.PrimaryPart
	local clone = v40:Clone()
	clone.Size = vector.create(1, 1, 1)
	clone.Name = "TargetSFX"
	clone.Parent = parent
	clone.Anchored = false

	for _, child in pairs(clone:GetChildren()) do
		child:Destroy()
	end

	weld2_2(v40, clone) -- inferred equivalent call
	v40 = Instance.new("StringValue", clone)
	v40.Name = "SoundName"
	v40.Value = "TargetDetected"
end

local v39 = game.Selection:Get()
local v40 = v39[1]

for i = 2, #v39 do
	local v41 = v39[i]
	print(v41.Position - v40.Position)
end

for _, v41 in pairs(game.Selection:Get()) do
	local parent = v41.Parent

	for _, part in pairs(parent:GetChildren()) do
		if part:IsA("MeshPart") and part.TextureID == v41.TextureID then
			part.TextureID = "rbxassetid://128971780314720"
		end
	end

	v41.TextureID = "rbxassetid://128971780314720"
end

for _, emitter in pairs(game.Selection:Get()) do
	if emitter:IsA("ParticleEmitter") then
		emitter.Rate *= 0.5
	end
end

for _, part in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not part:IsA("BasePart") then
		continue
	end

	if part.CanCollide then
		print("CanCollide", part:GetFullName())
		part.CanCollide = false
	end

	if not part.CanTouch then
		continue
	end

	print("CanTouch", part:GetFullName())
	part.CanTouch = false
end

local function FastWeld6(p, part)
	return weld2_2(p, part) -- inferred equivalent call
end

for _, folder2 in pairs(game.Selection:Get()) do
	local primaryPart = folder2.PrimaryPart

	for _, part in pairs(folder2:GetDescendants()) do
		if part:IsA("BasePart") and part ~= primaryPart then
			weld2_2(primaryPart, part) -- inferred equivalent call
		end
	end
end

for _, v41 in pairs(game.Selection:Get()) do
	local stringValue = v41.ProjectileSkinData:FindFirstChildOfClass("StringValue")
	stringValue.Value = string.gsub(stringValue.Value, "AnimatedObjects>", "")
end

for _, v41 in pairs(game.Selection:Get()) do
	local stringValue = v41.ProjectileSkinData:FindFirstChildOfClass("StringValue")
	stringValue.Value = string.gsub(stringValue.Value, "Ghost", "Spooky")
end

for _, v41 in pairs(game.Selection:Get()) do
	v41.Name = string.gsub(v41.Name, "AttachmentHelper_", "")
end

for _, v41 in pairs(game.Selection:Get()) do
	v41.Parent = v41.Parent.RealHead
	v41.Parent.Name = "Head"
end

local v41 = game.Selection:Get()

for i = 1, #v41, 2 do
	local parent = v41[i]
	local v43 = v41[i + 1]

	for _, child in pairs(v43:GetChildren()) do
		child.Parent = parent
	end
end

v = game.Selection:Get()
game.Selection:Set({})
local emitters = {}

for _, folder2 in pairs(v) do
	for _, emitter in pairs(folder2:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") then
			table.insert(emitters, emitter)
		end
	end
end

game.Selection:Set(emitters)

for _, sound in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not sound:IsA("Sound") then
		continue
	end

	print(sound.Name)
	sound:Destroy()
end

for _, v42 in pairs(game.Selection:Get()) do
	local gun = v42.Gun
	local model = Instance.new("Model")
	model.Name = "Minigun"
	model.Parent = gun.Parent
	gun.Parent = model
end

for _, v42 in pairs(game.Selection:Get()) do
	local rate = v42.Rate
	local lifetime = v42.Lifetime
	local speed = v42.Speed
	local rate2 = rate * 2
	NumberRange.new(lifetime.Min / 2, lifetime.Max / 2)
	NumberRange.new(speed.Min * 2, speed.Max * 2)
	v42.Rate = rate2
end

local parents = {}

for _, folder2 in pairs(game.Selection:Get()) do
	for _, emitter in pairs(folder2:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") then
			table.insert(parents, emitter.Parent)
		end
	end
end

local Selection4 = game:GetService("Selection")
Selection4:Set(parents)
local parts = {}

for _, part in game.Selection:Get()[1]:GetDescendants() do
	if part:IsA("BasePart") then
		table.insert(parts, part)
	end
end

local hint = Instance.new("Hint", workspace)
local count2 = #parts
local lastTime = os.clock()

for k, part in parts do
	if part.CanCollide then
		print(part:GetFullName())
	end

	part.CanCollide = false
	part.CanTouch = false
	part.Massless = true
	part.EnableFluidForces = false

	if part:IsA("MeshPart") and part.CollisionFidelity ~= Enum.CollisionFidelity.Box then
		part.CollisionFidelity = Enum.CollisionFidelity.Box
	end

	task.wait()

	if not (os.clock() - lastTime > 1) then
		continue
	end

	hint.Text = k .. " / " .. count2
	lastTime = os.clock()
end

hint:Destroy()
warn(count2 .. " parts done")
local v42 = game.Selection:Get()

for i = 1, 48 do
	local v43 = v42[i]
	v42[i + 48]:PivotTo(v43:GetPivot())
end

for _, v43 in pairs(game.Selection:Get()) do
	v43.CFrame = v43.Parent.CFrame
end

local v43 = game.Selection:Get()
v = v43[1]
local leftArm = v.Torso.LeftArm
local rightArm = v.Torso.RightArm
local body = v.RightArm.Body
local weld4 = v.Minigun.Body:FindFirstChildOfClass("Weld")

local function MoonWeld(meshPart, part, flag: boolean?) -- 5 equivalent calls inferred from this helper
	local motor6D = flag and Instance.new("Motor6D") or Instance.new("Weld")
	motor6D.Part0 = meshPart
	motor6D.Part1 = part
	motor6D.C0 = meshPart.CFrame:ToObjectSpace(part.CFrame)
	motor6D.Name = part.Name
	motor6D.Parent = meshPart
	part.Anchored = false
	return motor6D
end

for i = 2, #v43 do
	local v44 = v43[i]
	local leftArm2 = v44.Torso.LeftArm
	local rightArm2 = v44.Torso.RightArm
	local body2 = v44.RightArm.Body
	local weld5 = v44.Minigun.Body:FindFirstChildOfClass("Weld")
	leftArm2.C0 = leftArm.C0
	rightArm2.C0 = rightArm.C0
	body2.C0 = body.C0
	weld5.C0 = weld4.C0
	local meshPart = v44.Minigun.Body:FindFirstChildOfClass("MeshPart")
	meshPart.Name = "Body2"
	task.wait()
	task.wait()

	for _, child in pairs(meshPart:GetChildren()) do
		if child:IsA("Weld") or child:IsA("Motor6D") then
			child:Destroy()
		end
	end

	local count3 = 0

	for _, part in pairs(meshPart:GetChildren()) do
		if not part:IsA("MeshPart") then
			continue
		end

		count3 += 1
		part.Name = "Barrel" .. count3
		MoonWeld(meshPart, part, true)
	end
end

local function MoonWeld2(primaryPart, part, flag: boolean?)
	return MoonWeld(primaryPart, part, flag) -- inferred equivalent call
end

for _, v44 in pairs(game.Selection:Get()) do
	MoonWeld2(v44.PrimaryPart, v44.FiringVFX:FindFirstChildOfClass("Part"), false)
end

for _, folder2 in pairs(game.Selection:Get()) do
	for _, decal in pairs(folder2:GetDescendants()) do
		if decal:IsA("Decal") and decal.Texture == "rbxassetid://16643721222" then
			decal.Texture = "rbxassetid://74504934621090"
		end
	end
end

for _, v44 in pairs(game.Selection:Get()) do
	v44.Parent = v44.Parent.Parent:FindFirstChild("Gun>Main")
end

v = game.Selection:Get()[1]
local model = Instance.new("Model", v)
model.Name = "Trees"

for _, model2 in pairs(v:GetDescendants()) do
	if model2:IsA("Model") and model2.Name:find("shortpinetree") then
		model2.Parent = model
	end
end

v = game.Selection:Get()[1]
local model2 = Instance.new("Model", v)
model2.Name = "TreesThin"

for _, part in pairs(v:GetDescendants()) do
	if part:IsA("MeshPart") and part.MeshId == "rbxassetid://14868804523" then
		part.Parent = model2
	end
end

local folder2 = game.Selection:Get()[1]

for _, model3 in pairs(folder2:GetDescendants()) do
	if not (model3:IsA("Model") and #model3:GetChildren() == 0) then
		continue
	end

	model3:Destroy()
	print(model3:GetFullName())
end

for _, descendant in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if descendant:GetAttribute("TargetTorsoBounds") then
		print(descendant:GetFullName())
	end
end

local function MoonWeld3(weapon, clone, flag: boolean?)
	return MoonWeld(weapon, clone, flag) -- inferred equivalent call
end

for _, v44 in pairs(game.Selection:Get()) do
	local weapon = v44:FindFirstChild("Weapon")

	if weapon then
		local model3 = Instance.new("Model", v44)
		model3.Name = "Sniper"
		local clone = weapon:Clone()

		for _, child in pairs(clone:GetChildren()) do
			child:Destroy()
		end

		clone.Transparency = 1
		clone.Parent = model3
		MoonWeld3(weapon, clone, false)
	else
		warn("No Weapon in " .. v44.Name)
	end
end

local function MoonWeld4(p, clone, flag: boolean?)
	return MoonWeld(p, clone, flag) -- inferred equivalent call
end

for _, v44 in pairs(game.Selection:Get()) do
	local clone = v44:Clone()
	clone.Name = "Main"
	clone.Transparency = 1
	clone.CanQuery = false
	MoonWeld4(v44, clone, false)
	local model3 = Instance.new("Model", v44.Parent)
	model3.Name = "Gun"
	clone.Parent = model3
end

for _, v44 in pairs(game.Selection:Get()) do
	local root = v44.Root
	root.Position = v44.Torso.Position
	v44.PrimaryPart = root
end

for _, v44 in pairs(game.Selection:Get()) do
	local model3 = v44:FindFirstChildOfClass("Model")
	v44.Name = model3.Name
	model3.Name = "Rig"
end

local function MoonWeld5(rootPart, part, flag: boolean?)
	return MoonWeld(rootPart, part, flag) -- inferred equivalent call
end

for _, v44 in pairs(game.Selection:Get()) do
	local rootPart = v44.RootPart
	v44.PrimaryPart = rootPart
	MoonWeld5(rootPart, v44.Platform, false)
	MoonWeld5(rootPart, v44:FindFirstChildOfClass("Model").PrimaryPart, false)
end

local function MoonWeld6(primaryPart, part, flag: boolean?)
	return MoonWeld(primaryPart, part, flag) -- inferred equivalent call
end

for _, v44 in pairs(game.Selection:Get()) do
	local primaryPart = v44.PrimaryPart

	for _, part in pairs(v44:GetChildren()) do
		if part:IsA("BasePart") and part.Name == "StageCollider" then
			MoonWeld6(primaryPart, part, false)
		end
	end
end

for _, part in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not part:IsA("BasePart") or part.Anchored then
		continue
	end

	print(part:GetFullName())
	part.Anchored = true
end

for _, sound in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if sound:IsA("Sound") and sound.Playing then
		print(sound:GetFullName())
	end
end

for _, folder3 in ipairs(game.Selection:Get()) do
	local count3 = 0

	for _, _ in pairs(folder3:GetDescendants()) do
		count3 += 1
	end

	print(folder3.Name, "total items: " .. count3)
end

local count3 = 0

for _, pose in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not (pose:IsA("Pose") and pose.CFrame.Position.Magnitude > 500) then
		continue
	end

	pose.CFrame = CFrame.new(pose.CFrame.Position.Unit * 499) * pose.CFrame.Rotation
	count3 += 1
end

print("Total:", count3)

for _, child in pairs(game.Selection:Get()[1]:GetChildren()) do
	for _, folder3 in pairs(child:GetChildren()) do
		if not folder3:IsA("Folder") then
			continue
		end

		for _, child2 in pairs(folder3:GetChildren()) do
			local name = tonumber(child2.Name)

			if name then
				child2.Name = tostring(name + 100)
			end
		end
	end
end

for _, v44 in pairs(game.Selection:Get()) do
	for _, folder3 in pairs(v44:GetChildren()) do
		if not folder3:IsA("Folder") then
			continue
		end

		for _, child in pairs(folder3:GetChildren()) do
			local name = tonumber(child.Name)

			if name then
				child.Name = tostring(name + 100)
			end
		end
	end
end

for _, v44 in pairs(game.Selection:Get()) do
	local torso = v44:FindFirstChild("Torso")
		or v44:FindFirstChild("Torso ")
		or v44:FindFirstChild("torso")
		or v44:FindFirstChild("Upper Torso")
		or v44:FindFirstChild("UpperTorso")
		or v44:FindFirstChild("torso_suit")
	local head = v44:FindFirstChild("Head")
		or v44:FindFirstChild("head")
		or v44:FindFirstChild("Head1")
		or v44:FindFirstChild("hood_suit")

	if torso and torso:IsA("BasePart") then
		torso.PivotOffset = CFrame.new()
	else
		warn("No Torso in " .. v44.Name)
	end

	if head and head:IsA("BasePart") then
		head.PivotOffset = CFrame.new()
	else
		warn("No Head in " .. v44.Name)
	end
end

v = game.Selection:Get()[1]
local name = tonumber(v.Name)
v.Name = "Processed" .. v.Name
local parent = v.Parent
local values = v.Values

for _, child in pairs(values:GetChildren()) do
	local v44 = name + tonumber(child.Name)

	if parent:FindFirstChild(v44) then
		warn("Overwriting existing value: " .. child.Name)
		parent:FindFirstChild(v44):Destroy()
	end

	child.Name = tostring(v44)
	child.Parent = parent
end

local parent3 = game.Selection:Get()[1]

for _, child in pairs(parent3:GetChildren()) do
	local name2 = tonumber(child.Name)
	local _0 = name2 and child.Values:FindFirstChild("0")

	if _0 then
		_0.Name = tostring(name2)
		_0.Parent = parent3
	end

	child:Destroy()
end

local v45 = game.Selection:Get()[1]
local _0 = v45:FindFirstChild("0")
local name2

repeat
	name2 = tonumber(_0.Name)
	_0 = v45:FindFirstChild(name2 + 1)
until not _0

print("Final:", name2)
local total = 0

for _, descendant in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if descendant.ClassName == "ParticleEmitter" then
		total += descendant.Rate * descendant.Lifetime.Max
	end
end

print("Worst-case particle count:", total)

for _, v46 in pairs(game.Selection:Get()) do
	for _, child in pairs(v46:GetChildren()) do
		child.Name = child.Name:gsub("%s", "")
	end
end

for _, v46 in pairs(game.Selection:Get()) do
	v46.Name = v46.Parent.Parent.Name .. " Move"
end

local v46 = game.Selection:Get()[1]

for i = 2, #game.Selection:Get() do
	game.Selection:Get()[i]:SetAttribute("AttachOffsetFromRoot", v46.C0)
end

local function MoonWeld7(part, p, flag: boolean?)
	local motor6D = flag and Instance.new("Motor6D") or Instance.new("Weld")
	motor6D.Part0 = part
	motor6D.Part1 = p
	motor6D.C0 = part.CFrame:ToObjectSpace(p.CFrame)
	motor6D.Name = "WeldStart"
	motor6D.Parent = p
	p.Anchored = false
	return motor6D
end

local part3 = game.Selection:Get()[1]

for i = 2, #game.Selection:Get() do
	MoonWeld7(part3, game.Selection:Get()[i], false)
end

for _, v48 in pairs(game.Selection:Get()) do
	local zones = v48:FindFirstChild("Zones")
	local path = zones and zones:WaitForChild("Path")

	if path then
		for _, part in pairs(path:GetChildren()) do
			if not part:IsA("BasePart") then
				continue
			end

			if part.CanCollide then
				print("CanCollide", part:GetFullName())
			end

			if part.Transparency < 1 then
				print("Transparency", part:GetFullName())
			end

			if not part.Anchored then
				print("Not Anchored", part:GetFullName())
			end
		end
	else
		warn("No Path folder in " .. v48.Name)
	end
end

for _, part in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not (part:IsA("BasePart") and part.MaterialVariant == "Western Cliff") then
		continue
	end

	part.Material = Enum.Material.Basalt
	part.MaterialVariant = ""
	print("Western Cliff", part:GetFullName())
end

for _, part in pairs(game.Selection:Get()[1]:GetDescendants()) do
	if not part:IsA("UnionOperation") then
		continue
	end

	part.CollisionGroup = "x"
	part.CollisionGroup = "Default"
end

for _, child in pairs(game.Selection:Get()[1]:GetChildren()) do
	for _, child2 in pairs(child:GetChildren()) do
		if child2.Name ~= "Animations" then
			child2:Destroy()
		end
	end
end

local scale = game.Selection:Get()[1]:GetScale()
local folder3 = game.Selection:Get()[2]

for _, cframeValue in pairs(folder3:GetDescendants()) do
	if not cframeValue:IsA("CFrameValue") then
		continue
	end

	local value = cframeValue.Value
	cframeValue.Value = value - value.Position + value.Position * scale
end