local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local LanternClass = require(common.EmoteModules.LanternClass)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = { [EmoteAnimationGroup.Main] = 123777776636838 }
local keyframeEventNames = {
	[EmoteAnimationGroup.All] = { "Release", "PauseAnimation" }
}
return {
	Type = Type.Basic,
	Name = "Lantern",
	AnimationIds = animationIds,
	EmoteSoundData = {
		SoundId = 135437297006926,
		RollOffMaxDistance = 2000,
		Volume = 1.3,
		Looped = false
	},
	ModelNames = { "Lantern_Lighter", "Lantern_Lantern" },
	KeyframeEventNames = keyframeEventNames,
	CleanupOnMovement = true,
	ServerKeyframeHandler = function(p, p2)
		if p == "Release" then
			local lantern_Lantern = p2.Lantern_Lantern

			if not lantern_Lantern then
				warn("Lantern not found for Lantern emote")
				return
			end

			local clone = lantern_Lantern:Clone()
			Utilities.HideModel(lantern_Lantern)
			local motor = clone:FindFirstChild("Motor")

			if motor then
				motor:Destroy()
			end

			clone:PivotTo(lantern_Lantern:GetPivot())
			clone.Parent = workspace
			LanternClass.new(clone, {
				UpwardForceMultiplier = 1.0025,
				TargetHeight = 5,
				BaseDriftStrength = 1.2,
				DriftChangeInterval = 2,
				YawRotationSpeed = 6,
				WobbleAmount = 8,
				WobbleSpeed = 0.8,
				Lifetime = 10,
				FadeTime = 3,
				FlickerSpeed = 0.08,
				FlickerVariance = 0.4
			})
		end
	end
}