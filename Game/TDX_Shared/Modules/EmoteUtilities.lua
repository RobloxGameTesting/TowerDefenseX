local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("EmoteTypes"))
local miscResource = ResourceManager.GetMiscResource("EmoteModels", true)

local function GetBodyExtents(clone, humanoidRootPart)
	local v = 0
	local v2 = 0

	for _, part in clone:GetChildren() do
		if not (part:IsA("BasePart") and part.Transparency < 1) then
			continue
		end

		local y = humanoidRootPart.CFrame:PointToObjectSpace(part.Position).Y
		v = math.min(v, y - part.Size.Y / 2)
		v2 = math.max(v2, y + part.Size.Y / 2)
	end

	return v, v2
end

local EmoteUtilities = {}

for _, folder in miscResource:GetChildren() do
	for _, sound in folder:GetDescendants() do
		if not sound:IsA("Sound") or sound:GetAttribute("__GroupName") then
			continue
		end

		sound:SetAttribute("__GroupName", "Emotes")
		sound:AddTag("SoundFix")
	end
end

function EmoteUtilities.AttachEmoteModels(parent, items)
	for _, childName in items do
		local child = miscResource:FindFirstChild(childName)

		if not child then
			continue
		end

		local clone = child:Clone()
		clone:SetAttribute("EmoteGear", true)
		local motor = clone:FindFirstChild("Motor")

		if motor then
			local bodyPart = motor:GetAttribute("BodyPart")
			local humanoidRootPart

			if bodyPart ~= nil then
				humanoidRootPart = parent:FindFirstChild(bodyPart)
			end

			if humanoidRootPart == nil then
				humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
			end

			motor.Part0 = humanoidRootPart
			clone.Parent = parent
		else
			for _, child2 in clone:GetChildren() do
				if not child2:GetAttribute("Motor") then
					continue
				end

				local bodyPart = child2:GetAttribute("BodyPart")
				local part

				if bodyPart == nil then
					part = parent:FindFirstChild("HumanoidRootPart")
				else
					part = parent:FindFirstChild(bodyPart)
				end

				child2.Part0 = part
			end

			clone.Parent = parent
		end
	end
end

function EmoteUtilities.CloneBaseCharacter()
	local localPlayer = Players.LocalPlayer
	localPlayer.Character.Archivable = true
	local clone = localPlayer.Character:Clone()
	localPlayer.Character.Archivable = false

	for _, sound in clone:GetDescendants() do
		if sound:IsA("Sound") then
			sound:Destroy()
		end
	end

	return clone
end

function EmoteUtilities:SetupViewport(instance, data)
	local worldModel = self:FindFirstChildWhichIsA("WorldModel")
	worldModel:ClearAllChildren()
	local clone = instance:Clone()
	local emoteGear = clone:FindFirstChild("EmoteGear")

	if emoteGear then
		emoteGear:Destroy()
	end

	local humanoidRootPart = clone:FindFirstChild("HumanoidRootPart")
	humanoidRootPart.Anchored = true
	local v, v2 = GetBodyExtents(clone, humanoidRootPart)
	local cframe = clone:GetPivot():ToObjectSpace(humanoidRootPart.CFrame)
	clone:PivotTo(CFrame.new(0, -(v + v2) / 2, 0) * cframe:Inverse())
	local modelNames = data.ModelNames

	if modelNames then
		EmoteUtilities.AttachEmoteModels(clone, modelNames)
	end

	local v3 = not data.ViewportOffset and createVector(0, 0, 0) or data.ViewportOffset
	local v4 = math.max(350, ((v2 - v) / 2 + 0.3) / 0.00872686779075879)
	local camera = Instance.new("Camera")
	camera.FieldOfView = 1
	camera.CFrame = CFrame.new(Vector3.new(0, 0, -v4), createVector(0, 0, 0)) + v3
	camera.Parent = worldModel
	self.CurrentCamera = camera
	clone.Parent = worldModel
	task.spawn(function()
		repeat
			task.wait()
		until clone:IsDescendantOf(game)

		local humanoid = clone:WaitForChild("Humanoid")

		if humanoid then
			local track = (humanoid:FindFirstChildWhichIsA("Animator") or Instance.new("Animator", humanoid)):LoadAnimation(data.ViewportAnimation or data.Animations[math.random(1, #data.Animations)])
			track.Looped = true
			track:Play()
		end
	end)
end

function EmoteUtilities.RemoveEmoteSound(instance)
	local primaryPart = instance.PrimaryPart

	if not primaryPart then
		return
	end

	for _, child in primaryPart:GetChildren() do
		if child.Name ~= "EmoteSound" then
			continue
		end

		child:Stop()
		child:Destroy()
	end
end

function EmoteUtilities.RemoveEmoteGear(instance)
	for _, child in instance:GetChildren() do
		if child:GetAttribute("EmoteGear") or child.Name == "EmotePartner" then
			child:Destroy()
		end
	end
end

function EmoteUtilities:LeaveBehindEmoteModel(duration: number)
	local parent = self.Parent

	if not (parent and parent:IsA("Model")) then
		return false
	end

	local playerFromCharacter = Players:GetPlayerFromCharacter(parent)

	if not playerFromCharacter then
		return false
	end

	local parent2 = workspace:FindFirstChild("LeftBehindEmoteModels")

	if not parent2 then
		parent2 = Instance.new("Folder")
		parent2.Name = "LeftBehindEmoteModels"
		parent2.Parent = workspace
	end

	local count = 0

	for _, child in parent2:GetChildren() do
		if child:GetAttribute("OwnerUserId") == playerFromCharacter.UserId then
			count += 1
		end
	end

	if count >= 4 then
		return false
	end

	local v = false

	for _, motor6D in self:GetChildren() do
		if not (motor6D:IsA("Motor6D") and (motor6D.Name == "Motor" or motor6D:GetAttribute("Motor"))) then
			continue
		end

		v = true
		local part1 = motor6D.Part1

		if part1 then
			part1.Anchored = true
		end

		motor6D:Destroy()
	end

	local primaryPart = not v and self.PrimaryPart

	if primaryPart then
		primaryPart.Anchored = true
	end

	self:SetAttribute("OwnerUserId", playerFromCharacter.UserId)
	self.Parent = parent2
	task.delay(duration, function()
		self:Destroy()
	end)
	return true
end

function EmoteUtilities.GetLeftBehindEmoteModel(p, p2: string)
	local leftBehindEmoteModels = workspace:FindFirstChild("LeftBehindEmoteModels")

	if not leftBehindEmoteModels then
		return nil
	end

	local children = leftBehindEmoteModels:GetChildren()

	for i = #children, 1, -1 do
		local model = children[i]

		if model:IsA("Model") and model.Name == p2 and model:GetAttribute("OwnerUserId") == p.UserId then
			return model
		end
	end

	return nil
end

function EmoteUtilities.ResetHumanoidHipHeight(instance)
	local humanoid = instance:FindFirstChild("Humanoid")
	local originalHipHeight = humanoid and humanoid:GetAttribute("OriginalHipHeight")

	if originalHipHeight then
		humanoid.HipHeight = originalHipHeight
	end
end

function EmoteUtilities.GetParticleEmitters(instance)
	local emitters = {}

	for _, emitter in instance:GetChildren() do
		if emitter:IsA("ParticleEmitter") then
			table.insert(emitters, emitter)
		end
	end

	return emitters
end

return EmoteUtilities