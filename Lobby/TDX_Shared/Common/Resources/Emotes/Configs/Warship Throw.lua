local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local Utilities = require(common:WaitForChild("Utilities"))
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local emitOnceVisualEffects = common:WaitForChild("Resources"):WaitForChild("EmitOnceVisualEffects")
local v = {
	{
		Name = "VoidPrimeDebrisRock1",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 3
	},
	{
		Name = "VoidPrimeDebrisRock2",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 3
	},
	{
		Name = "VoidPrimeDebrisRock3",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastMedium,
		Weight = 2
	},
	{
		Name = "VoidPrimeDebrisAATurret",
		BlastName = Enums.VisualEffects.VoidMeteoriteBlastSmall,
		Weight = 1
	}
}
local total = 0

for _, v2 in v do
	total += v2.Weight
end

local v2 = {}

local function GetEffectsFolder() -- 4 equivalent calls inferred from this helper
	local v3 = workspace:FindFirstChild("EmoteEffects")

	if not v3 then
		v3 = Instance.new("Folder")
		v3.Name = "EmoteEffects"
		v3.Parent = workspace
	end

	return v3
end

local function GetGroundY(vector: Vector3, character, p: number)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local effectsFolder = GetEffectsFolder() -- inferred equivalent call
	raycastParams.FilterDescendantsInstances = { character, effectsFolder }
	local raycastResult = workspace:Raycast(vector, createVector(0, -100, 0), raycastParams)

	if raycastResult then
		return raycastResult.Position.Y
	end

	return p
end

local function PlayBlast(blastName: string, goal: Vector3)
	local child = emitOnceVisualEffects:FindFirstChild(blastName)

	if not child then
		return
	end

	local part = Instance.new("Part")
	part.Name = blastName
	part.Size = createVector(1, 1, 1)
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.CFrame = CFrame.new(goal)

	for _, child2 in child:GetChildren() do
		local clone = child2:Clone()

		if clone:IsA("Sound") then
			clone:SetAttribute("__GroupName", "Emotes")
			clone:AddTag("SoundFix")
		end

		clone.Parent = part
	end

	part.Parent = GetEffectsFolder() -- inferred equivalent call

	for _, child2 in part:GetChildren() do
		if child2:IsA("ParticleEmitter") then
			local v3 = Utilities.TryReadChildValue(child2, "EmitCount", child2.Rate)
			local v4 = Utilities.TryReadChildValue(child2, "Delay", child2:GetAttribute("EmitDelay")) or 0

			if v4 > 0 then
				local v5 = child2
				task.delay(v4, function()
					if v5.Parent then
						v5:Emit(v3)
					end
				end)
			else
				child2:Emit(v3)
			end
		elseif child2:IsA("Sound") then
			child2:Play()
		end
	end

	Debris:AddItem(part, 4)
end

local function DestroyRift(p, data)
	for _, connection in data.Connections do
		connection:Disconnect()
	end

	if data.Portal.Parent then
		data.Portal:Destroy()
	end

	for _, v3 in data.Debris do
		v3.Model:Destroy()
	end

	v2[p] = nil
end

local function SpawnDebris(player)
	local name = v[1].Name
	local blastName = v[1].BlastName
	local v3 = math.random() * total

	for _, v4 in v do
		v3 -= v4.Weight

		if not (v3 <= 0) then
			continue
		end

		name = v4.Name
		blastName = v4.BlastName
		break
	end

	local folder = ResourceManager.GetMiscResource(name)
	folder:ScaleTo(0.12 + math.random() * 0.08000000000000002)

	for _, part in folder:GetDescendants() do
		if not part:IsA("BasePart") then
			continue
		end

		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
	end

	local v4 = math.random() * 2 * 3.141592653589793
	local v5 = math.sqrt((math.random())) * 1.7712
	local spawnPosition = player.Position + Vector3.new(math.cos(v4) * v5, 0, math.sin(v4) * v5)
	local v6 = math.random() * 2 * 3.141592653589793
	local v7 = math.sqrt((math.random())) * 6
	local v8 = player.Position + Vector3.new(math.cos(v6) * v7, 0, math.sin(v6) * v7)
	local vector = Vector3.new(v8.X, GetGroundY(v8, player.Character, player.Position.Y - 100), v8.Z)
	local vector2 = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
	local tumbleAxis = not (vector2.Magnitude > 0.01) and createVector(1, 0, 0) or vector2.Unit
	local v9 = {
		Model = folder,
		SpawnPosition = spawnPosition,
		Goal = vector,
		Elapsed = 0,
		TumbleAxis = tumbleAxis,
		TumbleSpeed = 0.6981317007977318 + math.random() * 0.8726646259971648,
		TumbleAngle = math.random() * 2 * 3.141592653589793,
		BlastName = blastName
	}
	folder:PivotTo(CFrame.new(spawnPosition) * CFrame.fromAxisAngle(tumbleAxis, v9.TumbleAngle))
	folder.Parent = GetEffectsFolder() -- inferred equivalent call
	table.insert(player.Debris, v9)
end

local function UpdateDebris(state, p: number)
	for i = #state.Debris, 1, -1 do
		local v3 = state.Debris[i]
		v3.Elapsed += p
		local v4 = math.min(v3.Elapsed / 1.2, 1)
		local v5

		if v4 < 0.35 then
			v5 = v3.SpawnPosition - Vector3.new(0, v4 / 0.35 * 1.5, 0)
		else
			local v6 = (v4 - 0.35) / 0.65
			local v7 = v6 ^ 5
			local v8 = v3.SpawnPosition - createVector(0, 1.5, 0)
			local v9 = v6 * 0.65 * 1.2
			v5 = v8:Lerp(v3.Goal, v7) - Vector3.new(0, v9 * (25 / 7) * (1 - v7), 0)
		end

		v3.TumbleAngle += v3.TumbleSpeed * p * (v4 * 10 + 1)
		v3.Model:PivotTo(CFrame.new(v5) * CFrame.fromAxisAngle(v3.TumbleAxis, v3.TumbleAngle))

		if not (v3.Elapsed >= 1.2) then
			continue
		end

		PlayBlast(v3.BlastName, v3.Goal)
		v3.Model:Destroy()
		table.remove(state.Debris, i)
	end
