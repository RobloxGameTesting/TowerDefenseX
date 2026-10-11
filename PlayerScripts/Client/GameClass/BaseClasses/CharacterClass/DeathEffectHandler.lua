local DeathEffectHandler = {}
DeathEffectHandler.__index = DeathEffectHandler
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local WrapperFactory = require(Common:WaitForChild("WrapperFactory"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local HashGeneratorClass = require(Common:WaitForChild("HashGeneratorClass"))
local Utilities = require(Common:WaitForChild("Utilities"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local event = BindableHandler.GetEvent("SetSpeedMultiplier")
local v = {}
local v2 = HashGeneratorClass.New()

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

function DeathEffectHandler.NewDeathEffect(trackInstance, p: string, deathSound, p2: number)
	local hash = v2:Get()
	local miscResource = ResourceManager.GetMiscResource("EffectPart")
	local parts = { miscResource }
	local vector = Vector3.new()
	local v3 = {
		Hash = hash,
		Source = miscResource,
		TrackInstance = trackInstance,
		SourceOffset = vector,
		EffectInstances = parts,
		EmitterAndSoundWrapper = nil,
		DeathSound = nil,
		SoundOriginalPlaybackSpeed = 1,
		TimeLeft = math.max(25, not deathSound and 0 or deathSound.TimeLength + 5 or 0),
		DebrisFolder = nil
	}

	if p then
		local deathEffectConfig = ResourceManager.GetDeathEffectConfig(p)

		if deathEffectConfig then
			local debris = deathEffectConfig:FindFirstChild("Debris")

			if debris then
				for _, model in pairs(debris:GetChildren()) do
					if model:IsA("Model") then
						model:PivotTo(miscResource.CFrame)
					else
						warn("Unknown child in Debris folder: " .. tostring(model))
					end
				end

				v3.DebrisFolder = debris
			end

			for _, part in pairs(deathEffectConfig:GetChildren()) do
				if part:IsA("BasePart") then
					part.Position = miscResource.Position
					table.insert(parts, part)
				end

				part.Parent = miscResource
			end

			if deathEffectConfig:GetAttribute("Offset") then
				vector = deathEffectConfig:GetAttribute("Offset")
				v3.SourceOffset = vector
			end

			v3.EmitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(miscResource, p2)
			v3.EmitterAndSoundWrapper:PlayTriggered()
			deathEffectConfig:Destroy()
		end
	end

	if deathSound then
		pcall(function()
			v3.DeathSound = deathSound
			v3.SoundOriginalPlaybackSpeed = deathSound.PlaybackSpeed
			deathSound.Parent = miscResource
			deathSound.PlaybackSpeed *= p2
			GameSoundHandler.AddSoundToSoundGroup(deathSound, "SFX")
			deathSound:Play()
		end)
	end

	miscResource.Position = trackInstance.Position + vector
	miscResource.Name = "DeathEffectPart"
	miscResource.Parent = raycastIgnore

	if v3.DebrisFolder then
		for _, child in pairs(v3.DebrisFolder:GetChildren()) do
			child:PivotTo(miscResource.CFrame)
			LaunchDebris(child, child)
		end
	end

	v[hash] = v3
	return (setmetatable(v3, DeathEffectHandler))
end

function DeathEffectHandler.Tick(p: number)
	for _, v3 in pairs(v) do
		v3:Run(p)
	end
end

function DeathEffectHandler:Run(p: number)
	for _, effectInstance in pairs(self.EffectInstances) do
		effectInstance.Position = self.TrackInstance.Position + self.SourceOffset
	end

	self.TimeLeft -= p

	if self.TimeLeft <= 0 then
		self:Destroy()
	end
end

function DeathEffectHandler:Destroy()
	v[self.Hash] = nil
	v2:Return(self.Hash)

	if self.DebrisFolder then
		self.DebrisFolder:Destroy()
	end

	self.Source:Destroy()
end

function DeathEffectHandler:SpeedMultiplierChanged(p: number)
	local emitterAndSoundWrapper = self.EmitterAndSoundWrapper
	local deathSound = self.DeathSound

	if emitterAndSoundWrapper then
		emitterAndSoundWrapper:SpeedMultiplierChanged(p)
	end

	if deathSound then
		deathSound.PlaybackSpeed = p * self.SoundOriginalPlaybackSpeed
	end
end

event:AttachCallback(function(p: number)
	for _, v3 in pairs(v) do
		v3:SpeedMultiplierChanged(p)
	end
end)
return DeathEffectHandler