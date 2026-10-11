local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 95641163653973,
	[EmoteAnimationGroup.Interact] = 121610733558341
}
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = { "StartSip" }
}
return {
	Type = Type.Basic,
	Name = "Hot Choccy",
	AnimationIds = animationIds,
	ModelNames = { "Hot Choccy" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		if p == "StartSip" then
			local hotChoccy = p2["Hot Choccy"]

			if not hotChoccy then
				warn("Hot_Choccy_Model not found for Hot Choccy emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(hotChoccy, "Handle>SipAudio")

			if v then
				v:Stop()
				v:Play()
			else
				warn("SipAudio not found for Hot Choccy emote")
			end
		end
	end,
	ViewportAnimationId = 121610733558341
}