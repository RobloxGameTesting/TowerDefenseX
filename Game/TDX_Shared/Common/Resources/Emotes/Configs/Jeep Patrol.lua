local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local Utilities = require(common.Utilities)
local Type = Enums.Emotes.Type
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local animationIds = {
	[EmoteAnimationGroup.Main] = 130114893031103,
	[EmoteAnimationGroup.Start] = 126670593723197,
	[EmoteAnimationGroup.End] = 101450775408817,
	[EmoteAnimationGroup.Moving] = 95591152857050
}
local keyframeEventNames = {
	[EmoteAnimationGroup.Start] = { "PlayStartSFX", "PlayDriveLoop" },
	[EmoteAnimationGroup.End] = { "PlayEndSFX", "HideJeep" }
}
local v = {
	PlayStartSFX = "Body>JeepEmote_Start",
	PlayDriveLoop = "Body>JeepEmote_DriveLoop",
	PlayEndSFX = "Body>JeepEmote_End"
}
return {
	Type = Type.Vehicle,
	Name = "Jeep Patrol",
	AnimationIds = animationIds,
	ModelNames = { "Jeep Patrol" },
	KeyframeEventNames = keyframeEventNames,
	ServerKeyframeHandler = function(p, p2)
		local jeepPatrol = p2["Jeep Patrol"]

		if not jeepPatrol then
			warn("Jeep not found for Jeep Patrol emote")
			return
		end

		local v2 = v[p]

		if v2 then
			local v3 = Utilities.TryGetInstanceFromPath(jeepPatrol, v2)

			if not v3 then
				warn(`{v2} not found for Jeep Patrol emote`)
			elseif p == "PlayEndSFX" then
				for _, v4 in { "Body>JeepEmote_Start", "Body>JeepEmote_DriveLoop" } do
					local v5 = Utilities.TryGetInstanceFromPath(jeepPatrol, v4)

					if v5 then
						v5:Stop()
					end
				end

				local parent = jeepPatrol.Parent
				local humanoidRootPart

				if parent then
					humanoidRootPart = parent:FindFirstChild("HumanoidRootPart")
				end

				if humanoidRootPart then
					local clone = v3:Clone()
					clone.Parent = humanoidRootPart
					clone:Play()
					Debris:AddItem(clone, 3)
				end
			else
				v3:Stop()
				v3:Play()
			end
		elseif p == "HideJeep" then
			Utilities.HideModel(jeepPatrol)
		end
	end,
	MovingStudsPerLoop = 4.1469023027385274
}