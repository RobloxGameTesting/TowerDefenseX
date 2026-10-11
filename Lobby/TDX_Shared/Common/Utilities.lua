local Utilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Lighting")
local ReflectionService = game:GetService("ReflectionService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local BoundingBox = require(common:WaitForChild("BoundingBox"))
local TableUtilities = require(common:WaitForChild("TableUtilities"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v = {}
local v2 = {}

local function ClassHasEnabledProperty(p: string)
	local v3 = v[p]

	if v3 ~= nil then
		return v3
	end

	local v4 = false

	for _, v5 in ReflectionService:GetPropertiesOfClass(p) do
		if v5.Name ~= "Enabled" then
			continue
		end

		v4 = true
		break
	end

	v[p] = v4
	return v4
end

local function ClassHasClearMethod(p: string)
	local v3 = v2[p]

	if v3 ~= nil then
		return v3
	end

	local v4 = false

	for _, v5 in ReflectionService:GetMethodsOfClass(p) do
		if v5.Name ~= "Clear" then
			continue
		end

		v4 = true
		break
	end

	v2[p] = v4
	return v4
end

function Utilities.FormatNumberWithCommas(p: number)
	return tostring((math.floor(p))):reverse():gsub("(%d%d%d)", "%1,"):gsub(",(%-?)$", "%1"):reverse()
end

function Utilities.ConvertToTimeStringFull(p: number, value: string?)
	local v3 = math.floor(p % 86400 / 3600)
	local v4 = math.floor(p % 3600 / 60)
	local v5 = math.floor(p % 60)
	return string.format(value or "%02d:%02d:%02d", v3, v4, v5)
end

function Utilities.ConvertToTimeString(p: number)
	local v3 = math.floor(p / 60)
	local v4 = math.floor(p - v3 * 60)
	return string.format("%02d:%02d", v3, v4)
end

function Utilities.FormatNumberStat(p: number, p2: number?, flag: boolean?)
	if flag then
		return (tostring((math.round(p * 100))))
	end

	if p2 then
		return (tostring(string.format("%1.0" .. tostring(p2) .. "f", p)))
	end

	return (tostring(string.format("%1.03f", p)))
end

function Utilities.SplitBySpace(value: string)
	local result = {}

	for k in value:gmatch("%w+") do
		table.insert(result, k)
	end

	return result
end

function Utilities.SplitByComma(p: string)
	local result = {}

	for k in p.gmatch(p, "([^,]+)") do
		table.insert(result, k)
	end

	return result
end

function Utilities.SubInString(value: string, p: string)
	return string.gsub(value, "($$)", p)
end

function Utilities.StringStartsWith(value: string, list: string)
	return value:sub(1, #list) == list
end

function Utilities.StringEndsWith(value: string, list: string)
	return list == "" or value:sub(-#list) == list
end

function Utilities.FlipTable(items)
	local result = {}

	for k, item in pairs(items) do
		result[item] = k
	end

	return result
end

function Utilities.Keys(items)
	local result = {}

	for k, _ in pairs(items) do
		table.insert(result, k)
	end

	return result
end

function Utilities.Values(items)
	local result = {}

	for _, item in pairs(items) do
		table.insert(result, item)
	end

	return result
end

Utilities.DeepCopyTable = TableUtilities.DeepCopy

function Utilities.GetListMembers(items, p)
	local result = {}

	for _, item in pairs(items) do
		table.insert(result, item[p])
	end

	return result
end

function Utilities.GetKeyCount(items)
	local count = 0

	for _, _ in pairs(items) do
		count += 1
	end

	return count
end

function Utilities.GetAllBasepartDescendants(folder)
	local parts = {}

	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			table.insert(parts, part)
		end
	end

	return parts
end

function Utilities.Weld(p, part)
	local weld = Instance.new("Weld")
	weld.Part0 = p
	weld.Part1 = part
	weld.C0 = p.CFrame:ToObjectSpace(part.CFrame)
	weld.Name = part.Name
	weld.Parent = p
	return weld
end

function Utilities.Motor6D(p, part)
	local motor6D = Instance.new("Motor6D")
	motor6D.Part0 = p
	motor6D.Part1 = part
	motor6D.C0 = p.CFrame:ToObjectSpace(part.CFrame)
	motor6D.Name = part.Name
	motor6D.Parent = p
	return motor6D
end

function Utilities.WeldToBone(attachment, parent, items)
	local miscResource = ResourceManager.GetMiscResource("BoneRigAttachmentHelper")
	miscResource.Name = "AttachmentHelper" .. attachment.Name
	miscResource.Parent = parent
	local attachment2 = Instance.new("Attachment")
	attachment2.Parent = miscResource
	local rigidConstraint = Instance.new("RigidConstraint")
	rigidConstraint.Parent = miscResource
	rigidConstraint.Attachment0 = attachment
	rigidConstraint.Attachment1 = attachment2

	for _, item in pairs(items) do
		Utilities.Weld(miscResource, item)
	end

	return miscResource
end

function Utilities.PartAtPosition(position: Vector3, color, duration, size: Vector3?, p: string?, name: string?)
	local miscResource = ResourceManager.GetMiscResource("DebugPart")
	miscResource.Position = position

	if size then
		miscResource.Size = size
	end

	if name then
		miscResource.Name = name
	end

	if color then
		if typeof(color) == "string" then
			miscResource.BrickColor = BrickColor.new(color)
		else
			miscResource.Color = color
		end
	end

	miscResource.Parent = raycastIgnore

	if duration then
		if typeof(duration) == "number" then
			task.delay(duration, function()
				miscResource:Destroy()
			end)
		end
	else
		task.delay(0.38, function()
			miscResource:Destroy()
		end)
	end

	if p then
		Utilities.TextDisplayOnPart(miscResource, p)
	end

	return miscResource
end

function Utilities.PartAtXYZ(p, p2, p3, p4, p5)
	return Utilities.PartAtPosition(Vector3.new(p, p2, p3), p4, p5)
end

function Utilities.PartAtXZ(_, p, p2, p3, p4)
	return Utilities.PartAtPosition(Vector3.new(p, 1.5, p2), p3, p4)
end

function Utilities.RenderPartBetweenPoints(vector: Vector3, vector2: Vector3, color, value: number?, duration, name: string?)
	local miscResource = ResourceManager.GetMiscResource("Beam")

	if color then
		if typeof(color) == "string" then
			miscResource.BrickColor = BrickColor.new(color)
		else
			miscResource.Color = color
		end
	end

	local magnitude = (vector - vector2).Magnitude
	miscResource.Size = Vector3.new(value or 0.2, value or 0.2, magnitude)
	miscResource.CFrame = CFrame.new(vector, vector2) * CFrame.new(0, 0, -magnitude / 2)
	miscResource.Parent = raycastIgnore

	if name then
		miscResource.Name = name
	end

	if not duration then
		task.delay(0.38, function()
			miscResource:Destroy()
		end)
		return miscResource
	end

	if typeof(duration) == "number" then
		task.delay(duration, function()
			miscResource:Destroy()
		end)
	end

	return miscResource
end

function Utilities.RenderRay(p, p2, p3, p4, color, duration)
	local miscResource = ResourceManager.GetMiscResource("Beam")

	if color then
		if typeof(color) == "string" then
			miscResource.BrickColor = BrickColor.new(color)
		else
			miscResource.Color = color
		end
	end

	local v3 = p3 - p
	local v4 = p4 - p2
	local v5 = math.sqrt(v3 * v3 + v4 * v4)
	miscResource.Size = Vector3.new(0.2, 0.2, v5)
	miscResource.CFrame = CFrame.new(Vector3.new(p, 1.5, p2), (Vector3.new(p3, 1.5, p4))) * CFrame.new(0, 0, -v5 / 2)
	miscResource.Parent = raycastIgnore

	if not duration then
		task.delay(0.38, function()
			miscResource:Destroy()
		end)
	elseif typeof(duration) == "number" then
		task.delay(duration, function()
			miscResource:Destroy()
		end)
	end
end

function Utilities.TextDisplayOnPart(p, value: string)
	local miscResource = ResourceManager.GetMiscResource("TextDisplay")
	miscResource.Adornee = p
	miscResource.Parent = p
	miscResource.AlwaysOnTop = true
	local textLabel = miscResource:FindFirstChild("Frame"):FindFirstChild("TextLabel")
	textLabel.Text = value or ""
	textLabel.Visible = true
	return miscResource, textLabel
end

function Utilities.AlwaysOnTopGuiOnPart(parent, backgroundColor)
	local miscResource = ResourceManager.GetMiscResource("AlwaysOnTopGUI")
	miscResource.Parent = parent

	if backgroundColor then
		local frame = miscResource:FindFirstChild("Frame")
		frame.BackgroundColor3 = backgroundColor
	end

	return miscResource
end

function Utilities.AngleBetweenPoints(vector: Vector3, vector2: Vector3, vector3: Vector3)
	local vector4 = vector2 - vector
	local v3 = vector3 - vector2
	local v4 = vector4:Dot(v3) / (vector4.Magnitude * v3.Magnitude)

	if v4 <= 1 and v4 >= -1 then
		return (math.acos(v4))
	end

	return 0
end

function Utilities.AngleBetweenVectors(vector: Vector3, vector2: Vector3)
	local v3 = vector:Dot(vector2) / (vector.Magnitude * vector2.Magnitude)

	if v3 <= 1 and v3 >= -1 then
		return (math.acos(v3))
	end

	return 0
end

function Utilities.VisualizeRaycast(vector: Vector3, vector2: Vector3, p, p2: number?, value)
	local raycastResult = workspace:Raycast(vector, vector2, p)

	if not raycastResult then
		return
	end

	Utilities.RenderPartBetweenPoints(vector, raycastResult.Position, value or "Bright yellow", nil, p2)
end

function Utilities.NewRandomColor()
	return Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
end

function Utilities.GetTimeOffset(p: number)
	return workspace:GetServerTimeNow() - p
end

function Utilities.Lerp(p: number, p2: number, p3: number)
	return p * (1 - p3) + p2 * p3
end

function Utilities.ApproxEqual(p: number, p2: number, value: number?)
	return math.abs(p - p2) < (value or 0.01)
end

function Utilities.GetBoundsXZ(p)
	local boundingBox, v3 = BoundingBox.GetBoundingBox({ p })
	return
		boundingBox.Position.X - v3.X / 2,
		boundingBox.Position.X + v3.X / 2,
		boundingBox.Position.Z - v3.Z / 2,
		boundingBox.Position.Z + v3.Z / 2
end

function Utilities.TryReadChildValue(instance, childName: string, p)
	local child = instance:FindFirstChild(childName)

	if child then
		return child.Value
	end

	return p
end

function Utilities.GetRandomAngle()
	return
		0.017453292519943295 * math.random(1, 360),
		0.017453292519943295 * math.random(1, 360),
		0.017453292519943295 * math.random(1, 360)
end

function Utilities.GetRandomSign()
	if math.random() >= 0.5 then
		return 1
	end

	return -1
end

function Utilities.MakeSplinePoints(list, p: number)
	if #list < 3 then
		warn("Smoothing requires at least 3 points")
		return list
	end

	local v3 = #list - 1
	local vectors = {}

	for i = 1, v3 do
		local v4, v5, v6, v7

		if i == 1 then
			v4 = list[1]
			v5 = list[1]
			v6 = list[1 + 1]
			v7 = list[1 + 2]
		elseif i == v3 then
			v4 = list[#list - 2]
			v5 = list[#list - 1]
			v6 = list[#list]
			v7 = list[#list]
		else
			v4 = list[i - 1]
			v5 = list[i]
			v6 = list[i + 1]
			v7 = list[i + 2]
		end

		for j = 0, 1, 1 / p do
			local v8 = 0.5 * (2 * v5.X + (v6.X - v4.X) * j + (2 * v4.X - 5 * v5.X + 4 * v6.X - v7.X) * j * j + (3 * v5.X - v4.X - 3 * v6.X + v7.X) * j * j * j)
			local v9 = 0.5 * (2 * v5.Y + (v6.Y - v4.Y) * j + (2 * v4.Y - 5 * v5.Y + 4 * v6.Y - v7.Y) * j * j + (3 * v5.Y - v4.Y - 3 * v6.Y + v7.Y) * j * j * j)
			local v10 = 0.5 * (2 * v5.Z + (v6.Z - v4.Z) * j + (2 * v4.Z - 5 * v5.Z + 4 * v6.Z - v7.Z) * j * j + (3 * v5.Z - v4.Z - 3 * v6.Z + v7.Z) * j * j * j)

			if not (#vectors > 0) or vectors[#vectors].X ~= v8 or vectors[#vectors].Z ~= v10 then
				table.insert(vectors, (Vector3.new(v8, v9, v10)))
			end
		end
	end

	return vectors
end

function Utilities.ScaleNumberSequence(sequence, p: number)
	local numberSequenceKeypoints = {}

	for _, keypoint in ipairs(sequence.Keypoints) do
		table.insert(numberSequenceKeypoints, NumberSequenceKeypoint.new(keypoint.Time, p * keypoint.Value))
	end

	return NumberSequence.new(numberSequenceKeypoints)
end

function Utilities:ScaleParticleEmitter(p: number)
	self.Size = Utilities.ScaleNumberSequence(self.Size, p)
	self.Speed = NumberRange.new(p * self.Speed.Min, p * self.Speed.Max)
	self.Acceleration *= p
end

function Utilities.GetRandomPointAlongCircle(vector: Vector3, p: number)
	local v3 = math.random() * 2 * 3.141592653589793
	local v4 = math.cos(v3) * p
	local v5 = math.sin(v3) * p
	return Vector3.new(vector.X + v4, vector.Y, vector.Z + v5), v3
end

local v3 = {}

function Utilities.WarnEmptyAnimationOnce(p, instance)
	local v4 = p.Name .. "/" .. instance.Name

	if not v3[v4] then
		v3[v4] = true
		warn(`Skipping animation with an empty AnimationId: {instance:GetFullName()}`)
	end
end

function Utilities.MakeAnimationTrack(instance)
	local animations = instance:FindFirstChild("Animations")

	if not animations then
		return
	end

	local animation = animations:FindFirstChildOfClass("Animation")

	if not animation then
		return
	end

	if animation.AnimationId == "" then
		Utilities.WarnEmptyAnimationOnce(instance, animation)
	else
		local animationController = Instance.new("AnimationController", instance)
		return (Instance.new("Animator", animationController):LoadAnimation(animation))
	end
end

function Utilities.ApplyVariance(p: number, p2: number?)
	if p2 then
		return p + math.random(-1000 * p2, 1000 * p2) / 1000
	end

	return p
end

function Utilities.RandomNumberNegativeToPositiveOne()
	return (math.round((math.random())) * 2 - 1) * math.random()
end

function Utilities:ShuffleTableInPlace()
	for i = #self, 1, -1 do
		local v4 = math.random(i)
		local v5 = self[i]
		self[i] = self[v4]
		self[v4] = v5
	end
end

function Utilities.SelectRandomFromTable(list, p: number, flag: boolean?)
	if #list < p then
		warn("Count exceeds table length")
		return {}
	end

	if not flag then
		Utilities.ShuffleTableInPlace(list)
	end

	local result = {}

	for i = 1, p do
		result[i] = list[i]
	end

	return result
end

function Utilities.GetSpinResult(items)
	local total = 0

	for _, item in pairs(items) do
		if math.round(item) == item then
			total += item
		else
			warn("Chance values must be integers")
		end
	end

	local v4 = math.random(1, total)
	local total2 = 0

	for k, item in pairs(items) do
		total2 += item

		if v4 <= total2 then
			return k
		end
	end
end

function Utilities.GetRandomPointInPart(instance)
	local boundingBox, v4 = BoundingBox.GetBoundingBox({ instance })
	local cframe = instance.CFrame
	local halfSize = instance.Size / 2

	for _ = 1, 5 do
		local vector = Vector3.new(
			boundingBox.Position.X + math.random(-v4.X * 50, v4.X * 50) / 100,
			boundingBox.Position.Y + math.random(-v4.Y * 50, v4.Y * 50) / 100,
			boundingBox.Position.Z + math.random(-v4.Z * 50, v4.Z * 50) / 100
		)
		local pointToObjectSpace = cframe:PointToObjectSpace(vector)

		if
			math.abs(pointToObjectSpace.X) <= halfSize.X
			and math.abs(pointToObjectSpace.Y) <= halfSize.Y
			and math.abs(pointToObjectSpace.Z) <= halfSize.Z
		then
			return vector
		end
	end

	return instance.Position
end

function Utilities.TryGetInstanceFromPath(child, value: string, flag: boolean?)
	if flag then
		warn("PathString: " .. value)
	end

	for _, childName in pairs(string.split(value, ">")) do
		child = child:FindFirstChild(childName)

		if flag then
			warn("CurrentInstance: " .. tostring(child))
		end

		if not child then
			return
		end
	end

	return child
end

function Utilities.GetPathFromParent(parent, p)
	local name = parent.Name
	local v4 = 10

	while parent.Parent ~= p and v4 > 0 do
		parent = parent.Parent
		name = parent.Name .. ">" .. name
		v4 -= 1
	end

	return name
end

function Utilities.GetRandomNumberInNumberRange(range: NumberRange)
	return math.random(range.Min * 1000, range.Max * 1000) / 1000
end

function Utilities.LerpColorSequence(sequence, sequence2, p: number)
	local value = sequence.Keypoints[1].Value
	local value2 = sequence2.Keypoints[1].Value
	return ColorSequence.new(value:Lerp(value2, p))
end

function Utilities.LerpNumberSeqeunce(sequence, sequence2, p: number)
	local value = sequence.Keypoints[1].Value
	local value2 = sequence2.Keypoints[1].Value
	return NumberSequence.new(value + (value2 - value) * p)
end

function Utilities.LerpNumberRange(range: NumberRange, range2: NumberRange, p: number)
	local min = range.Min
	local v4 = min + (range2.Min - min) * p
	return NumberRange.new(v4, v4)
end

function Utilities:ShowModel()
	if self:IsA("BasePart") then
		if self.Transparency == 1 then
			self.Transparency = self:GetAttribute("OriginalTransparency") or 1
			self:SetAttribute("OriginalTransparency", nil)
		end
	elseif self:IsA("FaceInstance") then
		local originalTransparency = self:GetAttribute("OriginalTransparency")

		if originalTransparency ~= nil then
			self.Transparency = originalTransparency
			self:SetAttribute("OriginalTransparency", nil)
		end
	end

	for _, descendant in pairs(self:GetDescendants()) do
		if descendant:IsA("BasePart") then
			if descendant.Transparency == 1 then
				descendant.Transparency = descendant:GetAttribute("OriginalTransparency") or 1
				descendant:SetAttribute("OriginalTransparency", nil)
			end
		elseif descendant:IsA("FaceInstance") then
			local originalTransparency = descendant:GetAttribute("OriginalTransparency")

			if originalTransparency ~= nil then
				descendant.Transparency = originalTransparency
				descendant:SetAttribute("OriginalTransparency", nil)
			end
		end
	end

	for _, descendant in pairs(self:GetDescendants()) do
		if descendant:IsA("Sound") then
			local originalPlaying = descendant:GetAttribute("OriginalPlaying")

			if originalPlaying ~= nil then
				if originalPlaying then
					descendant:Play()
				end

				descendant:SetAttribute("OriginalPlaying", nil)
			end
		elseif not descendant:IsA("BasePart") then
			local originalEnabled = descendant:GetAttribute("OriginalEnabled")

			if originalEnabled ~= nil then
				descendant.Enabled = originalEnabled
				descendant:SetAttribute("OriginalEnabled", nil)
			end
		end
	end
end

function Utilities:HideModel()
	if self:IsA("BasePart") then
		if not self:GetAttribute("OriginalTransparency") then
			self:SetAttribute("OriginalTransparency", self.Transparency)
		end

		self.Transparency = 1
	elseif self:IsA("FaceInstance") then
		if not self:GetAttribute("OriginalTransparency") then
			self:SetAttribute("OriginalTransparency", self.Transparency)
		end

		self.Transparency = 1
	end

	for _, descendant in pairs(self:GetDescendants()) do
		if descendant:IsA("BasePart") then
			if not descendant:GetAttribute("OriginalTransparency") then
				descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
			end

			descendant.Transparency = 1
		elseif descendant:IsA("FaceInstance") then
			if not descendant:GetAttribute("OriginalTransparency") then
				descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
			end

			descendant.Transparency = 1
		end
	end

	for _, descendant in pairs(self:GetDescendants()) do
		if descendant:IsA("Sound") then
			if not descendant:GetAttribute("OriginalPlaying") then
				descendant:SetAttribute("OriginalPlaying", descendant.Playing)
			end

			descendant:Stop()
		elseif not (descendant:IsA("BasePart") or descendant:IsA("JointInstance")) then
			local className = descendant.ClassName
			local v4 = v[className]

			if v4 == nil then
				v4 = false

				for _, v5 in ReflectionService:GetPropertiesOfClass(className) do
					if v5.Name ~= "Enabled" then
						continue
					end

					v4 = true
					break
				end

				v[className] = v4
			end

			if v4 then
				if not descendant:GetAttribute("OriginalEnabled") then
					descendant:SetAttribute("OriginalEnabled", descendant.Enabled)
				end

				descendant.Enabled = false
				local className2 = descendant.ClassName
				local v5 = v2[className2]

				if v5 == nil then
					v5 = false

					for _, v6 in ReflectionService:GetMethodsOfClass(className2) do
						if v6.Name ~= "Clear" then
							continue
						end

						v5 = true
						break
					end

					v2[className2] = v5
				end

				if v5 then
					descendant:Clear()
				end
			end
		end
	end
end

function Utilities.SetModelCollisionGroup(folder, collisionGroup: string)
	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			part.CollisionGroup = collisionGroup
		end
	end
end

function Utilities.GetAttributeWithWarning(instance, attributeName: string)
	local attribute = instance:GetAttribute(attributeName)

	if attribute == nil then
		warn("Instance " .. instance:GetFullName() .. " is missing attribute " .. attributeName)
	end

	return attribute
end

function Utilities.FindFirstChildWithWarning(instance, childName: string)
	local child = instance:FindFirstChild(childName)

	if not child then
		warn("Instance " .. instance:GetFullName() .. " is missing child " .. childName)
	end

	return child
end

return Utilities