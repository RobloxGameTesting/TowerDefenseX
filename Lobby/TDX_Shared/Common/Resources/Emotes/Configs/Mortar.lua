local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("EmoteTypes"))
local Enums = require(Common:WaitForChild("Enums"))
local Utilities = require(Common.Utilities)
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = { [EmoteAnimationGroup.Main] = 138994133418300 }
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = {
		"HideLighter",
		"ShowLighter",
		"PlayFuseVFX",
		"HideBomb",
		"ShowBomb",
		"PlayTrailVFX",
		"PlayExplosionVFX"
	}
}
return {
	Type = Type.Basic,
	Name = "Mortar",
	AnimationIds = animationIds,
	EmoteSoundData = {
		SoundId = 127302996487063,
		RollOffMaxDistance = 2000,
		Volume = 0.9,
		Looped = false
	},
	ModelNames = { "Mortar_Mortar", "Mortar_Lighter", "Mortar_Bomb" },
	KeyframeEventNames = keyframeEventNames,
	CleanupOnMovement = true,
	ServerKeyframeHandler = function(p, p2)
		if p == "HideLighter" then
			local mortar_Lighter = p2.Mortar_Lighter

			if mortar_Lighter then
				Utilities.HideModel(mortar_Lighter)
			else
				warn("Lighter not found for Mortar emote")
			end
		elseif p == "ShowLighter" then
			local mortar_Lighter = p2.Mortar_Lighter

			if mortar_Lighter then
				Utilities.ShowModel(mortar_Lighter)
			else
				warn("Lighter not found for Mortar emote")
			end
		elseif p == "HideBomb" then
			local mortar_Bomb = p2.Mortar_Bomb

			if not mortar_Bomb then
				warn("Bomb not found for Mortar emote")
				return
			end

			Utilities.HideModel(mortar_Bomb)
			local v = Utilities.TryGetInstanceFromPath(mortar_Bomb, "Fuse>FuseVFX")

			if not v then
				warn("FuseAttachment not found for Mortar emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = false
			end

			local v2 = Utilities.TryGetInstanceFromPath(mortar_Bomb, "Circle>TrailVFX")

			if not v2 then
				warn("TrailVFX attachment not found for Mortar emote")
				return
			end

			for _, v3 in EmoteUtilities.GetParticleEmitters(v2) do
				v3.Enabled = false
			end
		elseif p == "ShowBomb" then
			local mortar_Bomb = p2.Mortar_Bomb

			if mortar_Bomb then
				Utilities.ShowModel(mortar_Bomb)
			else
				warn("Bomb not found for Mortar emote")
			end
		elseif p == "PlayFuseVFX" then
			local mortar_Bomb = p2.Mortar_Bomb

			if not mortar_Bomb then
				warn("Bomb not found for Mortar emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(mortar_Bomb, "Fuse>FuseVFX")

			if not v then
				warn("FuseAttachment not found for Mortar emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = true
			end
		elseif p == "PlayTrailVFX" then
			local mortar_Bomb = p2.Mortar_Bomb

			if not mortar_Bomb then
				warn("Bomb not found for Mortar emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(mortar_Bomb, "Circle>TrailVFX")

			if not v then
				warn("TrailVFX attachment not found for Mortar emote")
				return
			end

			for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
				v2.Enabled = true
			end
		elseif p == "PlayExplosionVFX" then
			local mortar_Bomb = p2.Mortar_Bomb

			if not mortar_Bomb then
				warn("Bomb not found for Mortar emote")
				return
			end

			local v = Utilities.TryGetInstanceFromPath(mortar_Bomb, "Circle>ExplosionVFX")

			if v then
				for _, v2 in EmoteUtilities.GetParticleEmitters(v) do
					v2:Emit(v2:GetAttribute("EmitCount") or 5)
				end
			else
				warn("ExplosionAttachment not found for Mortar emote")
			end
		end
	end
}