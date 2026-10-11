local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 107547367685301,
	[EmoteAnimationGroup.Interact] = 139739070213035
}
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = { "PlaySqueak" }
}
return {
	Type = Type.Basic,
	Name = "Bunny Plush",
	AnimationIds = animationIds,
	ModelNames = { "Bunny Plush" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		if p == "PlaySqueak" then
			local bunnyPlush = p2["Bunny Plush"]

			if not bunnyPlush then
				warn("Bunny Plush model not found for Bunny Plush emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(bunnyPlush, "Handle>SqueakAudio")

			if v then
				v:Stop()
				v:Play()
			else
				warn("SqueakAudio not found for Bunny Plush emote")
			end
		end
	end,
	ViewportAnimationId = 139739070213035
}