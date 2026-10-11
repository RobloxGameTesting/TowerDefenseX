local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("EmoteTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = { [EmoteAnimationGroup.Main] = 83005324086407 }
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = { "Candy" }
}
return {
	Type = Type.Basic,
	Name = "Candy Bucket",
	AnimationIds = animationIds,
	ModelNames = { "HalloweenBucket" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		if p == "Candy" then
			local halloweenBucket = p2.HalloweenBucket

			if not halloweenBucket then
				warn("HalloweenBucket not found for Candy Bucket emote")
				return
			end

			local candyVFXPart = halloweenBucket:WaitForChild("CandyVFXPart", 2)

			if not candyVFXPart then
				warn("CandyVFXPart not found for Candy Bucket emote")
				return
			end

			local particleEmitters = EmoteUtilities.GetParticleEmitters(candyVFXPart)
			local candyThrow = candyVFXPart:FindFirstChild("CandyThrow")

			if candyThrow then
				candyThrow:Stop()
				candyThrow:Play()
			end

			for _, particleEmitter in particleEmitters do
				particleEmitter:Emit(particleEmitter:GetAttribute("EmitCount") or 5)
			end
		end
	end
}