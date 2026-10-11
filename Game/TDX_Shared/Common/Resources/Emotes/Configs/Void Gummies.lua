local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 117849946435427,
	[EmoteAnimationGroup.Start] = 86604527358321,
	[EmoteAnimationGroup.Interact] = 81616703523523,
	[EmoteAnimationGroup.End] = 82179351917544
}
local keyframeEventNames = {
	[EmoteAnimationGroup.Start] = { "PlayEquipSFX" },
	[EmoteAnimationGroup.Interact] = { "PlayEatSFX" },
	[EmoteAnimationGroup.End] = { "PlayUnequipSFX", "HideProps" }
}
local v = {
	PlayEquipSFX = "Opened Bag>GummyEmote_Equip",
	PlayEatSFX = "Opened Bag>GummyEmote_Eat",
	PlayUnequipSFX = "Opened Bag>GummyEmote_Unequip"
}
return {
	Type = Type.Basic,
	Name = "Void Gummies",
	AnimationIds = animationIds,
	ModelNames = { "Void Gummies" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		local voidGummies = p2["Void Gummies"]

		if not voidGummies then
			warn("Props not found for Void Gummies emote")
			return
		end

		local v2 = v[p]

		if v2 then
			local v3 = Utilities.TryGetInstanceFromPath(voidGummies, v2)

			if not v3 then
				warn(`{v2} not found for Void Gummies emote`)
				return
			end

			v3:Stop()
			v3:Play()
		elseif p == "HideProps" then
			Utilities.HideModel(voidGummies)
		end
	end,
	ViewportAnimationId = 81616703523523
}