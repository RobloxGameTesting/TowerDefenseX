local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("EmoteTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local Utilities = require(Common.Utilities)
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = { [EmoteAnimationGroup.Main] = 136006749673247 }
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = {
		"HideLighter",
		"ShowLighter",
		"PauseAnimation",
		"PlayFuseVFX",
		"HideFuseVFX",
		"PlaySparklerVFX"
	}
}
return {
	Type = Type.Basic,
	Name = "Fountain",
	AnimationIds = animationIds,
	EmoteSoundData = {
		SoundId = 96344109486045,
		RollOffMaxDistance = 2000,
		Volume = 0.9,
		Looped = false
	},
	ModelNames = { "Fountain_Fountain", "Fountain_Lighter" },
	KeyframeEventNames = keyframeEventNames,
	CleanupOnMovement = true,
	ServerKeyframeHandler = function(p, p2)
		if p == "HideLighter" then
			local fountain_Lighter = p2.Fountain_Lighter

			if fountain_Lighter then
				Utilities.HideModel(fountain_Lighter)
			else
				warn("Lighter not found for Fountain emote")
			end
		elseif p == "ShowLighter" then
			local fountain_Lighter = p2.Fountain_Lighter

			if fountain_Lighter then
				Utilities.ShowModel(fountain_Lighter)
			else
				warn("Lighter not found for Fountain emote")
			end
		elseif p == "PlayFuseVFX" then
			local fountain_Fountain = p2.Fountain_Fountain

			if not fountain_Fountain then
				warn("Fountain not found for Fountain emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(fountain_Fountain, "String>FuseVFX")

			if not v then
				warn("FuseAttachment not found for Fountain emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = true
			end
		elseif p == "HideFuseVFX" then
			local fountain_Fountain = p2.Fountain_Fountain

			if not fountain_Fountain then
				warn("Fountain not found for Fountain emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(fountain_Fountain, "String>FuseVFX")

			if not v then
				warn("FuseAttachment not found for Fountain emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = false
			end
		elseif p == "PlaySparklerVFX" then
			local fountain_Fountain = p2.Fountain_Fountain

			if not fountain_Fountain then
				warn("Fountain not found for Fountain emote")
				return
			end

			EmoteUtilities.LeaveBehindEmoteModel(fountain_Fountain, 10)
			local v = Utilities.TryGetInstanceFromPath(fountain_Fountain, "Cylinder>SparklerVFX")

			if not v then
				warn("SparklerAttachment not found for Fountain emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = true
			end

			local v2 = Utilities.TryGetInstanceFromPath(
				fountain_Fountain,
				"Cylinder>SparklerSFX>FountainSparklerLoopSFX"
			)

			if v2 then
				v2:Stop()
				v2:Play()
			else
				warn("SparklerSFX not found for Fountain emote")
			end
		end
	end
}