local VisualEffectClass = {}
VisualEffectClass.__index = VisualEffectClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local ObjectPoolClass = require(common:WaitForChild("ObjectPoolClass"))
local TowerUtilities = require(common:WaitForChild("TowerUtilities"))
local PartFadingHelper = require(script.Parent:WaitForChild("PartFadingHelper"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local Hidden = Lighting:WaitForChild("Hidden")
local v = nil
local v2 = nil
local v3 = {}
local v4 = {}

local function ScalePart(instance, p: number) -- 2 equivalent calls inferred from this helper
	if not instance:GetAttribute("OriginalSize") then
		instance:SetAttribute("OriginalSize", instance.Size)
	end

	instance.Size *= p
end

local function ScaleVisualEffectPart(folder, scale: number)
	ScalePart(folder, scale) -- inferred equivalent call

	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			ScalePart(part, scale) -- inferred equivalent call
		end
	end
end

local function ResetScale(folder)
	folder.Size = folder:GetAttribute("OriginalSize")

	for _, part in pairs(folder:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Size = part:GetAttribute("OriginalSize")
		end
	end
end

local function CollectBeamsAndTrails(folder)
	local effects = {}

	for _, effect in pairs(folder:GetDescendants()) do
		if effect:IsA("Beam") or effect:IsA("Trail") then
			table.insert(effects, effect)
		end
	end

	return effects
end

local function SetBeamsAndTrailsEnabled(items, enabled: boolean) -- 4 equivalent calls inferred from this helper
	for _, item in pairs(items) do
		item.Enabled = enabled
	end
end

local function SetBeamsSpeedMultiplier(items, p: number)
	for _, beam in pairs(items) do
		if not beam:IsA("Beam") then
			continue
		end

		if not beam:GetAttribute("OriginalTextureSpeed") then
			beam:SetAttribute("OriginalTextureSpeed", beam.TextureSpeed)
		end

		beam.TextureSpeed = beam:GetAttribute("OriginalTextureSpeed") * p
	end
end

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25), math.random(15, 55), math.random(-25, 25)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-25, 25) / 100, math.random(-35, 35) / 100, 0))
end

local function LaunchDebris(child, _)
	local primaryPart = child.PrimaryPart

	if not primaryPart then
		warn("Debris model has no PrimaryPart: " .. tostring(child.Name))
		return
	end

	local allBasepartDescendants = Utilities.GetAllBasepartDescendants(child)
	local mass = primaryPart:GetMass()
	local forceMultiplier = child:GetAttribute("ForceMultiplier")
	primaryPart.Anchored = false
	primaryPart:ApplyImpulse(GetRandomInitialVelocity() * mass * (forceMultiplier or 1)) -- inferred equivalent call
	primaryPart:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * mass * (forceMultiplier or 1)) -- inferred equivalent call
	task.delay(0.07, function()
		primaryPart.CanCollide = true
		local instantDestroyTimeRange = child:GetAttribute("InstantDestroyTimeRange")

		if instantDestroyTimeRange then
			task.wait(Utilities.GetRandomNumberInNumberRange(instantDestroyTimeRange))
			child:Destroy()
		else
			task.wait(4)
			local total = 0

			while total < 1.5 do
				total += task.wait()

				for _, allBasepartDescendant in pairs(allBasepartDescendants) do
					if not allBasepartDescendant:GetAttribute("OriginalTransparency") then
						allBasepartDescendant:SetAttribute("OriginalTransparency", allBasepartDescendant.Transparency)
					end

					allBasepartDescendant.Transparency = allBasepartDescendant:GetAttribute("OriginalTransparency") + total / 1.5
				end
			end

			child:Destroy()
		end
	end)
end

