local ReplicatedStorage = game:GetService("ReplicatedStorage")
local wrappers = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common"):WaitForChild("Wrappers")
local EmitterWrapperClass = require(wrappers:WaitForChild("EmitterWrapperClass"))
local SoundWrapperClass = require(wrappers:WaitForChild("SoundWrapperClass"))
local EmitterAndSoundWrapperClass = require(wrappers:WaitForChild("EmitterAndSoundWrapperClass"))
local WrapperFactory = {}

function WrapperFactory.NewEmitterWrapper(p, p2: number, p3: number?)
	if not p2 then
		error("Speed multiplier missing when initializing emitter wrapper")
	end

	return EmitterWrapperClass.New(p, p2, p3)
end

function WrapperFactory.NewSoundWrapper(p, p2: number, p3: number?)
	if not p2 then
		error("Speed multiplier missing when initializing sound wrapper")
	end

	return SoundWrapperClass.New(p, p2, p3)
end

function WrapperFactory.NewEmitterAndSoundWrapper(p, p2: number)
	if not p2 then
		error("Speed multiplier missing when initializing emitter and sound wrapper")
	end

	return EmitterAndSoundWrapperClass.New(p, p2)
end

return WrapperFactory