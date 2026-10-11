local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("EmoteTypes"))
local Enums = require(common:WaitForChild("Enums"))
local EmoteAnimationGroup = Enums.Emotes.EmoteAnimationGroup
local CandyBucket = require(script.Parent:WaitForChild("Candy Bucket"))
local ServerKeyframeHandler = CandyBucket.ServerKeyframeHandler
local v = { HalloweenBucket = "HalloweenBucket R15" }
local animationIds = { [EmoteAnimationGroup.Main] = 118261129802635 }
local clone = table.clone(CandyBucket)
clone.Name = "Candy Bucket R15"
clone.AnimationIds = animationIds
clone.ModelNames = { "HalloweenBucket R15" }

function clone.ServerKeyframeHandler(p, p2)
	local clone2 = table.clone(p2)

	for k, v2 in v do
		clone2[k] = p2[v2]
	end

	ServerKeyframeHandler(p, clone2)
end

return clone