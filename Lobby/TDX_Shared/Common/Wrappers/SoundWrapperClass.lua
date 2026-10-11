local SoundWrapperClass = {}
SoundWrapperClass.__index = SoundWrapperClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local LazyResourceSounds = require(common:WaitForChild("LazyResourceSounds"))
local GameSoundHandler = require(TDX_Shared.Components.GameSoundHandler)
local random = Random.new(os.clock())
local TryReadChildValue = Utilities.TryReadChildValue

local function GetRandomSound(list) -- 4 equivalent calls inferred from this helper
	local count = #list

	if count > 1 then
		return list[math.random(1, count)]
	end

	return list[1]
end

function SoundWrapperClass.New(p, speedMultiplier: number, p2: number?)
	local v = {
		AllSoundsMap = {},
		TriggeredSoundsMap = {},
		ContinuousSoundsMap = {},
		KeyframeTriggeredSoundsMap = {},
		SoundGroupsMap = {},
		KeyframeTriggeredContinuousMap = {},
		DelayMap = {},
		RandomPlayChanceMap = {},
		FadeOutTweens = {},
		SpeedMultiplier = speedMultiplier
	}
	setmetatable(v, SoundWrapperClass)

	if p then
		v:AddSoundsFrom(p, speedMultiplier, p2)
	end

	return v
end

function SoundWrapperClass:PlayTriggered(p: number?, p2: number?)
	for _, v in pairs(self.TriggeredSoundsMap) do
		local v2 = self.DelayMap[v]

		if p and v2 then
			if v2 < p then
				p -= v2
				v2 = nil
			else
				v2 -= p
				p = nil
			end
		end

		if v2 and v2 > 0 then
			local v3 = v2
			local heartbeatConnection = nil
			local v4 = v
			heartbeatConnection = RunService.Heartbeat:Connect(function(dt: number)
				local v5 = dt * self.SpeedMultiplier
				v3 -= v5

				if v3 <= 0 then
					self:_InternalPlayTriggeredSound(GetRandomSound(v4), p, p2) -- inferred equivalent call
					heartbeatConnection:Disconnect()
				end
			end)
		else
			self:_InternalPlayTriggeredSound(GetRandomSound(v), p, p2) -- inferred equivalent call
		end
	end
end

function SoundWrapperClass:PlayContinuous()
	for _, v in pairs(self.ContinuousSoundsMap) do
		local randomSound = GetRandomSound(v) -- inferred equivalent call
		self.FadeOutTweens[randomSound]:Cancel()
		randomSound.Volume = randomSound:GetAttribute("OriginalVolume")

		if randomSound:GetAttribute("AlwaysResetTimePosition") then
			randomSound.TimePosition = 0
		end

		randomSound:Resume()
	end
end

function SoundWrapperClass.StopContinuous(p, flag: boolean?)
	if flag then
		for _, list in pairs(p.ContinuousSoundsMap) do
			for _, v in ipairs(list) do
				p.FadeOutTweens[v]:Cancel()
				v:Stop()
			end
		end
	else
		for _, list in pairs(p.ContinuousSoundsMap) do
			for _, v in ipairs(list) do
				p.FadeOutTweens[v]:Play()
			end
		end
	end
end

function SoundWrapperClass:PlayAll(p: number?, p2: number?)
	self:PlayTriggered(p, p2)
	self:PlayContinuous()
end

function SoundWrapperClass:FadeOutPlayingTriggeredSounds()
	for _, list in pairs(self.TriggeredSoundsMap) do
		for _, v in ipairs(list) do
			if v.Playing then
				self:_InternalFadeOutTriggeredSound(v)
			end
		end
	end

	for _, v in pairs(self.KeyframeTriggeredSoundsMap) do
		for _, list in pairs(v) do
			for _, v2 in ipairs(list) do
				if v2.Playing then
					self:_InternalFadeOutTriggeredSound(v2)
				end
			end
		end
	end
end

