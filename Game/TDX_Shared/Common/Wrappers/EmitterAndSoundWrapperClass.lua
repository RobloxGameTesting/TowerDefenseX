local EmitterAndSoundWrapperClass = {}
EmitterAndSoundWrapperClass.__index = EmitterAndSoundWrapperClass
local EmitterWrapperClass = require(script.Parent:WaitForChild("EmitterWrapperClass"))
local SoundWrapperClass = require(script.Parent:WaitForChild("SoundWrapperClass"))

function EmitterAndSoundWrapperClass.New(p, p2: number)
	return (setmetatable(
		{
			SoundWrapper = SoundWrapperClass.New(p, p2),
			EmitterWrapper = EmitterWrapperClass.New(p, p2)
		},
		EmitterAndSoundWrapperClass
	))
end

function EmitterAndSoundWrapperClass:PlayTriggered()
	self.EmitterWrapper:PlayTriggered()
	self.SoundWrapper:PlayTriggered()
end

function EmitterAndSoundWrapperClass:PlayContinuous()
	self.EmitterWrapper:PlayContinuous()
	self.SoundWrapper:PlayContinuous()
end

function EmitterAndSoundWrapperClass:StopContinuous(flag: boolean?)
	self.EmitterWrapper:StopContinuous()
	self.SoundWrapper:StopContinuous(flag)
end

function EmitterAndSoundWrapperClass:FadeOutPlayingTriggeredSounds()
	self.SoundWrapper:FadeOutPlayingTriggeredSounds()
end

function EmitterAndSoundWrapperClass:PlayAll()
	self.EmitterWrapper:PlayAll()
	self.SoundWrapper:PlayAll()
end

function EmitterAndSoundWrapperClass:PlayKeyframeTriggered(p: string)
	self.EmitterWrapper:PlayKeyframeTriggered(p)
	self.SoundWrapper:PlayKeyframeTriggered(p)
end

function EmitterAndSoundWrapperClass:SpeedMultiplierChanged(p: number)
	self.EmitterWrapper:SpeedMultiplierChanged(p)
	self.SoundWrapper:SpeedMultiplierChanged(p)
end

function EmitterAndSoundWrapperClass:ScaleEmitters(p: number)
	self.EmitterWrapper:ScaleEmitters(p)
end

function EmitterAndSoundWrapperClass:SetAttributeOnAllSounds(p: string, p2)
	self.SoundWrapper:SetAttributeOnAllSounds(p, p2)
end

function EmitterAndSoundWrapperClass:Reset()
	self.EmitterWrapper:Reset()
	self.SoundWrapper:Reset()
end

function EmitterAndSoundWrapperClass.Add(p, instance, p2: number)
	if instance:IsA("ParticleEmitter") then
		p.EmitterWrapper:AddEmitter(instance, p2)
	elseif instance:IsA("PointLight") or instance:IsA("SpotLight") or instance:IsA("SurfaceLight") then
		p.EmitterWrapper:AddLight(instance)
	elseif instance:IsA("Sound") then
		p.SoundWrapper:AddSound(instance, p2)
	else
		warn("Instance is not a particle emitter or sound")
	end
end

function EmitterAndSoundWrapperClass.AddFrom(p, p2, p3: number)
	p.EmitterWrapper:AddEmittersFrom(p2, p3)
	p.SoundWrapper:AddSoundsFrom(p2, p3)
end

return EmitterAndSoundWrapperClass