function VisualEffectClass.New(hash: number, data, p: number)
	local position = data.Position
	local followPart = data.FollowPart
	local scale = data.Scale
	assert(position or followPart, "NewVisualEffectData: Position and FollowPart were both nil")
	local isContinuous = data.IsContinuous
	local delay = data.Delay
	local v5 = delay or 0
	local v6 = delay or 0
	local name = TowerUtilities.AppendPathLevelString(data.Name, data.PathLevelString)
	local folder, timeLeft, timeLeftUntilRemove

	if isContinuous then
		folder = v:Get(name)
		timeLeft = v5 + (data.TimeToEmit or data.PlayUntilManuallyStopped and 0)
		timeLeftUntilRemove = v6 + (timeLeft + 5)
	else
		folder = v2:Get(name)
		timeLeft = v5 + (folder:GetAttribute("KeepTime") or 10)
		timeLeftUntilRemove = v6 + timeLeft
	end

	folder:PivotTo(followPart and followPart.CFrame or CFrame.new(position))
	local partFadingHelper = PartFadingHelper.New()

	for _, part in pairs(folder:GetDescendants()) do
		if not part:IsA("BasePart") then
			continue
		end

		part.CFrame = folder.CFrame

		if part:GetAttribute("FadeInAndOut") then
			partFadingHelper:Add(part)
		end
	end

	local debris = folder:FindFirstChild("Debris")

	if debris then
		for _, model in pairs(debris:GetChildren()) do
			if model:IsA("Model") then
				model:PivotTo(folder.CFrame)
			else
				warn("Unknown child in Debris folder: " .. tostring(model))
			end
		end

		debris.Parent = Hidden
	end

	local beamsAndTrails = CollectBeamsAndTrails(folder)
	SetBeamsAndTrailsEnabled(beamsAndTrails, false) -- inferred equivalent call
	folder.Parent = raycastIgnore
	local ignoreSpeedMultiplier = data.IgnoreSpeedMultiplier
	local v7 = (ignoreSpeedMultiplier and 1 or p) * (data.AdditionalSpeedMultiplier or 1)
	SetBeamsSpeedMultiplier(beamsAndTrails, v7)
	local v8 = {
		Hash = hash,
		Name = name,
		VisualEffectPart = folder,
		FollowPart = followPart,
		IgnoreSpeedMultiplier = ignoreSpeedMultiplier,
		AdditionalSpeedMultiplier = data.AdditionalSpeedMultiplier or 1,
		EmitterWrapper = WrapperFactory.NewEmitterWrapper(folder, v7),
		BeamsAndTrails = beamsAndTrails,
		SoundWrapper = WrapperFactory.NewSoundWrapper(folder, v7, 1.5),
		PartFadingHelper = partFadingHelper,
		DebrisFolder = debris,
		IsContinuous = isContinuous,
		PlayUntilManuallyStopped = data.PlayUntilManuallyStopped,
		ManuallyStopped = false,
		DelayLeft = delay,
		Started = false,
		TimeLeft = timeLeft,
		TimeLeftUntilRemove = timeLeftUntilRemove,
		Done = false,
		Scaled = scale ~= nil,
		Destroyed = false
	}

	if scale then
		ScaleVisualEffectPart(folder, scale)
		v8.EmitterWrapper:ScaleEmitters(scale)
	end

	setmetatable(v8, VisualEffectClass)

	if not delay then
		v8:_Activate()
	end

	return v8
end

function VisualEffectClass:Run(p: number)
	if self.Destroyed then
		return
	end

	if not self.PlayUntilManuallyStopped or self.ManuallyStopped then
		self.TimeLeft = math.max(0, self.TimeLeft - p)
		self.TimeLeftUntilRemove = math.max(0, self.TimeLeftUntilRemove - p)
	end

	if self.FollowPart then
		self.VisualEffectPart:PivotTo(CFrame.new(self.FollowPart.CFrame.Position))
	end

	if not self.Started and self.DelayLeft then
		self.DelayLeft = math.max(0, self.DelayLeft - p)

		if self.DelayLeft <= 0 then
			self:_Activate()
		end
	end

	self.PartFadingHelper:Run(p)

	if not self.Done and self.TimeLeft <= 0 and (not self.PlayUntilManuallyStopped or self.ManuallyStopped) then
		if self.IsContinuous then
			self.EmitterWrapper:StopContinuous()
			self.SoundWrapper:StopContinuous()
			SetBeamsAndTrailsEnabled(self.BeamsAndTrails, false) -- inferred equivalent call
		end

		self.Done = true
	end
end

function VisualEffectClass:SetFollowPart(followPart)
	self.FollowPart = followPart
end

function VisualEffectClass.CanRemove(p)
	return p.TimeLeftUntilRemove <= 0
end

