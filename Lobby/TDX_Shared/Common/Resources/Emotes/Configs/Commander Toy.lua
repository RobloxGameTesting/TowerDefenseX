local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 114284676721549,
	[EmoteAnimationGroup.Start] = 106626979186420
}
local keyframeEventNames = {
	[EmoteAnimationGroup.Start] = { "PlayWindupSound" },
	[EmoteAnimationGroup.Main] = { "PlayWalkSound" }
}
local v = {
	PlayWindupSound = "ToyTorso>CommanderToyEmote_Intro_Windup",
	PlayWalkSound = "ToyTorso>CommanderToyEmote_WalkingInCirclesLoop"
}
return {
	Type = Type.Basic,
	Name = "Commander Toy",
	AnimationIds = animationIds,
	ModelNames = { "Commander Toy" },
	MainAnimationDelay = 2.88,
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		local commanderToy = p2["Commander Toy"]

		if not commanderToy then
			warn("Toy not found for Commander Toy emote")
			return
		end

		local v2 = v[p]

		if v2 then
			local v3 = Utilities.TryGetInstanceFromPath(commanderToy, v2)

			if not v3 then
				warn(`{v2} not found for Commander Toy emote`)
			elseif p == "PlayWalkSound" then
				if not v3.IsPlaying then
					v3:Play()
				end
			else
				v3:Stop()
				v3:Play()
			end
		end
	end,
	ViewportAnimationId = 114284676721549
}