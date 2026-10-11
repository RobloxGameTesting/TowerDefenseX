local EmitterWrapperClass = {}
EmitterWrapperClass.__index = EmitterWrapperClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Utilities = require(Common:WaitForChild("Utilities"))
local Data = require(TDX_Shared.Client.Services.Data)
GuiService:IsTenFootInterface()
local TryReadChildValue = Utilities.TryReadChildValue
local lowGraphics = false

local function AdjustEmitCount(instance, p: number) -- 3 equivalent calls inferred from this helper
	if instance:GetAttribute("IsBlood") then
		return 0
	end

	if lowGraphics then
		return (math.ceil(p / 3))
	end

	return p
end

local function StartContinuousEmitter(instance)
	if instance:GetAttribute("IsBlood") then
		instance.Enabled = false
		return
	end

	if lowGraphics then
		if not instance:GetAttribute("OriginalRate") then
			instance:SetAttribute("OriginalRate", instance.Rate)
		end

		instance.Rate = math.ceil(instance:GetAttribute("OriginalRate") / 3)
	else
		instance.Rate = instance:GetAttribute("OriginalRate") or instance.Rate
	end

	instance.Enabled = true
end

function EmitterWrapperClass.New(p, speedMultiplier: number, p2: number?)
	local v = {
		AllEmitters = {},
		TriggeredEmitters = {},
		ContinuousEmitters = {},
		KeyframeTriggeredEmitters = {},
		Lights = {},
		KeyframeTriggeredLights = {},
		Trails = {},
		KeyframeTriggeredTrails = {},
		Beams = {},
		KeyframeTriggeredBeams = {},
		KeyframeTriggeredContinuousMap = {},
		EmitCountMap = {},
		DelayMap = {},
		LightFadeInTweens = {},
		LightFadeOutTweens = {},
		Scale = 1,
		SpeedMultiplier = speedMultiplier,
		EmitTriggeredWhenSpeedMultiplierNonZero = false,
		EmitContinuousWhenSpeedMultiplierNonZero = false,
		EmitKeyframeTriggeredWhenSpeedMultiplierNonZero = false,
		LastKeyframeName = nil
	}
	setmetatable(v, EmitterWrapperClass)

	if p then
		v:AddEmittersFrom(p, speedMultiplier, p2)
	end

	return v
end

function EmitterWrapperClass:PlayTriggered()
	if self.SpeedMultiplier == 0 then
		self.EmitTriggeredWhenSpeedMultiplierNonZero = true
		return
	end

	for _, triggeredEmitter in pairs(self.TriggeredEmitters) do
		local v = self.DelayMap[triggeredEmitter]

		if v > 0 then
			local v2 = v
			local heartbeatConnection = nil
			local v3 = triggeredEmitter
			heartbeatConnection = RunService.Heartbeat:Connect(function(dt: number)
				local v4 = dt * self.SpeedMultiplier
				v2 -= v4

				if v2 <= 0 then
					v3:Emit(AdjustEmitCount(v3, self.EmitCountMap[v3])) -- inferred equivalent call
					heartbeatConnection:Disconnect()
				end
			end)
		else
			triggeredEmitter:Emit(AdjustEmitCount(triggeredEmitter, self.EmitCountMap[triggeredEmitter])) -- inferred equivalent call
		end
	end
end

function EmitterWrapperClass:PlayContinuous()
	if self.SpeedMultiplier == 0 then
		self.EmitContinuousWhenSpeedMultiplierNonZero = true
		return
	end

	for _, continuousEmitter in pairs(self.ContinuousEmitters) do
		StartContinuousEmitter(continuousEmitter)
	end

	local lightFadeInTweens = self.LightFadeInTweens

	for _, light in pairs(self.Lights) do
		if lightFadeInTweens[light] then
			lightFadeInTweens[light]:Play()
		else
			light.Enabled = true
		end
	end

	for _, trail in pairs(self.Trails) do
		trail.Enabled = true
	end

	for _, beam in pairs(self.Beams) do
		beam.Enabled = true
	end
end