function SoundWrapperClass:PlayKeyframeTriggered(value: string)
	local flag

	if value:find("_Stop") then
		value = value:gsub("_Stop", "")
		flag = true
	else
		flag = false
	end

	local v = self.KeyframeTriggeredSoundsMap[value]
	local keyframeTriggeredContinuousMap = self.KeyframeTriggeredContinuousMap

	if v then
		for _, list in pairs(v) do
			if flag then
				for _, v2 in ipairs(list) do
					if keyframeTriggeredContinuousMap[v2] then
						self.FadeOutTweens[v2]:Play()
					end
				end
			else
				local randomSound = GetRandomSound(list) -- inferred equivalent call

				if keyframeTriggeredContinuousMap[randomSound] then
					self.FadeOutTweens[randomSound]:Cancel()
					randomSound.Volume = randomSound:GetAttribute("OriginalVolume")
					randomSound:Resume()
				else
					self:_InternalPlayTriggeredSound(randomSound)
				end
			end
		end
	end
end

function SoundWrapperClass:PlaySoundGroup(p: string)
	local v = self.SoundGroupsMap[p]

	if v then
		self:_InternalPlaySoundGroup(v)
	else
		warn(`Unknown sound group: {p}`)
	end
end

function SoundWrapperClass:StopSoundGroup(p: string)
	local v = self.SoundGroupsMap[p]

	if v then
		self:_InternalStopSoundGroup(v)
	else
		warn(`Unknown sound group: {p}`)
	end
end

function SoundWrapperClass:SpeedMultiplierChanged(speedMultiplier: number)
	for _, list in pairs(self.AllSoundsMap) do
		for _, v in ipairs(list) do
			v.PlaybackSpeed = speedMultiplier * v:GetAttribute("OriginalSpeed")
		end
	end

	self.SpeedMultiplier = speedMultiplier
end

function SoundWrapperClass.Reset(p)
	for _, fadeOutTween in pairs(p.FadeOutTweens) do
		fadeOutTween:Cancel()
	end

	for _, list in pairs(p.AllSoundsMap) do
		for _, v in ipairs(list) do
			v:Stop()
			v.PlaybackSpeed = v:GetAttribute("OriginalSpeed")
			v.Volume = v:GetAttribute("OriginalVolume")
		end
	end
end

function SoundWrapperClass.SetAttributeOnAllSounds(p, p2: string, p3)
	for _, list in pairs(p.AllSoundsMap) do
		for _, v in ipairs(list) do
			v:SetAttribute(p2, p3)
		end
	end
end

function SoundWrapperClass:AddSound(p, p2: number, p3: number?)
	self:_InternalAddSound(p, p3)
	self:SpeedMultiplierChanged(p2)
end

function SoundWrapperClass:AddSoundsFrom(folder, p: number, p2: number?, flag: boolean?)
	for _, descendant in pairs(folder:GetDescendants()) do
		if descendant:IsA("Sound") then
			if flag or not TryReadChildValue(descendant, "AnimationTriggered", false) then
				self:_InternalAddSound(descendant, p2)
			end
		elseif descendant:IsA("ObjectValue") and descendant.Name == "SoundPointer" then
			local value = descendant.Value

			if value then
				if value:IsA("Sound") then
					local clone = value:Clone()
					LazyResourceSounds.Restore(clone)
					clone.Parent = descendant.Parent

					if flag or not TryReadChildValue(clone, "AnimationTriggered", false) then
						self:_InternalAddSound(clone, p2)
					end
				elseif value:IsA("Folder") then
					local tryReadChildValue = TryReadChildValue(value, "AllChildrenDelay")
					local tryReadChildValue2 = TryReadChildValue(value, "SoundGroup")

					for _, sound in pairs(value:GetChildren()) do
						if not sound:IsA("Sound") then
							continue
						end

						local clone = sound:Clone()
						LazyResourceSounds.Restore(clone)
						clone.Parent = descendant.Parent

						if flag or not TryReadChildValue(clone, "AnimationTriggered", false) then
							self:_InternalAddSound(clone, p2, tryReadChildValue, tryReadChildValue2)
						end
					end
				end
			end

			descendant:Destroy()
		end
	end

	self:SpeedMultiplierChanged(p)
end

