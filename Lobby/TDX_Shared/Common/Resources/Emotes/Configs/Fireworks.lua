local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Type = Enums.Emotes.Type
local animationIds = { [Enums.Emotes.EmoteAnimationGroup.Main] = 94254568844237 }
return {
	Type = Type.Basic,
	Name = "Fireworks",
	AnimationIds = animationIds,
	EmoteSoundData = { SoundId = 86303084545959, RollOffMaxDistance = 2000 },
	ModelNames = { "Fireworks_FireWork", "Fireworks_Lighter" },
	ServerModelCallback = {
		Fireworks_FireWork = function(instance)
			task.delay(3.75, function()
				local instanceMain = instance and instance:FindFirstChild("Main")

				if not instanceMain then
					return
				end

				local trail = instanceMain:FindFirstChild("Trail")

				if not trail then
					return
				end

				for _, emitter in trail:GetChildren() do
					if emitter:IsA("ParticleEmitter") then
						emitter.Enabled = true
					end
				end
			end)
			task.delay(5.317, function()
				local instanceMain = instance and instance:FindFirstChild("Main")

				if not instanceMain then
					return
				end

				local trail = instanceMain:FindFirstChild("Trail")

				if trail then
					for _, emitter in trail:GetChildren() do
						if emitter:IsA("ParticleEmitter") then
							emitter.Enabled = false
						end
					end
				end

				local explode = instanceMain:FindFirstChild("Explode")

				if explode then
					for _, child in explode:GetChildren() do
						if child:IsA("ParticleEmitter") then
							child:Emit(child.Rate)
						elseif child:IsA("Sound") then
							child:Play()
						end
					end
				end

				for _, part in instance:GetChildren() do
					if part:IsA("BasePart") then
						part.Transparency = 1
					end
				end
			end)
		end
	}
}