function EmitterWrapperClass:StopContinuous()
	self.EmitContinuousWhenSpeedMultiplierNonZero = false

	for _, continuousEmitter in pairs(self.ContinuousEmitters) do
		continuousEmitter.Enabled = false
	end

	for _, keyframeTriggeredEmitter in pairs(self.KeyframeTriggeredEmitters) do
		for _, v in pairs(keyframeTriggeredEmitter) do
			v.Enabled = false
		end
	end

	local lightFadeOutTweens = self.LightFadeOutTweens

	for _, light in pairs(self.Lights) do
		if lightFadeOutTweens[light] then
			lightFadeOutTweens[light]:Play()
		else
			light.Enabled = false
		end
	end

	for _, keyframeTriggeredLight in pairs(self.KeyframeTriggeredLights) do
		for _, v in pairs(keyframeTriggeredLight) do
			if lightFadeOutTweens[v] then
				lightFadeOutTweens[v]:Play()
			else
				v.Enabled = false
			end
		end
	end

	for _, trail in pairs(self.Trails) do
		trail.Enabled = false
	end

	for _, keyframeTriggeredTrail in pairs(self.KeyframeTriggeredTrails) do
		for _, v in pairs(keyframeTriggeredTrail) do
			v.Enabled = false
		end
	end

	for _, beam in pairs(self.Beams) do
		beam.Enabled = false
	end

	for _, keyframeTriggeredBeam in pairs(self.KeyframeTriggeredBeams) do
		for _, v in pairs(keyframeTriggeredBeam) do
			v.Enabled = false
		end
	end
end

function EmitterWrapperClass:PlayAll()
	self:PlayTriggered()
	self:PlayContinuous()
end

function EmitterWrapperClass:PlayKeyframeTriggered(lastKeyframeName: string)
	local flag

	if lastKeyframeName:find("_Stop") then
		lastKeyframeName = lastKeyframeName:gsub("_Stop", "")
		flag = true
	else
		flag = false
	end

	if self.SpeedMultiplier == 0 then
		self.EmitKeyframeTriggeredWhenSpeedMultiplierNonZero = true
		self.LastKeyframeName = lastKeyframeName
	else
		local keyframeTriggeredEmitter = self.KeyframeTriggeredEmitters[lastKeyframeName]
		local keyframeTriggeredContinuousMap = self.KeyframeTriggeredContinuousMap

		if keyframeTriggeredEmitter then
			for _, v in pairs(keyframeTriggeredEmitter) do
				if flag then
					v.Enabled = false
				elseif keyframeTriggeredContinuousMap[v] then
					StartContinuousEmitter(v)
				else
					v:Emit(AdjustEmitCount(v, self.EmitCountMap[v])) -- inferred equivalent call
				end
			end
		end

		local keyframeTriggeredLight = self.KeyframeTriggeredLights[lastKeyframeName]

		if keyframeTriggeredLight then
			local lightFadeInTweens = self.LightFadeInTweens
			local lightFadeOutTweens = self.LightFadeOutTweens

			for _, v in pairs(keyframeTriggeredLight) do
				if flag then
					if lightFadeOutTweens[v] then
						lightFadeOutTweens[v]:Play()
					else
						v.Enabled = false
					end
				elseif lightFadeInTweens[v] then
					lightFadeInTweens[v]:Play()
				else
					v.Enabled = true
				end
			end
		end

		local keyframeTriggeredTrail = self.KeyframeTriggeredTrails[lastKeyframeName]

		if keyframeTriggeredTrail then
			for _, v in pairs(keyframeTriggeredTrail) do
				if flag then
					v.Enabled = false
				else
					v.Enabled = true
				end
			end
		end

		local keyframeTriggeredBeam = self.KeyframeTriggeredBeams[lastKeyframeName]

		if keyframeTriggeredBeam then
			for _, v in pairs(keyframeTriggeredBeam) do
				v.Enabled = not flag
			end
		end
	end
end

function EmitterWrapperClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, allEmitter in pairs(self.AllEmitters) do
		local scale = self.Scale
		local originalLifetime = allEmitter:GetAttribute("OriginalLifetime")
		local originalSpeed = allEmitter:GetAttribute("OriginalSpeed")
		local originalRotSpeed = allEmitter:GetAttribute("OriginalRotSpeed")
		local originalRate = allEmitter:GetAttribute("OriginalRate")
		local originalAcceleration = allEmitter:GetAttribute("OriginalAcceleration")
		local originalDrag = allEmitter:GetAttribute("OriginalDrag")
		local originalTimeScale = allEmitter:GetAttribute("OriginalTimeScale")

		if speedMultiplier > 1 then
			allEmitter.Lifetime = NumberRange.new(
				originalLifetime.Min / speedMultiplier,
				originalLifetime.Max / speedMultiplier
			)
			allEmitter.Speed = NumberRange.new(
				speedMultiplier * scale * originalSpeed.Min,
				speedMultiplier * scale * originalSpeed.Max
			)
			allEmitter.RotSpeed = NumberRange.new(
				speedMultiplier * originalRotSpeed.Min,
				speedMultiplier * originalRotSpeed.Max
			)
			allEmitter.Rate = speedMultiplier * originalRate
			allEmitter.Acceleration = speedMultiplier ^ 2 * originalAcceleration * scale
			allEmitter.Drag = speedMultiplier * originalDrag
			allEmitter.TimeScale = originalTimeScale
		else
			allEmitter.Lifetime = originalLifetime
			allEmitter.Speed = originalSpeed
			allEmitter.RotSpeed = originalRotSpeed
			allEmitter.Rate = originalRate
			allEmitter.Acceleration = originalAcceleration
			allEmitter.Drag = originalDrag
			allEmitter.TimeScale = speedMultiplier * originalTimeScale
		end
	end

	self.SpeedMultiplier = speedMultiplier

	if self.SpeedMultiplier ~= 0 then
		if self.EmitTriggeredWhenSpeedMultiplierNonZero then
			self:PlayTriggered()
			self.EmitTriggeredWhenSpeedMultiplierNonZero = false
		end

		if self.EmitContinuousWhenSpeedMultiplierNonZero then
			self:PlayContinuous()
			self.EmitContinuousWhenSpeedMultiplierNonZero = false
		end

		if self.EmitKeyframeTriggeredWhenSpeedMultiplierNonZero then
			self:PlayKeyframeTriggered(self.LastKeyframeName)
			self.EmitKeyframeTriggeredWhenSpeedMultiplierNonZero = false
		end
	end
end

function EmitterWrapperClass:ScaleEmitters(scale: number)
	local speedMultiplier = self.SpeedMultiplier

	for _, allEmitter in pairs(self.AllEmitters) do
		local originalSize = allEmitter:GetAttribute("OriginalSize")
		local originalSpeed = allEmitter:GetAttribute("OriginalSpeed")
		local originalAcceleration = allEmitter:GetAttribute("OriginalAcceleration")
		allEmitter.Size = Utilities.ScaleNumberSequence(originalSize, scale)
		allEmitter.Speed = NumberRange.new(
			speedMultiplier * scale * originalSpeed.Min,
			speedMultiplier * scale * originalSpeed.Max
		)
		allEmitter.Acceleration = speedMultiplier ^ 2 * originalAcceleration * scale
	end

	self.Scale = scale
end

function EmitterWrapperClass.Reset(p)
	for _, allEmitter in pairs(p.AllEmitters) do
		local originalSize = allEmitter:GetAttribute("OriginalSize")
		local originalLifetime = allEmitter:GetAttribute("OriginalLifetime")
		local originalSpeed = allEmitter:GetAttribute("OriginalSpeed")
		local originalRotSpeed = allEmitter:GetAttribute("OriginalRotSpeed")
		local originalRate = allEmitter:GetAttribute("OriginalRate")
		local originalAcceleration = allEmitter:GetAttribute("OriginalAcceleration")
		local originalDrag = allEmitter:GetAttribute("OriginalDrag")
		local originalTimeScale = allEmitter:GetAttribute("OriginalTimeScale")
		allEmitter.Size = originalSize
		allEmitter.Lifetime = originalLifetime
		allEmitter.Speed = originalSpeed
		allEmitter.RotSpeed = originalRotSpeed
		allEmitter.Rate = originalRate
		allEmitter.Acceleration = originalAcceleration
		allEmitter.Drag = originalDrag
		allEmitter.TimeScale = originalTimeScale
	end