function SoundWrapperClass:_InternalAddSound(instance, value: number?, value2: number?, p: string?)
	local allSoundsMap = self.AllSoundsMap
	local triggeredSoundsMap = self.TriggeredSoundsMap
	local continuousSoundsMap = self.ContinuousSoundsMap
	local keyframeTriggeredSoundsMap = self.KeyframeTriggeredSoundsMap
	local soundGroupsMap = self.SoundGroupsMap
	local name = instance.Name
	local v = TryReadChildValue(instance, "KeyframeTriggered", false)
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeTriggered", false)
	local v2 = v and TryReadChildValue(instance, "KeyframeName")
		or TryReadChildValue(instance.Parent, "AllChildrenKeyframeName", name)
	local v3 = TryReadChildValue(instance, "Delay")
		or TryReadChildValue(instance.Parent, "AllChildrenDelay")
		or value2
		or 0
	local tryReadChildValue = TryReadChildValue(instance, "RandomPlayChance")
	local v4 = TryReadChildValue(instance, "Continuous", false)
		or TryReadChildValue(instance.Parent, "AllChildrenContinuous", false)
	local v5 = TryReadChildValue(instance.Parent, "SoundGroup", false) or p

	if v3 > 0 and v4 then
		warn("Continuous sound with delay is not implemented")
	end

	if v4 and not (instance.Looped or TryReadChildValue(instance, "IgnoreNotLooped", false)) then
		warn("Continuous sound " .. name .. " is not looped")
	end

	if v then
		if not keyframeTriggeredSoundsMap[v2] then
			keyframeTriggeredSoundsMap[v2] = {}
		end

		if not keyframeTriggeredSoundsMap[v2][name] then
			keyframeTriggeredSoundsMap[v2][name] = {}
		end

		table.insert(keyframeTriggeredSoundsMap[v2][name], instance)
	elseif v4 then
		if not continuousSoundsMap[name] then
			continuousSoundsMap[name] = {}
		end

		table.insert(continuousSoundsMap[name], instance)
	elseif v5 then
		local instancesByName = soundGroupsMap[v5]

		if instancesByName == nil then
			instancesByName = {}
			soundGroupsMap[v5] = instancesByName
		end

		instancesByName[instance.Name] = instance
	else
		if not triggeredSoundsMap[name] then
			triggeredSoundsMap[name] = {}
		end

		table.insert(triggeredSoundsMap[name], instance)
	end

	if v4 then
		local tweenInfo = TweenInfo.new(value or 1)
		self.FadeOutTweens[instance] = TweenService:Create(instance, tweenInfo, { Volume = 0 })
	end

	if not instance:GetAttribute("OriginalValuesSaved") then
		instance:SetAttribute("OriginalSpeed", instance.PlaybackSpeed)
		instance:SetAttribute("OriginalVolume", instance.Volume)
		instance:SetAttribute("OriginalValuesSaved", true)
	end

	if v and v4 then
		self.KeyframeTriggeredContinuousMap[instance] = true
	end

	if not allSoundsMap[name] then
		allSoundsMap[name] = {}
	end

	table.insert(allSoundsMap[name], instance)

	if v3 > 0 then
		self.DelayMap[triggeredSoundsMap[name]] = v3
	end

	if tryReadChildValue then
		self.RandomPlayChanceMap[instance] = tryReadChildValue
	end

	GameSoundHandler.AddSoundToSoundGroup(instance, "SFX")
end

function SoundWrapperClass:_InternalFadeOutTriggeredSound(instance)
	if instance:GetAttribute("NoFadeOut") then
		return
	end

	local fadeOutTween = self.FadeOutTweens[instance]

	if fadeOutTween then
		fadeOutTween:Cancel()
	else
		fadeOutTween = TweenService:Create(instance, TweenInfo.new(2), { Volume = 0 })
		self.FadeOutTweens[instance] = fadeOutTween
	end

	fadeOutTween:Play()
end

function SoundWrapperClass:_InternalPlayTriggeredSound(instance, timePosition: number?, value: number?)
	local fadeOutTween = self.FadeOutTweens[instance]
	local v = self.RandomPlayChanceMap[instance]

	if v and v < random:NextNumber() then
		return
	end

	if fadeOutTween then
		fadeOutTween:Cancel()
		instance.Volume = instance:GetAttribute("OriginalVolume")
	end

	if timePosition then
		instance.TimePosition = timePosition
	else
		instance.TimePosition = 0
	end

	instance.PlaybackSpeed = self.SpeedMultiplier * instance:GetAttribute("OriginalSpeed") * (value or 1)
	instance:Play()
end

function SoundWrapperClass:_InternalPlaySoundGroup(p)
	p.Loop.TimePosition = 0
	p.Start.Ended:Once(function()
		p.Loop:Resume()
	end)
	p.Start:Play()
end

function SoundWrapperClass:_InternalStopSoundGroup(data)
	data.Start:Stop()
	data.Loop:Stop()
	data.End:Play()
end

return SoundWrapperClass