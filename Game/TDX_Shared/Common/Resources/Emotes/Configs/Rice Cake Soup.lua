local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 109614229944874,
	[EmoteAnimationGroup.Start] = 88529619364984,
	[EmoteAnimationGroup.End] = 93238621008784
}
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = { "StartAnimation", "EndAnimation" }
}
return {
	Type = Type.Basic,
	Name = "Rice Cake Soup",
	AnimationIds = animationIds,
	EmoteSoundData = {
		SoundId = 93859822606488,
		RollOffMaxDistance = 2000,
		Volume = 1.3,
		Looped = false
	},
	ModelNames = { "Rice Cake Soup_Soup", "Rice Cake Soup_Sticks" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p: string, p2)
		if p == "StartAnimation" then
			local riceCakeSoup_Soup = p2["Rice Cake Soup_Soup"]

			if not riceCakeSoup_Soup then
				warn("Soup not found for Rice Cake Soup emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(riceCakeSoup_Soup, "mainsoupPart>SFX>Rice Cake Soup_LoopSFX")

			if not v then
				warn("LoopSFX not found for Rice Cake Soup emote")
				return
			end

			v:Stop()
			v:Play()
		elseif p == "EndAnimation" then
			local riceCakeSoup_Soup = p2["Rice Cake Soup_Soup"]

			if not riceCakeSoup_Soup then
				warn("Soup not found for Rice Cake Soup emote")
				return
			end

			local riceCakeSoup_Sticks = p2["Rice Cake Soup_Sticks"]

			if not riceCakeSoup_Sticks then
				warn("Sticks not found for Rice Cake Soup emote")
				return
			end

			local yummers = riceCakeSoup_Sticks:FindFirstChild("Yummers")

			if yummers then
				yummers.Transparency = 1
				yummers.TextureID = ""
			end

			local v = Utilities.TryGetInstanceFromPath(riceCakeSoup_Soup, "mainsoupPart>SFX>Rice Cake Soup_EndSFX")

			if v then
				v:Stop()
				v:Play()
			else
				warn("LoopSFX not found for Rice Cake Soup emote")
			end
		end
	end
}