end

function EmitterWrapperClass:AddEmitter(p, p2: number, p3: number?, flag: boolean?)
	self:_InternalAddEmitter(p, p3, flag)
	self:ScaleEmitters(self.Scale)
	self:SpeedMultiplierChanged(p2)
end

function EmitterWrapperClass:AddEmitters(items, p: number, p2: number?, flag: boolean?)
	for _, item in pairs(items) do
		self:_InternalAddEmitter(item, p2, flag)
	end

	self:ScaleEmitters(self.Scale)
	self:SpeedMultiplierChanged(p)
end

function EmitterWrapperClass:AddLight(p)
	self:_InternalAddLight(p)
end

function EmitterWrapperClass:AddEmittersFrom(folder, p: number, p2: number?)
	for _, descendant in pairs(folder:GetDescendants()) do
		if descendant:IsA("ParticleEmitter") then
			self:_InternalAddEmitter(descendant, p2)
		elseif descendant:IsA("Trail") then
			self:_InternalAddTrail(descendant)
		elseif descendant:IsA("Beam") then
			self:_InternalAddBeam(descendant)
		elseif descendant:IsA("Light") then
			self:_InternalAddLight(descendant)
		elseif descendant:IsA("ObjectValue") and descendant.Name == "EmitterPointer" then
			local value = descendant.Value
			local parent = TryReadChildValue(descendant, "EmitterParent") or descendant.Parent

			if value then
				if value:IsA("ParticleEmitter") then
					local clone = value:Clone()
					clone.Parent = parent
					self:_InternalAddEmitter(clone, p2)
				elseif value:IsA("Folder") then
					local tryReadChildValue = TryReadChildValue(value, "AllChildrenContinuous")
					local tryReadChildValue2 = TryReadChildValue(value, "AllChildrenDelay")

					for _, emitter in pairs(value:GetChildren()) do
						if not emitter:IsA("ParticleEmitter") then
							continue
						end

						local clone = emitter:Clone()
						clone.Parent = parent
						self:_InternalAddEmitter(clone, p2, tryReadChildValue, tryReadChildValue2)
					end
				end
			end

			descendant:Destroy()
		end
	end

	self:ScaleEmitters(self.Scale)
	self:SpeedMultiplierChanged(p)
end

function EmitterWrapperClass:_InternalAddEmitter(instance, value: number?, flag: boolean?, value2: number?)
	local v = TryReadChildValue(instance, "KeyframeTriggered", false)
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeTriggered", false)
	local v2 = v and TryReadChildValue(instance, "KeyframeName")
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeName", instance.Name)
	local v3 = TryReadChildValue(instance, "Delay", instance:GetAttribute("EmitDelay"))
		or TryReadChildValue(instance.Parent, "AllChildrenDelay")
		or value2
		or 0
	local v4 = flag
		or TryReadChildValue(instance, "Continuous", instance:GetAttribute("Continuous"))
		or TryReadChildValue(instance.Parent, "AllChildrenContinuous")

	if TryReadChildValue(instance, "NotContinuous") then
		v4 = false
	end

	local tryReadChildValue = TryReadChildValue(instance, "EmitCount", instance.Rate or value or 8)

	if v3 > 0 and v4 then
		warn("Continuous emitter with delay is not implemented")
		print(instance:GetFullName())
	end

	if v3 > 0 and v then
		warn("Keyframe triggered emitter with delay is not implemented")
		print(instance:GetFullName())
	end

	if v then
		if not self.KeyframeTriggeredEmitters[v2] then
			self.KeyframeTriggeredEmitters[v2] = {}
		end

		table.insert(self.KeyframeTriggeredEmitters[v2], instance)
	elseif v4 then
		table.insert(self.ContinuousEmitters, instance)
	else
		table.insert(self.TriggeredEmitters, instance)
	end

	if not v4 then
		self.EmitCountMap[instance] = tryReadChildValue
	end

	self.DelayMap[instance] = v3

	if not instance:GetAttribute("OriginalValuesSaved") then
		instance:SetAttribute("OriginalSize", instance.Size)
		instance:SetAttribute("OriginalLifetime", instance.Lifetime)
		instance:SetAttribute("OriginalSpeed", instance.Speed)
		instance:SetAttribute("OriginalRotSpeed", instance.RotSpeed)
		instance:SetAttribute("OriginalRate", instance.Rate)
		instance:SetAttribute("OriginalAcceleration", instance.Acceleration)
		instance:SetAttribute("OriginalDrag", instance.Drag)
		instance:SetAttribute("OriginalTimeScale", instance.TimeScale)
		instance:SetAttribute("OriginalValuesSaved", true)
	end

	if v and v4 then
		self.KeyframeTriggeredContinuousMap[instance] = true
	end

	table.insert(self.AllEmitters, instance)