function VisualEffectClass:StopEarly(flag: boolean?)
	if flag then
		self.TimeLeftUntilRemove = 0
		self.TimeLeft = 0
		self:Destroy()
	else
		self.TimeLeftUntilRemove -= self.TimeLeft
		self.TimeLeft = 0
		self.PartFadingHelper:Fade(true, (math.min(self.TimeLeftUntilRemove, 0.75)))
	end

	self.ManuallyStopped = true
end

function VisualEffectClass:Destroy()
	if not self.Destroyed then
		if self.Scaled then
			ResetScale(self.VisualEffectPart)
		end

		self.PartFadingHelper:ResetTransparency()
		self.EmitterWrapper:Reset()
		self.SoundWrapper:Reset()
		SetBeamsAndTrailsEnabled(self.BeamsAndTrails, false) -- inferred equivalent call

		if self.DebrisFolder then
			self.DebrisFolder:Destroy()
			self.VisualEffectPart:Destroy()
			self.PartFadingHelper:Destroy()
		elseif self.IsContinuous then
			table.insert(v3, { Name = self.Name, VisualEffectPart = self.VisualEffectPart })
		else
			table.insert(v4, { Name = self.Name, VisualEffectPart = self.VisualEffectPart })
		end

		self.Destroyed = true
	end
end

function VisualEffectClass:SpeedMultiplierChanged(p: number)
	if self.IgnoreSpeedMultiplier then
		return
	end

	self.EmitterWrapper:SpeedMultiplierChanged(p * self.AdditionalSpeedMultiplier)
	self.SoundWrapper:SpeedMultiplierChanged(p * self.AdditionalSpeedMultiplier)
	SetBeamsSpeedMultiplier(self.BeamsAndTrails, p * self.AdditionalSpeedMultiplier)
end

function VisualEffectClass:_Activate()
	if self.IsContinuous then
		self.EmitterWrapper:PlayAll()
		self.SoundWrapper:PlayAll()
	else
		self.EmitterWrapper:PlayTriggered()
		self.SoundWrapper:PlayTriggered()
	end

	SetBeamsAndTrailsEnabled(self.BeamsAndTrails, true) -- inferred equivalent call
	local debrisFolder = self.DebrisFolder

	if debrisFolder then
		debrisFolder.Parent = self.VisualEffectPart

		for _, child in pairs(debrisFolder:GetChildren()) do
			child:PivotTo(self.VisualEffectPart.CFrame)
			LaunchDebris(child, child)
		end
	end

	self.PartFadingHelper:Fade(false, 0.75)
	self.Started = true
end

function VisualEffectClass:Reactivate()
	self:_Activate()
end

local function MakeNewContinuousEffectPart(p: string)
	local continuousEffectConfig = ResourceManager.GetContinuousEffectConfig(p)
	local miscResource = ResourceManager.GetMiscResource("EffectPart")

	for _, part in pairs(continuousEffectConfig:GetChildren()) do
		if part:IsA("BasePart") then
			part.Position = miscResource.Position
			Utilities.Weld(miscResource, part)
			part.Anchored = false
		end

		part.Parent = miscResource
	end

	continuousEffectConfig:Destroy()
	return miscResource
end

local function MakeNewEmitOnceEffectPart(p: string)
	local emitOnceEffectConfig = ResourceManager.GetEmitOnceEffectConfig(p)
	local miscResource = ResourceManager.GetMiscResource("EffectPart")

	for _, child in pairs(emitOnceEffectConfig:GetChildren()) do
		child.Parent = miscResource
	end

	local keepTime = emitOnceEffectConfig:GetAttribute("KeepTime")

	if keepTime then
		miscResource:SetAttribute("KeepTime", keepTime)
	end

	emitOnceEffectConfig:Destroy()
	return miscResource
end

v = ObjectPoolClass.New(
	"ContinuousEffectPool",
	ResourceManager.GetAllContinuousEffectConfigs(),
	MakeNewContinuousEffectPart
)
v2 = ObjectPoolClass.New("EmitOnceEffectPool", ResourceManager.GetAllEmitOnceEffectConfigs(), MakeNewEmitOnceEffectPart)
RunService.Heartbeat:Connect(function()
	for _, v5 in pairs(v3) do
		v:Recycle(v5.Name, v5.VisualEffectPart)
	end

	for _, v5 in pairs(v4) do
		v2:Recycle(v5.Name, v5.VisualEffectPart)
	end

	table.clear(v3)
	table.clear(v4)
end)
return VisualEffectClass