end

local function UpdateRift(instance, state, dt: number)
	state.Elapsed += dt

	if state.Elapsed > 12 and (state.State == "Opening" or state.State == "Open") then
		state.State = "Closing"
		state.CloseElapsed = 0
	end

	if state.State ~= "Done" then
		local v3 = 0.20943951023931956

		if state.State == "Closing" then
			v3 *= math.clamp(state.CloseElapsed / 0.8, 0, 1) * 99 + 1
		end

		state.Spin += v3 * dt
		local value = 1

		if state.State == "Opening" then
			local v4 = math.clamp(state.Elapsed / 1.5, 0, 1)
			value = TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			if v4 >= 1 then
				state.State = "Open"
			end
		elseif state.State == "Closing" then
			state.CloseElapsed += dt
			local v4 = math.clamp(state.CloseElapsed / 0.8, 0, 1)
			value = 1 - TweenService:GetValue(v4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

			if v4 >= 1 then
				state.State = "Done"
				state.Portal:Destroy()
			end
		end

		if state.State ~= "Done" then
			state.Portal:PivotTo(CFrame.new(state.Position) * CFrame.Angles(0, state.Spin, 0) * CFrame.Angles(0, 0, -1.5707963267948966))
			state.Portal:ScaleTo(math.max(value, 0.02) * 0.41)
		end
	end

	local rainElapsed = state.RainElapsed

	if rainElapsed and state.State == "Open" then
		local rainElapsed2 = rainElapsed + dt
		state.RainElapsed = rainElapsed2

		while #state.PendingSpawnTimes > 0 and state.PendingSpawnTimes[1] <= rainElapsed2 do
			table.remove(state.PendingSpawnTimes, 1)
			SpawnDebris(state)
		end
	end

	UpdateDebris(state, dt)

	if state.State == "Done" and #state.Debris == 0 then
		DestroyRift(instance, state)
	end
end

local function OpenRift(warshipThrow)
	if v2[warshipThrow] then
		return
	end

	local parent = warshipThrow.Parent
	local motor = warshipThrow:FindFirstChild("Motor")

	if not (parent and parent:IsA("Model") and motor) then
		return
	end

	local humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")

	if not humanoidRootPart then
		return
	end

	local folder = ResourceManager.GetMiscResource("VoidPrimePortal")

	for _, part in folder:GetDescendants() do
		if not part:IsA("BasePart") then
			continue
		end

		part.Anchored = true
		part.CastShadow = false
	end

	local v3 = {
		Character = parent,
		Portal = folder,
		Position = humanoidRootPart.CFrame:PointToWorldSpace(motor.C0.Position),
		State = "Opening",
		Elapsed = 0,
		Spin = 0,
		CloseElapsed = 0,
		RainElapsed = nil,
		PendingSpawnTimes = {},
		Debris = {},
		Connections = {}
	}
	folder:ScaleTo(0.008199999999999999)
	folder:PivotTo(CFrame.new(v3.Position) * CFrame.Angles(0, 0, -1.5707963267948966))
	folder.Parent = GetEffectsFolder() -- inferred equivalent call
	v2[warshipThrow] = v3
	table.insert(v3.Connections, RunService.Heartbeat:Connect(function(dt: number)
		UpdateRift(warshipThrow, v3, dt)
	end))
	table.insert(v3.Connections, warshipThrow.Destroying:Connect(function()
		if v3.State == "Opening" or v3.State == "Open" then
			v3.State = "Closing"
			v3.CloseElapsed = 0
		end
	end))
end

local function ThrowDebris(warshipThrow)
	local v3 = v2[warshipThrow]

	if not v3 or v3.RainElapsed or v3.State == "Closing" or v3.State == "Done" then
		return
	end

	v3.RainElapsed = 0
	table.insert(v3.PendingSpawnTimes, 0)
	table.insert(v3.PendingSpawnTimes, 0.32000000000000006)
	table.insert(v3.PendingSpawnTimes, 0.6400000000000001)
	table.insert(v3.PendingSpawnTimes, 0.96)
	table.insert(v3.PendingSpawnTimes, 1.2800000000000002)
	table.insert(v3.PendingSpawnTimes, 1.6)
end

local function CloseRift(warshipThrow) -- 1 equivalent call inferred from this helper
	local v3 = v2[warshipThrow]

	if v3 and (v3.State == "Opening" or v3.State == "Open") then
		v3.State = "Closing"
		v3.CloseElapsed = 0
	end
end

local animationIds = { [EmoteAnimationGroup.Main] = 125511392185485 }
local keyframeEventNames = {
	[EmoteAnimationGroup.Main] = { "OpenRift", "ThrowDebris", "CloseRift" }
}
return {
	Type = Type.Basic,
	Name = "Warship Throw",
	AnimationIds = animationIds,
	ModelNames = { "Warship Throw" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p: string, p2)
		local warshipThrow = p2["Warship Throw"]

		if not warshipThrow then
			warn("Rift anchor not found for Warship Throw emote")
		elseif p == "OpenRift" then
			OpenRift(warshipThrow)
		elseif p == "ThrowDebris" then
			ThrowDebris(warshipThrow)
		elseif p == "CloseRift" then
			CloseRift(warshipThrow) -- inferred equivalent call
		end
	end
}