end

function EmitterWrapperClass:_InternalAddLight(instance)
	if instance.Enabled then
		return
	end

	local v = TryReadChildValue(instance, "Continuous")
		or TryReadChildValue(instance.Parent, "AllChildrenContinuous", false)
	local v2 = TryReadChildValue(instance, "KeyframeTriggered", false)
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeTriggered", false)
	local v3 = v2 and TryReadChildValue(instance, "KeyframeName")
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeName", instance.Name)
	local tryReadChildValue = TryReadChildValue(instance, "FadeInTime")
	local tryReadChildValue2 = TryReadChildValue(instance, "FadeOutTime")

	if not v and (tryReadChildValue or tryReadChildValue2) then
		warn("Fade in/out time is only supported for continuous lights")
	end

	if v2 then
		if not self.KeyframeTriggeredLights[v3] then
			self.KeyframeTriggeredLights[v3] = {}
		end

		table.insert(self.KeyframeTriggeredLights[v3], instance)
	else
		table.insert(self.Lights, instance)
	end

	if tryReadChildValue and tryReadChildValue2 then
		local tweenInfo = TweenInfo.new(tryReadChildValue)
		local tweenInfo2 = TweenInfo.new(tryReadChildValue2)
		self.LightFadeInTweens[instance] = TweenService:Create(instance, tweenInfo, {
			Brightness = instance.Brightness
		})
		self.LightFadeOutTweens[instance] = TweenService:Create(instance, tweenInfo2, {
			Brightness = 0
		})
		instance.Brightness = 0
		instance.Enabled = true
	elseif tryReadChildValue or tryReadChildValue2 then
		warn("Fade in/out time must be set for both fade in and fade out")
	end
end

function EmitterWrapperClass:_InternalAddTrail(instance)
	if not TryReadChildValue(instance, "AbilityActivated") then
		return
	end

	local v = TryReadChildValue(instance, "KeyframeTriggered", false)
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeTriggered", false)
	local v2 = v and TryReadChildValue(instance, "KeyframeName")
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeName", instance.Name)

	if v then
		if not self.KeyframeTriggeredTrails[v2] then
			self.KeyframeTriggeredTrails[v2] = {}
		end

		table.insert(self.KeyframeTriggeredTrails[v2], instance)
	else
		table.insert(self.Trails, instance)
	end

	instance.Enabled = false
end

function EmitterWrapperClass:_InternalAddBeam(instance)
	local v = TryReadChildValue(instance, "KeyframeTriggered", false)
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeTriggered", false)
	local v2 = TryReadChildValue(instance, "Continuous", instance:GetAttribute("Continuous"))
		or TryReadChildValue(instance.Parent, "AllChildrenContinuous", false)

	if not (v or v2) then
		return
	end

	if v then
		local v3 = TryReadChildValue(instance, "KeyframeName")
			or TryReadChildValue(instance.Parent, "AllChildrenKeyframeName", instance.Name)

		if not self.KeyframeTriggeredBeams[v3] then
			self.KeyframeTriggeredBeams[v3] = {}
		end

		table.insert(self.KeyframeTriggeredBeams[v3], instance)
	else
		table.insert(self.Beams, instance)
	end

	instance.Enabled = false
end

local settings = Data.Get("Settings")
local blood = settings.Blood
lowGraphics = settings.LowGraphics
Data.Updated:Connect(function(p, p2)
	if p == "Settings" then
		blood = p2.Blood
		lowGraphics = p2.LowGraphics
	end
end)
return EmitterWrapperClass