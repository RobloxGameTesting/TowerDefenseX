local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 83669540048116,
	[EmoteAnimationGroup.Start] = 79371078016320,
	[EmoteAnimationGroup.Interact] = 87220781305555,
	[EmoteAnimationGroup.End] = 131240386894978
}
local keyframeEventNames = {
	[EmoteAnimationGroup.Start] = { "PlayTakeOutSFX" },
	[EmoteAnimationGroup.Interact] = { "PlayHugSFX" },
	[EmoteAnimationGroup.End] = { "PlayPutAwaySFX", "HidePlush" }
}
local v = {
	PlayTakeOutSFX = "VoidPlush>VoidPlushEmote_TakeOut",
	PlayHugSFX = "VoidPlush>VoidPlushEmote_Hug",
	PlayPutAwaySFX = "VoidPlush>VoidPlushEmote_PutAway"
}
return {
	Type = Type.Basic,
	Name = "Void Plush",
	AnimationIds = animationIds,
	ModelNames = { "Void Plush" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		local voidPlush = p2["Void Plush"]

		if not voidPlush then
			warn("Plush not found for Void Plush emote")
			return
		end

		local v2 = v[p]

		if v2 then
			local v3 = Utilities.TryGetInstanceFromPath(voidPlush, v2)

			if not v3 then
				warn(`{v2} not found for Void Plush emote`)
				return
			end

			v3:Stop()
			v3:Play()
		elseif p == "HidePlush" then
			Utilities.HideModel(voidPlush)
		end
	end,
	ViewportAnimationId = 87220781305555
}